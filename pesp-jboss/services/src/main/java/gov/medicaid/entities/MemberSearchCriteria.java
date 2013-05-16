/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.entities;

/**
 * Represents a member search criteria.
 *
 * @author TCSASSEMBLER
 * @version 1.0
 */
public class MemberSearchCriteria extends SearchCriteria {

    /**
     * Practice NPI.
     */
    private String npi;

    /**
     * Empty constructor.
     */
    public MemberSearchCriteria() {
    }

    /**
     * Gets the value of the field <code>npi</code>.
     * @return the npi
     */
    public String getNpi() {
        return npi;
    }

    /**
     * Sets the value of the field <code>npi</code>.
     * @param npi the npi to set
     */
    public void setNpi(String npi) {
        this.npi = npi;
    }
}