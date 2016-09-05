/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.entities;

/**
 * This represents the search criteria for MN business and liens.
 *
 * @author sampath01, j3_guile
 * @version 1.0
 */
public class BusinessLienSearchCriteria extends SearchCriteria {

    /**
     * Business name filter.
     */
    private String businessName;

    /**
     * File number filter.
     */
    private String fileNumber;

    /**
     * Search scope.
     */
    private SearchScope scope;

    /**
     * Filing status.
     */
    private FilingStatus filingStatus;

    /**
     * Default empty constructor.
     */
    public BusinessLienSearchCriteria() {
    }

    /**
     * Gets the value of the field <code>businessName</code>.
     *
     * @return the businessName
     */
    public String getBusinessName() {
        return businessName;
    }

    /**
     * Sets the value of the field <code>businessName</code>.
     *
     * @param businessName the businessName to set
     */
    public void setBusinessName(String businessName) {
        this.businessName = businessName;
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
     * Gets the value of the field <code>scope</code>.
     *
     * @return the scope
     */
    public SearchScope getScope() {
        return scope;
    }

    /**
     * Sets the value of the field <code>scope</code>.
     *
     * @param scope the scope to set
     */
    public void setScope(SearchScope scope) {
        this.scope = scope;
    }

    /**
     * Gets the value of the field <code>filingStatus</code>.
     *
     * @return the filingStatus
     */
    public FilingStatus getFilingStatus() {
        return filingStatus;
    }

    /**
     * Sets the value of the field <code>filingStatus</code>.
     *
     * @param filingStatus the filingStatus to set
     */
    public void setFilingStatus(FilingStatus filingStatus) {
        this.filingStatus = filingStatus;
    }
}