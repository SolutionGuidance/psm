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

import javax.persistence.*;
import java.io.Serializable;
import java.util.List;

@javax.persistence.Entity
@Table(name = "ownership_info")
public class OwnershipInformation implements Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "ownership_info_id")
    private long id;

    /**
     * If enrolled, the profile identifier.
     */
    @Column(name = "profile_id")
    private long profileId;

    /**
     * References the ticket for this request.
     */
    @Column(name= "ticket_id")
    private long ticketId;

    /**
     * Type of entity for disclosure.
     */
    @ManyToOne
    @JoinColumn(name = "entity_structure_type_code")
    private EntityStructureType entityType;

    /**
     * Type of entity for disclosure.
     */
    @ManyToOne
    @JoinColumn(name = "entity_structure_subtype_code")
    private EntityStructureType entitySubType;

    /**
     * If type is OTHER, specify here.
     */
    @Column(name = "other_entity_type_desc")
    private String otherEntityTypeDesc;

    /**
     * Beneficial owners.
     */
    @OneToMany(fetch = FetchType.EAGER)
    @JoinColumn(name = "ownership_info_id", referencedColumnName = "ownership_info_id")
    private List<BeneficialOwner> beneficialOwners;


    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
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

}
