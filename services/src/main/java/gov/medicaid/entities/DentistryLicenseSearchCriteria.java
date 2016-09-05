/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.entities;

import gov.medicaid.entities.LicenseType;

/**
 * This represents the search criteria for Dentistry License.
 *
 * @author sampath01, j3_guile
 * @version 1.0
 */
public class DentistryLicenseSearchCriteria extends SearchCriteria {

    /**
     * Middle name filter.
     */
    private String middleName;

    /**
     * License type.
     */
    private LicenseType licenseType;

    /**
     * City filter.
     */
    private String city;

    /**
     * Default empty constructor.
     */
    public DentistryLicenseSearchCriteria() {
    }

    /**
     * Gets the value of the field <code>middleName</code>.
     *
     * @return the middleName
     */
    public String getMiddleName() {
        return middleName;
    }

    /**
     * Sets the value of the field <code>middleName</code>.
     *
     * @param middleName the middleName to set
     */
    public void setMiddleName(String middleName) {
        this.middleName = middleName;
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
     * Gets the value of the field <code>city</code>.
     *
     * @return the city
     */
    public String getCity() {
        return city;
    }

    /**
     * Sets the value of the field <code>city</code>.
     *
     * @param city the city to set
     */
    public void setCity(String city) {
        this.city = city;
    }
}