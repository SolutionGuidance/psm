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

import java.util.Date;

import gov.medicaid.binders.XMLUtility;
import gov.medicaid.domain.model.EnrollmentProcess;
import gov.medicaid.entities.CMSUser;
import gov.medicaid.entities.Enrollment;
import gov.medicaid.entities.Event;
import gov.medicaid.services.CMSConfigurator;
import gov.medicaid.services.PortalServiceException;
import gov.medicaid.services.ProviderEnrollmentService;

import javax.persistence.EntityManager;
import javax.persistence.Query;

import org.drools.runtime.process.WorkItem;
import org.drools.runtime.process.WorkItemManager;

/**
 * This initializes the application model.
 * 
 * @author TCSASSEMBLER
 * @version 1.0
 */
public class RejectedHandler extends GenericHandler {

    /**
     * Provider service.
     */
    private final ProviderEnrollmentService providerService;

    /**
     * Entity manager.
     */
    private final EntityManager entityManager;

    /**
     * Constructor using the fields.
     */
    public RejectedHandler() {
        CMSConfigurator config = new CMSConfigurator();
        this.providerService = config.getEnrollmentService();
        this.entityManager = config.getPortalEntityManager();
    }

    /**
     * Initializes the process variable.
     * 
     * @param item
     *            the work item to abort
     * @param manager
     *            the work item manager
     */
    public void executeWorkItem(WorkItem item, WorkItemManager manager) {
        EnrollmentProcess model = (EnrollmentProcess) item.getParameter("model");
        String processInstanceId = model.getProcessAudit().getProcessInstanceId();

        String actorId = model.getEnrollment().getProviderInformation().getReviewedBy();
        Query query = entityManager.createQuery("FROM CMSUser where username = :username");
        query.setParameter("username", actorId);
        CMSUser user = (CMSUser) query.getSingleResult();

        long processId = Long.parseLong(processInstanceId);
        try {
            Enrollment ticket = providerService.getTicketByProcessInstanceId(user, processId);
            String statusReason = model.getEnrollmentStatus().getStatusReason();
            providerService.rejectTicket(user, ticket.getTicketId(), statusReason);

            Event e = new Event();
            e.setCreatedBy(actorId);
            e.setCreatedOn(new Date());
            e.setId(0);
            e.setNpi(model.getEnrollment().getProviderInformation().getNPI());
            e.setStatus("03");
            e.setTicketId(ticket.getTicketId());
            entityManager.persist(e);

            item.getResults().put("model", model);
            manager.completeWorkItem(item.getId(), item.getResults());

            // Issue #215 - add hook for rejection
        } catch (PortalServiceException e) {
            XMLUtility.moveToStatus(model, actorId, "ERROR", "Reject process failed to completed.");
            abortWorkItem(item, manager);
        }
    }
}