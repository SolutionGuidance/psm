/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.entities;

/**
 * This represents the search criteria for Pharmacy License.
 *
 * @author sampath01, j3_guile
 * @version 1.0
 */
public class PharmacyLicenseSearchCriteria extends SearchCriteria {

    /**
     * The business name filter.
     */
    private String businessName;

    /**
     * Default empty constructor.
     */
    public PharmacyLicenseSearchCriteria() {
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