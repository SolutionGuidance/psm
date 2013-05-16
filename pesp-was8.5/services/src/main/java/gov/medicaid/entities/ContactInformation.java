/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.entities;

/**
 * Represents the contact information.
 *
 * @author TCSASSEMBLER
 * @version 1.0
 */
public class ContactInformation extends IdentifiableEntity {

    /**
     * The phone number.
     */
    private String phoneNumber;

    /**
     * The fax number.
     */
    private String faxNumber;

    /**
     * The email.
     */
    private String email;

    /**
     * The address.
     */
    private Address address;

    /**
     * Empty constructor.
     */
    public ContactInformation() {
    }

    /**
     * Gets the value of the field <code>phoneNumber</code>.
     *
     * @return the phoneNumber
     */
    public String getPhoneNumber() {
        return phoneNumber;
    }

    /**
     * Sets the value of the field <code>phoneNumber</code>.
     *
     * @param phoneNumber the phoneNumber to set
     */
    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    /**
     * Gets the value of the field <code>faxNumber</code>.
     *
     * @return the faxNumber
     */
    public String getFaxNumber() {
        return faxNumber;
    }

    /**
     * Sets the value of the field <code>faxNumber</code>.
     *
     * @param faxNumber the faxNumber to set
     */
    public void setFaxNumber(String faxNumber) {
        this.faxNumber = faxNumber;
    }

    /**
     * Gets the value of the field <code>email</code>.
     *
     * @return the email
     */
    public String getEmail() {
        return email;
    }

    /**
     * Sets the value of the field <code>email</code>.
     *
     * @param email the email to set
     */
    public void setEmail(String email) {
        this.email = email;
    }

    /**
     * Gets the value of the field <code>address</code>.
     *
     * @return the address
     */
    public Address getAddress() {
        return address;
    }

    /**
     * Sets the value of the field <code>address</code>.
     *
     * @param address the address to set
     */
    public void setAddress(Address address) {
        this.address = address;
    }
}
