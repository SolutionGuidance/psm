/*
 * Copyright (C) 2013 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.entities;

import java.io.Serializable;

/**
 * This entity holds agency data of SAMSearch web service response.
 *
 * @author flexme
 * @version 1.0
 */
public class SAMAgency implements Serializable {
    /**
     * Represents the uid type.
     */
    private String uidType;
    /**
     * Represents the uid value.
     */
    private String uidValue;

    /**
     * Empty constructor.
     */
    public SAMAgency() {
    }

    /**
     * Gets the uid type.
     *
     * @return the uid type.
     */
    public String getUidType() {
        return uidType;
    }

    /**
     * Sets the uid type.
     *
     * @param uidType the uid type.
     */
    public void setUidType(String uidType) {
        this.uidType = uidType;
    }

    /**
     * Gets the uid value.
     *
     * @return the uid value.
     */
    public String getUidValue() {
        return uidValue;
    }

    /**
     * Sets the uid value.
     *
     * @param uidValue the uid value.
     */
    public void setUidValue(String uidValue) {
        this.uidValue = uidValue;
    }
}
