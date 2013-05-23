/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.entities;

/**
 * Represents a user permission.
 *
 * @author argolite, j3_guile
 * @version 1.0
 */
public class UserPermission {

    /**
     * The action.
     */
    private String action;

    /**
     * The permission status.
     */
    private boolean permission;

    /**
     * Default empty constructor.
     */
    public UserPermission() {
    }

    /**
     * Gets the value of the field <code>action</code>.
     *
     * @return the action
     */
    public String getAction() {
        return action;
    }

    /**
     * Sets the value of the field <code>action</code>.
     *
     * @param action the action to set
     */
    public void setAction(String action) {
        this.action = action;
    }

    /**
     * Gets the value of the field <code>permission</code>.
     *
     * @return the permission
     */
    public boolean isPermission() {
        return permission;
    }

    /**
     * Sets the value of the field <code>permission</code>.
     *
     * @param permission the permission to set
     */
    public void setPermission(boolean permission) {
        this.permission = permission;
    }
}
