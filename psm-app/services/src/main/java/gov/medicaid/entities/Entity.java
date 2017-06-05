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
 * Represents a person or organization.
 *
 * @author TCSASSEMBLER
 * @version 1.0
 */
public abstract class Entity extends IdentifiableEntity {

    /**
     * Enrolled flag.
     */
    private String enrolled;

    /**
     * If enrolled, the profile identifier.
     */
    private long profileId;

    /**
     * References the ticket for this request.
     */
    private long ticketId;

    /**
     * The full name.
     */
    private String name;

    /**
     * The full legal name.
     */
    private String legalName;

    private String legacyIndicator;

    private String legacyId;

    private String npi;

    /**
     * NPI - PECOS.
     */
    private String npiVerifiedInd;

    /**
     * NPI - NPILookup.
     */
    private String npiLookupVerifiedInd;

    private String nonExclusionVerifiedInd;

    /**
     * The provider type (if enrolled).
     */
    private ProviderType providerType;

    /**
     * Additional type information.
     */
    private String providerSubType;

    private ContactInformation contactInformation;

    /**
     * For agencies.
     */
    private String backgroundStudyId;

    /**
     * For agencies.
     */
    private Date backgroundClearanceDate;

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

    public String getLegacyIndicator() {
        return legacyIndicator;
    }

    public void setLegacyIndicator(String legacyIndicator) {
        this.legacyIndicator = legacyIndicator;
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

    public long getTicketId() {
        return ticketId;
    }

    public void setTicketId(long ticketId) {
        this.ticketId = ticketId;
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

    public String getNpiVerifiedInd() {
        return npiVerifiedInd;
    }

    public void setNpiVerifiedInd(String npiVerifiedInd) {
        this.npiVerifiedInd = npiVerifiedInd;
    }

    public String getNonExclusionVerifiedInd() {
        return nonExclusionVerifiedInd;
    }

    public void setNonExclusionVerifiedInd(String nonExclusionVerifiedInd) {
        this.nonExclusionVerifiedInd = nonExclusionVerifiedInd;
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

    public String getNpiLookupVerifiedInd() {
        return npiLookupVerifiedInd;
    }

    public void setNpiLookupVerifiedInd(String npiLookupVerifiedInd) {
        this.npiLookupVerifiedInd = npiLookupVerifiedInd;
    }

    public String getLegacyId() {
        return legacyId;
    }

    public void setLegacyId(String legacyId) {
        this.legacyId = legacyId;
    }
}
