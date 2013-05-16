/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.domain.rules.inference;

/**
 * This class is used by the rules to perform validation on a phone number within a context, since a phone number may
 * appear in different levels of a profile.
 *
 * @author TCSASSEMBLER
 * @version 1.0
 */
public class PhoneNumberEntry {

    /**
     * The phone number to be checked.
     */
    private final String phoneNumber;

    /**
     * FAX number, Contact Number, etc.
     */
    private String type;

    /**
     * The path to this phone number.
     */
    private String path;

    /**
     * Prevents loops when multiple phones are present.
     */
    private String validated;

    /**
     * Creates a new instance using the given entity.
     *
     * @param type the phone number type
     * @param path the path to the field
     * @param phoneNumber the value
     */
    public PhoneNumberEntry(String type, String path, String phoneNumber) {
        this.type = type;
        this.path = path;
        this.phoneNumber = phoneNumber;
        this.validated = "N";
    }

    /**
     * Gets the value of the field <code>type</code>.
     *
     * @return the type
     */
    public String getType() {
        return type;
    }

    /**
     * Sets the value of the field <code>type</code>.
     *
     * @param type the type to set
     */
    public void setType(String type) {
        this.type = type;
    }

    /**
     * Gets the value of the field <code>path</code>.
     *
     * @return the path
     */
    public String getPath() {
        return path;
    }

    /**
     * Sets the value of the field <code>path</code>.
     *
     * @param path the path to set
     */
    public void setPath(String path) {
        this.path = path;
    }

    /**
     * Gets the value of the field <code>validated</code>.
     *
     * @return the validated
     */
    public String getValidated() {
        return validated;
    }

    /**
     * Sets the value of the field <code>validated</code>.
     *
     * @param validated the validated to set
     */
    public void setValidated(String validated) {
        this.validated = validated;
    }

    /**
     * Gets the value of the field <code>phoneNumber</code>.
     *
     * @return the phoneNumber
     */
    public String getPhoneNumber() {
        return phoneNumber;
    }
}
