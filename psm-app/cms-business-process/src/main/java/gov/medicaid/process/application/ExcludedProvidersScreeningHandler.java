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
import gov.medicaid.domain.model.ProviderInformationType;
import gov.medicaid.domain.model.VerificationStatusType;
import gov.medicaid.entities.AutomaticScreening;
import gov.medicaid.services.impl.LeieExternalScreener;
import org.drools.runtime.process.WorkItem;
import org.drools.runtime.process.WorkItemManager;

import javax.persistence.EntityManager;
import java.util.logging.Logger;

/**
 * This checks the excluded providers from the OIG LEIE.
 */
public class ExcludedProvidersScreeningHandler extends GenericHandler {
    private final Logger logger = Logger.getLogger(getClass().getName());

    private final LeieExternalScreener leieExternalScreener;

    public ExcludedProvidersScreeningHandler(
            String baseUri,
            EntityManager entityManager
    ) {
        leieExternalScreener = new LeieExternalScreener(
                baseUri,
                entityManager
        );
    }

    public void executeWorkItem(WorkItem item, WorkItemManager manager) {
        logger.info("Checking provider exclusion.");
        ApplicationProcess processModel = (ApplicationProcess) item.getParameter("model");
        Long applicationId = Long.parseLong(
                processModel.getApplication().getObjectId()
        );

        ProviderInformationType provider = XMLUtility.nsGetProvider(processModel);

        AutomaticScreening.Result result = leieExternalScreener.screen(
                applicationId,
                provider.getNPI()
        );

        switch (result) {
            case PASS:
                setResultNotExcluded(processModel);
                break;
            case FAIL:
                setResultExcluded(processModel);
                break;
            case ERROR:
                break;
        }

        item.getResults().put("model", processModel);
        manager.completeWorkItem(item.getId(), item.getResults());
    }

    private void setResultExcluded(
            ApplicationProcess processModel
    ) {
        setNonExclusionVerificationStatus(processModel, "N");
    }

    private void setResultNotExcluded(
            ApplicationProcess processModel
    ) {
        setNonExclusionVerificationStatus(processModel, "Y");
    }

    private void setNonExclusionVerificationStatus(
            ApplicationProcess processModel,
            String status
    ) {
        VerificationStatusType verificationStatus =
                XMLUtility.nsGetVerificationStatus(processModel);
        verificationStatus.setNonExclusion(status);
    }
}
