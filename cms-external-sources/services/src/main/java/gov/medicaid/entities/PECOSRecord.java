/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.entities;

/**
 * This entity holds data of a PECOS record.
 * @author zsudraco, hanshuai
 * @version 1.0
 */
@SuppressWarnings("serial")
public class PECOSRecord extends IdentifiableEntity {
    /**
     * This is National Provider Identifier.
     */
    private String npi;

    /**
     * This is last name.
     */
    private String lastName;

    /**
     * This is first name.
     */
    private String firstName;
    
    /**
     * Default empty constructor.
     */
    public PECOSRecord() {
    }

    /**
     * Gets the value of the field <code>npi</code>.
     *
     * @return the npi
     */
    public String getNpi() {
        return npi;
    }

    /**
     * Sets the value of the field <code>npi</code>.
     *
     * @param npi the npi to set
     */
    public void setNpi(String npi) {
        this.npi = npi;
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
}

