/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.entities;

import java.io.Serializable;
import java.util.Date;

/**
 * This serves as Accredited Birth Center entity.
 *
 * <p>
 * <strong>Thread Safety:</strong> This class is mutable and not thread safe.
 * </p>
 *
 * @author argolite, j3_guile
 * @version 1.0
 */
public class AccreditedBirthCenter implements Serializable {

    /**
     * Accredited birth center name.
     */
    private String name;
    
    /**
     * Accredited date.
     */
    private Date accreditedDate;

    /**
     * Birth center address.
     */
    private String birthCenterAddress;

    /**
     * City.
     */
    private String city;

    /**
     * State.
     */
    private String state;

    /**
     * Default empty constructor.
     */
    public AccreditedBirthCenter() {
    }

    /**
     * Gets the value of the field <code>accreditedDate</code>.
     *
     * @return the accreditedDate
     */
    public Date getAccreditedDate() {
        return accreditedDate;
    }

    /**
     * Sets the value of the field <code>accreditedDate</code>.
     *
     * @param accreditedDate the accreditedDate to set
     */
    public void setAccreditedDate(Date accreditedDate) {
        this.accreditedDate = accreditedDate;
    }

    /**
     * Gets the value of the field <code>birthCenterAddress</code>.
     *
     * @return the birthCenterAddress
     */
    public String getBirthCenterAddress() {
        return birthCenterAddress;
    }

    /**
     * Sets the value of the field <code>birthCenterAddress</code>.
     *
     * @param birthCenterAddress the birthCenterAddress to set
     */
    public void setBirthCenterAddress(String birthCenterAddress) {
        this.birthCenterAddress = birthCenterAddress;
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
     * Gets the value of the field <code>state</code>.
     *
     * @return the state
     */
    public String getState() {
        return state;
    }

    /**
     * Sets the value of the field <code>state</code>.
     *
     * @param state the state to set
     */
    public void setState(String state) {
        this.state = state;
    }

    /**
     * Gets the value of the field <code>name</code>.
     * @return the name
     */
    public String getName() {
        return name;
    }

    /**
     * Sets the value of the field <code>name</code>.
     * @param name the name to set
     */
    public void setName(String name) {
        this.name = name;
    }

}
