/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.entities;

import gov.medicaid.entities.Specialty;

/**
 * This represents the search criteria for Medical Practice License.
 *
 * @author sampath01, j3_guile
 * @version 1.0
 */
public class MedicalPracticeLicenseSearchCriteria extends SearchCriteria {

    /**
     * The specialty filter.
     */
    private Specialty specialty;

    /**
     * The city filter.
     */
    private String city;

    /**
     * The zipcode filter.
     */
    private String zipcode;

    /**
     * Default empty constructor.
     */
    public MedicalPracticeLicenseSearchCriteria() {
    }

    /**
     * Gets the value of the field <code>specialty</code>.
     *
     * @return the specialty
     */
    public Specialty getSpecialty() {
        return specialty;
    }

    /**
     * Sets the value of the field <code>specialty</code>.
     *
     * @param specialty the specialty to set
     */
    public void setSpecialty(Specialty specialty) {
        this.specialty = specialty;
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
     * Gets the value of the field <code>zipcode</code>.
     *
     * @return the zipcode
     */
    public String getZipcode() {
        return zipcode;
    }

    /**
     * Sets the value of the field <code>zipcode</code>.
     *
     * @param zipcode the zipcode to set
     */
    public void setZipcode(String zipcode) {
        this.zipcode = zipcode;
    }
}