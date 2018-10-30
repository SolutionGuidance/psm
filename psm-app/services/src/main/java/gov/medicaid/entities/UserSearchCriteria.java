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

package gov.medicaid.entities;

import java.util.List;

/**
 * Represents a user search criteria.
 */
public class UserSearchCriteria extends SearchCriteria {

    /**
     * The username.
     */
    private String username;

    /**
     * The last name.
     */
    private String lastName;

    /**
     * The first name.
     */
    private String firstName;

    /**
     * Full flag.
     */
    private boolean full;

    /**
     * Email flag.
     */
    private String email;

    /**
     * Roles.
     */
    private List<String> roles;

    /**
     * Specifies that the search should be "AND" related.
     * Defaults to false to preserve existing behavior.
     */
    private boolean and = true;

    /**
     * Indicates to show the filter panel or not.
     */
    private boolean showFilterPanel;

    /**
     * Represents the search is from search box or not.
     */
    private boolean searchBox;

    /**
     * Default empty constructor.
     */
    public UserSearchCriteria() {
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
     * Gets the value of the field <code>lastName</code>.
     * @return the lastName
     */
    public String getLastName() {
        return lastName;
    }

    /**
     * Sets the value of the field <code>lastName</code>.
     * @param lastName the lastName to set
     */
    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    /**
     * Gets the value of the field <code>firstName</code>.
     * @return the firstName
     */
    public String getFirstName() {
        return firstName;
    }

    /**
     * Sets the value of the field <code>firstName</code>.
     * @param firstName the firstName to set
     */
    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    /**
     * Gets the value of the field <code>full</code>.
     * @return the full
     */
    public boolean isFull() {
        return full;
    }

    /**
     * Sets the value of the field <code>full</code>.
     * @param full the full to set
     */
    public void setFull(boolean full) {
        this.full = full;
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

    /**
     * Gets the value of the field <code>roles</code>.
     * @return the roles
     */
    public List<String> getRoles() {
        return roles;
    }

    /**
     * Sets the value of the field <code>roles</code>.
     * @param roles the roles to set
     */
    public void setRoles(List<String> roles) {
        this.roles = roles;
    }

    /**
     * Gets the value of the field <code>searchBox</code>.
     * @return the searchBox
     */
    public boolean isSearchBox() {
        return searchBox;
    }

    /**
     * Sets the value of the field <code>searchBox</code>.
     * @param searchBox the searchBox to set
     */
    public void setSearchBox(boolean searchBox) {
        this.searchBox = searchBox;
    }

    /**
     * Gets the value of the field <code>and</code>.
     * @return the and
     */
    public boolean isAnd() {
        return and;
    }

    /**
     * Sets the value of the field <code>and</code>.
     * @param and the and to set
     */
    public void setAnd(boolean and) {
        this.and = and;
    }

    /**
     * Gets the value of the field <code>showFilterPanel</code>.
     * @return the showFilterPanel
     */
    public boolean isShowFilterPanel() {
        return showFilterPanel;
    }

    /**
     * Sets the value of the field <code>showFilterPanel</code>.
     * @param showFilterPanel the showFilterPanel to set
     */
    public void setShowFilterPanel(boolean showFilterPanel) {
        this.showFilterPanel = showFilterPanel;
    }
}
