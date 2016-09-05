/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.controllers.dto;

/**
 * This class is used to return an AJAX response.
 *
 * @author TCSASSEMBLER
 * @version 1.0
 * @since Medicaid Provider Screening Portal - Service Agent Controllers
 */
public class StatusDTO {

    /**
     * True for successful execution.
     */
    private boolean success;

    /**
     * Status message.
     */
    private String message;

    /**
     * Empty constructor.
     */
    public StatusDTO() {

    }

    /**
     * Gets the value of the field <code>success</code>.
     *
     * @return the success
     */
    public boolean isSuccess() {
        return success;
    }

    /**
     * Sets the value of the field <code>success</code>.
     *
     * @param success the success to set
     */
    public void setSuccess(boolean success) {
        this.success = success;
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
}
