/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.entities;

/**
 * This represents the search criteria for OIG excluded providers.
 *
 * @author sampath01, j3_guile
 * @version 1.0
 */
public class OIGSearchCriteria extends SearchCriteria {

    /**
     * Business name filter.
     */
    private String businessName;

    /**
     * Default empty constructor.
     */
    public OIGSearchCriteria() {
    }

    /**
     * Gets the value of the field <code>businessName</code>.
     *
     * @return the businessName
     */
    public String getBusinessName() {
        return businessName;
    }

    /**
     * Sets the value of the field <code>businessName</code>.
     *
     * @param businessName the businessName to set
     */
    public void setBusinessName(String businessName) {
        this.businessName = businessName;
    }
}