/*
 * Copyright (C) 2013 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.screening.services.impl;

/**
 * This exception is thrown for all configuration related errors.
 *
 * @author cyberjag
 * @version 1.0
 */
public class ConfigurationException extends RuntimeException {

    /**
     * Creates a new instance using the provided exception message.
     *
     * @param message the exception message
     */
    public ConfigurationException(String message) {
        super(message);
    }

    /**
     * Creates a new instance using the provided exception message and the underlying cause.
     *
     * @param message the exception message
     * @param cause the cause of the exception
     */
    public ConfigurationException(String message, Throwable cause) {
        super(message, cause);
    }
}
