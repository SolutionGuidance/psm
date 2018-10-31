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

package gov.medicaid.services.impl;

import gov.medicaid.binders.XMLUtility;
import gov.medicaid.domain.model.ApplicationProcess;
import gov.medicaid.domain.model.ApplicationType;
import gov.medicaid.domain.model.EditHistoryType;
import gov.medicaid.domain.model.ProviderInformationType;
import gov.medicaid.domain.model.VerificationStatusType;
import gov.medicaid.domain.rules.CMSKnowledgeUtility;
import gov.medicaid.entities.Application;
import gov.medicaid.entities.ApplicationStatus;
import gov.medicaid.entities.CMSUser;
import gov.medicaid.entities.dto.ViewStatics;
import gov.medicaid.process.application.AcceptedHandler;
import gov.medicaid.process.application.ApplicationMonitor;
import gov.medicaid.process.application.DmfScreeningHandler;
import gov.medicaid.process.application.ExcludedProvidersScreeningHandler;
import gov.medicaid.process.application.PreProcessHandler;
import gov.medicaid.process.application.RejectedHandler;
import gov.medicaid.process.application.ScreeningHandler;
import gov.medicaid.process.application.ValidationHandler;
import gov.medicaid.services.BusinessProcessService;
import gov.medicaid.services.CMSConfigurator;
import gov.medicaid.services.NotificationService;
import gov.medicaid.services.PortalServiceException;
import gov.medicaid.services.ProviderApplicationService;
import gov.medicaid.services.util.XMLAdapter;

import org.drools.SystemEventListenerFactory;
import org.drools.runtime.StatefulKnowledgeSession;
import org.drools.runtime.process.ProcessInstance;
import org.drools.runtime.process.WorkItemHandler;
import org.jbpm.task.AccessType;
import org.jbpm.task.Content;
import org.jbpm.task.Task;
import org.jbpm.task.query.TaskSummary;
import org.jbpm.task.service.ContentData;
import org.jbpm.task.service.TaskService;
import org.jbpm.task.service.local.LocalTaskService;

import javax.annotation.PostConstruct;
import javax.annotation.Resource;
import javax.ejb.EJB;
import javax.ejb.EJBContext;
import javax.ejb.Local;
import javax.ejb.Stateless;
import javax.ejb.TransactionManagement;
import javax.ejb.TransactionManagementType;
import javax.persistence.EntityManagerFactory;
import javax.persistence.PersistenceUnit;
import javax.transaction.Status;
import javax.transaction.UserTransaction;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.util.Arrays;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;
import java.util.logging.Logger;

import static java.util.logging.Level.SEVERE;

@Stateless
@Local(BusinessProcessService.class)
@TransactionManagement(TransactionManagementType.BEAN)
public class BusinessProcessServiceBean extends BaseService implements BusinessProcessService {
    private final Logger logger = Logger.getLogger(getClass().getName());

    /**
     * See https://issues.jboss.org/browse/JBPM-3791
     *
     * To use a different parameter, override the default handler in getTaskClient().
     */
    private static final String LOCALE = "en-UK";

    /**
     * List of handlers to be registered to workflow sessions.
     */
    private final Map<String, WorkItemHandler> handlers = new HashMap<>();

    /**
     * Persistence for provider application.
     */
    @EJB
    private ProviderApplicationService providerService;

    @Resource
    private EJBContext context;

    /**
     * Persistence unit.
     */
    @PersistenceUnit(unitName = "cms")
    private EntityManagerFactory emf;

    /**
     * Notification service used for sending emails.
     */
    @EJB
    private NotificationService notificationService;

    /**
     * Empty constructor.
     */
    public BusinessProcessServiceBean() {
    }

    /**
     * Initializes this service.
     */
    @PostConstruct
    public void init() {
        super.init();
        CMSConfigurator config = new CMSConfigurator();

        handlers.put("PreProcess", new PreProcessHandler());
        handlers.put("Validate", new ValidationHandler());
        handlers.put("Reject Application", new RejectedHandler());
        handlers.put(
                "Check Excluded Provider List in OIG",
                new ExcludedProvidersScreeningHandler(
                        config.getLeieApiBaseUrl(),
                        config.getPortalEntityManager()
                )
        );
        handlers.put(
                "Check DMF",
                new DmfScreeningHandler(
                        config.getDmfApiBaseUrl(),
                        config.getPortalEntityManager()
                )
        );
        handlers.put("Auto Screening", new ScreeningHandler());
        handlers.put("Accept Application", new AcceptedHandler(notificationService));

        if (providerService == null) {
            providerService = config.getApplicationService();
        }
    }

    /**
     * Starts a new application process.
     *
     * @param application the application requested
     * @return the process instance id
     * @throws Exception for any errors encountered
     */
    private long enroll(
            ApplicationType applicationType
    ) throws Exception {
        StatefulKnowledgeSession ksession = null;
        UserTransaction utx = context.getUserTransaction();
        boolean owner = false;
        try {
            if (utx.getStatus() == Status.STATUS_NO_TRANSACTION) {
                utx.begin();
                owner = true;
            }

            ksession = CMSKnowledgeUtility.newWorkflowSession(getEmf(), utx);
            Set<Entry<String, WorkItemHandler>> entrySet = handlers.entrySet();
            for (Entry<String, WorkItemHandler> entry : entrySet) {
                ksession.getWorkItemManager().registerWorkItemHandler(entry.getKey(), entry.getValue());
            }

            Map<String, Object> params = new HashMap<>();
            ApplicationProcess processModel = new XMLSerializingApplicationProcess();
            processModel.setSessionId(ksession.getId());
            processModel.setApplication(applicationType);
            params.put("model", processModel);
            ksession.insert(processModel);
            ksession.addEventListener(new ApplicationMonitor());
            ProcessInstance process = ksession.startProcess("gov.medicaid.process.application", params);
            if (utx.getStatus() == Status.STATUS_ACTIVE && owner) {
                utx.commit();
            }
            return process.getId();
        } finally {
            if (ksession != null) {
                try {
                    ksession.dispose();
                } catch (Throwable t) {
                    logger.log(SEVERE, "Could not close session.", t);
                }
            }
        }
    }

    private void resubmit(
            CMSUser user,
            ApplicationProcess processModel
    ) throws Exception {
        StatefulKnowledgeSession ksession = null;
        UserTransaction utx = context.getUserTransaction();
        try {
            utx.begin();
            ksession = CMSKnowledgeUtility.newWorkflowSession(getEmf(), utx);
            Set<Entry<String, WorkItemHandler>> entrySet = handlers.entrySet();
            for (Entry<String, WorkItemHandler> entry : entrySet) {
                ksession.getWorkItemManager().registerWorkItemHandler(entry.getKey(), entry.getValue());
            }

            Map<String, Object> params = new HashMap<>();
            processModel.setSessionId(ksession.getId());
            params.put("model", processModel);
            ksession.insert(processModel);
            ksession.addEventListener(new ApplicationMonitor());
            ProcessInstance process = ksession.startProcess("gov.medicaid.process.application", params);
            long processId = process.getId();
            String applicationId = processModel.getApplication().getObjectId();
            Application application = providerService.getApplicationDetails(getSystemUser(), Long.parseLong(applicationId));
            application.setProcessInstanceId(processId);
            application.setLastUpdatedBy(user);
            getEm().merge(application);
            utx.commit();
        } finally {
            try {
                ksession.dispose();
            } catch (Throwable t) {
                logger.log(SEVERE, "Could not close session.", t);
            }
        }
    }

    private EntityManagerFactory getEmf() {
        return emf;
    }

    /**
     * Retrieves the available tasks for the given user and roles.
     *
     * @param username the user to get the tasks for
     * @param roles    the roles of the user
     * @return all tasks that the user can claim or already owns
     * @throws Exception for any errors encountered
     */
    public List<TaskSummary> getAvailableTasks(
            String username,
            List<String> roles
    ) throws Exception {
        UserTransaction utx = context.getUserTransaction();
        LocalTaskService client = null;
        try {
            utx.begin();
            client = new LocalTaskService(new TaskService(getEmf(), SystemEventListenerFactory.getSystemEventListener()));
            utx.commit();
            return client.getTasksAssignedAsPotentialOwner("Administrator", roles, LOCALE);
        } finally {
            if (client != null) {
                client.dispose();
            }
        }
    }

    /**
     * Retrieves the current state of the process execution.
     *
     * @param taskId the task id to get the current details for
     * @return all tasks that the user can claim or already owns
     * @throws Exception for any errors encountered
     */
    public ApplicationProcess getTaskModel(long taskId) throws Exception {
        LocalTaskService client = new LocalTaskService(new TaskService(getEmf(), SystemEventListenerFactory.getSystemEventListener()));
        try {
            return getApplicationForReview(client, taskId);
        } finally {
            client.dispose();
        }
    }

    /**
     * Completes the given task.
     *
     * @param taskId   the task to be completed
     * @param approver the user performing the task
     * @param roles    the roles of the user
     * @param reject   flag if the results are rejected
     * @param updates  the changes
     * @param comment  the change comments
     * @throws Exception for any errors encountered
     */
    public void completeReview(
            final long taskId,
            String approver,
            List<String> roles,
            final ProviderInformationType updates,
            boolean reject,
            String comment
    ) throws Exception {
        UserTransaction utx = context.getUserTransaction();
        utx.begin();
        String username = "Administrator";
        LocalTaskService client = new LocalTaskService(new TaskService(getEmf(), SystemEventListenerFactory.getSystemEventListener()));
        StatefulKnowledgeSession ksession = null;
        try {
            client.claim(taskId, username, roles);

            ApplicationProcess processModel = getApplicationForReview(client, taskId);
            ksession = reloadSessionById(utx, client, processModel);
            ApplicationType applicationType = processModel.getApplication();

            // track changes made by approvers.
            if (updates != null) {
                ProviderInformationType oldData = applicationType.getProviderInformation();
                // replace the current profile
                applicationType.setProviderInformation(updates);
                EditHistoryType editHistory = new EditHistoryType();
                editHistory.setEditedBy(approver);
                editHistory.setEditedByRole(roles.toString());
                editHistory.setEditedOn(Calendar.getInstance());
                editHistory.setEditNote(comment);
                editHistory.setProviderInformation(oldData);
                processModel.getApplication().getSubmissionEditHistory().add(editHistory);
            }

            processModel.getApplication().getProviderInformation().setReviewedBy(approver);

            client.start(taskId, username);
            client.complete(taskId, username, marshalContent(processModel, "N"));
            utx.commit();
        } finally {
            try {
                ksession.dispose();
            } catch (Throwable t) {
                logger.log(SEVERE, "Could not close session.", t);
            }
            client.dispose();
        }
    }

    /**
     * Reloads the knowledge session with the given id.
     *
     * @param utx          the current transaction
     * @param client       the service client
     * @param processModel the process model
     * @return the reloaded session
     */
    private StatefulKnowledgeSession reloadSessionById(
            UserTransaction utx,
            LocalTaskService client,
            ApplicationProcess processModel
    ) {
        StatefulKnowledgeSession ksession = null;

        Integer session = processModel.getSessionId();
        if (session != null) {
            // this is a workaround based on https://issues.jboss.org/browse/JBPM-3673
            ksession = CMSKnowledgeUtility.reloadWorkflowSession(session, getEmf(), utx);
            LocalHumanTaskHandler handler = new LocalHumanTaskHandler(ksession, client);
            ksession.getWorkItemManager().registerWorkItemHandler("Human Task", handler);
            Set<Entry<String, WorkItemHandler>> entrySet = handlers.entrySet();
            for (Entry<String, WorkItemHandler> entry : entrySet) {
                ksession.getWorkItemManager().registerWorkItemHandler(entry.getKey(), entry.getValue());
            }
            ksession.signalEvent("Trigger", null);
        }
        return ksession;
    }

    public void updateRequest(
            ApplicationType applicationTypeIn,
            CMSUser user
    ) throws Exception {
        UserTransaction utx = context.getUserTransaction();
        final ProviderInformationType updates = applicationTypeIn.getProviderInformation();

        if (user.getRole().getDescription().equals(ViewStatics.ROLE_PROVIDER)) {
            if (!user.getUserId().equals(applicationTypeIn.getSubmittedBy())) {
                throw new PortalServiceException("Only the submitter and administrators are allowed to modify pending submissions.");
            }
        }

        // use process admin to recall submission
        String username = "Administrator";
        List<String> adminRole = Arrays.asList(
                ViewStatics.ROLE_SERVICE_ADMINISTRATOR
        );

        LocalTaskService client = new LocalTaskService(new TaskService(getEmf(), SystemEventListenerFactory.getSystemEventListener()));

        List<TaskSummary> tasks = client.getTasksAssignedAsPotentialOwner(username, adminRole, "en-UK", -1, -1);
        long taskId = 0;
        for (TaskSummary taskSummary : tasks) {
            if (applicationTypeIn.getProcessInstanceId() == taskSummary.getProcessInstanceId()) {
                taskId = taskSummary.getId();
                break;
            }
        }
        if (taskId == 0) {
            throw new PortalServiceException("Request was not found in pending queue.");
        }

        try {
            utx.begin();
            client.claim(taskId, username);

            ApplicationProcess processModel = getApplicationForReview(client, taskId);
            ApplicationType applicationType = processModel.getApplication();

            // track changes made by approvers.
            if (updates != null) {
                ProviderInformationType oldData = applicationType.getProviderInformation();
                // replace the current profile
                applicationType.setProviderInformation(updates);
                EditHistoryType editHistory = new EditHistoryType();
                editHistory.setEditedBy(user.getUserId());
                editHistory.setEditedByRole(user.getRole().getDescription());
                editHistory.setEditedOn(Calendar.getInstance());
                editHistory.setEditNote("Resubmitted");
                editHistory.setProviderInformation(oldData);
                processModel.getApplication().getSubmissionEditHistory().add(editHistory);
            }

            processModel.getApplication().getProviderInformation().setReviewedBy(user.getUserId());
            // reset verification whenever the request is resubmitted
            processModel.getApplication().getProviderInformation().setVerificationStatus(new VerificationStatusType());

            XMLUtility.moveToStatus(processModel, username, "PENDING", "Request was resubmitted with changes.");
            client.start(taskId, username);

            // recall/abort request
            client.complete(taskId, username, marshalContent(processModel, "Y"));
            utx.commit();

            // resubmit
            resubmit(user, processModel);
        } finally {
            client.dispose();
        }
    }


    /**
     * Retrieves the current model.
     *
     * @param client the client to be used
     * @param taskId the task id associated
     * @return the process model for the waiting task
     */
    @SuppressWarnings("unchecked")
    private ApplicationProcess getApplicationForReview(
            LocalTaskService client,
            long taskId
    ) throws IOException, ClassNotFoundException {
        Task task = client.getTask(taskId);
        Content content = client.getContent(task.getTaskData().getDocumentContentId());
        ByteArrayInputStream bis = new ByteArrayInputStream(content.getContent());
        ObjectInputStream in = new ObjectInputStream(bis);
        Map<String, Object> taskModel = (Map<String, Object>) in.readObject();
        in.close();
        return (ApplicationProcess) taskModel.get("ProcessModel");
    }

    /**
     * Submits the given application.
     *
     * @param user     the user performing the action
     * @param applicationId the application id to be submitted
     * @throws PortalServiceException for any errors encountered
     */
    public void submitApplication(
            CMSUser user,
            long applicationId
    ) throws PortalServiceException {
        UserTransaction ut = context.getUserTransaction();
        try {
            Application application = providerService.getApplicationWithScreenings(user, applicationId).
                orElseThrow(() -> new PortalServiceException("Couldn't find application"));

            if (!ViewStatics.DRAFT_STATUS.equals(application.getStatus().getDescription())) {
                throw new PortalServiceException("Cannot submit application because it is not in draft status.");
            }

            application.setStatus(findLookupByDescription(ApplicationStatus.class, ViewStatics.PENDING_STATUS));
            application.setSubmittedBy(user);
            application.setSubmissionDate(Calendar.getInstance().getTime());
            application.setStatusDate(Calendar.getInstance().getTime());

            try {
                if (isApplicationRequest(application)) {
                    long processInstance = enroll(XMLAdapter.toXML(application));
                    application.setProcessInstanceId(processInstance);
                }
            } catch (Exception e) {
                throw new PortalServiceException("Submission caused an error, see logs for details.", e);
            }

            ut.begin();
            application.setLastUpdatedBy(user);
            getEm().merge(application);
            ut.commit();
        } catch (Exception e) {
            throw new PortalServiceException("Submission caused an error, see logs for details.", e);
        }
    }

    private boolean isApplicationRequest(Application application) {
        List<String> applicationRequestTypes = Arrays.asList(
                ViewStatics.APPLICATION_REQUEST,
                ViewStatics.RENEWAL_REQUEST,
                ViewStatics.UPDATE_REQUEST
        );
        return applicationRequestTypes.contains(
                application.getRequestType().getDescription()
        );
    }

    /**
     * Converts the process model to the output content data.
     *
     * @param processModel the process model
     * @return the content data model
     * @throws IOException if the objects cannot be written.
     */
    private ContentData marshalContent(
            ApplicationProcess processModel,
            String isAbort
    ) throws IOException {
        Map<String, Object> data = new HashMap<>();
        data.put("model", processModel);
        data.put("isAbort", isAbort);
        ByteArrayOutputStream bos = new ByteArrayOutputStream();
        ObjectOutputStream out = new ObjectOutputStream(bos);
        out.writeObject(data);
        out.close();
        ContentData contentData = new ContentData();
        contentData.setContent(bos.toByteArray());
        contentData.setAccessType(AccessType.Inline);
        return contentData;
    }
}
