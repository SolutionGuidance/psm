/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.controllers.forms;

/**
 * Update password form.
 *
 * @author TCSASSEMBLER
 * @version 1.0
 */
public class UpdatePasswordForm {

    /**
     * The old password.
     */
    private String oldPassword;

    /**
     * The new password.
     */
    private String password;

    /**
     * Confirm if typed correctly.
     */
    private String confirmPassword;

    /**
     * Empty constructor.
     */
    public UpdatePasswordForm() {
    }

    /**
     * Gets the value of the field <code>oldPassword</code>.
     *
     * @return the oldPassword
     */
    public String getOldPassword() {
        return oldPassword;
    }

    /**
     * Sets the value of the field <code>oldPassword</code>.
     *
     * @param oldPassword the oldPassword to set
     */
    public void setOldPassword(String oldPassword) {
        this.oldPassword = oldPassword;
    }

    /**
     * Gets the value of the field <code>password</code>.
     *
     * @return the password
     */
    public String getPassword() {
        return password;
    }

    /**
     * Sets the value of the field <code>password</code>.
     *
     * @param password the password to set
     */
    public void setPassword(String password) {
        this.password = password;
    }

    /**
     * Gets the value of the field <code>confirmPassword</code>.
     *
     * @return the confirmPassword
     */
    public String getConfirmPassword() {
        return confirmPassword;
    }

    /**
     * Sets the value of the field <code>confirmPassword</code>.
     *
     * @param confirmPassword the confirmPassword to set
     */
    public void setConfirmPassword(String confirmPassword) {
        this.confirmPassword = confirmPassword;
    }
}
