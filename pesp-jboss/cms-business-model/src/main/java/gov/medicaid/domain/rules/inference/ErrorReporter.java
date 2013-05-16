/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.domain.rules.inference;

import gov.medicaid.domain.model.OperationStatusType;
import gov.medicaid.domain.model.StatusMessageType;
import gov.medicaid.domain.model.StatusMessagesType;
import gov.medicaid.domain.model.ValidationResultType;

/**
 * This is a wrapper to the validation result entity to allow quickly adding messages from the rules.
 *
 * @author TCSASSEMBLER
 * @version 1.0
 */
public class ErrorReporter {

    /**
     * The wrapped validation result entity.
     */
    private final ValidationResultType result;

    /**
     * Creates a new error reporter for the given result. By default, validation is successful, if any errors are
     * marked, then it is set to an appropriate status.
     *
     * @param result the result object to be wrapped
     */
    public ErrorReporter(ValidationResultType result) {
        if (result.getStatus() == null) {
            OperationStatusType status = new OperationStatusType();
            result.setStatus(status);
            status.setStatusCode("SUCCESS");
        }
        this.result = result;
    }

    /**
     * This function creates or appends a new error message to the current validation results.
     *
     * @param path - the path to the element (in case there are name conflicts, this identifies the validated field)
     * @param code - the error code to be issued
     * @param message - the validation message
     */
    public void addError(String path, String code, String message) {
        OperationStatusType status = result.getStatus();
        if (status.getStatusMessages() == null) {
            status.setStatusMessages(new StatusMessagesType());
        }

        // add a new error message to be presented to the caller
        StatusMessageType error = new StatusMessageType();
        error.setSeverity("ERROR");
        error.setRelatedElementPath(path);
        error.setCode(code);
        error.setMessage(message);
        status.getStatusMessages().getStatusMessage().add(error);

        // if any error exists, validation is marked as failed
        status.setStatusCode("FAILURE");
    }

    /**
     * Returns the current validation result.
     *
     * @return the wrapped result.
     */
    public ValidationResultType getResult() {
        return result;
    }
}
