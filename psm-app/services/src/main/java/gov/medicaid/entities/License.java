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

import javax.persistence.Column;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import java.io.Serializable;
import java.util.Date;

/**
 * Represents a license or specialty certification.
 */
@javax.persistence.Entity
@Table(name = "licenses")
public class License implements Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "license_id")
    private long id;

    /**
     * The owner profile.
     */
    @Column(name = "profile_id")
    private long profileId;

    /**
     * The affiliate id if it belongs to a QP.
     */
    @Column(name = "affiliate_id")
    private Long affiliateId;

    /**
     * Specialty, Tribal Cert or License.
     */
    @Column(name = "object_type")
    private String objectType;

    @Column(name = "license_number")
    private String licenseNumber;

    @Column(name = "issued_at")
    private Date originalIssueDate;

    @Column(name = "expires_at")
    private Date renewalEndDate;

    @Column(name = "issuing_us_state")
    private String issuingUSState;

    @ManyToOne
    @JoinColumn(name = "issuing_board_code")
    private IssuingBoard issuingBoard;

    @ManyToOne
    @JoinColumn(name = "license_status_code")
    private LicenseStatus status;

    @ManyToOne
    @JoinColumn(name = "license_type_code")
    private LicenseType type;

    @ManyToOne
    @JoinColumn(name = "specialty_type_code")
    private SpecialtyType specialty;

    @Column(name = "attachment_id")
    private long attachmentId;

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

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
