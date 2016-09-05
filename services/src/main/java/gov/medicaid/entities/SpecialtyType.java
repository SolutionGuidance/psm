/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.entities;

/**
 * This represents a specialty type.
 *
 * @author TCSASSEMBLER
 * @version 1.0
 */
public class SpecialtyType extends LookupEntity {

    /**
     * Specialty subcategory.
     */
    private String subCategory;

    /**
     * Default empty constructor.
     */
    public SpecialtyType() {
    }

    /**
     * Gets the value of the field <code>subCategory</code>.
     * @return the subCategory
     */
    public String getSubCategory() {
        return subCategory;
    }

    /**
     * Sets the value of the field <code>subCategory</code>.
     * @param subCategory the subCategory to set
     */
    public void setSubCategory(String subCategory) {
        this.subCategory = subCategory;
    }
}