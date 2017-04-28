/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.entities;

/**
 * Represents the search criteria for licensed provider.
 * <p>
 * <strong>Thread Safety:</strong> This class is mutable and not thread safe.
 * </p>
 * 
 * @author argolite, TCSASSEMBLER
 * @version 1.0
 * @since Organizational Provider Screening External Datasources Services 2
 */
@SuppressWarnings("serial")
public abstract class LicensedProviderSearchCriteria extends SearchCriteria {
    /**
     * The name.
     */
    private String name;

    /**
     * The city.
     */
    private String city;

    /**
     * The country
     */
    private String county;

    /**
     * The zip code.
     */
    private String zip;

    /**
     * The license number.
     */
    private long licenseNumber;

    /**
     * Empty constructor.
     */
    public LicensedProviderSearchCriteria() {
    }
    

    /**
     * Gets the value of the field <code>name</code>.
     *
     * @return the name
     */
    public String getName() {
        return name;
    }

    /**
     * Sets the value of the field <code>name</code>.
     *
     * @param name the name to set
     */
    public void setName(String name) {
        this.name = name;
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
     * Gets the value of the field <code>county</code>.
     *
     * @return the county
     */
    public String getCounty() {
        return county;
    }

    /**
     * Sets the value of the field <code>county</code>.
     *
     * @param county the county to set
     */
    public void setCounty(String county) {
        this.county = county;
    }

    /**
     * Gets the value of the field <code>zip</code>.
     *
     * @return the zip
     */
    public String getZip() {
        return zip;
    }

    /**
     * Sets the value of the field <code>zip</code>.
     *
     * @param zip the zip to set
     */
    public void setZip(String zip) {
        this.zip = zip;
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
     * @param licenseNumber the license number to set.
     */
    public void setLicenseNumber(long licenseNumber) {
        this.licenseNumber = licenseNumber;
    }
}

