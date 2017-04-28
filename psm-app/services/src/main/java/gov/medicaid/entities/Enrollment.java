/*
 * Copyright 2012-2013 TopCoder, Inc.
 *
 * This code was developed under U.S. government contract NNH10CD71C. 
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * You may not use this file except in compliance with the License.
 * You may obtain a copy of the License at:
 *     http://www.apache.org/licenses/LICENSE-2.0
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package gov.medicaid.entities;

import java.io.Serializable;
import java.util.Date;

/**
 * Represents a ticket/enrollment.
 *
 * @author TCSASSEMBLER
 * @version 1.0
 */
public class Enrollment implements Serializable {

    /**
     * Ticket identifier.
     */
    private long ticketId;

    /**
     * Ticket status.
     */
    private EnrollmentStatus status;

    /**
     * Ticket request type.
     */
    private RequestType requestType;

    /**
     * Business process instance.
     */
    private long processInstanceId;

    /**
     * The profile id that was created by this ticket.
     */
    private long profileReferenceId;

    /**
     * The current page.
     */
    private String progressPage;

    /**
     * The timestamp of the referenced profile.
     */
    private Date referenceTimestamp;

    /**
     * The submission date.
     */
    private Date submissionDate;

    /**
     * The last status change date.
     */
    private Date statusDate;

    /**
     * Note included in the last status change.
     */
    private String statusNote;

    /**
     * Username that submitted the request.
     */
    private String submittedBy;

    /**
     * Username that created this request.
     */
    private String createdBy;

    /**
     * Username that created this request.
     */
    private Date createdOn;

    /**
     * Username that last made changes to the ticket.
     */
    private String lastUpdatedBy;

    /**
     * Ticket details.
     */
    private ProviderProfile details;

    /**
     * Empty constructor.
     */
    public Enrollment() {
    }

    /**
     * Gets the value of the field <code>ticketId</code>.
     *
     * @return the ticketId
     */
    public long getTicketId() {
        return ticketId;
    }

    /**
     * Sets the value of the field <code>ticketId</code>.
     *
     * @param ticketId the ticketId to set
     */
    public void setTicketId(long ticketId) {
        this.ticketId = ticketId;
    }

    /**
     * Gets the value of the field <code>status</code>.
     *
     * @return the status
     */
    public EnrollmentStatus getStatus() {
        return status;
    }

    /**
     * Sets the value of the field <code>status</code>.
     *
     * @param status the status to set
     */
    public void setStatus(EnrollmentStatus status) {
        this.status = status;
    }

    /**
     * Gets the value of the field <code>requestType</code>.
     *
     * @return the requestType
     */
    public RequestType getRequestType() {
        return requestType;
    }

    /**
     * Sets the value of the field <code>requestType</code>.
     *
     * @param requestType the requestType to set
     */
    public void setRequestType(RequestType requestType) {
        this.requestType = requestType;
    }

    /**
     * Gets the value of the field <code>statusDate</code>.
     *
     * @return the statusDate
     */
    public Date getStatusDate() {
        return statusDate;
    }

    /**
     * Sets the value of the field <code>statusDate</code>.
     *
     * @param statusDate the statusDate to set
     */
    public void setStatusDate(Date statusDate) {
        this.statusDate = statusDate;
    }

    /**
     * Gets the value of the field <code>statusNote</code>.
     *
     * @return the statusNote
     */
    public String getStatusNote() {
        return statusNote;
    }

    /**
     * Sets the value of the field <code>statusNote</code>.
     *
     * @param statusNote the statusNote to set
     */
    public void setStatusNote(String statusNote) {
        this.statusNote = statusNote;
    }

    /**
     * Gets the value of the field <code>submittedBy</code>.
     *
     * @return the submittedBy
     */
    public String getSubmittedBy() {
        return submittedBy;
    }

    /**
     * Sets the value of the field <code>submittedBy</code>.
     *
     * @param submittedBy the submittedBy to set
     */
    public void setSubmittedBy(String submittedBy) {
        this.submittedBy = submittedBy;
    }

    /**
     * Gets the value of the field <code>lastUpdatedBy</code>.
     *
     * @return the lastUpdatedBy
     */
    public String getLastUpdatedBy() {
        return lastUpdatedBy;
    }

    /**
     * Sets the value of the field <code>lastUpdatedBy</code>.
     *
     * @param lastUpdatedBy the lastUpdatedBy to set
     */
    public void setLastUpdatedBy(String lastUpdatedBy) {
        this.lastUpdatedBy = lastUpdatedBy;
    }

    /**
     * Gets the value of the field <code>details</code>.
     *
     * @return the details
     */
    public ProviderProfile getDetails() {
        return details;
    }

    /**
     * Sets the value of the field <code>details</code>.
     *
     * @param details the details to set
     */
    public void setDetails(ProviderProfile details) {
        this.details = details;
    }

    /**
     * Gets the value of the field <code>processInstanceId</code>.
     *
     * @return the processInstanceId
     */
    public long getProcessInstanceId() {
        return processInstanceId;
    }

    /**
     * Sets the value of the field <code>processInstanceId</code>.
     *
     * @param processInstanceId the processInstanceId to set
     */
    public void setProcessInstanceId(long processInstanceId) {
        this.processInstanceId = processInstanceId;
    }

    /**
     * Gets the value of the field <code>submissionDate</code>.
     *
     * @return the submissionDate
     */
    public Date getSubmissionDate() {
        return submissionDate;
    }

    /**
     * Sets the value of the field <code>submissionDate</code>.
     *
     * @param submissionDate the submissionDate to set
     */
    public void setSubmissionDate(Date submissionDate) {
        this.submissionDate = submissionDate;
    }

    /**
     * Gets the value of the field <code>createdBy</code>.
     *
     * @return the createdBy
     */
    public String getCreatedBy() {
        return createdBy;
    }

    /**
     * Sets the value of the field <code>createdBy</code>.
     *
     * @param createdBy the createdBy to set
     */
    public void setCreatedBy(String createdBy) {
        this.createdBy = createdBy;
    }

    /**
     * Gets the value of the field <code>profileReferenceId</code>.
     * @return the profileReferenceId
     */
    public long getProfileReferenceId() {
        return profileReferenceId;
    }

    /**
     * Sets the value of the field <code>profileReferenceId</code>.
     * @param profileReferenceId the profileReferenceId to set
     */
    public void setProfileReferenceId(long profileReferenceId) {
        this.profileReferenceId = profileReferenceId;
    }

    /**
     * Gets the value of the field <code>createdOn</code>.
     * @return the createdOn
     */
    public Date getCreatedOn() {
        return createdOn;
    }

    /**
     * Sets the value of the field <code>createdOn</code>.
     * @param createdOn the createdOn to set
     */
    public void setCreatedOn(Date createdOn) {
        this.createdOn = createdOn;
    }

    /**
     * Gets the value of the field <code>progressPage</code>.
     * @return the progressPage
     */
    public String getProgressPage() {
        return progressPage;
    }

    /**
     * Sets the value of the field <code>progressPage</code>.
     * @param progressPage the progressPage to set
     */
    public void setProgressPage(String progressPage) {
        this.progressPage = progressPage;
    }

    /**
     * Gets the value of the field <code>referenceTimestamp</code>.
     * @return the referenceTimestamp
     */
    public Date getReferenceTimestamp() {
        return referenceTimestamp;
    }

    /**
     * Sets the value of the field <code>referenceTimestamp</code>.
     * @param referenceTimestamp the referenceTimestamp to set
     */
    public void setReferenceTimestamp(Date referenceTimestamp) {
        this.referenceTimestamp = referenceTimestamp;
    }
}
