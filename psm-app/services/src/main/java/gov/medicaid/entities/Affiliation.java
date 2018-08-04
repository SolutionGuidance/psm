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
import javax.persistence.Transient;
import java.io.Serializable;
import java.util.Date;
import java.util.List;

/**
 * Represents group/member affiliation.
 */
@javax.persistence.Entity
@Table(name = "affiliations")
public class Affiliation implements Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "affiliation_id")
    private long id;

    /**
     * Primary indicator.
     */
    @Column(name = "is_primary")
    private String primaryInd;

    /**
     * Owning profile id.
     */
    @Column(name = "profile_id")
    private long profileId;

    /**
     * Additional location, member, etc.
     */
    @Column(name = "object_type")
    private String objectType;

    @Column(name = "effective_at")
    private Date effectiveDate;

    @Column(name = "target_profile_id")
    private long targetProfileId;

    @Column(name = "target_entity_id")
    private long targetEntityId;

    /**
     * For qualified professionals.
     */
    @ManyToOne
    @JoinColumn(name = "qualified_professional_type_code")
    private QPType qpType;

    /**
     * Subtype for mental health professional.
     */
    @Column(name = "mental_health_professional_type")
    private String mhpType;

    /**
     * Acknowledgement attachment (QP).
     */
    @Column(name = "acknowledgement_attachment_id")
    private String acknowledgementAttachmentId;

    /**
     * Ended flag.
     */
    @Column(name = "is_terminated")
    private String terminatedInd;

    /**
     * End date.
     */
    @Column(name = "terminated_at")
    private Date terminationDate;

    @Transient
    private List<License> affiliateLicenses;

    @Transient
    private Entity entity;

    /**
     * The BGS Study ID for Personal Care Provider Org.
     */
    @Column(name = "bgs_study_id")
    private String bgsStudyId;

    /**
     * The BGS Clearance Date for Personal Care Provide Org.
     */
    @Column(name = "bgs_clearance_date")
    private Date bgsClearanceDate;

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public long getTargetProfileId() {
        return targetProfileId;
    }

    public void setTargetProfileId(long targetProfileId) {
        this.targetProfileId = targetProfileId;
    }

    public long getProfileId() {
        return profileId;
    }

    public void setProfileId(long profileId) {
        this.profileId = profileId;
    }

    public long getTargetEntityId() {
        return targetEntityId;
    }

    public void setTargetEntityId(long targetEntityId) {
        this.targetEntityId = targetEntityId;
    }

    public Entity getEntity() {
        return entity;
    }

    public void setEntity(Entity entity) {
        this.entity = entity;
    }

    public String getPrimaryInd() {
        return primaryInd;
    }

    public void setPrimaryInd(String primaryInd) {
        this.primaryInd = primaryInd;
    }

    public Date getEffectiveDate() {
        return effectiveDate;
    }

    public void setEffectiveDate(Date effectiveDate) {
        this.effectiveDate = effectiveDate;
    }

    public String getObjectType() {
        return objectType;
    }

    public void setObjectType(String objectType) {
        this.objectType = objectType;
    }

    public QPType getQpType() {
        return qpType;
    }

    public void setQpType(QPType qpType) {
        this.qpType = qpType;
    }

    public String getAcknowledgementAttachmentId() {
        return acknowledgementAttachmentId;
    }

    public void setAcknowledgementAttachmentId(String acknowledgementAttachmentId) {
        this.acknowledgementAttachmentId = acknowledgementAttachmentId;
    }

    public String getTerminatedInd() {
        return terminatedInd;
    }

    public void setTerminatedInd(String terminatedInd) {
        this.terminatedInd = terminatedInd;
    }

    public Date getTerminationDate() {
        return terminationDate;
    }

    public void setTerminationDate(Date terminationDate) {
        this.terminationDate = terminationDate;
    }

    public List<License> getAffiliateLicenses() {
        return affiliateLicenses;
    }

    public void setAffiliateLicenses(List<License> affiliateLicenses) {
        this.affiliateLicenses = affiliateLicenses;
    }

    public String getMhpType() {
        return mhpType;
    }

    public void setMhpType(String mhpType) {
        this.mhpType = mhpType;
    }

    public String getBgsStudyId() {
        return bgsStudyId;
    }

    public void setBgsStudyId(String bgsStudyId) {
        this.bgsStudyId = bgsStudyId;
    }

    public Date getBgsClearanceDate() {
        return bgsClearanceDate;
    }

    public void setBgsClearanceDate(Date bgsClearanceDate) {
        this.bgsClearanceDate = bgsClearanceDate;
    }
}
