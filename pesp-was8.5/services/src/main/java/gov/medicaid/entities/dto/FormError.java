/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.entities.dto;

/**
 * Holder for validation errors.
 *
 * @author TCSASSEMBLER
 * @version 1.0
 */
public class FormError {

    /**
     * The field with the error.
     */
    private String fieldId;

    /**
     * The error message.
     */
    private String message;

    /**
     * Empty constructor.
     */
    public FormError() {
    }

    /**
     * Gets the value of the field <code>fieldId</code>.
     *
     * @return the fieldId
     */
    public String getFieldId() {
        return fieldId;
    }

    /**
     * Sets the value of the field <code>fieldId</code>.
     *
     * @param fieldId the fieldId to set
     */
    public void setFieldId(String fieldId) {
        this.fieldId = fieldId;
    }

    /**
     * Gets the value of the field <code>message</code>.
     *
     * @return the message
     */
    public String getMessage() {
        return message;
    }

    /**
     * Sets the value of the field <code>message</code>.
     *
     * @param message the message to set
     */
    public void setMessage(String message) {
        this.message = message;
    }

    /**
     * To string.
     *
     * @return string representation of this object.
     */
    public String toString() {
        return "FormError [fieldId=" + fieldId + ", message=" + message + "]";
    }
}
