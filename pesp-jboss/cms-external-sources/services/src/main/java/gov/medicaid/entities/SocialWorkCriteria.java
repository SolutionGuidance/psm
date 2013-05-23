/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.entities;

import gov.medicaid.entities.LicenseLevel;

/**
 * Represents the search criteria for social work licenses by their numbers.
 *
 * <b>Thread Safety</b> This class is mutable and not thread safe.
 *
 * @author argolite, j3_guile
 * @version 1.0
 */
public abstract class SocialWorkCriteria extends SearchCriteria {

    /**
     * License level.
     */
    private LicenseLevel level;

    /**
     * City.
     */
    private String city;

    /**
     * County.
     */
    private String county;

    /**
     * Default empty constructor.
     */
    protected SocialWorkCriteria() {
    }

    /**
     * Gets the value of the field <code>level</code>.
     *
     * @return the level
     */
    public LicenseLevel getLevel() {
        return level;
    }

    /**
     * Sets the value of the field <code>level</code>.
     *
     * @param level the level to set
     */
    public void setLevel(LicenseLevel level) {
        this.level = level;
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
}