/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.entities;

/**
 * This serves as the base class for all lookup entities.
 *
 * @author argolite, j3_guile
 * @version 1.0
 */
public abstract class LookupEntity extends IdentifiableEntity {

    /**
     * The lookup name.
     */
    private String name;

    /**
     * Default empty constructor.
     */
    public LookupEntity() {
    }

    /**
     * Gets the value of the field <code>name</code>.
     *
     * @return the name
     */
    public String getName() {
        return name;
    }

    /**
     * Sets the value of the field <code>name</code>.
     *
     * @param name the name to set
     */
    public void setName(String name) {
        this.name = name;
    }
}