/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.entities;

/**
 * This serves as search criteria for Medicaid Certified Providers.
 *
 * <b>Thread Safety</b> This class is mutable and not thread safe.
 *
 * @author argolite, j3_guile
 * @version 1.0
 */
public class MedicaidCertifiedProviderSearchCriteria extends SearchCriteria {

    /**
     * The type.
     */
    private String type;

    /**
     * The criteria.
     */
    private String criteria;

    /**
     * The value.
     */
    private String value;

    /**
     * Default empty constructor.
     */
    public MedicaidCertifiedProviderSearchCriteria() {
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
