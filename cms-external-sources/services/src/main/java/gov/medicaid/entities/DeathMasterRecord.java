/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.entities;

import java.util.Date;

/**
 * This entity holds data for a death master record.
 * @author zsudraco, hanshuai
 * @version 1.0
 */
@SuppressWarnings("serial")
public class DeathMasterRecord extends IdentifiableEntity {
    /**
     * This is social security number.
     */
    private String ssn;

    /**
     * This is last name.
     */
    private String lastName;

    /**
     * This is name suffix.
     */
    private String nameSuffix;

    /**
     * This is first name.
     */
    private String firstName;

    /**
     * This is middle name.
     */
    private String middleName;

    /**
     * This is V or P code.
     */
    private String vpCode;

    /**
     * This is date of death.
     */
    private Date dateOfDeath;

    /**
     * This is date of birth.
     */
    private Date dateOfBirth;
    
    /**
     * Default empty constructor.
     */
    public DeathMasterRecord() {
    }

    /**
     * Gets the value of the field <code>accreditedDate</code>.
     *
     * @return the accreditedDate
     */
    public String getSsn() {
        return ssn;
    }

    /**
     * Sets the value of the field <code>ssn</code>.
     *
     * @param ssn the ssn to set
     */
    public void setSsn(String ssn) {
        this.ssn = ssn;
    }

    /**
     * Gets the value of the field <code>lastName</code>.
     *
     * @return the lastName
     */
    public String getLastName() {
        return lastName;
    }

    /**
     * Sets the value of the field <code>lastName</code>.
     *
     * @param lastName the lastName to set
     */
    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    /**
     * Gets the value of the field <code>nameSuffix</code>.
     *
     * @return the nameSuffix
     */
    public String getNameSuffix() {
        return nameSuffix;
    }

    /**
     * Sets the value of the field <code>nameSuffix</code>.
     *
     * @param nameSuffix the nameSuffix to set
     */
    public void setNameSuffix(String nameSuffix) {
        this.nameSuffix = nameSuffix;
    }

    /**
     * Gets the value of the field <code>firstName</code>.
     *
     * @return the firstName
     */
    public String getFirstName() {
        return firstName;
    }

    /**
     * Sets the value of the field <code>firstName</code>.
     *
     * @param firstName the firstName to set
     */
    public void setFirstName(String firstName) {
        this.firstName = firstName;
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
     * Gets the value of the field <code>vpCode</code>.
     *
     * @return the vpCode
     */
    public String getVpCode() {
        return vpCode;
    }

    /**
     * Sets the value of the field <code>vpCode</code>.
     *
     * @param vpCode the vpCode to set
     */
    public void setVpCode(String vpCode) {
        this.vpCode = vpCode;
    }

    /**
     * Gets the value of the field <code>dateOfDeath</code>.
     *
     * @return the dateOfDeath
     */
    public Date getDateOfDeath() {
        return dateOfDeath;
    }

    /**
     * Sets the value of the field <code>dateOfDeath</code>.
     *
     * @param dateOfDeath the dateOfDeath to set
     */
    public void setDateOfDeath(Date dateOfDeath) {
        this.dateOfDeath = dateOfDeath;
    }

    /**
     * Gets the value of the field <code>dateOfBirth</code>.
     *
     * @return the dateOfBirth
     */
    public Date getDateOfBirth() {
        return dateOfBirth;
    }

    /**
     * Sets the value of the field <code>dateOfBirth</code>.
     *
     * @param dateOfBirth the dateOfBirth to set
     */
    public void setDateOfBirth(Date dateOfBirth) {
        this.dateOfBirth = dateOfBirth;
    }
}

