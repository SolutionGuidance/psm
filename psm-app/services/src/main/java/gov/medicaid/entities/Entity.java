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
import javax.persistence.Inheritance;
import javax.persistence.InheritanceType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import java.io.Serializable;
import java.util.Date;


/**
 * Represents a person or organization.
 */
@javax.persistence.Entity
@Inheritance(strategy = InheritanceType.JOINED)
@Table(name = "entities")
public abstract class Entity implements Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "entity_id")
    private long id;

    /**
     * Enrolled flag.
     */
    private String enrolled;

    /**
     * If enrolled, the profile identifier.
     */
    @Column(name = "profile_id", nullable = false)
    private long profileId;

    /**
     * The full name.
     */
    private String name;

    /**
     * The full legal name.
     */
    @Column(name = "legal_name")
    private String legalName;

    private String npi;

    /**
     * The provider type (if enrolled).
     */
    @ManyToOne
    @JoinColumn(name = "provider_type_code")
    private ProviderType providerType;

    /**
     * Additional type information.
     */
    @Column(name = "provider_sub_type")
    private String providerSubType;

    @ManyToOne
    @JoinColumn(name = "contact_id")
    private ContactInformation contactInformation;

    /**
     * For agencies.
     */
    @Column(name = "background_study_id")
    private String backgroundStudyId;

    /**
     * For agencies.
     */
    @Column(name = "background_clearance_date")
    private Date backgroundClearanceDate;

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getLegalName() {
        return legalName;
    }

    public void setLegalName(String legalName) {
        this.legalName = legalName;
    }

    public String getNpi() {
        return npi;
    }

    public void setNpi(String npi) {
        this.npi = npi;
    }

    public ContactInformation getContactInformation() {
        return contactInformation;
    }

    public void setContactInformation(ContactInformation contactInformation) {
        this.contactInformation = contactInformation;
    }

    public long getProfileId() {
        return profileId;
    }

    public void setProfileId(long profileId) {
        this.profileId = profileId;
    }

    public String getEnrolled() {
        return enrolled;
    }

    public void setEnrolled(String enrolled) {
        this.enrolled = enrolled;
    }

    public ProviderType getProviderType() {
        return providerType;
    }

    public void setProviderType(ProviderType providerType) {
        this.providerType = providerType;
    }

    public String getBackgroundStudyId() {
        return backgroundStudyId;
    }

    public void setBackgroundStudyId(String backgroundStudyId) {
        this.backgroundStudyId = backgroundStudyId;
    }

    public Date getBackgroundClearanceDate() {
        return backgroundClearanceDate;
    }

    public void setBackgroundClearanceDate(Date backgroundClearanceDate) {
        this.backgroundClearanceDate = backgroundClearanceDate;
    }

    public String getProviderSubType() {
        return providerSubType;
    }

    public void setProviderSubType(String providerSubType) {
        this.providerSubType = providerSubType;
    }

}
