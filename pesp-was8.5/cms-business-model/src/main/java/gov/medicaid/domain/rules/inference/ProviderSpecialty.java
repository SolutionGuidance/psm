/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.domain.rules.inference;

/**
 * Represents a possible selection for the provider's specialty.
 *
 * @author TCSASSEMBLER
 * @version 1.0
 * @since Provider Enrollment Drools Front End Validation Part 2
 */
public class ProviderSpecialty {

    /**
     * The provider type.
     */
    private String providerType;

    /**
     * The specialty.
     */
    private String specialty;

    /**
     * Creates a new specialty option.
     *
     * @param providerType the provider type
     * @param specialty the specialty type
     */
    public ProviderSpecialty(String providerType, String specialty) {
        super();
        this.providerType = providerType;
        this.specialty = specialty;
    }

    /**
     * Gets the value of the field <code>providerType</code>.
     * @return the providerType
     */
    public String getProviderType() {
        return providerType;
    }

    /**
     * Sets the value of the field <code>providerType</code>.
     * @param providerType the providerType to set
     */
    public void setProviderType(String providerType) {
        this.providerType = providerType;
    }

    /**
     * Gets the value of the field <code>specialty</code>.
     * @return the specialty
     */
    public String getSpecialty() {
        return specialty;
    }

    /**
     * Sets the value of the field <code>specialty</code>.
     * @param specialty the specialty to set
     */
    public void setSpecialty(String specialty) {
        this.specialty = specialty;
    }
}
