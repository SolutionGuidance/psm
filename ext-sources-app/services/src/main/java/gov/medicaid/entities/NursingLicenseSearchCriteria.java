/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.entities;

import gov.medicaid.entities.LicenseType;

/**
 * This represents the search criteria for Nursing License.
 *
 * @author sampath01, j3_guile
 * @version 1.0
 */
public class NursingLicenseSearchCriteria extends SearchCriteria {

    /**
     * License type.
     */
    private LicenseType licenseType;

    /**
     * License check digit.
     */
    private String checkDigit;

    /**
     * Default empty constructor.
     */
    public NursingLicenseSearchCriteria() {
    }

    /**
     * Gets the value of the field <code>licenseType</code>.
     *
     * @return the licenseType
     */
    public LicenseType getLicenseType() {
        return licenseType;
    }

    /**
     * Sets the value of the field <code>licenseType</code>.
     *
     * @param licenseType the licenseType to set
     */
    public void setLicenseType(LicenseType licenseType) {
        this.licenseType = licenseType;
    }

    /**
     * Gets the value of the field <code>checkDigit</code>.
     *
     * @return the checkDigit
     */
    public String getCheckDigit() {
        return checkDigit;
    }

    /**
     * Sets the value of the field <code>checkDigit</code>.
     *
     * @param checkDigit the checkDigit to set
     */
    public void setCheckDigit(String checkDigit) {
        this.checkDigit = checkDigit;
    }
}