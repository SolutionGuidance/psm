/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.entities;

/**
 * Represents an appeal.
 *
 * @author argolite, j3_guile
 * @version 1.0
 */
public class Appeal extends LookupEntity {

    /**
     * The appeal description.
     */
    private String description;

    /**
     * Default empty constructor.
     */
    public Appeal() {
    }

    /**
     * Gets the value of the field <code>description</code>.
     *
     * @return the description
     */
    public String getDescription() {
        return description;
    }

    /**
     * Sets the value of the field <code>description</code>.
     *
     * @param description the description to set
     */
    public void setDescription(String description) {
        this.description = description;
    }
}
