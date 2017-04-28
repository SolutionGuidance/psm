/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.entities;

import java.util.Date;
import java.util.List;

/**
 * Represents a business.
 *
 * @author argolite, j3_guile
 * @version 1.0
 */
public class Business extends IdentifiableEntity {

    /**
     * Business Status.
     */
    private BusinessStatus status;

    /**
     * Name.
     */
    private String name;

    /**
     * Business Type.
     */
    private BusinessType type;

    /**
     * File number.
     */
    private String fileNumber;

    /**
     * Statute.
     */
    private String statute;

    /**
     * Home jurisdiction.
     */
    private String homeJurisdiction;

    /**
     * Filing date.
     */
    private Date filingDate;

    /**
     * Renewal due date.
     */
    private Date renewalDueDate;

    /**
     * Registered office address.
     */
    private Address registeredOfficeAddress;

    /**
     * Registered agents.
     */
    private List<ProviderProfile> registeredAgents;

    /**
     * Filing history.
     */
    private List<FilingHistory> filingHistory;

    /**
     * Default empty constructor.
     */
    public Business() {
    }

    /**
     * Gets the value of the field <code>status</code>.
     *
     * @return the status
     */
    public BusinessStatus getStatus() {
        return status;
    }

    /**
     * Sets the value of the field <code>status</code>.
     *
     * @param status the status to set
     */
    public void setStatus(BusinessStatus status) {
        this.status = status;
    }

    /**
     * Gets the value of the field <code>name</code>.
     *
     * @return the name
     */
    public String getName() {
        return name;
    }

    /**
     * Sets the value of the field <code>name</code>.
     *
     * @param name the name to set
     */
    public void setName(String name) {
        this.name = name;
    }

    /**
     * Gets the value of the field <code>type</code>.
     *
     * @return the type
     */
    public BusinessType getType() {
        return type;
    }

    /**
     * Sets the value of the field <code>type</code>.
     *
     * @param type the type to set
     */
    public void setType(BusinessType type) {
        this.type = type;
    }

    /**
     * Gets the value of the field <code>fileNumber</code>.
     *
     * @return the fileNumber
     */
    public String getFileNumber() {
        return fileNumber;
    }

    /**
     * Sets the value of the field <code>fileNumber</code>.
     *
     * @param fileNumber the fileNumber to set
     */
    public void setFileNumber(String fileNumber) {
        this.fileNumber = fileNumber;
    }

    /**
     * Gets the value of the field <code>statute</code>.
     *
     * @return the statute
     */
    public String getStatute() {
        return statute;
    }

    /**
     * Sets the value of the field <code>statute</code>.
     *
     * @param statute the statute to set
     */
    public void setStatute(String statute) {
        this.statute = statute;
    }

    /**
     * Gets the value of the field <code>homeJurisdiction</code>.
     *
     * @return the homeJurisdiction
     */
    public String getHomeJurisdiction() {
        return homeJurisdiction;
    }

    /**
     * Sets the value of the field <code>homeJurisdiction</code>.
     *
     * @param homeJurisdiction the homeJurisdiction to set
     */
    public void setHomeJurisdiction(String homeJurisdiction) {
        this.homeJurisdiction = homeJurisdiction;
    }

    /**
     * Gets the value of the field <code>filingDate</code>.
     *
     * @return the filingDate
     */
    public Date getFilingDate() {
        return filingDate;
    }

    /**
     * Sets the value of the field <code>filingDate</code>.
     *
     * @param filingDate the filingDate to set
     */
    public void setFilingDate(Date filingDate) {
        this.filingDate = filingDate;
    }

    /**
     * Gets the value of the field <code>renewalDueDate</code>.
     *
     * @return the renewalDueDate
     */
    public Date getRenewalDueDate() {
        return renewalDueDate;
    }

    /**
     * Sets the value of the field <code>renewalDueDate</code>.
     *
     * @param renewalDueDate the renewalDueDate to set
     */
    public void setRenewalDueDate(Date renewalDueDate) {
        this.renewalDueDate = renewalDueDate;
    }

    /**
     * Gets the value of the field <code>registeredOfficeAddress</code>.
     *
     * @return the registeredOfficeAddress
     */
    public Address getRegisteredOfficeAddress() {
        return registeredOfficeAddress;
    }

    /**
     * Sets the value of the field <code>registeredOfficeAddress</code>.
     *
     * @param registeredOfficeAddress the registeredOfficeAddress to set
     */
    public void setRegisteredOfficeAddress(Address registeredOfficeAddress) {
        this.registeredOfficeAddress = registeredOfficeAddress;
    }

    /**
     * Gets the value of the field <code>registeredAgents</code>.
     *
     * @return the registeredAgents
     */
    public List<ProviderProfile> getRegisteredAgents() {
        return registeredAgents;
    }

    /**
     * Sets the value of the field <code>registeredAgents</code>.
     *
     * @param registeredAgents the registeredAgents to set
     */
    public void setRegisteredAgents(List<ProviderProfile> registeredAgents) {
        this.registeredAgents = registeredAgents;
    }

    /**
     * Gets the value of the field <code>filingHistory</code>.
     *
     * @return the filingHistory
     */
    public List<FilingHistory> getFilingHistory() {
        return filingHistory;
    }

    /**
     * Sets the value of the field <code>filingHistory</code>.
     *
     * @param filingHistory the filingHistory to set
     */
    public void setFilingHistory(List<FilingHistory> filingHistory) {
        this.filingHistory = filingHistory;
    }

}
