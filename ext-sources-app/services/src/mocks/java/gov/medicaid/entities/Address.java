/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.entities;

/**
 * Represents an address.
 *
 * @author argolite, j3_guile
 * @version 1.0
 */
public class Address extends IdentifiableEntity {

    /**
     * Location.
     */
    private String location;

    /**
     * City.
     */
    private String city;
    
    /**
     * County.
     */
    private String County;

    /**
     * State code (2 chars).
     */
    private String state;

    /**
     * Zip code.
     */
    private String zipcode;

    /**
     * Country.
     */
    private String country;

    /**
     * Default empty constructor.
     */
    public Address() {
    }

    /**
     * Gets the value of the field <code>location</code>.
     * @return the location
     */
    public String getLocation() {
        return location;
    }

    /**
     * Sets the value of the field <code>location</code>.
     * @param location the location to set
     */
    public void setLocation(String location) {
        this.location = location;
    }

    /**
     * Gets the value of the field <code>city</code>.
     * @return the city
     */
    public String getCity() {
        return city;
    }

    /**
     * Sets the value of the field <code>city</code>.
     * @param city the city to set
     */
    public void setCity(String city) {
        this.city = city;
    }

    /**
     * Gets the value of the field <code>state</code>.
     * @return the state
     */
    public String getState() {
        return state;
    }

    /**
     * Sets the value of the field <code>state</code>.
     * @param state the state to set
     */
    public void setState(String state) {
        this.state = state;
    }

    /**
     * Gets the value of the field <code>zipcode</code>.
     * @return the zipcode
     */
    public String getZipcode() {
        return zipcode;
    }

    /**
     * Sets the value of the field <code>zipcode</code>.
     * @param zipcode the zipcode to set
     */
    public void setZipcode(String zipcode) {
        this.zipcode = zipcode;
    }

    /**
     * Gets the value of the field <code>country</code>.
     * @return the country
     */
    public String getCountry() {
        return country;
    }

    /**
     * Sets the value of the field <code>country</code>.
     * @param country the country to set
     */
    public void setCountry(String country) {
        this.country = country;
    }

    /**
     * Gets the value of the field <code>county</code>.
     * @return the county
     */
    public String getCounty() {
        return County;
    }

    /**
     * Sets the value of the field <code>county</code>.
     * @param county the county to set
     */
    public void setCounty(String county) {
        County = county;
    }
}
