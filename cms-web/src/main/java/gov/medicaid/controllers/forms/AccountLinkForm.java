/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.controllers.forms;

import java.io.Serializable;

/**
 * Account link creation form.
 *
 * @author TCSASSEMBLER
 * @version 1.0
 */
public class AccountLinkForm implements Serializable {

    /**
     * System id.
     */
    private String systemId;

    /**
     * Account id.
     */
    private String accountId;

    /**
     * Password.
     */
    private String password;

    /**
     * Empty constructor.
     */
    public AccountLinkForm() {
    }

    /**
     * Gets the value of the field <code>systemId</code>.
     *
     * @return the systemId
     */
    public String getSystemId() {
        return systemId;
    }

    /**
     * Sets the value of the field <code>systemId</code>.
     *
     * @param systemId the systemId to set
     */
    public void setSystemId(String systemId) {
        this.systemId = systemId;
    }

    /**
     * Gets the value of the field <code>accountId</code>.
     *
     * @return the accountId
     */
    public String getAccountId() {
        return accountId;
    }

    /**
     * Sets the value of the field <code>accountId</code>.
     *
     * @param accountId the accountId to set
     */
    public void setAccountId(String accountId) {
        this.accountId = accountId;
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
}
