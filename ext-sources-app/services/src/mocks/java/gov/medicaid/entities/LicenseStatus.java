/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.entities;

import java.util.Date;

/**
 * Represents a permit type.
 *
 * @author argolite, j3_guile
 * @version 1.0
 */
public class LicenseStatus extends LookupEntity {

    /**
     * License status date.
     */
    private Date date;

    /**
     * Default empty constructor.
     */
    public LicenseStatus() {
    }

    /**
     * Gets the value of the field <code>date</code>.
     * @return the date
     */
    public Date getDate() {
        return date;
    }

    /**
     * Sets the value of the field <code>date</code>.
     * @param date the date to set
     */
    public void setDate(Date date) {
        this.date = date;
    }
}
