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

import java.util.List;

/**
 * Ownership information.
 * @author TCSASSEMBLER
 * @version 1.0
 */
public class OwnershipInformation extends IdentifiableEntity {

    /**
     * If enrolled, the profile identifier.
     */
    private long profileId;

    /**
     * References the ticket for this request.
     */
    private long ticketId;

    /**
     * Type of entity for disclosure.
     */
    private EntityStructureType entityType;

    /**
     * Type of entity for disclosure.
     */
    private EntityStructureType entitySubType;

    /**
     * If type is OTHER, specify here.
     */
    private String otherEntityTypeDesc;

    /**
     * Beneficial owners.
     */
    private List<BeneficialOwner> beneficialOwners;

    /**
     * Disclosed property ownership.
     */
    private List<Asset> assets;

    /**
     * Ownership information records.
     */
    public OwnershipInformation() {

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
     * Gets the value of the field <code>entityType</code>.
     *
     * @return the entityType
     */
    public EntityStructureType getEntityType() {
        return entityType;
    }

    /**
     * Sets the value of the field <code>entityType</code>.
     *
     * @param entityType the entityType to set
     */
    public void setEntityType(EntityStructureType entityType) {
        this.entityType = entityType;
    }

    /**
     * Gets the value of the field <code>entitySubType</code>.
     *
     * @return the entitySubType
     */
    public EntityStructureType getEntitySubType() {
        return entitySubType;
    }

    /**
     * Sets the value of the field <code>entitySubType</code>.
     *
     * @param entitySubType the entitySubType to set
     */
    public void setEntitySubType(EntityStructureType entitySubType) {
        this.entitySubType = entitySubType;
    }

    /**
     * Gets the value of the field <code>otherEntityTypeDesc</code>.
     *
     * @return the otherEntityTypeDesc
     */
    public String getOtherEntityTypeDesc() {
        return otherEntityTypeDesc;
    }

    /**
     * Sets the value of the field <code>otherEntityTypeDesc</code>.
     *
     * @param otherEntityTypeDesc the otherEntityTypeDesc to set
     */
    public void setOtherEntityTypeDesc(String otherEntityTypeDesc) {
        this.otherEntityTypeDesc = otherEntityTypeDesc;
    }

    /**
     * Gets the value of the field <code>beneficialOwners</code>.
     *
     * @return the beneficialOwners
     */
    public List<BeneficialOwner> getBeneficialOwners() {
        return beneficialOwners;
    }

    /**
     * Sets the value of the field <code>beneficialOwners</code>.
     *
     * @param beneficialOwners the beneficialOwners to set
     */
    public void setBeneficialOwners(List<BeneficialOwner> beneficialOwners) {
        this.beneficialOwners = beneficialOwners;
    }

    /**
     * Gets the value of the field <code>assets</code>.
     *
     * @return the assets
     */
    public List<Asset> getAssets() {
        return assets;
    }

    /**
     * Sets the value of the field <code>assets</code>.
     *
     * @param assets the assets to set
     */
    public void setAssets(List<Asset> assets) {
        this.assets = assets;
    }
}
