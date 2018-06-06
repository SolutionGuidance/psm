package gov.medicaid.domain.rules;

import gov.medicaid.domain.model.EditHistoryType;
import gov.medicaid.domain.model.EnrollmentProcess;
import gov.medicaid.domain.model.EnrollmentType;
import gov.medicaid.domain.model.ProviderInformationType;
import gov.medicaid.domain.model.UISection;
import gov.medicaid.domain.model.ValidationResponse;
import gov.medicaid.domain.model.ValidationResultType;
import gov.medicaid.domain.rules.inference.LookupEntry;
import gov.medicaid.entities.CMSUser;
import gov.medicaid.entities.Enrollment;
import gov.medicaid.process.enrollment.EnrollmentMonitor;
import gov.medicaid.process.enrollment.EnrollmentProcessUtils;
import gov.medicaid.services.ProviderEnrollmentService;
import gov.medicaid.services.impl.LocalHumanTaskHandler;
import gov.medicaid.services.impl.XMLSerializingEnrollmentProcess;

import org.drools.SystemEventListenerFactory;
import org.drools.runtime.StatefulKnowledgeSession;
import org.drools.runtime.process.ProcessInstance;
import org.drools.runtime.process.WorkItemHandler;
import org.drools.runtime.process.WorkItemManager;
import org.jbpm.task.service.TaskService;
import org.jbpm.task.service.local.LocalTaskService;

import javax.ejb.EJBContext;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.transaction.Status;
import javax.transaction.UserTransaction;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.logging.Logger;

import static java.util.logging.Level.SEVERE;

/**
 * This class handles all KnowledgeSession operations.
 */
public class RulesExecutor {

    private static final Logger logger = Logger.getLogger(RulesExecutor.class.getName());

    private RulesExecutor() {
    }

    /**
     * Uses the front-end validation rules to check the provider profile.
     *
     * @param request the validation request
     * @return ValidationResponse the validation messages.
     */
    public static ValidationResponse executeProviderValidationRules(
        gov.medicaid.domain.model.ValidationRequest request) {

        StatefulKnowledgeSession ksession = CMSKnowledgeUtility.newValidationSession();
        try {
            gov.medicaid.domain.model.ValidationResultType validationResultType = new ValidationResultType();
            List<LookupEntry> allLookupEntries = GlobalLookups.getInstance().getAllLookupEntries();

            for (LookupEntry thisLookupEntry : allLookupEntries) {
                ksession.insert(thisLookupEntry);
            }

            // configure sections to validate
            if ("Y".equals(request.getPartial())) {
                List<UISection> uiSections = request.getSections();
                for (UISection thisUISection : uiSections) {
                    ksession.insert(new LookupEntry("UISection", thisUISection.value(),
                        thisUISection.value()));
                }
            }

            ProviderInformationType providerInformationType =
                request.getEnrollment().getProviderInformation();
            ksession.insert(request.getEnrollment());
            ksession.insert(providerInformationType);
            ksession.insert(validationResultType);
            ksession.fireAllRules();

            ValidationResponse validationResponse = new ValidationResponse();
            validationResponse.setValidationResult(validationResultType);
            return validationResponse;
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

    /**
     * @param enrollmentProcess
     * @param validationResultType
     */
    public static void executeProviderScreeningRules(
        gov.medicaid.domain.model.EnrollmentProcess enrollmentProcess,
        gov.medicaid.domain.model.ValidationResultType validationResultType) {

        StatefulKnowledgeSession ksession =
            CMSKnowledgeUtility.newScreeningValidationSession();
        try {
            ksession.insert(enrollmentProcess.getPostSubmissionInformation());
            gov.medicaid.domain.model.EnrollmentType enrollmentType = enrollmentProcess.getEnrollment();
            ksession.insert(enrollmentType);
            ksession.insert(enrollmentType.getProviderInformation());
            ksession.insert(
                enrollmentType.getProviderInformation().getVerificationStatus());
            ksession.insert(enrollmentProcess.getProcessResults().getScreeningResults());
            ksession.insert(validationResultType);
            List<LookupEntry> allLookupEntries = GlobalLookups.getInstance().getAllLookupEntries();
            for (LookupEntry thisLookupEntry : allLookupEntries) {
                ksession.insert(thisLookupEntry);
            }
            ksession.fireAllRules();
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

    /**
     * @param enrollment
     * @param workItemHandlerEntrySet
     * @param entityManagerFactory
     * @param ejbContext
     * @return long     the EnrollmentProcess id
     * @throws Exception
     */
    public static long startEnrollmentProcess(EnrollmentType enrollment,
        Set<Map.Entry<String, WorkItemHandler>> workItemHandlerEntrySet,
        EntityManagerFactory entityManagerFactory, EJBContext ejbContext)
        throws Exception {

        long processId;
        StatefulKnowledgeSession ksession = null;
        try {
            UserTransaction tx = ejbContext.getUserTransaction();
            boolean isTxLocal = false;
            if (tx.getStatus() == Status.STATUS_NO_TRANSACTION) {
                tx.begin();
                isTxLocal = true;
            }
            ksession = CMSKnowledgeUtility.newWorkflowSession(
                entityManagerFactory, tx);
            WorkItemManager workItemManager = ksession.getWorkItemManager();

            for (Map.Entry<String, WorkItemHandler> thisEntry : workItemHandlerEntrySet) {
                workItemManager.registerWorkItemHandler(thisEntry.getKey(),
                    thisEntry.getValue());
            }
            Map<String, Object> params = new HashMap<>();
            EnrollmentProcess enrollmentProcess = new XMLSerializingEnrollmentProcess();
            enrollmentProcess.setSessionId(ksession.getId());
            enrollmentProcess.setEnrollment(enrollment);
            params.put("model", enrollmentProcess);
            ksession.insert(enrollmentProcess);
            ksession.addEventListener(new EnrollmentMonitor());
            ProcessInstance process = ksession.startProcess(
                "gov.medicaid.process.enrollment",
                params);
            if (tx.getStatus() == Status.STATUS_ACTIVE && isTxLocal) {
                tx.commit();
            }
            processId = process.getId();
        } catch (Throwable t) {
            logger.log(SEVERE, "Exception starting Enrollment process.", t);
            throw t;
        } finally {
            if (ksession != null) {
                try {
                    ksession.dispose();
                } catch (Throwable t) {
                    logger.log(SEVERE, "Could not close session.", t);
                }
            }
        }
        return processId;
    }

    /**
     * @param user
     * @param systemUser
     * @param enrollmentProcess
     * @param workItemHandlerEntrySet
     * @param providerEnrollmentService
     * @param entityManagerFactory
     * @param entityManager
     * @param ejbContext
     * @throws Exception
     */
    public static void resubmitEnrollment(CMSUser user, CMSUser systemUser,
        EnrollmentProcess enrollmentProcess,
        Set<Map.Entry<String, WorkItemHandler>> workItemHandlerEntrySet,
        ProviderEnrollmentService providerEnrollmentService,
        EntityManagerFactory entityManagerFactory, EntityManager entityManager,
        EJBContext ejbContext) throws Exception {

        StatefulKnowledgeSession ksession = null;
        try {
            UserTransaction tx = ejbContext.getUserTransaction();
            tx.begin();
            ksession = CMSKnowledgeUtility.newWorkflowSession(entityManagerFactory,
                tx);
            WorkItemManager workItemManager = ksession.getWorkItemManager();
            for (Map.Entry<String, WorkItemHandler> thisEntry : workItemHandlerEntrySet) {
                workItemManager.registerWorkItemHandler(thisEntry.getKey(),
                    thisEntry.getValue());
            }

            Map<String, Object> params = new HashMap<>();
            enrollmentProcess.setSessionId(ksession.getId());
            params.put("model", enrollmentProcess);
            ksession.insert(enrollmentProcess);
            ksession.addEventListener(new EnrollmentMonitor());
            ProcessInstance processInstance = ksession.startProcess(
                "gov.medicaid.process.enrollment", params);
            long processId = processInstance.getId();
            String objectId = enrollmentProcess.getEnrollment().getObjectId();
            Enrollment ticket = providerEnrollmentService.getTicketDetails(systemUser,
                Long.parseLong(objectId));
            ticket.setProcessInstanceId(processId);
            ticket.setLastUpdatedBy(user);
            entityManager.merge(ticket);
            tx.commit();
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

    /**
     * @param username
     * @param approver
     * @param comment
     * @param updates
     * @param taskId
     * @param roles
     * @param workItemHandlerEntrySet
     * @param entityManagerFactory
     * @param ejbContext
     * @throws Exception
     */
    public static void completeEnrollmentReview(
        String username, String approver, String comment,
        ProviderInformationType updates, long taskId, List<String> roles,
        Set<Map.Entry<String, WorkItemHandler>> workItemHandlerEntrySet,
        EntityManagerFactory entityManagerFactory,
        EJBContext ejbContext) throws Exception {

        LocalTaskService localTaskService = new LocalTaskService(
            new TaskService(entityManagerFactory,
                SystemEventListenerFactory.getSystemEventListener()));
        StatefulKnowledgeSession ksession = null;
        try {
            UserTransaction tx = ejbContext.getUserTransaction();
            tx.begin();

            localTaskService.claim(taskId, username, roles);
            EnrollmentProcess enrollmentForReview =
                EnrollmentProcessUtils.getEnrollmentForReview(
                    localTaskService,
                    taskId);
            ksession = reloadSessionById(enrollmentForReview, localTaskService,
                workItemHandlerEntrySet, entityManagerFactory, tx);
            EnrollmentType enrollment = enrollmentForReview.getEnrollment();

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
                enrollment.getSubmissionEditHistory().add(
                    editHistory);
            }
            enrollment.getProviderInformation().setReviewedBy(
                approver);
            localTaskService.start(taskId, username);
            localTaskService.complete(taskId, username,
                EnrollmentProcessUtils.marshalEnrollmentProcess(enrollmentForReview,
                    "N"));
            tx.commit();
        } finally {
            try {
                if (null != ksession) {
                    ksession.dispose();
                }
            } catch (Throwable t) {
                logger.log(SEVERE, "Could not close session.", t);
                if (null != localTaskService) {
                    localTaskService.dispose();
                }
            }
        }
    }

    /**
     * Reloads the knowledge session with the given id.
     *
     * @param enrollmentProcess
     * @param workItemHandlerEntrySet
     * @param entityManagerFactory
     * @param tx
     * @return StatefulKnowledgeSession the reloaded session
     */
    private static StatefulKnowledgeSession reloadSessionById(
        EnrollmentProcess enrollmentProcess,
        LocalTaskService client,
        Set<Map.Entry<String, WorkItemHandler>> workItemHandlerEntrySet,
        EntityManagerFactory entityManagerFactory,
        UserTransaction tx) throws Exception {

        Integer enrollmentProcessSessionId = enrollmentProcess.getSessionId();
        if (null == enrollmentProcessSessionId) {
            throw new Exception("no EnrollmentProcessId found");
        }
        StatefulKnowledgeSession ksession = null;

        // this is a workaround based on https://issues.jboss.org/browse/JBPM-3673
        ksession = CMSKnowledgeUtility.reloadWorkflowSession(enrollmentProcessSessionId,
            entityManagerFactory, tx);
        LocalHumanTaskHandler handler = new LocalHumanTaskHandler(ksession, client);
        ksession.getWorkItemManager().registerWorkItemHandler("Human Task", handler);
        for (Map.Entry<String, WorkItemHandler> thisEntry : workItemHandlerEntrySet) {
            ksession.getWorkItemManager().registerWorkItemHandler(thisEntry.getKey(),
                thisEntry.getValue());
            ksession.signalEvent("Trigger", null);
        }
        return ksession;
    }

}
