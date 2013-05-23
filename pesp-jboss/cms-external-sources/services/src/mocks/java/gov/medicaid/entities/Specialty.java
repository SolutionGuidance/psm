/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.entities;

/**
 * This represents a specialty.
 *
 * @author argolite, j3_guile
 * @version 1.0
 */
public class Specialty extends LookupEntity {

    /**
     * The specialty code.
     */
    private long code;

    /**
     * The specialty type.
     */
    private SpecialtyType type;

    /**
     * Default empty constructor.
     */
    public Specialty() {
    }

    /**
     * Gets the value of the field <code>code</code>.
     *
     * @return the code
     */
    public long getCode() {
        return code;
    }

    /**
     * Sets the value of the field <code>code</code>.
     *
     * @param code the code to set
     */
    public void setCode(long code) {
        this.code = code;
    }

    /**
     * Gets the value of the field <code>type</code>.
     *
     * @return the type
     */
    public SpecialtyType getType() {
        return type;
    }

    /**
     * Sets the value of the field <code>type</code>.
     *
     * @param type the type to set
     */
    public void setType(SpecialtyType type) {
        this.type = type;
    }
}