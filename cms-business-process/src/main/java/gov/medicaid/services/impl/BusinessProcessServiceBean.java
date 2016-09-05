/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.services.impl;

import gov.medicaid.binders.XMLUtility;
import gov.medicaid.domain.model.EditHistoryType;
import gov.medicaid.domain.model.EnrollmentProcess;
import gov.medicaid.domain.model.EnrollmentType;
import gov.medicaid.domain.model.ProviderInformationType;
import gov.medicaid.domain.model.VerificationStatusType;
import gov.medicaid.domain.rules.CMSKnowledgeUtility;
import gov.medicaid.entities.CMSUser;
import gov.medicaid.entities.Enrollment;
import gov.medicaid.entities.EnrollmentStatus;
import gov.medicaid.entities.ProviderProfile;
import gov.medicaid.entities.dto.ViewStatics;
import gov.medicaid.process.enrollment.AcceptedHandler;
import gov.medicaid.process.enrollment.DisqualificationHandler;
import gov.medicaid.process.enrollment.EnrollmentHistoryHandler;
import gov.medicaid.process.enrollment.EnrollmentMonitor;
import gov.medicaid.process.enrollment.ExcludedProvidersScreeningHandler;
import gov.medicaid.process.enrollment.NPILookupHandler;
import gov.medicaid.process.enrollment.PreProcessHandler;
import gov.medicaid.process.enrollment.RejectedHandler;
import gov.medicaid.process.enrollment.SAMExcludedProvidersScreeningHandler;
import gov.medicaid.process.enrollment.ScreeningHandler;
import gov.medicaid.process.enrollment.ValidationHandler;
import gov.medicaid.process.enrollment.VerifyLicenseHandler;
import gov.medicaid.process.enrollment.VerifySSNHandler;
import gov.medicaid.services.BusinessProcessService;
import gov.medicaid.services.CMSConfigurator;
import gov.medicaid.services.PortalServiceException;
import gov.medicaid.services.ProviderEnrollmentService;
import gov.medicaid.services.util.XMLAdapter;

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

import javax.annotation.PostConstruct;
import javax.ejb.EJB;
import javax.ejb.Local;
import javax.ejb.Stateless;
import javax.ejb.TransactionAttribute;
import javax.ejb.TransactionAttributeType;
import javax.ejb.TransactionManagement;
import javax.ejb.TransactionManagementType;

import org.drools.SystemEventListenerFactory;
import org.drools.runtime.StatefulKnowledgeSession;
import org.drools.runtime.process.ProcessInstance;
import org.drools.runtime.process.WorkItemHandler;
import org.jbpm.process.instance.impl.demo.SystemOutWorkItemHandler;
import org.jbpm.process.workitem.wsht.BlockingGetTaskResponseHandler;
import org.jbpm.process.workitem.wsht.CommandBasedWSHumanTaskHandler;
import org.jbpm.task.AccessType;
import org.jbpm.task.Task;
import org.jbpm.task.query.TaskSummary;
import org.jbpm.task.service.ContentData;
import org.jbpm.task.service.TaskClient;
import org.jbpm.task.service.mina.MinaTaskClientConnector;
import org.jbpm.task.service.mina.MinaTaskClientHandler;
import org.jbpm.task.service.responsehandlers.BlockingGetContentResponseHandler;
import org.jbpm.task.service.responsehandlers.BlockingTaskOperationResponseHandler;
import org.jbpm.task.service.responsehandlers.BlockingTaskSummaryResponseHandler;

/**
 * A local implementation of the Enrollment service. For process testing purposes.
 *
 * @author TCSASSEMBLER
 * @version 1.0
 */
@Stateless
@Local(BusinessProcessService.class)
@TransactionAttribute(TransactionAttributeType.REQUIRED)
@TransactionManagement(TransactionManagementType.CONTAINER)
public class BusinessProcessServiceBean extends BaseService implements BusinessProcessService {

    /**
     * Maximum time to wait for asynchronous methods.
     */
    private static final int ASYNC_TIMEOUT = 10000;

    /**
     * See https://issues.jboss.org/browse/JBPM-3791
     *
     * To use a different parameter, override the default handler in getTaskClient().
     */
    private static final String LOCALE = "en-UK";

    /**
     * List of handlers to be registered to workflow sessions.
     */
    private final Map<String, WorkItemHandler> handlers = new HashMap<String, WorkItemHandler>();

    /**
     * Persistence for provider enrollment.
     */
    @EJB
    private ProviderEnrollmentService providerService;

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
        handlers.put("PreProcess", new PreProcessHandler());
        handlers.put("Validate", new ValidationHandler());
        handlers.put("Data Transformation", new SystemOutWorkItemHandler());
        handlers.put("Reject Application", new RejectedHandler());
        handlers.put("Get Enrollment History", new EnrollmentHistoryHandler());
        handlers.put("Verify SSN", new VerifySSNHandler());
        handlers.put("NPI Lookup", new NPILookupHandler());
        handlers.put("Verify License or Certification", new VerifyLicenseHandler());
        handlers.put("Check Excluded Provider List in OIG", new ExcludedProvidersScreeningHandler());
        handlers.put("Check Excluded Provider List in SAM", new SAMExcludedProvidersScreeningHandler());
        handlers.put("Auto Screening", new ScreeningHandler());
        handlers.put("Auto Disqualification", new DisqualificationHandler());
        handlers.put("Send Mailbox Account Request", new SystemOutWorkItemHandler());
        handlers.put("Background Check", new SystemOutWorkItemHandler());
        handlers.put("SIRS", new SystemOutWorkItemHandler());
        handlers.put("Accept Application", new AcceptedHandler());

        CMSConfigurator config = new CMSConfigurator();
        if (providerService == null) {
            providerService = config.getEnrollmentService();
        }
    }

    /**
     * Starts a new enrollment process.
     *
     * @param enrollment the enrollment requested
     * @return the process instance id
     * @throws Exception for any errors encountered
     */
    public long enroll(EnrollmentType enrollment) throws Exception {
        StatefulKnowledgeSession ksession = CMSKnowledgeUtility.newWorkflowSession();
        Set<Entry<String, WorkItemHandler>> entrySet = handlers.entrySet();
        for (Entry<String, WorkItemHandler> entry : entrySet) {
            ksession.getWorkItemManager().registerWorkItemHandler(entry.getKey(), entry.getValue());
        }
        
        Map<String, Object> params = new HashMap<String, Object>();
        EnrollmentProcess processModel = new XMLSerializingEnrollmentProcess();
        processModel.setSessionId(ksession.getId());
        processModel.setEnrollment(enrollment);
        params.put("model", processModel);
        ksession.insert(processModel);
        ksession.addEventListener(new EnrollmentMonitor());
        ProcessInstance process = ksession.startProcess("gov.medicaid.process.enrollment", params);
        return process.getId();
    }

    /**
     * Starts the renewal process.
     *
     * @param ticket the renewal request
     * @param currentProfile the current profile for this provider
     * @return the process instance id.
     * @throws Exception for any errors encountered
     */
    public long renew(EnrollmentType ticket, EnrollmentType currentProfile) throws Exception {
        return enroll(ticket);
    }

    /**
     * Starts the update process.
     *
     * @param ticket the update request
     * @param currentProfile the current profile for this provider
     * @return the process instance id.
     * @throws Exception for any errors encountered
     */
    public long update(EnrollmentType ticket, EnrollmentType currentProfile) throws Exception {
        return enroll(ticket);
    }

    /**
     * Retrieves the available tasks for the given user and roles.
     *
     * @param username the user to get the tasks for
     * @param roles the roles of the user
     * @return all tasks that the user can claim or already owns
     * @throws Exception for any errors encountered
     */
    public List<TaskSummary> getAvailableTasks(String username, List<String> roles) throws Exception {
        CMSKnowledgeUtility.ensureTaskServiceStarted();
        TaskClient client = getTaskClient();
        client.connect();
        try {
            BlockingTaskSummaryResponseHandler responseHandler = new BlockingTaskSummaryResponseHandler();
            client.getTasksAssignedAsPotentialOwner("Administrator", roles, LOCALE, responseHandler);
            responseHandler.waitTillDone(ASYNC_TIMEOUT);
            return responseHandler.getResults();
        } finally {
            client.disconnect();
        }
    }

    /**
     * Retrieves the current state of the process execution.
     *
     * @param taskId the task id to get the current details for
     * @return all tasks that the user can claim or already owns
     * @throws Exception for any errors encountered
     */
    public EnrollmentProcess getTaskModel(long taskId) throws Exception {
        CMSKnowledgeUtility.ensureTaskServiceStarted();
        TaskClient client = getTaskClient();
        client.connect();
        try {
            return getEnrollmentForReview(client, taskId);
        } finally {
            client.disconnect();
        }
    }

    /**
     * Completes the given task.
     *
     * @param taskId the task to be completed
     * @param approver the user performing the task
     * @param roles the roles of the user
     * @param reject flag if the results are rejected
     * @param updates the changes
     * @param comment the change comments
     * @throws Exception for any errors encountered
     */
    public void completeReview(final long taskId, String approver, List<String> roles,
        final ProviderInformationType updates, boolean reject, String comment) throws Exception {
        String username = "Administrator";
        TaskClient client = getTaskClient();
        client.connect();
        try {
            BlockingTaskOperationResponseHandler responseHandler = null;
            responseHandler = new BlockingTaskOperationResponseHandler();
            client.claim(taskId, username, roles, responseHandler);
            responseHandler.waitTillDone(ASYNC_TIMEOUT);

            EnrollmentProcess processModel = getEnrollmentForReview(client, taskId);
            Integer session = processModel.getSessionId();
            if (session != null) {
                // this is a workaround based on https://issues.jboss.org/browse/JBPM-3673
                StatefulKnowledgeSession ksession = CMSKnowledgeUtility.reloadWorkflowSession(session);
                CommandBasedWSHumanTaskHandler handler = new CommandBasedWSHumanTaskHandler(ksession);
                ksession.getWorkItemManager().registerWorkItemHandler("Human Task", handler);
                Set<Entry<String, WorkItemHandler>> entrySet = handlers.entrySet();
                for (Entry<String, WorkItemHandler> entry : entrySet) {
                    ksession.getWorkItemManager().registerWorkItemHandler(entry.getKey(), entry.getValue());
                }
                handler.connect();
                ksession.signalEvent("Trigger", null);
                client.disconnect();
                client = getTaskClient();
                client.connect();
            }
            EnrollmentType enrollment = processModel.getEnrollment();

            // track changes made by approvers.
            if (updates != null) {
                ProviderInformationType oldData = enrollment.getProviderInformation();
                // replace the current profile
                enrollment.setProviderInformation(updates);
                EditHistoryType editHistory = new EditHistoryType();
                editHistory.setEditedBy(approver);
                editHistory.setEditedByRole(roles.toString());
                editHistory.setEditedOn(Calendar.getInstance());
                editHistory.setEditNote(comment);
                editHistory.setProviderInformation(oldData);
                processModel.getEnrollment().getSubmissionEditHistory().add(editHistory);
            }

            processModel.getEnrollment().getProviderInformation().setReviewedBy(approver);

            XMLUtility.moveToStatus(processModel, username, reject ? "REJECTED" : "ACCEPTED", comment);
            responseHandler = new BlockingTaskOperationResponseHandler();
            client.start(taskId, username, responseHandler);
            responseHandler.waitTillDone(ASYNC_TIMEOUT);

            responseHandler = new BlockingTaskOperationResponseHandler();
            client.complete(taskId, username, marshalContent(processModel), responseHandler);
            responseHandler.waitTillDone(ASYNC_TIMEOUT);

        } finally {
            client.disconnect();
        }
    }
    
    /**
     * Completes the given task.
     *
     * @param taskId the task to be completed
     * @param user the user performing the task
     * @param roles the roles of the user
     * @param reject flag if the results are rejected
     * @param updates the changes
     * @param comment the change comments
     * @throws Exception for any errors encountered
     */
    public void updateRequest(EnrollmentType ticket, String user, String userRole) throws Exception {
        final ProviderInformationType updates = ticket.getProviderInformation();
        
        if (userRole.equals(ViewStatics.ROLE_PROVIDER)) {
            if (!user.equals(ticket.getSubmittedBy())) {
                throw new PortalServiceException("Only the submitter and administrators are allowed to modify pending submissions.");
            }
        }
        
        // use process admin to recall submission
        String username = "Administrator";
        List<String> adminRole = Arrays.asList(ViewStatics.ROLE_SVC_ADMIN);
        
        TaskClient client = getTaskClient();
        client.connect();

        List<TaskSummary> tasks = getAvailableTasks(username, adminRole);
        long taskId = 0;
        for (TaskSummary taskSummary : tasks) {
            if (ticket.getProcessInstanceId() == taskSummary.getProcessInstanceId()) {
                taskId = taskSummary.getId();
                break;
            }
        }
        if (taskId == 0) {
            throw new PortalServiceException("Request was not found in pending queue.");
        }
        
        try {
            BlockingTaskOperationResponseHandler responseHandler = null;
            responseHandler = new BlockingTaskOperationResponseHandler();
            client.claim(taskId, username, adminRole, responseHandler);
            responseHandler.waitTillDone(ASYNC_TIMEOUT);

            EnrollmentProcess processModel = getEnrollmentForReview(client, taskId);
            Integer session = processModel.getSessionId();
            if (session != null) {
                // this is a workaround based on https://issues.jboss.org/browse/JBPM-3673
                StatefulKnowledgeSession ksession = CMSKnowledgeUtility.reloadWorkflowSession(session);
                CommandBasedWSHumanTaskHandler handler = new CommandBasedWSHumanTaskHandler(ksession);
                ksession.getWorkItemManager().registerWorkItemHandler("Human Task", handler);
                Set<Entry<String, WorkItemHandler>> entrySet = handlers.entrySet();
                for (Entry<String, WorkItemHandler> entry : entrySet) {
                    ksession.getWorkItemManager().registerWorkItemHandler(entry.getKey(), entry.getValue());
                }
                handler.connect();
                ksession.signalEvent("Trigger", null);
                client.disconnect();
                client = getTaskClient();
                client.connect();
            }
            EnrollmentType enrollment = processModel.getEnrollment();

            // track changes made by approvers.
            if (updates != null) {
                ProviderInformationType oldData = enrollment.getProviderInformation();
                // replace the current profile
                enrollment.setProviderInformation(updates);
                EditHistoryType editHistory = new EditHistoryType();
                editHistory.setEditedBy(user);
                editHistory.setEditedByRole(userRole);
                editHistory.setEditedOn(Calendar.getInstance());
                editHistory.setEditNote("Resubmitted");
                editHistory.setProviderInformation(oldData);
                processModel.getEnrollment().getSubmissionEditHistory().add(editHistory);
            }

            processModel.getEnrollment().getProviderInformation().setReviewedBy(user);
            // reset verification whenever the request is resubmitted
            processModel.getEnrollment().getProviderInformation().setVerificationStatus(new VerificationStatusType());
            
            XMLUtility.moveToStatus(processModel, username, "PENDING", "Request was resubmitted with changes.");
            responseHandler = new BlockingTaskOperationResponseHandler();
            client.start(taskId, username, responseHandler);
            responseHandler.waitTillDone(ASYNC_TIMEOUT);

            responseHandler = new BlockingTaskOperationResponseHandler();
            client.complete(taskId, username, marshalContent(processModel), responseHandler);
            responseHandler.waitTillDone(ASYNC_TIMEOUT);

        } finally {
            client.disconnect();
        }
    }


    /**
     * Submits the given ticket.
     *
     * @param user the user performing the action
     * @param ticketId the ticket id to be submitted
     * @throws PortalServiceException for any errors encountered
     */
    public void submitTicket(CMSUser user, long ticketId) throws PortalServiceException {
        Enrollment ticket = providerService.getTicketDetails(user, ticketId);

        if (!ViewStatics.DRAFT_STATUS.equals(ticket.getStatus().getDescription())) {
            throw new PortalServiceException("Cannot submit ticket because it is not in draft status.");
        }

        ticket.setStatus(findLookupByDescription(EnrollmentStatus.class, ViewStatics.PENDING_STATUS));
        ticket.setSubmittedBy(user.getUserId());
        ticket.setSubmissionDate(Calendar.getInstance().getTime());
        ticket.setStatusDate(Calendar.getInstance().getTime());

        try {
            if (ViewStatics.ENROLLMENT_REQUEST.equals(ticket.getRequestType().getDescription())) {
                long processInstance = enroll(XMLAdapter.toXML(ticket));
                ticket.setProcessInstanceId(processInstance);

            } else if (ViewStatics.RENEWAL_REQUEST.equals(ticket.getRequestType().getDescription())) {
                ProviderProfile baseProfile = providerService.getProviderDetails(user, ticket.getDetails()
                    .getProfileId());
                long processInstance = renew(XMLAdapter.toXML(ticket), XMLAdapter.toXML(baseProfile));
                ticket.setProcessInstanceId(processInstance);

            } else if (ViewStatics.UPDATE_REQUEST.equals(ticket.getRequestType().getDescription())) {
                ProviderProfile baseProfile = providerService.getProviderDetails(user, ticket.getDetails()
                    .getProfileId());
                long processInstance = update(XMLAdapter.toXML(ticket), XMLAdapter.toXML(baseProfile));
                ticket.setProcessInstanceId(processInstance);
            }
        } catch (Exception e) {
            throw new PortalServiceException("Submission caused an error, see logs for details.", e);
        }

        ticket.setLastUpdatedBy(user.getUserId());
        getEm().merge(ticket);
    }

    /**
     * Converts the process model to the output content data.
     *
     * @param processModel the process model
     * @return the content data model
     * @throws IOException if the objects cannot be written.
     */
    private ContentData marshalContent(EnrollmentProcess processModel) throws IOException {
        ContentData contentData = null;
        Map<String, Object> data = new HashMap<String, Object>();
        data.put("model", processModel);
        ByteArrayOutputStream bos = new ByteArrayOutputStream();
        ObjectOutputStream out = new ObjectOutputStream(bos);
        out.writeObject(data);
        out.close();
        contentData = new ContentData();
        contentData.setContent(bos.toByteArray());
        contentData.setAccessType(AccessType.Inline);
        return contentData;
    }

    /**
     * Retrieves the current model.
     *
     * @param client the client to be used
     * @param taskId the task id associated
     * @return the process model for the waiting task
     * @throws Exception for any errors encountered
     */
    @SuppressWarnings("unchecked")
    private EnrollmentProcess getEnrollmentForReview(TaskClient client, final long taskId) throws Exception {
        Task task = getTask(taskId, client);
        BlockingGetContentResponseHandler getContentResponseHandler = new BlockingGetContentResponseHandler();
        client.getContent(task.getTaskData().getDocumentContentId(), getContentResponseHandler);
        getContentResponseHandler.waitTillDone(ASYNC_TIMEOUT);

        ByteArrayInputStream bis = new ByteArrayInputStream(getContentResponseHandler.getContent().getContent());
        ObjectInputStream in = new ObjectInputStream(bis);
        Map<String, Object> taskModel = (Map<String, Object>) in.readObject();
        in.close();
        return (EnrollmentProcess) taskModel.get("ProcessModel");
    }

    /**
     * Retrieves the given task by id.
     *
     * @param taskId the task id to retrieve
     * @param client the client to use
     * @return the task with the given id
     */
    private Task getTask(final long taskId, TaskClient client) {
        BlockingGetTaskResponseHandler getTaskResponse = new BlockingGetTaskResponseHandler();
        client.getTask(taskId, getTaskResponse);
        getTaskResponse.waitTillDone(ASYNC_TIMEOUT);
        Task task = getTaskResponse.getTask();
        return task;
    }

    /**
     * Create a task service client.
     *
     * @return a task service client
     */
    private TaskClient getTaskClient() {
        CMSKnowledgeUtility.ensureTaskServiceStarted();
        TaskClient client = new TaskClient(new MinaTaskClientConnector("HumanTaskClient", new MinaTaskClientHandler(
            SystemEventListenerFactory.getSystemEventListener())));
        return client;
    }
}
