/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.controllers.forms;

/**
 * Forgot password form.
 *
 * @author TCSASSEMBLER
 * @version 1.0
 */
public class ForgotPasswordForm {

    /**
     * The username.
     */
    private String username;

    /**
     * The email address.
     */
    private String email;

    /**
     * Empty constructor.
     */
    public ForgotPasswordForm() {
    }

    /**
     * Gets the value of the field <code>username</code>.
     * @return the username
     */
    public String getUsername() {
        return username;
    }

    /**
     * Sets the value of the field <code>username</code>.
     * @param username the username to set
     */
    public void setUsername(String username) {
        this.username = username;
    }

    /**
     * Gets the value of the field <code>email</code>.
     * @return the email
     */
    public String getEmail() {
        return email;
    }

    /**
     * Sets the value of the field <code>email</code>.
     * @param email the email to set
     */
    public void setEmail(String email) {
        this.email = email;
    }
}
