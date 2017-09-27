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

package gov.medicaid.services;

import javax.ejb.ApplicationException;

import com.topcoder.util.errorhandling.BaseRuntimeException;
import com.topcoder.util.errorhandling.ExceptionData;

/**
 * This is the top-level exception. It is thrown by all methods if there is an error.
 *
 * @author TCSASSEMBLER
 * @version 1.0
 */
@ApplicationException
public class PortalServiceRuntimeException extends BaseRuntimeException {

    /**
     * Creates a new exception instance with this error message.
     *
     * @param message - the error message
     */
    public PortalServiceRuntimeException(String message) {
        super(message);
    }

    /**
     * Creates a new exception instance with this error message and cause of error.
     *
     * @param message the error message
     * @param cause the underlying cause
     */
    public PortalServiceRuntimeException(String message, Throwable cause) {
        super(message, cause);
    }

    /**
     * Creates a new exception instance with this error message and any additional data to attach to the
     * exception.
     *
     *
     * @param message the error message
     * @param data additional data regarding the exception
     */
    public PortalServiceRuntimeException(String message, ExceptionData data) {
        super(message, data);
    }

    /**
     * Creates a new exception instance with this error message, cause of error, and any additional data to
     * attach to the exception.
     *
     *
     * @param message the error message
     * @param cause the underlying cause
     * @param data additional data regarding the exception
     */
    public PortalServiceRuntimeException(String message, Throwable cause, ExceptionData data) {
        super(message, cause, data);
    }
}