/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.entities;

/**
 * This represents a required field.
 *
 * @author argolite, TCSASSEMBLER
 * @version 1.0
 */
public class RequiredField extends LookupEntity {

    /**
     * The required field type.
     */
    private RequiredFieldType type;

    /**
     * Default empty constructor.
     */
    public RequiredField() {
    }

    /**
     * Gets the value of the field <code>type</code>.
     *
     * @return the type
     */
    public RequiredFieldType getType() {
        return type;
    }

    /**
     * Sets the value of the field <code>type</code>.
     *
     * @param type the type to set
     */
    public void setType(RequiredFieldType type) {
        this.type = type;
    }
}