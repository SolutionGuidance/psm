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
import java.util.List;

/**
 * Represents group/member affiliation.
 */
public class Affiliation extends IdentifiableEntity {

    /**
     * Primary indicator.
     */
    private String primaryInd;

    /**
     * Owning profile id.
     */
    private long profileId;

    /**
     * Additional location, member, etc.
     */
    private String objectType;

    /**
     * Owning ticket id.
     */
    private long ticketId;

    private Date effectiveDate;

    private long targetProfileId;

    private long targetEntityId;

    /**
     * For qualified professionals.
     */
    private QPType qpType;

    /**
     * Subtype for mental health professional.
     */
    private String mhpType;

    /**
     * Acknowledgement attachment (QP).
     */
    private String acknowledgementAttachmentId;

    /**
     * Ended flag.
     */
    private String terminatedInd;

    /**
     * End date.
     */
    private Date terminationDate;

    private List<License> affiliateLicenses;

    private Entity entity;

    /**
     * The BGS Study ID for Personal Care Provider Org.
     */
    private String bgsStudyId;

    /**
     * The BGS Clearance Date for Personal Care Provide Org.
     */
    private Date bgsClearanceDate;

    /**
     * Empty constructor.
     */
    public Affiliation() {
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

    public long getTicketId() {
        return ticketId;
    }

    public void setTicketId(long ticketId) {
        this.ticketId = ticketId;
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
