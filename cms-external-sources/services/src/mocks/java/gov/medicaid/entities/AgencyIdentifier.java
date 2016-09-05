/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.entities;

/**
 * Maps the EPLS agency ids. http://apps.topcoder.com/forums/?module=Thread&threadID=759419&start=0&mc=10#1597113
 *
 * @author sampath01, j3_guile
 * @version 1.0
 */
public class AgencyIdentifier {

    /**
     * Type.
     */
    private String type;

    /**
     * Value.
     */
    private String value;

    /**
     * Default empty constructor.
     */
    public AgencyIdentifier() {
    }

    /**
     * Gets the value of the field <code>type</code>.
     *
     * @return the type
     */
    public String getType() {
        return type;
    }

    /**
     * Sets the value of the field <code>type</code>.
     *
     * @param type the type to set
     */
    public void setType(String type) {
        this.type = type;
    }

    /**
     * Gets the value of the field <code>value</code>.
     *
     * @return the value
     */
    public String getValue() {
        return value;
    }

    /**
     * Sets the value of the field <code>value</code>.
     *
     * @param value the value to set
     */
    public void setValue(String value) {
        this.value = value;
    }
}
