/*
 * Copyright 2012, 2013 TopCoder, Inc.
 * Copyright 2018 The MITRE Corporation
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package gov.medicaid.entities;

import java.util.Date;
import java.util.List;

/**
 * Represents a provider search criteria.
 */
public class ProviderSearchCriteria extends SearchCriteria {

    /**
     * Application id.
     */
    private String applicationNumber;

    /**
     * Profile id.
     */
    private long profileId;


    /**
     * Provider NPI/UMPI.
     */
    private String npi;

    /**
     * Provider Risk Level.
     */
    private String riskLevel;

    /**
     * Request types.
     */
    private List<String> riskLevels;

    /**
     * Provider type.
     */
    private String providerType;

    /**
     * Request types.
     */
    private List<String> requestTypes;

    /**
     * Statuses.
     */
    private List<String> statuses;

    /**
     * Submission date start.
     */
    private Date submissionDateStart;

    /**
     * Submission date end.
     */
    private Date submissionDateEnd;

    /**
     * Last status change start date.
     */
    private Date statusDateStart;

    /**
     * Last status change end date.
     */
    private Date statusDateEnd;

    /**
     * Request create start date filter.
     */
    private Date createDateStart;

    /**
     * Request create end date filter.
     */
    private Date createDateEnd;

    /**
     * Provider name filter.
     */
    private String providerName;

    /**
     * Default empty constructor.
     */
    public ProviderSearchCriteria() {
    }

    /**
     * Gets the value of the field <code>applicationNumber</code>.
     *
     * @return the applicationNumber
     */
    public String getApplicationNumber() {
        return applicationNumber;
    }

    /**
     * Sets the value of the field <code>applicationNumber</code>.
     *
     * @param applicationNumber the applicationNumber to set
     */
    public void setApplicationNumber(String applicationNumber) {
        this.applicationNumber = applicationNumber;
    }

    /**
     * Gets the value of the field <code>providerType</code>.
     *
     * @return the providerType
     */
    public String getProviderType() {
        return providerType;
    }

    /**
     * Sets the value of the field <code>providerType</code>.
     *
     * @param providerType the providerType to set
     */
    public void setProviderType(String providerType) {
        this.providerType = providerType;
    }

    /**
     * Gets the value of the field <code>requestTypes</code>.
     *
     * @return the requestTypes
     */
    public List<String> getRequestTypes() {
        return requestTypes;
    }

    /**
     * Sets the value of the field <code>requestTypes</code>.
     *
     * @param requestTypes the requestTypes to set
     */
    public void setRequestTypes(List<String> requestTypes) {
        this.requestTypes = requestTypes;
    }

    /**
     * Gets the value of the field <code>statuses</code>.
     *
     * @return the statuses
     */
    public List<String> getStatuses() {
        return statuses;
    }

    /**
     * Sets the value of the field <code>statuses</code>.
     *
     * @param statuses the statuses to set
     */
    public void setStatuses(List<String> statuses) {
        this.statuses = statuses;
    }

    /**
     * Gets the value of the field <code>submissionDateStart</code>.
     *
     * @return the submissionDateStart
     */
    public Date getSubmissionDateStart() {
        return submissionDateStart;
    }

    /**
     * Sets the value of the field <code>submissionDateStart</code>.
     *
     * @param submissionDateStart the submissionDateStart to set
     */
    public void setSubmissionDateStart(Date submissionDateStart) {
        this.submissionDateStart = submissionDateStart;
    }

    /**
     * Gets the value of the field <code>submissionDateEnd</code>.
     *
     * @return the submissionDateEnd
     */
    public Date getSubmissionDateEnd() {
        return submissionDateEnd;
    }

    /**
     * Sets the value of the field <code>submissionDateEnd</code>.
     *
     * @param submissionDateEnd the submissionDateEnd to set
     */
    public void setSubmissionDateEnd(Date submissionDateEnd) {
        this.submissionDateEnd = submissionDateEnd;
    }

    /**
     * Gets the value of the field <code>npi</code>.
     *
     * @return the npi
     */
    public String getNpi() {
        return npi;
    }

    /**
     * Sets the value of the field <code>npi</code>.
     *
     * @param npi the npi to set
     */
    public void setNpi(String npi) {
        this.npi = npi;
    }

    /**
     * Gets the value of the field <code>riskLevel</code>.
     *
     * @return the riskLevel
     */
    public String getRiskLevel() {
        return riskLevel;
    }

    /**
     * Sets the value of the field <code>riskLevel</code>.
     *
     * @param riskLevel the riskLevel to set
     */
    public void setRiskLevel(String riskLevel) {
        this.riskLevel = riskLevel;
    }

    /**
     * Gets the value of the field <code>statusDateStart</code>.
     * @return the statusDateStart
     */
    public Date getStatusDateStart() {
        return statusDateStart;
    }

    /**
     * Sets the value of the field <code>statusDateStart</code>.
     * @param statusDateStart the statusDateStart to set
     */
    public void setStatusDateStart(Date statusDateStart) {
        this.statusDateStart = statusDateStart;
    }

    /**
     * Gets the value of the field <code>statusDateEnd</code>.
     * @return the statusDateEnd
     */
    public Date getStatusDateEnd() {
        return statusDateEnd;
    }

    /**
     * Sets the value of the field <code>statusDateEnd</code>.
     * @param statusDateEnd the statusDateEnd to set
     */
    public void setStatusDateEnd(Date statusDateEnd) {
        this.statusDateEnd = statusDateEnd;
    }

    /**
     * Gets the value of the field <code>createDateStart</code>.
     * @return the createDateStart
     */
    public Date getCreateDateStart() {
        return createDateStart;
    }

    /**
     * Sets the value of the field <code>createDateStart</code>.
     * @param createDateStart the createDateStart to set
     */
    public void setCreateDateStart(Date createDateStart) {
        this.createDateStart = createDateStart;
    }

    /**
     * Gets the value of the field <code>createDateEnd</code>.
     * @return the createDateEnd
     */
    public Date getCreateDateEnd() {
        return createDateEnd;
    }

    /**
     * Sets the value of the field <code>createDateEnd</code>.
     * @param createDateEnd the createDateEnd to set
     */
    public void setCreateDateEnd(Date createDateEnd) {
        this.createDateEnd = createDateEnd;
    }

    /**
     * Gets the value of the field <code>profileId</code>.
     * @return the profileId
     */
    public long getProfileId() {
        return profileId;
    }

    /**
     * Sets the value of the field <code>profileId</code>.
     * @param profileId the profileId to set
     */
    public void setProfileId(long profileId) {
        this.profileId = profileId;
    }

    /**
     * Gets the value of the field <code>providerName</code>.
     * @return the providerName
     */
    public String getProviderName() {
        return providerName;
    }

    /**
     * Sets the value of the field <code>providerName</code>.
     * @param providerName the providerName to set
     */
    public void setProviderName(String providerName) {
        this.providerName = providerName;
    }

    /**
     * Gets the value of the field <code>riskLevels</code>.
     * @return the riskLevels
     */
    public List<String> getRiskLevels() {
        return riskLevels;
    }

    /**
     * Sets the value of the field <code>riskLevels</code>.
     * @param riskLevels the riskLevels to set
     */
    public void setRiskLevels(List<String> riskLevels) {
        this.riskLevels = riskLevels;
    }
}
