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

    private String licenseNumber;

    private Date originalIssueDate;

    private Date renewalEndDate;

    private String issuingUSState;

    private IssuingBoard issuingBoard;

    private LicenseStatus status;

    private LicenseType type;

    private SpecialtyType specialty;

    private long attachmentId;

    public String getLicenseNumber() {
        return licenseNumber;
    }

    public void setLicenseNumber(String licenseNumber) {
        this.licenseNumber = licenseNumber;
    }

    public Date getOriginalIssueDate() {
        return originalIssueDate;
    }

    public void setOriginalIssueDate(Date originalIssueDate) {
        this.originalIssueDate = originalIssueDate;
    }

    public Date getRenewalEndDate() {
        return renewalEndDate;
    }

    public void setRenewalEndDate(Date renewalEndDate) {
        this.renewalEndDate = renewalEndDate;
    }

    public String getIssuingUSState() {
        return issuingUSState;
    }

    public void setIssuingUSState(String issuingUSState) {
        this.issuingUSState = issuingUSState;
    }

    public LicenseStatus getStatus() {
        return status;
    }

    public void setStatus(LicenseStatus status) {
        this.status = status;
    }

    public LicenseType getType() {
        return type;
    }

    public void setType(LicenseType type) {
        this.type = type;
    }

    public SpecialtyType getSpecialty() {
        return specialty;
    }

    public void setSpecialty(SpecialtyType specialty) {
        this.specialty = specialty;
    }

    public IssuingBoard getIssuingBoard() {
        return issuingBoard;
    }

    public void setIssuingBoard(IssuingBoard issuingBoard) {
        this.issuingBoard = issuingBoard;
    }

    public long getAttachmentId() {
        return attachmentId;
    }

    public void setAttachmentId(long attachmentId) {
        this.attachmentId = attachmentId;
    }

    public long getProfileId() {
        return profileId;
    }

    public void setProfileId(long profileId) {
        this.profileId = profileId;
    }

    public long getTicketId() {
        return ticketId;
    }

    public void setTicketId(long ticketId) {
        this.ticketId = ticketId;
    }

    public String getObjectType() {
        return objectType;
    }

    public void setObjectType(String objectType) {
        this.objectType = objectType;
    }

    public long getAffiliateId() {
        return affiliateId == null ? 0L : affiliateId;
    }

    public void setAffiliateId(Long affiliateId) {
        if (affiliateId == null) {
            this.affiliateId = 0L;
        } else {
            this.affiliateId = affiliateId;
        }
    }
}
