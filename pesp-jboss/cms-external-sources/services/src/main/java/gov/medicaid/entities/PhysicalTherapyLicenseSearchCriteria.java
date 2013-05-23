/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.entities;

/**
 * This represents the search criteria for Physical Therapy License.
 *
 * @author sampath01, j3_guile
 * @version 1.0
 */
public class PhysicalTherapyLicenseSearchCriteria extends SearchCriteria {

    /**
     * The criteria filter.
     */
    private String criteria;

    /**
     * Default empty constructor.
     */
    public PhysicalTherapyLicenseSearchCriteria() {
    }

    /**
     * Gets the value of the field <code>criteria</code>.
     *
     * @return the criteria
     */
    public String getCriteria() {
        return criteria;
    }

    /**
     * Sets the value of the field <code>criteria</code>.
     *
     * @param criteria the criteria to set
     */
    public void setCriteria(String criteria) {
        this.criteria = criteria;
    }
}