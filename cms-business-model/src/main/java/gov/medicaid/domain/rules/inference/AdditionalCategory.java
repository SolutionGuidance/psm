/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.domain.rules.inference;

/**
 * Represents a possible dual license selection for a provider type.
 *
 * @author TCSASSEMBLER
 * @version 1.0
 * @since Provider Enrollment Drools Front End Validation Part 2
 */
public class AdditionalCategory {

    /**
     * The provider type.
     */
    private String providerType;

    /**
     * The category/dual license type.
     */
    private String category;

    /**
     * Creates a new additional category option.
     *
     * @param providerType the provider type
     * @param category the dual license category that can be added
     */
    public AdditionalCategory(String providerType, String category) {
        super();
        this.providerType = providerType;
        this.category = category;
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
     * Gets the value of the field <code>category</code>.
     *
     * @return the category
     */
    public String getCategory() {
        return category;
    }

    /**
     * Sets the value of the field <code>category</code>.
     *
     * @param category the category to set
     */
    public void setCategory(String category) {
        this.category = category;
    }
}
