/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.controllers.forms;

import java.io.Serializable;

/**
 * Contains all the fields needed during registration.
 *
 * @author TCSASSEMBLER
 * @version 1.0
 */
public class RegistrationForm implements Serializable {

    /**
     * Requested username.
     */
    private String username;

    /**
     * Email address.
     */
    private String email;

    /**
     * First name.
     */
    private String firstName;

    /**
     * Last name.
     */
    private String lastName;

    /**
     * Middle name.
     */
    private String middleName;

    /**
     * Empty constructor.
     */
    public RegistrationForm() {
    }

    /**
     * Gets the value of the field <code>username</code>.
     *
     * @return the username
     */
    public String getUsername() {
        return username;
    }

    /**
     * Sets the value of the field <code>username</code>.
     *
     * @param username the username to set
     */
    public void setUsername(String username) {
        this.username = username;
    }

    /**
     * Gets the value of the field <code>email</code>.
     *
     * @return the email
     */
    public String getEmail() {
        return email;
    }

    /**
     * Sets the value of the field <code>email</code>.
     *
     * @param email the email to set
     */
    public void setEmail(String email) {
        this.email = email;
    }

    /**
     * Gets the value of the field <code>firstName</code>.
     *
     * @return the firstName
     */
    public String getFirstName() {
        return firstName;
    }

    /**
     * Sets the value of the field <code>firstName</code>.
     *
     * @param firstName the firstName to set
     */
    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    /**
     * Gets the value of the field <code>lastName</code>.
     *
     * @return the lastName
     */
    public String getLastName() {
        return lastName;
    }

    /**
     * Sets the value of the field <code>lastName</code>.
     *
     * @param lastName the lastName to set
     */
    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    /**
     * Gets the value of the field <code>middleName</code>.
     *
     * @return the middleName
     */
    public String getMiddleName() {
        return middleName;
    }

    /**
     * Sets the value of the field <code>middleName</code>.
     *
     * @param middleName the middleName to set
     */
    public void setMiddleName(String middleName) {
        this.middleName = middleName;
    }
}
