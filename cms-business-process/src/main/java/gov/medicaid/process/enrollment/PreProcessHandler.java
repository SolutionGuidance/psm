/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.process.enrollment;

import gov.medicaid.binders.XMLUtility;
import gov.medicaid.domain.model.EnrollmentProcess;
import gov.medicaid.domain.model.LicenseInformationType;
import gov.medicaid.domain.model.LicenseType;
import gov.medicaid.domain.model.PostSubmissionInformationType;
import gov.medicaid.domain.model.ProcessAuditType;
import gov.medicaid.domain.model.ProcessResultsType;
import gov.medicaid.domain.model.ProviderInformationType;
import gov.medicaid.domain.model.RequestType;
import gov.medicaid.domain.model.ValidationResultType;
import gov.medicaid.domain.model.VerificationStatusType;

import java.util.List;
import java.util.logging.Logger;

import org.drools.runtime.process.WorkItem;
import org.drools.runtime.process.WorkItemManager;

/**
 * This initializes the application model.
 *
 * @author TCSASSEMBLER
 * @version 1.0
 */
public class PreProcessHandler extends GenericHandler {

    /**
     * The logger for this class.
     */
    private Logger logger = Logger.getLogger(PreProcessHandler.class.getName());

    /**
     * Aborts the work item.
     *
     * @param item the work item to abort
     * @param manager the work item manager
     */
    public void abortWorkItem(WorkItem item, WorkItemManager manager) {
        manager.abortWorkItem(item.getId());
    }

    /**
     * Initializes the process variable.
     *
     * @param item the work item to abort
     * @param manager the work item manager
     */
    public void executeWorkItem(WorkItem item, WorkItemManager manager) {
        logger.info("Initializing the enrollment process model.");
        EnrollmentProcess processModel = (EnrollmentProcess) item.getParameter("model");

        // clear post submission data, it will be set by the rules
        processModel.setPostSubmissionInformation(new PostSubmissionInformationType());
        if (processModel.getEnrollment().getRequestType() == RequestType.ENROLLMENT) {
            LicenseInformationType licenseInfo = XMLUtility.nsGetLicenseInformation(processModel);
            List<LicenseType> licenseList = licenseInfo.getLicense();
            for (LicenseType licenseType : licenseList) {
                licenseType.setVerified(null);
            }

            processModel.getEnrollment().setRiskLevel(null);

            // clear any verification status that is set by caller
            ProviderInformationType provider = XMLUtility.nsGetProvider(processModel);
            provider.setVerificationStatus(new VerificationStatusType());
        }

        // associate with the process instance
        ProcessAuditType processAudit = XMLUtility.nsGetProcessAudit(processModel);
        processAudit.setProcessInstanceId("" + item.getProcessInstanceId());

        // set default validation status
        ValidationResultType validationResult = XMLUtility.nsGetValidationResult(processModel);
        validationResult.setStatus(XMLUtility.newStatus("SUCCESS"));

        ProcessResultsType processResult = XMLUtility.nsGetProcessResults(processModel);
        processResult.setValidationResult(validationResult);

        XMLUtility.moveToStatus(processModel, processModel.getEnrollment().getSubmittedBy(), "SUBMITTED", null);
        item.getResults().put("model", processModel);
        manager.completeWorkItem(item.getId(), item.getResults());
    }
}