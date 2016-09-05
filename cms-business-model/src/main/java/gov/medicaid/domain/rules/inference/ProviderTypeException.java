/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.domain.rules.inference;

/**
 * This class is used by the rules logically insert exceptions based on the provider type.
 *
 * @author TCSASSEMBLER
 * @version 1.0
 */
public class ProviderTypeException {

    /**
     * The type of exception.
     */
    private String type;

    /**
     * The provider type.
     */
    private String providerType;

    /**
     * The specialty type.
     */
    private String specialtyType;

    /**
     * Creates a new instance using the given fields.
     *
     * @param type the type
     * @param providerType the provider type
     */
    public ProviderTypeException(String type, String providerType) {
        super();
        this.type = type;
        this.providerType = providerType;
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
     * Gets the value of the field <code>providerType</code>.
     *
     * @return the providerType
     */
    public String getProviderType() {
        return providerType;
    }

    /**
     * Sets the value of the field <code>providerType</code>.
     *
     * @param providerType the providerType to set
     */
    public void setProviderType(String providerType) {
        this.providerType = providerType;
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
}
