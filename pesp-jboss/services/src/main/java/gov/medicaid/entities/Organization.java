/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.entities;



/**
 * Represents an organization.
 *
 * @author TCSASSEMBLER
 * @version 1.0
 */
public class Organization extends Entity {

    /**
     * Employer number.
     */
    private String fein;

    /**
     * For agencies.
     */
    private String agencyId;

    /**
     * Indicates that the billing address is the same as the primary address.
     */
    private String billingSameAsPrimary;

    /**
     * Indicates that the reimbursement address is the same as the primary address.
     */
    private String reimbursementSameAsPrimary;

    /**
     * Indicates that the ten99 address is the same as the primary address.
     */
    private String ten99SameAsPrimary;

    /**
     * Practice secondary address.
     */
    private Address billingAddress;

    /**
     * Practice secondary address.
     */
    private Address reimbursementAddress;

    /**
     * Practice secondary address.
     */
    private Address ten99Address;

    /**
     * Practice minnesotaTaxId.
     */
    private String stateTaxId;

    /**
     * Practice fiscal year end.
     */
    private String fiscalYearEnd;

    /**
     * Remittance sequence order.
     */
    private RemittanceSequenceOrder remittanceSequenceOrder;

    /**
     * EFT Vendor number.
     */
    private String eftVendorNumber;

    /**
     * Empty constructor.
     */
    public Organization() {
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

    /**
     * Gets the value of the field <code>billingAddress</code>.
     *
     * @return the billingAddress
     */
    public Address getBillingAddress() {
        return billingAddress;
    }

    /**
     * Sets the value of the field <code>billingAddress</code>.
     *
     * @param billingAddress the billingAddress to set
     */
    public void setBillingAddress(Address billingAddress) {
        this.billingAddress = billingAddress;
    }

    /**
     * Gets the value of the field <code>reimbursementAddress</code>.
     *
     * @return the reimbursementAddress
     */
    public Address getReimbursementAddress() {
        return reimbursementAddress;
    }

    /**
     * Sets the value of the field <code>reimbursementAddress</code>.
     *
     * @param reimbursementAddress the reimbursementAddress to set
     */
    public void setReimbursementAddress(Address reimbursementAddress) {
        this.reimbursementAddress = reimbursementAddress;
    }

    /**
     * Gets the value of the field <code>ten99Address</code>.
     *
     * @return the ten99Address
     */
    public Address getTen99Address() {
        return ten99Address;
    }

    /**
     * Sets the value of the field <code>ten99Address</code>.
     *
     * @param ten99Address the ten99Address to set
     */
    public void setTen99Address(Address ten99Address) {
        this.ten99Address = ten99Address;
    }

    /**
     * Gets the value of the field <code>stateTaxId</code>.
     *
     * @return the stateTaxId
     */
    public String getStateTaxId() {
        return stateTaxId;
    }

    /**
     * Sets the value of the field <code>stateTaxId</code>.
     *
     * @param stateTaxId the stateTaxId to set
     */
    public void setStateTaxId(String stateTaxId) {
        this.stateTaxId = stateTaxId;
    }

    /**
     * Gets the value of the field <code>fiscalYearEnd</code>.
     *
     * @return the fiscalYearEnd
     */
    public String getFiscalYearEnd() {
        return fiscalYearEnd;
    }

    /**
     * Sets the value of the field <code>fiscalYearEnd</code>.
     *
     * @param fiscalYearEnd the fiscalYearEnd to set
     */
    public void setFiscalYearEnd(String fiscalYearEnd) {
        this.fiscalYearEnd = fiscalYearEnd;
    }

    /**
     * Gets the value of the field <code>remittanceSequenceOrder</code>.
     *
     * @return the remittanceSequenceOrder
     */
    public RemittanceSequenceOrder getRemittanceSequenceOrder() {
        return remittanceSequenceOrder;
    }

    /**
     * Sets the value of the field <code>remittanceSequenceOrder</code>.
     *
     * @param remittanceSequenceOrder the remittanceSequenceOrder to set
     */
    public void setRemittanceSequenceOrder(RemittanceSequenceOrder remittanceSequenceOrder) {
        this.remittanceSequenceOrder = remittanceSequenceOrder;
    }

    /**
     * Gets the value of the field <code>eftVendorNumber</code>.
     *
     * @return the eftVendorNumber
     */
    public String getEftVendorNumber() {
        return eftVendorNumber;
    }

    /**
     * Sets the value of the field <code>eftVendorNumber</code>.
     *
     * @param eftVendorNumber the eftVendorNumber to set
     */
    public void setEftVendorNumber(String eftVendorNumber) {
        this.eftVendorNumber = eftVendorNumber;
    }

    /**
     * Gets the value of the field <code>billingSameAsPrimary</code>.
     *
     * @return the billingSameAsPrimary
     */
    public String getBillingSameAsPrimary() {
        return billingSameAsPrimary;
    }

    /**
     * Sets the value of the field <code>billingSameAsPrimary</code>.
     *
     * @param billingSameAsPrimary the billingSameAsPrimary to set
     */
    public void setBillingSameAsPrimary(String billingSameAsPrimary) {
        this.billingSameAsPrimary = billingSameAsPrimary;
    }

    /**
     * Gets the value of the field <code>reimbursementSameAsPrimary</code>.
     *
     * @return the reimbursementSameAsPrimary
     */
    public String getReimbursementSameAsPrimary() {
        return reimbursementSameAsPrimary;
    }

    /**
     * Sets the value of the field <code>reimbursementSameAsPrimary</code>.
     *
     * @param reimbursementSameAsPrimary the reimbursementSameAsPrimary to set
     */
    public void setReimbursementSameAsPrimary(String reimbursementSameAsPrimary) {
        this.reimbursementSameAsPrimary = reimbursementSameAsPrimary;
    }

    /**
     * Gets the value of the field <code>ten99SameAsPrimary</code>.
     *
     * @return the ten99SameAsPrimary
     */
    public String getTen99SameAsPrimary() {
        return ten99SameAsPrimary;
    }

    /**
     * Sets the value of the field <code>ten99SameAsPrimary</code>.
     *
     * @param ten99SameAsPrimary the ten99SameAsPrimary to set
     */
    public void setTen99SameAsPrimary(String ten99SameAsPrimary) {
        this.ten99SameAsPrimary = ten99SameAsPrimary;
    }

    /**
     * Gets the value of the field <code>agencyId</code>.
     *
     * @return the agencyId
     */
    public String getAgencyId() {
        return agencyId;
    }

    /**
     * Sets the value of the field <code>agencyId</code>.
     *
     * @param agencyId the agencyId to set
     */
    public void setAgencyId(String agencyId) {
        this.agencyId = agencyId;
    }

}
