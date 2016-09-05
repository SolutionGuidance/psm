/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.entities;

import java.util.Date;

/**
 * A person beneficial owner.
 *
 * @author TCSASSEMBLER
 * @version 1.0
 */
public class PersonBeneficialOwner extends BeneficialOwner {

    /**
     * First name.
     */
    private String firstName;

    /**
     * Middle name.
     */
    private String middleName;

    /**
     * Last name.
     */
    private String lastName;

    /**
     * SSN.
     */
    private String ssn;

    /**
     * Date of birth.
     */
    private Date dob;

    /**
     * Hire date.
     */
    private Date hireDate;

    /**
     * Relationship type.
     */
    private RelationshipType relationship;

    /**
     * Empty constructor.
     */
    public PersonBeneficialOwner() {
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
     * Gets the value of the field <code>ssn</code>.
     *
     * @return the ssn
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
     * Gets the value of the field <code>dob</code>.
     *
     * @return the dob
     */
    public Date getDob() {
        return dob;
    }

    /**
     * Sets the value of the field <code>dob</code>.
     *
     * @param dob the dob to set
     */
    public void setDob(Date dob) {
        this.dob = dob;
    }

    /**
     * Gets the value of the field <code>hireDate</code>.
     *
     * @return the hireDate
     */
    public Date getHireDate() {
        return hireDate;
    }

    /**
     * Sets the value of the field <code>hireDate</code>.
     *
     * @param hireDate the hireDate to set
     */
    public void setHireDate(Date hireDate) {
        this.hireDate = hireDate;
    }

    /**
     * Gets the value of the field <code>relationship</code>.
     *
     * @return the relationship
     */
    public RelationshipType getRelationship() {
        return relationship;
    }

    /**
     * Sets the value of the field <code>relationship</code>.
     *
     * @param relationship the relationship to set
     */
    public void setRelationship(RelationshipType relationship) {
        this.relationship = relationship;
    }
}
