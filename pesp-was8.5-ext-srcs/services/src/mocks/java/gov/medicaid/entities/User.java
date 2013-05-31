/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.entities;

import java.util.List;

/**
 * Represents a user.
 *
 * @author argolite, j3_guile
 * @version 1.0
 */
public class User {

    /**
     * Prefix.
     */
    private String prefix;

    /**
     * Suffix.
     */
    private String suffix;

    /**
     * The username.
     */
    private String username;

    /**
     * The email address.
     */
    private String email;

    /**
     * The first name.
     */
    private String firstName;

    /**
     * The last name.
     */
    private String lastName;

    /**
     * The middle name.
     */
    private String middleName;

    /**
     * The provider profile.
     */
    private ProviderProfile profile;

    /**
     * The user role.
     */
    private Role role;

    /**
     * The user status.
     */
    private UserStatus status;

    /**
     * The user permissions.
     */
    private List<UserPermission> permissions;

    /**
     * Default empty constructor.
     */
    public User() {
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

    /**
     * Gets the value of the field <code>profile</code>.
     *
     * @return the profile
     */
    public ProviderProfile getProfile() {
        return profile;
    }

    /**
     * Sets the value of the field <code>profile</code>.
     *
     * @param profile the profile to set
     */
    public void setProfile(ProviderProfile profile) {
        this.profile = profile;
    }

    /**
     * Gets the value of the field <code>role</code>.
     *
     * @return the role
     */
    public Role getRole() {
        return role;
    }

    /**
     * Sets the value of the field <code>role</code>.
     *
     * @param role the role to set
     */
    public void setRole(Role role) {
        this.role = role;
    }

    /**
     * Gets the value of the field <code>status</code>.
     *
     * @return the status
     */
    public UserStatus getStatus() {
        return status;
    }

    /**
     * Sets the value of the field <code>status</code>.
     *
     * @param status the status to set
     */
    public void setStatus(UserStatus status) {
        this.status = status;
    }

    /**
     * Gets the value of the field <code>permissions</code>.
     *
     * @return the permissions
     */
    public List<UserPermission> getPermissions() {
        return permissions;
    }

    /**
     * Sets the value of the field <code>permissions</code>.
     *
     * @param permissions the permissions to set
     */
    public void setPermissions(List<UserPermission> permissions) {
        this.permissions = permissions;
    }

    /**
     * Gets the value of the field <code>prefix</code>.
     *
     * @return the prefix
     */
    public String getPrefix() {
        return prefix;
    }

    /**
     * Sets the value of the field <code>prefix</code>.
     *
     * @param prefix the prefix to set
     */
    public void setPrefix(String prefix) {
        this.prefix = prefix;
    }

    /**
     * Gets the value of the field <code>suffix</code>.
     *
     * @return the suffix
     */
    public String getSuffix() {
        return suffix;
    }

    /**
     * Sets the value of the field <code>suffix</code>.
     *
     * @param suffix the suffix to set
     */
    public void setSuffix(String suffix) {
        this.suffix = suffix;
    }

}
