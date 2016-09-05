/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.entities;


/**
 * Projection results from search of enrolled practices.
 *
 * @author TCSASSEMBLER
 * @version 1.0
 */
public class ContactData {

    /**
     * Profile id.
     */
    private long profileId;

    /**
     * Contact name.
     */
    private String name;
    
    /**
     * Contact phone number.
     */
    private String phoneNumber;

    /**
     * Creates an instance using the values.
     * @param profileId assigned to the field with the same name
     * @param name assigned to the field with the same name
     */
    public ContactData(long profileId, String name) {
        super();
        this.profileId = profileId;
        this.name = name;
    }
    
    /**
     * Creates an instance using the values.
     * @param profileId assigned to the field with the same name
     * @param name assigned to the field with the same name
     */
    public ContactData(long profileId, String name, String phoneNumber) {
        super();
        this.profileId = profileId;
        this.name = name;
        this.phoneNumber = phoneNumber;
    }

    /**
     * Gets the value of the field <code>profileId</code>.
     * @return the profileId
     */
    public long getProfileId() {
        return profileId;
    }

    /**
     * Gets the value of the field <code>name</code>.
     * @return the name
     */
    public String getName() {
        return name;
    }

    /**
     * Gets the value of the field <code>phoneNumber</code>.
     * @return the phoneNumber
     */
    public String getPhoneNumber() {
        return phoneNumber;
    }
}
