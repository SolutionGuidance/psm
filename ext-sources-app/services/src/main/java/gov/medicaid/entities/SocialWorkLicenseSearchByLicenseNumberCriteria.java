/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.entities;

/**
 * Represents the search criteria for social work licenses by their numbers.
 *
 * <b>Thread Safety</b> This class is mutable and not thread safe.
 *
 * @author argolite, j3_guile
 * @version 1.0
 */
public class SocialWorkLicenseSearchByLicenseNumberCriteria extends SocialWorkCriteria {

    /**
     * The license number.
     */
    private long licenseNumber;

    /**
     * Default empty constructor.
     */
    public SocialWorkLicenseSearchByLicenseNumberCriteria() {
    }

    /**
     * Gets the value of the field <code>licenseNumber</code>.
     *
     * @return the licenseNumber
     */
    public long getLicenseNumber() {
        return licenseNumber;
    }

    /**
     * Sets the value of the field <code>licenseNumber</code>.
     *
     * @param licenseNumber the licenseNumber to set
     */
    public void setLicenseNumber(long licenseNumber) {
        this.licenseNumber = licenseNumber;
    }
}