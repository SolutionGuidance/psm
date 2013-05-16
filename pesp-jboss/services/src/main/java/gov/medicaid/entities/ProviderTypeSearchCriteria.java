/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.entities;


/**
 * Represents a provider type search criteria.
 *
 * @author argolite, TCSASSEMBLER
 * @version 1.0
 */
public class ProviderTypeSearchCriteria extends SearchCriteria {

    /**
     * Type name.
     */
    private String typeName;

    /**
     * Default empty constructor.
     */
    public ProviderTypeSearchCriteria() {
    }

    /**
     * Gets the value of the field <code>typeName</code>.
     * @return the typeName
     */
    public String getTypeName() {
        return typeName;
    }

    /**
     * Sets the value of the field <code>typeName</code>.
     * @param typeName the typeName to set
     */
    public void setTypeName(String typeName) {
        this.typeName = typeName;
    }
}