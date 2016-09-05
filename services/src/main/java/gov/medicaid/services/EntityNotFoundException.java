/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.services;

import javax.ejb.ApplicationException;

import com.topcoder.util.errorhandling.ExceptionData;

/**
 * This exception is thrown by update and delete methods if an entity was not found.
 *
 * @author argolite, TCSASSEMBLER
 * @version 1.0
 */
@ApplicationException
public class EntityNotFoundException extends PortalServiceException {

    /**
     * Creates a new exception instance with this error message.
     *
     * @param message - the error message
     */
    public EntityNotFoundException(String message) {
        super(message);
    }

    /**
     * Creates a new exception instance with this error message and cause of error.
     *
     * @param message the error message
     * @param cause the underlying cause
     */
    public EntityNotFoundException(String message, Throwable cause) {
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
    public EntityNotFoundException(String message, ExceptionData data) {
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
    public EntityNotFoundException(String message, Throwable cause, ExceptionData data) {
        super(message, cause, data);
    }
}