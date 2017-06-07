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


import java.util.Date;

/**
 * Represents a license or specialty certification.
 *
 * @author TCSASSEMBLER
 * @version 1.0
 */
public class License extends IdentifiableEntity {

    /**
     * The owner profile.
     */
    private long profileId;

    /**
     * The owner ticket.
     */
    private long ticketId;

    /**
     * The affiliate id if it belongs to a QP.
     */
    private Long affiliateId;

    /**
     * Specialty, Tribal Cert or License.
     */
    private String objectType;

    /**
     * License number.
     */
    private String licenseNumber;

    /**
     * Original issue date.
     */
    private Date originalIssueDate;

    /**
     * Renewal date.
     */
    private Date renewalEndDate;

    /**
     * Issuing state.
     */
    private String issuingUSState;

    /**
     * The issuing board.
     */
    private IssuingBoard issuingBoard;

    /**
     * Status.
     */
    private LicenseStatus status;

    /**
     * License type.
     */
    private LicenseType type;

    /**
     * Specialty type.
     */
    private SpecialtyType specialty;

    /**
     * Verified.
     */
    private String verified;

    /**
     * Attachment id.
     */
    private long attachmentId;

    /**
     * Default empty constructor.
     */
    public License() {
    }

    /**
     * Gets the value of the field <code>licenseNumber</code>.
     *
     * @return the licenseNumber
     */
    public String getLicenseNumber() {
        return licenseNumber;
    }

    /**
     * Sets the value of the field <code>licenseNumber</code>.
     *
     * @param licenseNumber the licenseNumber to set
     */
    public void setLicenseNumber(String licenseNumber) {
        this.licenseNumber = licenseNumber;
    }

    /**
     * Gets the value of the field <code>originalIssueDate</code>.
     *
     * @return the originalIssueDate
     */
    public Date getOriginalIssueDate() {
        return originalIssueDate;
    }

    /**
     * Sets the value of the field <code>originalIssueDate</code>.
     *
     * @param originalIssueDate the originalIssueDate to set
     */
    public void setOriginalIssueDate(Date originalIssueDate) {
        this.originalIssueDate = originalIssueDate;
    }

    /**
     * Gets the value of the field <code>renewalEndDate</code>.
     *
     * @return the renewalEndDate
     */
    public Date getRenewalEndDate() {
        return renewalEndDate;
    }

    /**
     * Sets the value of the field <code>renewalEndDate</code>.
     *
     * @param renewalEndDate the renewalEndDate to set
     */
    public void setRenewalEndDate(Date renewalEndDate) {
        this.renewalEndDate = renewalEndDate;
    }

    /**
     * Gets the value of the field <code>issuingUSState</code>.
     *
     * @return the issuingUSState
     */
    public String getIssuingUSState() {
        return issuingUSState;
    }

    /**
     * Sets the value of the field <code>issuingUSState</code>.
     *
     * @param issuingUSState the issuingUSState to set
     */
    public void setIssuingUSState(String issuingUSState) {
        this.issuingUSState = issuingUSState;
    }

    /**
     * Gets the value of the field <code>status</code>.
     *
     * @return the status
     */
    public LicenseStatus getStatus() {
        return status;
    }

    /**
     * Sets the value of the field <code>status</code>.
     *
     * @param status the status to set
     */
    public void setStatus(LicenseStatus status) {
        this.status = status;
    }

    /**
     * Gets the value of the field <code>type</code>.
     *
     * @return the type
     */
    public LicenseType getType() {
        return type;
    }

    /**
     * Sets the value of the field <code>type</code>.
     *
     * @param type the type to set
     */
    public void setType(LicenseType type) {
        this.type = type;
    }

    /**
     * Gets the value of the field <code>specialty</code>.
     *
     * @return the specialty
     */
    public SpecialtyType getSpecialty() {
        return specialty;
    }

    /**
     * Sets the value of the field <code>specialty</code>.
     *
     * @param specialty the specialty to set
     */
    public void setSpecialty(SpecialtyType specialty) {
        this.specialty = specialty;
    }

    /**
     * Gets the value of the field <code>verified</code>.
     *
     * @return the verified
     */
    public String getVerified() {
        return verified;
    }

    /**
     * Sets the value of the field <code>verified</code>.
     *
     * @param verified the verified to set
     */
    public void setVerified(String verified) {
        this.verified = verified;
    }

    /**
     * Gets the value of the field <code>issuingBoard</code>.
     *
     * @return the issuingBoard
     */
    public IssuingBoard getIssuingBoard() {
        return issuingBoard;
    }

    /**
     * Sets the value of the field <code>issuingBoard</code>.
     *
     * @param issuingBoard the issuingBoard to set
     */
    public void setIssuingBoard(IssuingBoard issuingBoard) {
        this.issuingBoard = issuingBoard;
    }

    /**
     * Gets the value of the field <code>attachmentId</code>.
     *
     * @return the attachmentId
     */
    public long getAttachmentId() {
        return attachmentId;
    }

    /**
     * Sets the value of the field <code>attachmentId</code>.
     *
     * @param attachmentId the attachmentId to set
     */
    public void setAttachmentId(long attachmentId) {
        this.attachmentId = attachmentId;
    }

    /**
     * Gets the value of the field <code>profileId</code>.
     *
     * @return the profileId
     */
    public long getProfileId() {
        return profileId;
    }

    /**
     * Sets the value of the field <code>profileId</code>.
     *
     * @param profileId the profileId to set
     */
    public void setProfileId(long profileId) {
        this.profileId = profileId;
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
     * Gets the value of the field <code>objectType</code>.
     * @return the objectType
     */
    public String getObjectType() {
        return objectType;
    }

    /**
     * Sets the value of the field <code>objectType</code>.
     * @param objectType the objectType to set
     */
    public void setObjectType(String objectType) {
        this.objectType = objectType;
    }

    /**
     * Gets the value of the field <code>affiliateId</code>.
     * @return the affiliateId
     */
    public long getAffiliateId() {
        return affiliateId == null ? 0L : affiliateId;
    }

    /**
     * Sets the value of the field <code>affiliateId</code>.
     * @param affiliateId the affiliateId to set
     */
    public void setAffiliateId(Long affiliateId) {
        if (affiliateId == null) {
            this.affiliateId = 0L;
        } else {
            this.affiliateId = affiliateId;
        }
    }
}
