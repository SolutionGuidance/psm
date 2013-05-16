/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.entities;

import java.io.Serializable;

/**
 * Represents a lookup entity.
 *
 * @author TCSASSEMBLER
 * @version 1.0
 */
public class LookupEntity implements Serializable {

    /**
     * Lookup code.
     */
    private String code;

    /**
     * Lookup description.
     */
    private String description;

    /**
     * Empty constructor.
     */
    public LookupEntity() {
    }

    /**
     * Gets the value of the field <code>code</code>.
     *
     * @return the code
     */
    public String getCode() {
        return code;
    }

    /**
     * Sets the value of the field <code>code</code>.
     *
     * @param code the code to set
     */
    public void setCode(String code) {
        this.code = code;
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
