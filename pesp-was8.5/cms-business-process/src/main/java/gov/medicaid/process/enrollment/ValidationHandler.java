/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.process.enrollment;

import gov.medicaid.binders.XMLUtility;
import gov.medicaid.domain.model.EnrollmentProcess;

import java.util.logging.Logger;

import org.drools.runtime.process.WorkItem;
import org.drools.runtime.process.WorkItemManager;

/**
 * This is a mock handler for front-end validation.
 *
 * @author TCSASSEMBLER
 * @version 1.0
 */
public class ValidationHandler extends GenericHandler {

    /**
     * The logger for this class.
     */
    private Logger logger = Logger.getLogger(ValidationHandler.class.getName());

    /**
     * Mock validations.
     *
     * @param item the work item to abort
     * @param manager the work item manager
     */
    public void executeWorkItem(WorkItem item, WorkItemManager manager) {
        logger.info("Validating the provider.");
        EnrollmentProcess processModel = (EnrollmentProcess) item.getParameter("model");

        if (processModel.getEnrollment().getRequestType() == null) {
            XMLUtility.nsGetValidationResult(processModel).setStatus(XMLUtility.newStatus("FAILURE"));
        }

        item.getResults().put("model", processModel);
        manager.completeWorkItem(item.getId(), item.getResults());
    }
}