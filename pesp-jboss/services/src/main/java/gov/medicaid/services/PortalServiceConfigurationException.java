/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.services;

import com.topcoder.util.errorhandling.BaseRuntimeException;
import com.topcoder.util.errorhandling.ExceptionData;

/**
 * This exception is thrown by implementations' init methods if there are required injection fields that are not
 * injected.
 *
 * @author argolite, TCSASSEMBLER
 * @version 1.0
 */
public class PortalServiceConfigurationException extends BaseRuntimeException {

    /**
     * Creates a new exception instance with this error message.
     *
     * @param message - the error message
     */
    public PortalServiceConfigurationException(String message) {
        super(message);
    }

    /**
     * Creates a new exception instance with this error message and cause of error.
     *
     * @param message the error message
     * @param cause the underlying cause
     */
    public PortalServiceConfigurationException(String message, Throwable cause) {
        super(message, cause);
    }

    /**
     * Creates a new exception instance with this error message and any additional data to attach to the exception.
     *
     *
     * @param message the error message
     * @param data additional data regarding the exception
     */
    public PortalServiceConfigurationException(String message, ExceptionData data) {
        super(message, data);
    }

    /**
     * Creates a new exception instance with this error message, cause of error, and any additional data to attach to
     * the exception.
     *
     *
     * @param message the error message
     * @param cause the underlying cause
     * @param data additional data regarding the exception
     */
    public PortalServiceConfigurationException(String message, Throwable cause, ExceptionData data) {
        super(message, cause, data);
    }
}
