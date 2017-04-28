/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.entities;

import gov.medicaid.entities.ExclusionType;
import gov.medicaid.entities.NPIType;

import java.util.Date;

/**
 * This represents the search criteria for EPLS excluded providers.
 *
 * @author sampath01, j3_guile
 * @version 1.0
 */
public class EPLSSearchCriteria extends SearchCriteria {

    /**
     * NPI type.
     */
    private NPIType npiType;

    /**
     * Name.
     */
    private String name;

    /**
     * Action date from.
     */
    private Date actionDateFrom;

    /**
     * Action date to.
     */
    private Date actionDateTo;

    /**
     * Termination date from.
     */
    private Date terminationDateFrom;

    /**
     * Termination date to.
     */
    private Date terminationDateTo;

    /**
     * Create date from.
     */
    private Date createDateFrom;

    /**
     * Create date to.
     */
    private Date createDateTo;

    /**
     * Modify date from.
     */
    private Date modifyDateFrom;

    /**
     * Modify date to.
     */
    private Date modifyDateTo;

    /**
     * Exclusion type.
     */
    private ExclusionType exclusionType;

    /**
     * Reciprocal code.
     */
    private String reciprocalCode;

    /**
     * Procurement code.
     */
    private String procurementCode;

    /**
     * Non procurement code.
     */
    private String nonProcurementCode;

    /**
     * Agency.
     */
    private String agency;

    /**
     * US state.
     */
    private String usState;

    /**
     * Country.
     */
    private String country;

    /**
     * DUNS.
     */
    private String duns;

    /**
     * Cage code.
     */
    private String cageCode;

    /**
     * Default empty constructor.
     */
    public EPLSSearchCriteria() {
    }

    /**
     * Gets the value of the field <code>npiType</code>.
     *
     * @return the npiType
     */
    public NPIType getNpiType() {
        return npiType;
    }

    /**
     * Sets the value of the field <code>npiType</code>.
     *
     * @param npiType the npiType to set
     */
    public void setNpiType(NPIType npiType) {
        this.npiType = npiType;
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
     * Gets the value of the field <code>actionDateFrom</code>.
     *
     * @return the actionDateFrom
     */
    public Date getActionDateFrom() {
        return actionDateFrom;
    }

    /**
     * Sets the value of the field <code>actionDateFrom</code>.
     *
     * @param actionDateFrom the actionDateFrom to set
     */
    public void setActionDateFrom(Date actionDateFrom) {
        this.actionDateFrom = actionDateFrom;
    }

    /**
     * Gets the value of the field <code>actionDateTo</code>.
     *
     * @return the actionDateTo
     */
    public Date getActionDateTo() {
        return actionDateTo;
    }

    /**
     * Sets the value of the field <code>actionDateTo</code>.
     *
     * @param actionDateTo the actionDateTo to set
     */
    public void setActionDateTo(Date actionDateTo) {
        this.actionDateTo = actionDateTo;
    }

    /**
     * Gets the value of the field <code>terminationDateFrom</code>.
     *
     * @return the terminationDateFrom
     */
    public Date getTerminationDateFrom() {
        return terminationDateFrom;
    }

    /**
     * Sets the value of the field <code>terminationDateFrom</code>.
     *
     * @param terminationDateFrom the terminationDateFrom to set
     */
    public void setTerminationDateFrom(Date terminationDateFrom) {
        this.terminationDateFrom = terminationDateFrom;
    }

    /**
     * Gets the value of the field <code>terminationDateTo</code>.
     *
     * @return the terminationDateTo
     */
    public Date getTerminationDateTo() {
        return terminationDateTo;
    }

    /**
     * Sets the value of the field <code>terminationDateTo</code>.
     *
     * @param terminationDateTo the terminationDateTo to set
     */
    public void setTerminationDateTo(Date terminationDateTo) {
        this.terminationDateTo = terminationDateTo;
    }

    /**
     * Gets the value of the field <code>createDateFrom</code>.
     *
     * @return the createDateFrom
     */
    public Date getCreateDateFrom() {
        return createDateFrom;
    }

    /**
     * Sets the value of the field <code>createDateFrom</code>.
     *
     * @param createDateFrom the createDateFrom to set
     */
    public void setCreateDateFrom(Date createDateFrom) {
        this.createDateFrom = createDateFrom;
    }

    /**
     * Gets the value of the field <code>createDateTo</code>.
     *
     * @return the createDateTo
     */
    public Date getCreateDateTo() {
        return createDateTo;
    }

    /**
     * Sets the value of the field <code>createDateTo</code>.
     *
     * @param createDateTo the createDateTo to set
     */
    public void setCreateDateTo(Date createDateTo) {
        this.createDateTo = createDateTo;
    }

    /**
     * Gets the value of the field <code>modifyDateFrom</code>.
     *
     * @return the modifyDateFrom
     */
    public Date getModifyDateFrom() {
        return modifyDateFrom;
    }

    /**
     * Sets the value of the field <code>modifyDateFrom</code>.
     *
     * @param modifyDateFrom the modifyDateFrom to set
     */
    public void setModifyDateFrom(Date modifyDateFrom) {
        this.modifyDateFrom = modifyDateFrom;
    }

    /**
     * Gets the value of the field <code>modifyDateTo</code>.
     *
     * @return the modifyDateTo
     */
    public Date getModifyDateTo() {
        return modifyDateTo;
    }

    /**
     * Sets the value of the field <code>modifyDateTo</code>.
     *
     * @param modifyDateTo the modifyDateTo to set
     */
    public void setModifyDateTo(Date modifyDateTo) {
        this.modifyDateTo = modifyDateTo;
    }

    /**
     * Gets the value of the field <code>exclusionType</code>.
     *
     * @return the exclusionType
     */
    public ExclusionType getExclusionType() {
        return exclusionType;
    }

    /**
     * Sets the value of the field <code>exclusionType</code>.
     *
     * @param exclusionType the exclusionType to set
     */
    public void setExclusionType(ExclusionType exclusionType) {
        this.exclusionType = exclusionType;
    }

    /**
     * Gets the value of the field <code>reciprocalCode</code>.
     *
     * @return the reciprocalCode
     */
    public String getReciprocalCode() {
        return reciprocalCode;
    }

    /**
     * Sets the value of the field <code>reciprocalCode</code>.
     *
     * @param reciprocalCode the reciprocalCode to set
     */
    public void setReciprocalCode(String reciprocalCode) {
        this.reciprocalCode = reciprocalCode;
    }

    /**
     * Gets the value of the field <code>procurementCode</code>.
     *
     * @return the procurementCode
     */
    public String getProcurementCode() {
        return procurementCode;
    }

    /**
     * Sets the value of the field <code>procurementCode</code>.
     *
     * @param procurementCode the procurementCode to set
     */
    public void setProcurementCode(String procurementCode) {
        this.procurementCode = procurementCode;
    }

    /**
     * Gets the value of the field <code>nonProcurementCode</code>.
     *
     * @return the nonProcurementCode
     */
    public String getNonProcurementCode() {
        return nonProcurementCode;
    }

    /**
     * Sets the value of the field <code>nonProcurementCode</code>.
     *
     * @param nonProcurementCode the nonProcurementCode to set
     */
    public void setNonProcurementCode(String nonProcurementCode) {
        this.nonProcurementCode = nonProcurementCode;
    }

    /**
     * Gets the value of the field <code>agency</code>.
     *
     * @return the agency
     */
    public String getAgency() {
        return agency;
    }

    /**
     * Sets the value of the field <code>agency</code>.
     *
     * @param agency the agency to set
     */
    public void setAgency(String agency) {
        this.agency = agency;
    }

    /**
     * Gets the value of the field <code>usState</code>.
     *
     * @return the usState
     */
    public String getUsState() {
        return usState;
    }

    /**
     * Sets the value of the field <code>usState</code>.
     *
     * @param usState the usState to set
     */
    public void setUsState(String usState) {
        this.usState = usState;
    }

    /**
     * Gets the value of the field <code>country</code>.
     *
     * @return the country
     */
    public String getCountry() {
        return country;
    }

    /**
     * Sets the value of the field <code>country</code>.
     *
     * @param country the country to set
     */
    public void setCountry(String country) {
        this.country = country;
    }

    /**
     * Gets the value of the field <code>duns</code>.
     *
     * @return the duns
     */
    public String getDuns() {
        return duns;
    }

    /**
     * Sets the value of the field <code>duns</code>.
     *
     * @param duns the duns to set
     */
    public void setDuns(String duns) {
        this.duns = duns;
    }

    /**
     * Gets the value of the field <code>cageCode</code>.
     *
     * @return the cageCode
     */
    public String getCageCode() {
        return cageCode;
    }

    /**
     * Sets the value of the field <code>cageCode</code>.
     *
     * @param cageCode the cageCode to set
     */
    public void setCageCode(String cageCode) {
        this.cageCode = cageCode;
    }
}