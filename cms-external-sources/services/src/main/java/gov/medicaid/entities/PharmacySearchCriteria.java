/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.entities;

/**
 * Represents the search criteria for chemical dependency program.
 * <p>
 * <strong>Thread Safety:</strong> This class is mutable and not thread safe.
 * </p>
 * 
 * @author argolite, TCSASSEMBLER
 * @version 1.0
 * @since Organizational Provider Screening External Datasources Services 2
 */
@SuppressWarnings("serial")
public class PharmacySearchCriteria extends SearchCriteria {
    /**
     * The name.
     */
    private String name;

    /**
     * The address.
     */
    private String address;

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
     * Empty constructor
     */
    public PharmacySearchCriteria() {
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
     * @param name
     *            the name to set
     */
    public void setName(String name) {
        this.name = name;
    }

    /**
     * Gets the value of the field <code>address</code>.
     * 
     * @return the address
     */
    public String getAddress() {
        return address;
    }

    /**
     * Sets the value of the field <code>address</code>.
     * 
     * @param address
     *            the address to set
     */
    public void setAddress(String address) {
        this.address = address;
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
     * @param city
     *            the city to set
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
     * @param county
     *            the county to set
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
     * @param zip
     *            the zip to set
     */
    public void setZip(String zip) {
        this.zip = zip;
    }
}
