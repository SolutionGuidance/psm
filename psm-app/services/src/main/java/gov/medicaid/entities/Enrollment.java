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

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedAttributeNode;
import javax.persistence.NamedEntityGraph;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Transient;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * Represents a ticket/enrollment.
 *
 * @author TCSASSEMBLER
 * @version 1.0
 */
@javax.persistence.Entity
@Table(name = "enrollments")
@NamedEntityGraph(
        name = "Enrollment with screenings",
        attributeNodes = {@NamedAttributeNode("automaticScreenings")}
)
public class Enrollment implements Serializable {

    /**
     * Ticket identifier.
     */
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "enrollment_id")
    private long ticketId;

    /**
     * Ticket status.
     */
    @ManyToOne
    @JoinColumn(name = "enrollment_status_code")
    private EnrollmentStatus status;

    /**
     * Ticket request type.
     */
    @ManyToOne
    @JoinColumn(name = "request_type_code")
    private RequestType requestType;

    /**
     * Business process instance.
     */
    @Column(
            name = "process_instance_id",
            nullable = false
    )
    private long processInstanceId = 0;

    /**
     * The profile id that was created by this ticket.
     */
    @Column(
            name = "profile_reference_id",
            nullable = false
    )
    private long profileReferenceId = 0;

    /**
     * The current page.
     */
    @Column(name = "progress_page")
    private String progressPage;

    /**
     * The timestamp of the referenced profile.
     */
    @Column(name = "reference_timestamp")
    private Date referenceTimestamp;

    @Column(name = "submitted_at")
    private Date submissionDate;

    /**
     * The last status change date.
     */
    @Column(name = "changed_at")
    private Date statusDate;

    /**
     * Note included in the last status change.
     */
    @Column(name = "change_note")
    private String statusNote;

    /**
     * Username that submitted the request.
     */
    @Column(name = "submitted_by")
    private String submittedBy;

    /**
     * Username that created this request.
     */
    @Column(name = "created_by")
    private String createdBy;

    @Column(name = "created_at")
    private Date createdOn;

    /**
     * Username that last made changes to the ticket.
     */
    @Column(name = "changed_by")
    private String lastUpdatedBy;

    /**
     * Ticket details.
     */
    @Transient
    private ProviderProfile details;

    @OneToMany(
            mappedBy = "enrollment",
            cascade = CascadeType.ALL
    )
    private List<AutomaticScreening> automaticScreenings = new ArrayList<>();

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

    public List<AutomaticScreening> getAutomaticScreenings() {
        return automaticScreenings;
    }

    public void setAutomaticScreenings(List<AutomaticScreening> automaticScreenings) {
        this.automaticScreenings = automaticScreenings;
    }

    public void addAutomaticScreening(AutomaticScreening automaticScreening) {
        automaticScreening.setEnrollment(this);
        automaticScreenings.add(automaticScreening);
    }
}
