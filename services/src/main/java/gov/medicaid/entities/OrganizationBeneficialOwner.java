/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.entities;

/**
 * A corporate beneficial owner.
 *
 * @author TCSASSEMBLER
 * @version 1.0
 */
public class OrganizationBeneficialOwner extends BeneficialOwner {

    /**
     * Entity legal name.
     */
    private String legalName;

    /**
     * Entity employer number.
     */
    private String fein;

    /**
     * Empty constructor.
     */
    public OrganizationBeneficialOwner() {
    }

    /**
     * Gets the value of the field <code>legalName</code>.
     *
     * @return the legalName
     */
    public String getLegalName() {
        return legalName;
    }

    /**
     * Sets the value of the field <code>legalName</code>.
     *
     * @param legalName the legalName to set
     */
    public void setLegalName(String legalName) {
        this.legalName = legalName;
    }

    /**
     * Gets the value of the field <code>fein</code>.
     *
     * @return the fein
     */
    public String getFein() {
        return fein;
    }

    /**
     * Sets the value of the field <code>fein</code>.
     *
     * @param fein the fein to set
     */
    public void setFein(String fein) {
        this.fein = fein;
    }
}
