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
import gov.medicaid.entities.Application;
import gov.medicaid.entities.CMSUser;
import gov.medicaid.entities.EmailTemplate;
import gov.medicaid.entities.Event;
import gov.medicaid.services.CMSConfigurator;
import gov.medicaid.services.NotificationService;
import gov.medicaid.services.PortalServiceException;
import gov.medicaid.services.ProviderApplicationService;
import gov.medicaid.services.util.XMLAdapter;

import org.drools.runtime.process.WorkItem;
import org.drools.runtime.process.WorkItemManager;

import javax.persistence.EntityManager;
import javax.persistence.Query;

import java.util.Date;

/**
 * This initializes the application model.
 */
public class AcceptedHandler extends GenericHandler {

    /**
     * Provider service.
     */
    private final ProviderApplicationService providerService;

    /**
     * Notification service.
     */
    private final NotificationService notificationService;

    /**
     * Entity manager.
     */
    private final EntityManager entityManager;

    /**
     * Constructor using the fields.
     */
    public AcceptedHandler(NotificationService notificationService) {
        CMSConfigurator config = new CMSConfigurator();
        this.providerService = config.getApplicationService();
        this.entityManager = config.getPortalEntityManager();
        this.notificationService = notificationService;
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
        ApplicationProcess model = (ApplicationProcess) item.getParameter("model");
        String processInstanceId = model.getProcessAudit().getProcessInstanceId();

        String actorId = model.getApplication().getProviderInformation().getReviewedBy();
        Query query = entityManager.createQuery("FROM CMSUser where username = :username");
        query.setParameter("username", actorId);
        CMSUser user = (CMSUser) query.getSingleResult();

        long processId = Long.parseLong(processInstanceId);
        try {
            Application application = providerService.getApplicationByProcessInstanceId(user, processId);

            XMLAdapter.copyApprovalFieldsToApplication(model, application);
            providerService.approveApplicationWithChanges(user, application);
            entityManager.joinTransaction();
            Event e = new Event();
            e.setCreatedBy(actorId);
            e.setCreatedOn(new Date());
            e.setId(0);
            e.setNpi(model.getApplication().getProviderInformation().getNPI());
            e.setStatus("04");
            e.setApplicationId(application.getApplicationId());
            entityManager.persist(e);

            item.getResults().put("model", model);
            manager.completeWorkItem(item.getId(), item.getResults());
            notificationService.sendApplicationNotification(model.getApplication(), EmailTemplate.APPROVED_APPLICATION);

            // Issue #215 - add hook for approval
        } catch (PortalServiceException e) {
            XMLUtility.moveToStatus(model, actorId, "ERROR", "Approval process failed to completed.");
            abortWorkItem(item, manager);
        }
    }
}
