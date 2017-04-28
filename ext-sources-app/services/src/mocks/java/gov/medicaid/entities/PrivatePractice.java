/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.entities;

/**
 * Represents a private practice.
 *
 * @author argolite, j3_guile
 * @version 1.0
 */
public class PrivatePractice extends AuditableEntity {

    /**
     * Practice name.
     */
    private String name;

    /**
     * Practice group NPI.
     */
    private String groupNPI;

    /**
     * Practice office address.
     */
    private Address officeAddress;

    /**
     * Practice office phone number.
     */
    private String officePhoneNumber;

    /**
     * Practice office fax number.
     */
    private String officeFaxNumber;

    /**
     * Practice federal tax id.
     */
    private String federalTaxId;

    /**
     * Practice legal name.
     */
    private String legalName;

    /**
     * Practice minnesotaTaxId.
     */
    private String minnesotaTaxId;

    /**
     * Practice fiscal year end.
     */
    private String fiscalYearEnd;

    /**
     * Practice city.
     */
    private String practiceCity;

    /**
     * Practice state.
     */
    private String practiceState;

    /**
     * Practice zip code.
     */
    private String practiceZip;

    /**
     * Practice secondary address.
     */
    private Address secondaryAddress;

    /**
     * Practice secondary phone number.
     */
    private String secondaryPhoneNumber;

    /**
     * Default empty constructor.
     */
    public PrivatePractice() {
    }

    /**
     * Gets the value of the field <code>name</code>.
     * @return the name
     */
    public String getName() {
        return name;
    }

    /**
     * Sets the value of the field <code>name</code>.
     * @param name the name to set
     */
    public void setName(String name) {
        this.name = name;
    }

    /**
     * Gets the value of the field <code>groupNPI</code>.
     * @return the groupNPI
     */
    public String getGroupNPI() {
        return groupNPI;
    }

    /**
     * Sets the value of the field <code>groupNPI</code>.
     * @param groupNPI the groupNPI to set
     */
    public void setGroupNPI(String groupNPI) {
        this.groupNPI = groupNPI;
    }

    /**
     * Gets the value of the field <code>officeAddress</code>.
     * @return the officeAddress
     */
    public Address getOfficeAddress() {
        return officeAddress;
    }

    /**
     * Sets the value of the field <code>officeAddress</code>.
     * @param officeAddress the officeAddress to set
     */
    public void setOfficeAddress(Address officeAddress) {
        this.officeAddress = officeAddress;
    }

    /**
     * Gets the value of the field <code>officePhoneNumber</code>.
     * @return the officePhoneNumber
     */
    public String getOfficePhoneNumber() {
        return officePhoneNumber;
    }

    /**
     * Sets the value of the field <code>officePhoneNumber</code>.
     * @param officePhoneNumber the officePhoneNumber to set
     */
    public void setOfficePhoneNumber(String officePhoneNumber) {
        this.officePhoneNumber = officePhoneNumber;
    }

    /**
     * Gets the value of the field <code>officeFaxNumber</code>.
     * @return the officeFaxNumber
     */
    public String getOfficeFaxNumber() {
        return officeFaxNumber;
    }

    /**
     * Sets the value of the field <code>officeFaxNumber</code>.
     * @param officeFaxNumber the officeFaxNumber to set
     */
    public void setOfficeFaxNumber(String officeFaxNumber) {
        this.officeFaxNumber = officeFaxNumber;
    }

    /**
     * Gets the value of the field <code>federalTaxId</code>.
     * @return the federalTaxId
     */
    public String getFederalTaxId() {
        return federalTaxId;
    }

    /**
     * Sets the value of the field <code>federalTaxId</code>.
     * @param federalTaxId the federalTaxId to set
     */
    public void setFederalTaxId(String federalTaxId) {
        this.federalTaxId = federalTaxId;
    }

    /**
     * Gets the value of the field <code>legalName</code>.
     * @return the legalName
     */
    public String getLegalName() {
        return legalName;
    }

    /**
     * Sets the value of the field <code>legalName</code>.
     * @param legalName the legalName to set
     */
    public void setLegalName(String legalName) {
        this.legalName = legalName;
    }

    /**
     * Gets the value of the field <code>minnesotaTaxId</code>.
     * @return the minnesotaTaxId
     */
    public String getMinnesotaTaxId() {
        return minnesotaTaxId;
    }

    /**
     * Sets the value of the field <code>minnesotaTaxId</code>.
     * @param minnesotaTaxId the minnesotaTaxId to set
     */
    public void setMinnesotaTaxId(String minnesotaTaxId) {
        this.minnesotaTaxId = minnesotaTaxId;
    }

    /**
     * Gets the value of the field <code>fiscalYearEnd</code>.
     * @return the fiscalYearEnd
     */
    public String getFiscalYearEnd() {
        return fiscalYearEnd;
    }

    /**
     * Sets the value of the field <code>fiscalYearEnd</code>.
     * @param fiscalYearEnd the fiscalYearEnd to set
     */
    public void setFiscalYearEnd(String fiscalYearEnd) {
        this.fiscalYearEnd = fiscalYearEnd;
    }

    /**
     * Gets the value of the field <code>practiceCity</code>.
     * @return the practiceCity
     */
    public String getPracticeCity() {
        return practiceCity;
    }

    /**
     * Sets the value of the field <code>practiceCity</code>.
     * @param practiceCity the practiceCity to set
     */
    public void setPracticeCity(String practiceCity) {
        this.practiceCity = practiceCity;
    }

    /**
     * Gets the value of the field <code>practiceState</code>.
     * @return the practiceState
     */
    public String getPracticeState() {
        return practiceState;
    }

    /**
     * Sets the value of the field <code>practiceState</code>.
     * @param practiceState the practiceState to set
     */
    public void setPracticeState(String practiceState) {
        this.practiceState = practiceState;
    }

    /**
     * Gets the value of the field <code>practiceZip</code>.
     * @return the practiceZip
     */
    public String getPracticeZip() {
        return practiceZip;
    }

    /**
     * Sets the value of the field <code>practiceZip</code>.
     * @param practiceZip the practiceZip to set
     */
    public void setPracticeZip(String practiceZip) {
        this.practiceZip = practiceZip;
    }

    /**
     * Gets the value of the field <code>secondaryAddress</code>.
     * @return the secondaryAddress
     */
    public Address getSecondaryAddress() {
        return secondaryAddress;
    }

    /**
     * Sets the value of the field <code>secondaryAddress</code>.
     * @param secondaryAddress the secondaryAddress to set
     */
    public void setSecondaryAddress(Address secondaryAddress) {
        this.secondaryAddress = secondaryAddress;
    }

    /**
     * Gets the value of the field <code>secondaryPhoneNumber</code>.
     * @return the secondaryPhoneNumber
     */
    public String getSecondaryPhoneNumber() {
        return secondaryPhoneNumber;
    }

    /**
     * Sets the value of the field <code>secondaryPhoneNumber</code>.
     * @param secondaryPhoneNumber the secondaryPhoneNumber to set
     */
    public void setSecondaryPhoneNumber(String secondaryPhoneNumber) {
        this.secondaryPhoneNumber = secondaryPhoneNumber;
    }
}