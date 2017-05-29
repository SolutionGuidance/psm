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

    public long getTicketId() {
        return ticketId;
    }

    public void setTicketId(long ticketId) {
        this.ticketId = ticketId;
    }

    public EnrollmentStatus getStatus() {
        return status;
    }

    public void setStatus(EnrollmentStatus status) {
        this.status = status;
    }

    public RequestType getRequestType() {
        return requestType;
    }

    public void setRequestType(RequestType requestType) {
        this.requestType = requestType;
    }

    public Date getStatusDate() {
        return statusDate;
    }

    public void setStatusDate(Date statusDate) {
        this.statusDate = statusDate;
    }

    public String getStatusNote() {
        return statusNote;
    }

    public void setStatusNote(String statusNote) {
        this.statusNote = statusNote;
    }

    public String getSubmittedBy() {
        return submittedBy;
    }

    public void setSubmittedBy(String submittedBy) {
        this.submittedBy = submittedBy;
    }

    public String getLastUpdatedBy() {
        return lastUpdatedBy;
    }

    public void setLastUpdatedBy(String lastUpdatedBy) {
        this.lastUpdatedBy = lastUpdatedBy;
    }

    public ProviderProfile getDetails() {
        return details;
    }

    public void setDetails(ProviderProfile details) {
        this.details = details;
    }

    public long getProcessInstanceId() {
        return processInstanceId;
    }

    public void setProcessInstanceId(long processInstanceId) {
        this.processInstanceId = processInstanceId;
    }

    public Date getSubmissionDate() {
        return submissionDate;
    }

    public void setSubmissionDate(Date submissionDate) {
        this.submissionDate = submissionDate;
    }

    public String getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(String createdBy) {
        this.createdBy = createdBy;
    }

    public long getProfileReferenceId() {
        return profileReferenceId;
    }

    public void setProfileReferenceId(long profileReferenceId) {
        this.profileReferenceId = profileReferenceId;
    }

    public Date getCreatedOn() {
        return createdOn;
    }

    public void setCreatedOn(Date createdOn) {
        this.createdOn = createdOn;
    }

    public String getProgressPage() {
        return progressPage;
    }

    public void setProgressPage(String progressPage) {
        this.progressPage = progressPage;
    }

    public Date getReferenceTimestamp() {
        return referenceTimestamp;
    }

    public void setReferenceTimestamp(Date referenceTimestamp) {
        this.referenceTimestamp = referenceTimestamp;
    }
}
