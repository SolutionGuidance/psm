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

    /**
     * The legacy indicator.
     */
    private String legacyIndicator;

    /**
     * The legacy ID.
     */
    private String legacyId;

    /**
     * NPI.
     */
    private String npi;

    /**
     * NPI - PECOS.
     */
    private String npiVerifiedInd;

    /**
     * NPI - NPILookup.
     */
    private String npiLookupVerifiedInd;

    /**
     * NPI.
     */
    private String nonExclusionVerifiedInd;


    /**
     * The provider type (if enrolled).
     */
    private ProviderType providerType;

    /**
     * Additional type information.
     */
    private String providerSubType;

    /**
     * Contact information.
     */
    private ContactInformation contactInformation;

    /**
     * For agencies.
     */
    private String backgroundStudyId;

    /**
     * For agencies.
     */
    private Date backgroundClearanceDate;

    /**
     * Gets the value of the field <code>name</code>.
     *
     * @return the name
     */
    public String getName() {
        return name;
    }

    /**
     * Sets the value of the field <code>name</code>.
     *
     * @param name the name to set
     */
    public void setName(String name) {
        this.name = name;
    }

    /**
     * Gets the value of the field <code>legalName</code>.
     *
     * @return the legalName
     */
    public String getLegalName() {
        return legalName;
    }

    /**
     * Sets the value of the field <code>legalName</code>.
     *
     * @param legalName the legalName to set
     */
    public void setLegalName(String legalName) {
        this.legalName = legalName;
    }

    /**
     * Gets the value of the field <code>legacyIndicator</code>.
     *
     * @return the legacyIndicator
     */
    public String getLegacyIndicator() {
        return legacyIndicator;
    }

    /**
     * Sets the value of the field <code>legacyIndicator</code>.
     *
     * @param legacyIndicator the legacyIndicator to set
     */
    public void setLegacyIndicator(String legacyIndicator) {
        this.legacyIndicator = legacyIndicator;
    }

    /**
     * Gets the value of the field <code>npi</code>.
     *
     * @return the npi
     */
    public String getNpi() {
        return npi;
    }

    /**
     * Sets the value of the field <code>npi</code>.
     *
     * @param npi the npi to set
     */
    public void setNpi(String npi) {
        this.npi = npi;
    }

    /**
     * Gets the value of the field <code>contactInformation</code>.
     *
     * @return the contactInformation
     */
    public ContactInformation getContactInformation() {
        return contactInformation;
    }

    /**
     * Sets the value of the field <code>contactInformation</code>.
     *
     * @param contactInformation the contactInformation to set
     */
    public void setContactInformation(ContactInformation contactInformation) {
        this.contactInformation = contactInformation;
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
     * Gets the value of the field <code>enrolled</code>.
     *
     * @return the enrolled
     */
    public String getEnrolled() {
        return enrolled;
    }

    /**
     * Sets the value of the field <code>enrolled</code>.
     *
     * @param enrolled the enrolled to set
     */
    public void setEnrolled(String enrolled) {
        this.enrolled = enrolled;
    }

    /**
     * Gets the value of the field <code>providerType</code>.
     *
     * @return the providerType
     */
    public ProviderType getProviderType() {
        return providerType;
    }

    /**
     * Sets the value of the field <code>providerType</code>.
     *
     * @param providerType the providerType to set
     */
    public void setProviderType(ProviderType providerType) {
        this.providerType = providerType;
    }

    /**
     * Gets the value of the field <code>npiVerifiedInd</code>.
     * @return the npiVerifiedInd
     */
    public String getNpiVerifiedInd() {
        return npiVerifiedInd;
    }

    /**
     * Sets the value of the field <code>npiVerifiedInd</code>.
     * @param npiVerifiedInd the npiVerifiedInd to set
     */
    public void setNpiVerifiedInd(String npiVerifiedInd) {
        this.npiVerifiedInd = npiVerifiedInd;
    }

    /**
     * Gets the value of the field <code>nonExclusionVerifiedInd</code>.
     * @return the nonExclusionVerifiedInd
     */
    public String getNonExclusionVerifiedInd() {
        return nonExclusionVerifiedInd;
    }

    /**
     * Sets the value of the field <code>nonExclusionVerifiedInd</code>.
     * @param nonExclusionVerifiedInd the nonExclusionVerifiedInd to set
     */
    public void setNonExclusionVerifiedInd(String nonExclusionVerifiedInd) {
        this.nonExclusionVerifiedInd = nonExclusionVerifiedInd;
    }

    /**
     * Gets the value of the field <code>backgroundStudyId</code>.
     *
     * @return the backgroundStudyId
     */
    public String getBackgroundStudyId() {
        return backgroundStudyId;
    }

    /**
     * Sets the value of the field <code>backgroundStudyId</code>.
     *
     * @param backgroundStudyId the backgroundStudyId to set
     */
    public void setBackgroundStudyId(String backgroundStudyId) {
        this.backgroundStudyId = backgroundStudyId;
    }

    /**
     * Gets the value of the field <code>backgroundClearanceDate</code>.
     * @return the backgroundClearanceDate
     */
    public Date getBackgroundClearanceDate() {
        return backgroundClearanceDate;
    }

    /**
     * Sets the value of the field <code>backgroundClearanceDate</code>.
     * @param backgroundClearanceDate the backgroundClearanceDate to set
     */
    public void setBackgroundClearanceDate(Date backgroundClearanceDate) {
        this.backgroundClearanceDate = backgroundClearanceDate;
    }

    /**
     * Gets the value of the field <code>providerSubType</code>.
     * @return the providerSubType
     */
    public String getProviderSubType() {
        return providerSubType;
    }

    /**
     * Sets the value of the field <code>providerSubType</code>.
     * @param providerSubType the providerSubType to set
     */
    public void setProviderSubType(String providerSubType) {
        this.providerSubType = providerSubType;
    }

    /**
     * Gets the <code>npiLookupVerifiedInd</code>.
     * @return the npiLookupVerifiedInd
     */
    public String getNpiLookupVerifiedInd() {
        return npiLookupVerifiedInd;
    }

    /**
     * Sets the <code>npiLookupVerifiedInd</code>.
     * @param npiLookupVerifiedInd the npiLookupVerifiedInd to set
     */
    public void setNpiLookupVerifiedInd(String npiLookupVerifiedInd) {
        this.npiLookupVerifiedInd = npiLookupVerifiedInd;
    }

    /**
     * Gets the value of the field <code>legacyId</code>.
     * @return the legacyId
     */
    public String getLegacyId() {
        return legacyId;
    }

    /**
     * Sets the value of the field <code>legacyId</code>.
     * @param legacyId the legacyId to set
     */
    public void setLegacyId(String legacyId) {
        this.legacyId = legacyId;
    }
}
