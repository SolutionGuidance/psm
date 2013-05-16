/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.entities;

/**
 * Represents a user status.
 *
 * @author TCSASSEMBLER
 * @version 1.0
 */
public enum SystemId {

    /**
     * CMS Online system.
     */
    CMS_ONLINE("CMSO"),

    /**
     * CMS Batch processing system.
     */
    CMS_BATCH("CMSB"),

    /**
     * CMS External sources system.
     */
    CMS_EXT_SRC("CMSX"),

    /**
     * MN ITS system.
     */
    MN_ITS("MNIT");

    /**
     * The value for the system.
     */
    private final String value;

    /**
     * Creates a new instance with the given value.
     * @param value the value to be assigned
     */
    private SystemId(String value) {
        this.value = value;
    }

    /**
     * Returns the value of this enumeration.
     *
     * @return the value of this instance
     */
    public String toString() {
        return value;
    }

    /**
     * Returns the value of this enumeration.
     *
     * @return the value of this instance
     */
    public String value() {
        return value;
    }

}
