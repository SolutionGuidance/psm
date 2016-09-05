/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.entities;

/**
 * Represents supported templates.
 *
 * @author TCSASSEMBLER
 * @version 1.0
 */
public enum EmailTemplate {

    /**
     * Email template for new registrations.
     */
    NEW_REGISTRATION,

    /**
     * Email template for new registrations.
     */
    NEW_REGISTRATION_BY_ADMIN,

    /**
     * Email template for logged in user initiated password change.
     */
    UPDATE_PASSWORD,

    /**
     * Email template for "forgot password" reset.
     */
    FORGOT_PASSWORD

}
