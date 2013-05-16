/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.entities;

/**
 * Represents possible beneficial owner types.
 *
 * @author TCSASSEMBLER
 * @version 1.0
 */
public class BeneficialOwnerType extends LookupEntity {

    /**
     * Type of owner (P- person/O-org/A-any);
     */
    private String ownerType;
    
    /**
     * Empty constructor.
     */
    public BeneficialOwnerType() {
    }

    /**
     * Gets the value of the field <code>ownerType</code>.
     * @return the ownerType
     */
    public String getOwnerType() {
        return ownerType;
    }

    /**
     * Sets the value of the field <code>ownerType</code>.
     * @param ownerType the ownerType to set
     */
    public void setOwnerType(String ownerType) {
        this.ownerType = ownerType;
    }
    
    
}
