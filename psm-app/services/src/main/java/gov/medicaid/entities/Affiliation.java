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
 *
 * @author TCSASSEMBLER
 * @version 1.0
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

    /**
     * Effective date.
     */
    private Date effectiveDate;

    /**
     * Target profile.
     */
    private long targetProfileId;

    /**
     * Target entity.
     */
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

    /**
     * Affiliates licenses.
     */
    private List<License> affiliateLicenses;

    /**
     * The entity.
     */
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
     * Gets the value of the field <code>targetProfileId</code>.
     *
     * @return the targetProfileId
     */
    public long getTargetProfileId() {
        return targetProfileId;
    }

    /**
     * Sets the value of the field <code>targetProfileId</code>.
     *
     * @param targetProfileId the targetProfileId to set
     */
    public void setTargetProfileId(long targetProfileId) {
        this.targetProfileId = targetProfileId;
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
     * Gets the value of the field <code>targetEntityId</code>.
     *
     * @return the targetEntityId
     */
    public long getTargetEntityId() {
        return targetEntityId;
    }

    /**
     * Sets the value of the field <code>targetEntityId</code>.
     *
     * @param targetEntityId the targetEntityId to set
     */
    public void setTargetEntityId(long targetEntityId) {
        this.targetEntityId = targetEntityId;
    }

    /**
     * Gets the value of the field <code>entity</code>.
     *
     * @return the entity
     */
    public Entity getEntity() {
        return entity;
    }

    /**
     * Sets the value of the field <code>entity</code>.
     *
     * @param entity the entity to set
     */
    public void setEntity(Entity entity) {
        this.entity = entity;
    }

    /**
     * Gets the value of the field <code>primaryInd</code>.
     *
     * @return the primaryInd
     */
    public String getPrimaryInd() {
        return primaryInd;
    }

    /**
     * Sets the value of the field <code>primaryInd</code>.
     *
     * @param primaryInd the primaryInd to set
     */
    public void setPrimaryInd(String primaryInd) {
        this.primaryInd = primaryInd;
    }

    /**
     * Gets the value of the field <code>effectiveDate</code>.
     *
     * @return the effectiveDate
     */
    public Date getEffectiveDate() {
        return effectiveDate;
    }

    /**
     * Sets the value of the field <code>effectiveDate</code>.
     *
     * @param effectiveDate the effectiveDate to set
     */
    public void setEffectiveDate(Date effectiveDate) {
        this.effectiveDate = effectiveDate;
    }

    /**
     * Gets the value of the field <code>objectType</code>.
     *
     * @return the objectType
     */
    public String getObjectType() {
        return objectType;
    }

    /**
     * Sets the value of the field <code>objectType</code>.
     *
     * @param objectType the objectType to set
     */
    public void setObjectType(String objectType) {
        this.objectType = objectType;
    }

    /**
     * Gets the value of the field <code>qpType</code>.
     * @return the qpType
     */
    public QPType getQpType() {
        return qpType;
    }

    /**
     * Sets the value of the field <code>qpType</code>.
     * @param qpType the qpType to set
     */
    public void setQpType(QPType qpType) {
        this.qpType = qpType;
    }

    /**
     * Gets the value of the field <code>acknowledgementAttachmentId</code>.
     * @return the acknowledgementAttachmentId
     */
    public String getAcknowledgementAttachmentId() {
        return acknowledgementAttachmentId;
    }

    /**
     * Sets the value of the field <code>acknowledgementAttachmentId</code>.
     * @param acknowledgementAttachmentId the acknowledgementAttachmentId to set
     */
    public void setAcknowledgementAttachmentId(String acknowledgementAttachmentId) {
        this.acknowledgementAttachmentId = acknowledgementAttachmentId;
    }

    /**
     * Gets the value of the field <code>terminatedInd</code>.
     * @return the terminatedInd
     */
    public String getTerminatedInd() {
        return terminatedInd;
    }

    /**
     * Sets the value of the field <code>terminatedInd</code>.
     * @param terminatedInd the terminatedInd to set
     */
    public void setTerminatedInd(String terminatedInd) {
        this.terminatedInd = terminatedInd;
    }

    /**
     * Gets the value of the field <code>terminationDate</code>.
     * @return the terminationDate
     */
    public Date getTerminationDate() {
        return terminationDate;
    }

    /**
     * Sets the value of the field <code>terminationDate</code>.
     * @param terminationDate the terminationDate to set
     */
    public void setTerminationDate(Date terminationDate) {
        this.terminationDate = terminationDate;
    }

    /**
     * Gets the value of the field <code>affiliateLicenses</code>.
     * @return the affiliateLicenses
     */
    public List<License> getAffiliateLicenses() {
        return affiliateLicenses;
    }

    /**
     * Sets the value of the field <code>affiliateLicenses</code>.
     * @param affiliateLicenses the affiliateLicenses to set
     */
    public void setAffiliateLicenses(List<License> affiliateLicenses) {
        this.affiliateLicenses = affiliateLicenses;
    }

    /**
     * Gets the <code>mhpType</code>.
     * @return the mhpType
     */
    public String getMhpType() {
        return mhpType;
    }

    /**
     * Sets the <code>mhpType</code>.
     * @param mhpType the mhpType to set
     */
    public void setMhpType(String mhpType) {
        this.mhpType = mhpType;
    }

    /**
     * Gets the <code>bgsStudyId</code>.
     * @return the bgsStudyId
     */
	public String getBgsStudyId() {
		return bgsStudyId;
	}

	/**
     * Sets the <code>bgsStudyId</code>.
     * @param mhpType the bgsStudyId to set
     */
	public void setBgsStudyId(String bgsStudyId) {
		this.bgsStudyId = bgsStudyId;
	}

	/**
     * Gets the <code>bgsClearanceDate</code>.
     * @return the bgsClearanceDate
     */
	public Date getBgsClearanceDate() {
		return bgsClearanceDate;
	}

	/**
     * Sets the <code>bgsClearanceDate</code>.
     * @param mhpType the bgsClearanceDate to set
     */
	public void setBgsClearanceDate(Date bgsClearanceDate) {
		this.bgsClearanceDate = bgsClearanceDate;
	}
}
