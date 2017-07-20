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
package gov.medicaid.services.impl;

import com.topcoder.util.log.Level;
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
import org.drools.SystemEventListenerFactory;
import org.drools.runtime.StatefulKnowledgeSession;
import org.drools.runtime.process.ProcessInstance;
import org.drools.runtime.process.WorkItemHandler;
import org.jbpm.process.instance.impl.demo.SystemOutWorkItemHandler;
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

@Stateless
@Local(BusinessProcessService.class)
@TransactionManagement(TransactionManagementType.BEAN)
public class BusinessProcessServiceBean extends BaseService implements BusinessProcessService {

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
     * Persistence for provider enrollment.
     */
    @EJB
    private ProviderEnrollmentService providerService;

    @Resource
    private EJBContext context;

    /**
     * Persistence unit.
     */
    @PersistenceUnit(unitName = "cms")
    private EntityManagerFactory emf;

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
        handlers.put("Auto Disqualification", new DisqualificationHandler());
        handlers.put("Auto Screening", new ScreeningHandler());
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
            EnrollmentProcess processModel = new XMLSerializingEnrollmentProcess();
            processModel.setSessionId(ksession.getId());
            processModel.setEnrollment(enrollment);
            params.put("model", processModel);
            ksession.insert(processModel);
            ksession.addEventListener(new EnrollmentMonitor());
            ProcessInstance process = ksession.startProcess("gov.medicaid.process.enrollment", params);
            if (utx.getStatus() == Status.STATUS_ACTIVE && owner) {
                utx.commit();
            }
            return process.getId();
        } finally {
            if (ksession != null) {
                try {
                    ksession.dispose();
                } catch (Throwable t) {
                    getLog().log(Level.ERROR, t, "Could not close session.");
                }
            }
        }
    }

    private void resubmit(
            String user,
            EnrollmentProcess processModel
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
            ksession.addEventListener(new EnrollmentMonitor());
            ProcessInstance process = ksession.startProcess("gov.medicaid.process.enrollment", params);
            long processId = process.getId();
            String ticketId = processModel.getEnrollment().getObjectId();
            Enrollment ticket = providerService.getTicketDetails(getSystemUser(), Long.parseLong(ticketId));
            ticket.setProcessInstanceId(processId);
            ticket.setLastUpdatedBy(user);
            getEm().merge(ticket);
            utx.commit();
        } finally {
            try {
                ksession.dispose();
            } catch (Throwable t) {
                getLog().log(Level.ERROR, t, "Could not close session.");
            }
        }
    }

    private EntityManagerFactory getEmf() {
        return emf;
    }

    /**
     * Starts the renewal process.
     *
     * @param ticket         the renewal request
     * @param currentProfile the current profile for this provider
     * @return the process instance id.
     * @throws Exception for any errors encountered
     */
    public long renew(
            EnrollmentType ticket,
            EnrollmentType currentProfile
    ) throws Exception {
        return enroll(ticket);
    }

    /**
     * Starts the update process.
     *
     * @param ticket         the update request
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
    public EnrollmentProcess getTaskModel(long taskId) throws Exception {
        LocalTaskService client = new LocalTaskService(new TaskService(getEmf(), SystemEventListenerFactory.getSystemEventListener()));
        try {
            return getEnrollmentForReview(client, taskId);
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

            EnrollmentProcess processModel = getEnrollmentForReview(client, taskId);
            ksession = reloadSessionById(utx, client, processModel);
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

            client.start(taskId, username);
            client.complete(taskId, username, marshalContent(processModel, "N"));
            utx.commit();
        } finally {
            try {
                ksession.dispose();
            } catch (Throwable t) {
                getLog().log(Level.ERROR, t, "Could not close session.");
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
            EnrollmentProcess processModel
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
            EnrollmentType ticket,
            String user,
            String userRole
    ) throws Exception {
        UserTransaction utx = context.getUserTransaction();
        final ProviderInformationType updates = ticket.getProviderInformation();

        if (userRole.equals(ViewStatics.ROLE_PROVIDER)) {
            if (!user.equals(ticket.getSubmittedBy())) {
                throw new PortalServiceException("Only the submitter and administrators are allowed to modify pending submissions.");
            }
        }

        // use process admin to recall submission
        String username = "Administrator";
        List<String> adminRole = Arrays.asList(ViewStatics.ROLE_SVC_ADMIN);

        LocalTaskService client = new LocalTaskService(new TaskService(getEmf(), SystemEventListenerFactory.getSystemEventListener()));

        List<TaskSummary> tasks = client.getTasksAssignedAsPotentialOwner(username, adminRole, "en-UK", -1, -1);
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
            utx.begin();
            client.claim(taskId, username);

            EnrollmentProcess processModel = getEnrollmentForReview(client, taskId);
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
    private EnrollmentProcess getEnrollmentForReview(
            LocalTaskService client,
            long taskId
    ) throws IOException, ClassNotFoundException {
        Task task = client.getTask(taskId);
        Content content = client.getContent(task.getTaskData().getDocumentContentId());
        ByteArrayInputStream bis = new ByteArrayInputStream(content.getContent());
        ObjectInputStream in = new ObjectInputStream(bis);
        Map<String, Object> taskModel = (Map<String, Object>) in.readObject();
        in.close();
        return (EnrollmentProcess) taskModel.get("ProcessModel");
    }

    /**
     * Submits the given ticket.
     *
     * @param user     the user performing the action
     * @param ticketId the ticket id to be submitted
     * @throws PortalServiceException for any errors encountered
     */
    public void submitTicket(
            CMSUser user,
            long ticketId
    ) throws PortalServiceException {
        UserTransaction ut = context.getUserTransaction();
        try {
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

            ut.begin();
            ticket.setLastUpdatedBy(user.getUserId());
            getEm().merge(ticket);
            ut.commit();
        } catch (Exception e) {
            throw new PortalServiceException("Submission caused an error, see logs for details.", e);
        }
    }

    /**
     * Converts the process model to the output content data.
     *
     * @param processModel the process model
     * @return the content data model
     * @throws IOException if the objects cannot be written.
     */
    private ContentData marshalContent(
            EnrollmentProcess processModel,
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
