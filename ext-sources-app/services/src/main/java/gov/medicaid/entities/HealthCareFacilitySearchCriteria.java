/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.entities;

/**
 * Represents the search criteria for health care facilities.
 * <p>
 * <strong>Thread Safety:</strong> This class is mutable and not thread safe.
 * </p>
 * 
 * @author argolite, TCSASSEMBLER
 * @version 1.0
 * @since Organizational Provider Screening External Datasources Services 1
 */
@SuppressWarnings("serial")
public abstract class HealthCareFacilitySearchCriteria extends SearchCriteria {
    /**
     * The criteria
     */
    private String criteria;

    /**
     * The value
     */
    private String value;

    /**
     * Empty constructor
     */
    public HealthCareFacilitySearchCriteria() {
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

    /**
     * Gets the value of the field <code>value</code>.
     *
     * @return the value
     */
    public String getValue() {
        return value;
    }

    /**
     * Sets the value of the field <code>value</code>.
     *
     * @param value the value to set
     */
    public void setValue(String value) {
        this.value = value;
    }
}

