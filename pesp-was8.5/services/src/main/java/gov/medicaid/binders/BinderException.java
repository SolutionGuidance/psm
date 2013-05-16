/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.binders;

import com.topcoder.util.errorhandling.BaseCriticalException;

/**
 * Exception for invalid data formats.
 *
 * @author TCSASSEMBLER
 * @version 1.0
 */
public class BinderException extends BaseCriticalException {

    /**
     * Cause of the bind exception.
     */
    private String parameterKey;

    /**
     * Cause of the bind exception.
     */
    private String parameterValue;

    /**
     * Creates an exception with the given message.
     * @param message the error message
     */
    public BinderException(String message) {
        super(message);
    }

    /**
     * Creates an exception with the given message and cause.
     * @param message the error message
     * @param cause the underlying cause
     */
    public BinderException(String message, Throwable cause) {
        super(message, cause);
    }

    public void setAttribute(String parameterKey, String parameterValue) {
        this.parameterKey = parameterKey;
        this.parameterValue = parameterValue;
    }

    /**
     * Gets the value of the field <code>parameterKey</code>.
     * @return the parameterKey
     */
    public String getParameterKey() {
        return parameterKey;
    }

    /**
     * Sets the value of the field <code>parameterKey</code>.
     * @param parameterKey the parameterKey to set
     */
    public void setParameterKey(String parameterKey) {
        this.parameterKey = parameterKey;
    }

    /**
     * Gets the value of the field <code>parameterValue</code>.
     * @return the parameterValue
     */
    public String getParameterValue() {
        return parameterValue;
    }

    /**
     * Sets the value of the field <code>parameterValue</code>.
     * @param parameterValue the parameterValue to set
     */
    public void setParameterValue(String parameterValue) {
        this.parameterValue = parameterValue;
    }
}
