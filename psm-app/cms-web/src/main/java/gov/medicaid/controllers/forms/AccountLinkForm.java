/*
 * Copyright 2012, 2013 TopCoder, Inc.
 * Copyright 2018 The MITRE Corporation
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package gov.medicaid.controllers.forms;

import java.io.Serializable;

/**
 * Account link creation form.
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
