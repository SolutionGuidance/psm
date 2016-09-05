/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.entities;

/**
 * This represents the search criteria for Chiropractic License.
 *
 * @author sampath01, j3_guile
 * @version 1.0
 */
public class ChiropracticLicenseSearchCriteria extends SearchCriteria {

    /**
     * City filter.
     */
    private String city;

    /**
     * Zip code filter.
     */
    private String zipCode;

    /**
     * Partial flag.
     */
    private boolean partial;

    /**
     * Default empty constructor.
     */
    public ChiropracticLicenseSearchCriteria() {
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

    /**
     * Gets the value of the field <code>zipCode</code>.
     *
     * @return the zipCode
     */
    public String getZipCode() {
        return zipCode;
    }

    /**
     * Sets the value of the field <code>zipCode</code>.
     *
     * @param zipCode the zipCode to set
     */
    public void setZipCode(String zipCode) {
        this.zipCode = zipCode;
    }

    /**
     * Gets the value of the field <code>partial</code>.
     *
     * @return the partial
     */
    public boolean isPartial() {
        return partial;
    }

    /**
     * Sets the value of the field <code>partial</code>.
     *
     * @param partial the partial to set
     */
    public void setPartial(boolean partial) {
        this.partial = partial;
    }
}