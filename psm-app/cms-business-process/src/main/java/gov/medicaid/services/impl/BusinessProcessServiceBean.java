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

import gov.medicaid.binders.XMLUtility;
import gov.medicaid.domain.model.EditHistoryType;
import gov.medicaid.domain.model.EnrollmentProcess;
import gov.medicaid.domain.model.EnrollmentType;
import gov.medicaid.domain.model.ProviderInformationType;
import gov.medicaid.domain.model.VerificationStatusType;
import gov.medicaid.domain.rules.RulesExecutor;
import gov.medicaid.entities.CMSUser;
import gov.medicaid.entities.Enrollment;
import gov.medicaid.entities.EnrollmentStatus;
import gov.medicaid.entities.ProviderProfile;
import gov.medicaid.entities.dto.ViewStatics;
import gov.medicaid.process.enrollment.AcceptedHandler;
import gov.medicaid.process.enrollment.EnrollmentProcessUtils;
import gov.medicaid.process.enrollment.ExcludedProvidersScreeningHandler;
import gov.medicaid.process.enrollment.PreProcessHandler;
import gov.medicaid.process.enrollment.RejectedHandler;
import gov.medicaid.process.enrollment.ScreeningHandler;
import gov.medicaid.process.enrollment.ValidationHandler;
import gov.medicaid.services.BusinessProcessService;
import gov.medicaid.services.CMSConfigurator;
import gov.medicaid.services.NotificationService;
import gov.medicaid.services.PortalServiceException;
import gov.medicaid.services.ProviderEnrollmentService;
import gov.medicaid.services.util.XMLAdapter;
import org.drools.SystemEventListenerFactory;
import org.drools.runtime.process.WorkItemHandler;
import org.jbpm.task.query.TaskSummary;
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
import javax.transaction.UserTransaction;
import java.util.Arrays;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Logger;

import static java.util.logging.Level.SEVERE;

@Stateless
@Local(BusinessProcessService.class)
@TransactionManagement(TransactionManagementType.BEAN)
public class BusinessProcessServiceBean extends BaseService implements BusinessProcessService {
    private final Logger logger = Logger.getLogger(getClass().getName());

    /**
     * See https://issues.jboss.org/browse/JBPM-3791
     * <p>
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
        handlers.put("Auto Screening", new ScreeningHandler());
        handlers.put("Accept Application", new AcceptedHandler(notificationService));

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
        Long processId;
        try {
            processId = RulesExecutor.startEnrollmentProcess(enrollment,
                handlers.entrySet(),
                getEmf(), context);
        } catch (Throwable t) {
            logger.log(SEVERE, "Could not close session.", t);
            throw t;
        }
        return processId;
    }

    private void resubmit(
        String user,
        EnrollmentProcess processModel
    ) throws Exception {
        RulesExecutor.resubmitEnrollment(user, getSystemUser(),
            processModel, handlers.entrySet(), providerService, getEmf(),
            getEm(), context);
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
    public long update(EnrollmentType ticket,
        EnrollmentType currentProfile) throws Exception {
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
            client = new LocalTaskService(new TaskService(getEmf(),
                SystemEventListenerFactory.getSystemEventListener()));
            utx.commit();
            return client.getTasksAssignedAsPotentialOwner("Administrator", roles,
                LOCALE);
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
        LocalTaskService client = new LocalTaskService(new TaskService(getEmf(),
            SystemEventListenerFactory.getSystemEventListener()));
        try {
            return EnrollmentProcessUtils.getEnrollmentForReview(client, taskId);
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

        String username = "Administrator";
        RulesExecutor.completeEnrollmentReview(username, approver, comment, updates,
            taskId, roles, handlers.entrySet(), getEmf(), context);
    }

    /**
     * @param ticket   the update request
     * @param user     the user performing the update
     * @param userRole the role of the user
     * @throws Exception
     */
    public void updateRequest(
        EnrollmentType ticket,
        String user,
        String userRole
    ) throws Exception {
        UserTransaction utx = context.getUserTransaction();
        final ProviderInformationType updates = ticket.getProviderInformation();

        if (userRole.equals(ViewStatics.ROLE_PROVIDER)) {
            if (!user.equals(ticket.getSubmittedBy())) {
                throw new PortalServiceException(
                    "Only the submitter and administrators are allowed to modify pending submissions.");
            }
        }

        // use process admin to recall submission
        String username = "Administrator";
        List<String> adminRole = Arrays.asList(
            ViewStatics.ROLE_SERVICE_ADMINISTRATOR
        );

        LocalTaskService client = new LocalTaskService(new TaskService(getEmf(),
            SystemEventListenerFactory.getSystemEventListener()));

        List<TaskSummary> tasks = client.getTasksAssignedAsPotentialOwner(username,
            adminRole, "en-UK", -1, -1);
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

            EnrollmentProcess processModel = EnrollmentProcessUtils.getEnrollmentForReview(
                client,
                taskId);
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
            processModel.getEnrollment().getProviderInformation().setVerificationStatus(
                new VerificationStatusType());

            XMLUtility.moveToStatus(processModel, username, "PENDING",
                "Request was resubmitted with changes.");
            client.start(taskId, username);

            // recall/abort request
            client.complete(taskId, username,
                EnrollmentProcessUtils.marshalEnrollmentProcess(
                    processModel, "Y"));
            utx.commit();

            // resubmit
            resubmit(user, processModel);
        } finally {
            client.dispose();
        }
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
                throw new PortalServiceException(
                    "Cannot submit ticket because it is not in draft status.");
            }

            ticket.setStatus(findLookupByDescription(EnrollmentStatus.class,
                ViewStatics.PENDING_STATUS));
            ticket.setSubmittedBy(user.getUserId());
            ticket.setSubmissionDate(Calendar.getInstance().getTime());
            ticket.setStatusDate(Calendar.getInstance().getTime());

            try {
                if (ViewStatics.ENROLLMENT_REQUEST.equals(
                    ticket.getRequestType().getDescription())) {
                    long processInstance = enroll(XMLAdapter.toXML(ticket));
                    ticket.setProcessInstanceId(processInstance);

                } else if (ViewStatics.RENEWAL_REQUEST.equals(
                    ticket.getRequestType().getDescription())) {
                    ProviderProfile baseProfile = providerService.getProviderDetails(user,
                        ticket.getDetails()
                            .getProfileId());
                    long processInstance = renew(XMLAdapter.toXML(ticket),
                        XMLAdapter.toXML(baseProfile));
                    ticket.setProcessInstanceId(processInstance);

                } else if (ViewStatics.UPDATE_REQUEST.equals(
                    ticket.getRequestType().getDescription())) {
                    ProviderProfile baseProfile = providerService.getProviderDetails(user,
                        ticket.getDetails()
                            .getProfileId());
                    long processInstance = update(XMLAdapter.toXML(ticket),
                        XMLAdapter.toXML(baseProfile));
                    ticket.setProcessInstanceId(processInstance);
                }
            } catch (Exception e) {
                throw new PortalServiceException(
                    "Submission caused an error, see logs for details.", e);
            }

            ut.begin();
            ticket.setLastUpdatedBy(user.getUserId());
            getEm().merge(ticket);
            ut.commit();
        } catch (Exception e) {
            throw new PortalServiceException(
                "Submission caused an error, see logs for details.", e);
        }
    }
}
