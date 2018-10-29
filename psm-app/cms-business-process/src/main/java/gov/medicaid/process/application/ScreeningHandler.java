/*
 * Copyright 2012, 2013 TopCoder, Inc.
 * Copyright 2018 The MITRE Corporation
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package gov.medicaid.process.application;

import gov.medicaid.binders.XMLUtility;
import gov.medicaid.domain.model.ApplicationProcess;
import gov.medicaid.domain.model.ApplicationType;
import gov.medicaid.domain.model.ProviderInformationType;
import gov.medicaid.domain.model.ValidationResultType;
import gov.medicaid.domain.rules.CMSKnowledgeUtility;
import gov.medicaid.domain.rules.GlobalLookups;
import gov.medicaid.domain.rules.inference.LookupEntry;
import gov.medicaid.entities.Application;
import gov.medicaid.entities.CMSUser;
import gov.medicaid.services.CMSConfigurator;
import gov.medicaid.services.PortalServiceException;
import gov.medicaid.services.ProviderApplicationService;
import gov.medicaid.services.ScreeningService;
import gov.medicaid.services.util.XMLAdapter;

import org.drools.runtime.StatefulKnowledgeSession;
import org.drools.runtime.process.WorkItem;
import org.drools.runtime.process.WorkItemManager;

import java.util.List;
import java.util.logging.Logger;

/**
 * This handler is responsible all screening rules.
 */
public class ScreeningHandler extends GenericHandler {
    /**
     * Provider service.
     */
    private final ProviderApplicationService providerService;

    private final ScreeningService screeningService;

    private final Logger logger = Logger.getLogger(getClass().getName());

    /**
     * The screening system user.
     */
    private CMSUser systemUser;

    public ScreeningHandler() {
        CMSConfigurator config = new CMSConfigurator();
        this.providerService = config.getApplicationService();
        this.screeningService = config.getScreeningService();
        systemUser = config.getSystemUser();
    }

    /**
     * Runs the screening rules.
     *
     * @param item the work item to abort
     * @param manager the work item manager
     */
    public void executeWorkItem(WorkItem item, WorkItemManager manager) {
        logger.info("Screening the provider.");
        ApplicationProcess processModel = (ApplicationProcess) item.getParameter("model");

        ValidationResultType validationResult = new ValidationResultType();
        XMLUtility.nsGetScreeningResults(processModel).setAutomaticScreeningStatus(validationResult);
        StatefulKnowledgeSession ksession = CMSKnowledgeUtility.newScreeningValidationSession();

        // known facts for screening
        ksession.insert(processModel.getPostSubmissionInformation());
        ApplicationType applicationType = processModel.getApplication();
        ksession.insert(applicationType);
        ksession.insert(applicationType.getProviderInformation());
        ksession.insert(applicationType.getProviderInformation().getVerificationStatus());
        ksession.insert(processModel.getProcessResults().getScreeningResults());
        ksession.insert(validationResult);
        List<LookupEntry> allLookupEntries = GlobalLookups.getInstance().getAllLookupEntries();
        for (LookupEntry lookupEntry : allLookupEntries) {
            ksession.insert(lookupEntry);
        }

        ksession.fireAllRules();

        // merge rule changes to the model
        try {
            /*
             * This may be needed!!!
             *
             * When updating the application, the code to save the screenings was needed because
             * the application was getting duplicated left and right.  Now, applications get duplicated
             * if and only if they have done a major state change, and in those instances, they
             * should get new screenings.
             *
             * However, that may be an incorrect assumption, so until we fully test the changes
             * and workflows introduced by this change, we should keep around the code that was
             * needed to duplicate the screenings.
             *

            providerService.saveApplicationDetails(XMLAdapter.fromXML(systemUser, application));
            long applicationId = Long.parseLong(application.getObjectId());
            Application application = providerService.getApplicationWithScreenings(systemUser, applicationId).
                orElseThrow(() -> new PortalServiceException("Couldn't find application"));
            XMLAdapter
                .mergeFromXML(application.getAutomaticScreenings(), application)
                .forEach(screeningService::saveScreening);
            ProviderInformationType providerInformation = application.getProviderInformation();
            String reviewer = providerInformation.getReviewedBy(); // transient field (should really add to DB)
            ProviderInformationType updatedInfo = XMLAdapter.toXML(application).getProviderInformation();

            */
            Application updatedApplication =
                providerService.saveApplicationDetails(XMLAdapter.fromXML(systemUser, applicationType));
            ProviderInformationType providerInformation = applicationType.getProviderInformation();
            String reviewer = providerInformation.getReviewedBy(); // transient field (should really add to DB)
            ProviderInformationType updatedInfo = XMLAdapter.toXML(updatedApplication).getProviderInformation();
            updatedInfo.setReviewedBy(reviewer);
            applicationType.setProviderInformation(updatedInfo);
        } catch (PortalServiceException e) {
            logger.log(java.util.logging.Level.SEVERE, e.getMessage(), e);
        }

        // reset validation results
        item.getResults().put("model", processModel);
        manager.completeWorkItem(item.getId(), item.getResults());
    }
}
