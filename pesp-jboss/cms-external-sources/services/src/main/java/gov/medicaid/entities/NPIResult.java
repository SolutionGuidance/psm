/*
 * Copyright (C) 2013 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.entities;

import java.io.Serializable;

/**
 * This entity holds data of NPINumberLookup web service response.
 * @author flexme
 * @version 1.0
 */
public class NPIResult implements Serializable {
    /**
     * The NPI number.
     */
    private String npi;

    /**
     * The last name.
     */
    private String lastName;

    /**
     * The prefix.
     */
    private String prefix;

    /**
     * The first & middle names.
     */
    private String firstNames;

    /**
     * The state.
     */
    private String state;

    /**
     * The zip code.
     */
    private String zip;

    /**
     * Empty constrctor.
     */
    public NPIResult() {
    }

    /**
     * Gets the NPI number.
     *
     * @return the NPI number.
     */
    public String getNpi() {
        return npi;
    }

    /**
     * Sets the NPI number.
     *
     * @param npi the NPI number.
     */
    public void setNpi(String npi) {
        this.npi = npi;
    }

    /**
     * Gets the last name.
     *
     * @return the last name.
     */
    public String getLastName() {
        return lastName;
    }

    /**
     * Sets the last name.
     *
     * @param lastName the last name.
     */
    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    /**
     * Gets the prefix.
     *
     * @return the prefix.
     */
    public String getPrefix() {
        return prefix;
    }

    /**
     * Sets the prefix.
     *
     * @param prefix the prefix.
     */
    public void setPrefix(String prefix) {
        this.prefix = prefix;
    }

    /**
     * Gets the first & middle names.
     *
     * @return the first & middle names.
     */
    public String getFirstNames() {
        return firstNames;
    }

    /**
     * Sets the first & middle names.
     *
     * @param firstNames the first & middle names.
     */
    public void setFirstNames(String firstNames) {
        this.firstNames = firstNames;
    }

    /**
     * Sets the state.
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
}
