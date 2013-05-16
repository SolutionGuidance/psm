/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.domain.rules.inference;


/**
 * This class is used by the rules logically insert exceptions.
 *
 * @author TCSASSEMBLER
 * @version 1.0
 */
public class CertificateException {

    /**
     * The type of exception.
     */
    private String type;

    /**
     * The license type.
     */
    private String licenseType;

    /**
     * The specialty type.
     */
    private String specialtyType;

    /**
     * Creates a new instance using the given fields.
     *
     * @param type the type
     * @param licenseType the license type
     * @param specialtyType the specialty type
     */
    public CertificateException(String type, String licenseType, String specialtyType) {
        super();
        this.type = type;
        this.licenseType = defaultString(licenseType);
        this.specialtyType = defaultString(specialtyType);
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
     * Gets the value of the field <code>licenseType</code>.
     *
     * @return the licenseType
     */
    public String getLicenseType() {
        return licenseType;
    }

    /**
     * Sets the value of the field <code>licenseType</code>.
     *
     * @param licenseType the licenseType to set
     */
    public void setLicenseType(String licenseType) {
        this.licenseType = licenseType;
    }

    /**
     * Gets the value of the field <code>specialtyType</code>.
     *
     * @return the specialtyType
     */
    public String getSpecialtyType() {
        return specialtyType;
    }

    /**
     * Sets the value of the field <code>specialtyType</code>.
     *
     * @param specialtyType the specialtyType to set
     */
    public void setSpecialtyType(String specialtyType) {
        this.specialtyType = specialtyType;
    }

    /**
     * Returns a blank string if the value is null.
     *
     * @param value the value to check
     * @return a blank string if the value is null.
     */
    private static String defaultString(String value) {
        return value == null ? "" : value;
    }
}
