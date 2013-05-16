/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.entities;

import java.math.BigDecimal;

/**
 * Base class for beneficial owners of organizations.
 *
 * @author TCSASSEMBLER
 * @version 1.0
 */
public abstract class BeneficialOwner extends IdentifiableEntity {

    /**
     * Type of beneficial owner.
     */
    private BeneficialOwnerType type;

    /**
     * If type is other, specify description.
     */
    private String typeDescription;

    /**
     * If type is sub contractor, specify name.
     */
    private String subcontractorName;

    /**
     * If type is owner, specify ownership percent.
     */
    private BigDecimal ownershipInterest;

    /**
     * Beneficial owner address.
     */
    private Address address;

    /**
     * Indicates this owner has interest in other provider.
     */
    private String otherProviderInterestInd;

    /**
     * Other provider name.
     */
    private String otherProviderLegalName;

    /**
     * Other provider ownership interest.
     */
    private BigDecimal otherProviderOwnershipInterest;

    /**
     * Other provider address.
     */
    private Address otherProviderAddress;

    /**
     * Empty constructor.
     */
    protected BeneficialOwner() {
    }

    /**
     * Gets the value of the field <code>type</code>.
     *
     * @return the type
     */
    public BeneficialOwnerType getType() {
        return type;
    }

    /**
     * Sets the value of the field <code>type</code>.
     *
     * @param type the type to set
     */
    public void setType(BeneficialOwnerType type) {
        this.type = type;
    }

    /**
     * Gets the value of the field <code>typeDescription</code>.
     *
     * @return the typeDescription
     */
    public String getTypeDescription() {
        return typeDescription;
    }

    /**
     * Sets the value of the field <code>typeDescription</code>.
     *
     * @param typeDescription the typeDescription to set
     */
    public void setTypeDescription(String typeDescription) {
        this.typeDescription = typeDescription;
    }

    /**
     * Gets the value of the field <code>subcontractorName</code>.
     *
     * @return the subcontractorName
     */
    public String getSubcontractorName() {
        return subcontractorName;
    }

    /**
     * Sets the value of the field <code>subcontractorName</code>.
     *
     * @param subcontractorName the subcontractorName to set
     */
    public void setSubcontractorName(String subcontractorName) {
        this.subcontractorName = subcontractorName;
    }

    /**
     * Gets the value of the field <code>ownershipInterest</code>.
     *
     * @return the ownershipInterest
     */
    public BigDecimal getOwnershipInterest() {
        return ownershipInterest;
    }

    /**
     * Sets the value of the field <code>ownershipInterest</code>.
     *
     * @param ownershipInterest the ownershipInterest to set
     */
    public void setOwnershipInterest(BigDecimal ownershipInterest) {
        this.ownershipInterest = ownershipInterest;
    }

    /**
     * Gets the value of the field <code>address</code>.
     *
     * @return the address
     */
    public Address getAddress() {
        return address;
    }

    /**
     * Sets the value of the field <code>address</code>.
     *
     * @param address the address to set
     */
    public void setAddress(Address address) {
        this.address = address;
    }

    /**
     * Gets the value of the field <code>otherProviderInterestInd</code>.
     *
     * @return the otherProviderInterestInd
     */
    public String getOtherProviderInterestInd() {
        return otherProviderInterestInd;
    }

    /**
     * Sets the value of the field <code>otherProviderInterestInd</code>.
     *
     * @param otherProviderInterestInd the otherProviderInterestInd to set
     */
    public void setOtherProviderInterestInd(String otherProviderInterestInd) {
        this.otherProviderInterestInd = otherProviderInterestInd;
    }

    /**
     * Gets the value of the field <code>otherProviderLegalName</code>.
     *
     * @return the otherProviderLegalName
     */
    public String getOtherProviderLegalName() {
        return otherProviderLegalName;
    }

    /**
     * Sets the value of the field <code>otherProviderLegalName</code>.
     *
     * @param otherProviderLegalName the otherProviderLegalName to set
     */
    public void setOtherProviderLegalName(String otherProviderLegalName) {
        this.otherProviderLegalName = otherProviderLegalName;
    }

    /**
     * Gets the value of the field <code>otherProviderOwnershipInterest</code>.
     *
     * @return the otherProviderOwnershipInterest
     */
    public BigDecimal getOtherProviderOwnershipInterest() {
        return otherProviderOwnershipInterest;
    }

    /**
     * Sets the value of the field <code>otherProviderOwnershipInterest</code>.
     *
     * @param otherProviderOwnershipInterest the otherProviderOwnershipInterest to set
     */
    public void setOtherProviderOwnershipInterest(BigDecimal otherProviderOwnershipInterest) {
        this.otherProviderOwnershipInterest = otherProviderOwnershipInterest;
    }

    /**
     * Gets the value of the field <code>otherProviderAddress</code>.
     *
     * @return the otherProviderAddress
     */
    public Address getOtherProviderAddress() {
        return otherProviderAddress;
    }

    /**
     * Sets the value of the field <code>otherProviderAddress</code>.
     *
     * @param otherProviderAddress the otherProviderAddress to set
     */
    public void setOtherProviderAddress(Address otherProviderAddress) {
        this.otherProviderAddress = otherProviderAddress;
    }
}
