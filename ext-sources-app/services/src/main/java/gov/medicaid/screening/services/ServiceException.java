/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.screening.services;

import javax.ejb.ApplicationException;

/**
 * This exception is thrown for any errors encountered at the service level.
 *
 * @author argolite, j3_guile
 * @version 1.0
 */
@ApplicationException
public class ServiceException extends Exception {

    /**
     * Creates a new instance using the provided exception message.
     *
     * @param message the exception message
     */
    public ServiceException(String message) {
        super(message);
    }

    /**
     * Creates a new instance using the provided exception message and the underlying cause.
     *
     * @param message the exception message
     * @param cause the cause of the exception
     */
    public ServiceException(String message, Throwable cause) {
        super(message, cause);
    }
}