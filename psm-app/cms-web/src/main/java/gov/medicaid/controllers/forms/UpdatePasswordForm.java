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

/**
 * Update password form.
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
