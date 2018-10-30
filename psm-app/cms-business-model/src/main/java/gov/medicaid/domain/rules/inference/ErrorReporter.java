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

package gov.medicaid.domain.rules.inference;

import gov.medicaid.domain.model.OperationStatusType;
import gov.medicaid.domain.model.StatusMessageType;
import gov.medicaid.domain.model.StatusMessagesType;
import gov.medicaid.domain.model.ValidationResultType;

/**
 * This is a wrapper to the validation result entity to allow quickly adding messages from the rules.
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
