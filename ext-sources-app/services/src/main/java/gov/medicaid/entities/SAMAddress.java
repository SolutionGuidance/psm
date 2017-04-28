/*
 * Copyright (C) 2013 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.entities;

import java.io.Serializable;

/**
 * This entity holds address data of SAMSearch web service response.
 *
 * @author flexme
 * @version 1.0
 */
public class SAMAddress implements Serializable {
    /**
     * Represents the first street.
     */
    private String street1;
    /**
     * Represents the second street.
     */
    private String street2;
    /**
     * Represents the city.
     */
    private String city;
    /**
     * Represents the zip code.
     */
    private String zip;
    /**
     * Represents the province.
     */
    private String province;
    /**
     * Represents the state.
     */
    private String state;
    /**
     * Represents the duns.
     */
    private String duns;

    /**
     * Empty constructor.
     */
    public SAMAddress() {
    }

    /**
     * Gets the first street.
     *
     * @return the first street.
     */
    public String getStreet1() {
        return street1;
    }

    /**
     * Sets the first street.
     *
     * @param street1 the first street.
     */
    public void setStreet1(String street1) {
        this.street1 = street1;
    }

    /**
     * Gets the second street.
     *
     * @return the second street.
     */
    public String getStreet2() {
        return street2;
    }

    /**
     * Sets the second street.
     *
     * @param street2 the second street.
     */
    public void setStreet2(String street2) {
        this.street2 = street2;
    }

    /**
     * Gets the city.
     *
     * @return the city.
     */
    public String getCity() {
        return city;
    }

    /**
     * Sets the city.
     *
     * @param city the city.
     */
    public void setCity(String city) {
        this.city = city;
    }

    /**
     * Gets the zip code.
     *
     * @return the zip code.
     */
    public String getZip() {
        return zip;
    }

    /**
     * Sets the zip code.
     *
     * @param zip the zip code.
     */
    public void setZip(String zip) {
        this.zip = zip;
    }

    /**
     * Gets the province.
     *
     * @return the province.
     */
    public String getProvince() {
        return province;
    }

    /**
     * Sets the province.
     *
     * @param province the province.
     */
    public void setProvince(String province) {
        this.province = province;
    }

    /**
     * Gets the state.
     *
     * @return the state.
     */
    public String getState() {
        return state;
    }

    /**
     * Sets the state.
     *
     * @param state the state.
     */
    public void setState(String state) {
        this.state = state;
    }

    /**
     * Gets the duns.
     *
     * @return the duns.
     */
    public String getDuns() {
        return duns;
    }

    /**
     * Sets the duns.
     *
     * @param duns the duns.
     */
    public void setDuns(String duns) {
        this.duns = duns;
    }
}
