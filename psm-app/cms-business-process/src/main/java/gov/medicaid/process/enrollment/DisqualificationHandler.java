/*
 * Copyright 2012-2013 TopCoder, Inc.
 *
 * This code was developed under U.S. government contract NNH10CD71C. 
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * You may not use this file except in compliance with the License.
 * You may obtain a copy of the License at:
 *     http://www.apache.org/licenses/LICENSE-2.0
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package gov.medicaid.process.enrollment;

import gov.medicaid.binders.XMLUtility;
import gov.medicaid.domain.model.EnrollmentProcess;
import gov.medicaid.domain.model.ProviderInformationType;
import gov.medicaid.entities.CMSUser;
import gov.medicaid.entities.Enrollment;
import gov.medicaid.entities.Event;
import gov.medicaid.services.CMSConfigurator;
import gov.medicaid.services.PortalServiceException;
import gov.medicaid.services.ProviderEnrollmentService;
import gov.medicaid.services.util.XMLAdapter;

import java.util.Date;
import java.util.logging.Logger;

import javax.persistence.EntityManager;

import org.drools.runtime.process.WorkItem;
import org.drools.runtime.process.WorkItemManager;

/**
 * This initializes the application model.
 * 
 * @author TCSASSEMBLER
 * @version 1.0
 */
public class DisqualificationHandler extends GenericHandler {

    /**
     * The logger for this class.
     */
    private Logger logger = Logger.getLogger(DisqualificationHandler.class.getName());

    /**
     * Provider service.
     */
    private final ProviderEnrollmentService providerService;

    /**
     * Entity manager.
     */
    private final EntityManager entityManager;

    /**
     * The screening system user.
     */
    private CMSUser systemUser;

    /**
     * Constructor using the fields.
     */
    public DisqualificationHandler() {
        CMSConfigurator config = new CMSConfigurator();
        this.providerService = config.getEnrollmentService();
        this.entityManager = config.getPortalEntityManager();
        systemUser = config.getSystemUser();
    }

    /**
     * If any of the provider enrollment question is answered as 'Yes' then the enrollment will be rejected.
     * 
     * @param item
     *            the work item to abort
     * @param manager
     *            the work item manager
     */
    public void executeWorkItem(WorkItem item, WorkItemManager manager) {
        logger.info("Checking disqualification criteria");
        EnrollmentProcess model = (EnrollmentProcess) item.getParameter("model");
        ProviderInformationType provider = XMLUtility.nsGetProvider(model);
        if ("Y".equals(provider.getHasCivilPenalty()) || "Y".equals(provider.getHasCriminalConviction())
                || "Y".equals(provider.getHasPreviousExclusion()) || "Y".equals(provider.getEmployeeHasCivilPenalty())
                || "Y".equals(provider.getEmployeeHasCriminalConviction())
                || "Y".equals(provider.getEmployeeHasPreviousExclusion())) {

            try {
                Enrollment ticket = XMLAdapter.fromXML(systemUser, model.getEnrollment());
                providerService.rejectTicket(systemUser, ticket.getTicketId(),
                        "Auto disqualified due to the answer in Provider Disclosure");
                item.getResults().put("model", model);

                Event e = new Event();
                e.setCreatedBy(systemUser.getUserId());
                e.setCreatedOn(new Date());
                e.setId(0);
                e.setNpi(model.getEnrollment().getProviderInformation().getNPI());
                e.setStatus("03");
                e.setTicketId(ticket.getTicketId());
                entityManager.persist(e);

                manager.completeWorkItem(item.getId(), item.getResults());
            } catch (PortalServiceException e) {
                logger.log(java.util.logging.Level.SEVERE, e.getMessage(), e);
            }

        }
    }
}