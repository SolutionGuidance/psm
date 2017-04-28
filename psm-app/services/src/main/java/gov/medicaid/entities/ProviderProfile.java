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

import gov.medicaid.binders.BinderUtils;
import gov.medicaid.domain.model.CategoriesOfServiceType;

import java.util.Date;
import java.util.List;

/**
 * Represents the provider profile.
 * 
 * @author TCSASSEMBLER
 * @version 1.0
 */
public class ProviderProfile extends IdentifiableEntity implements Cloneable {

    /**
     * The profile identifier.
     */
    private long profileId;

    /**
     * References the ticket for this request, if 0, this means it is already approved.
     */
    private long ticketId;

    /**
     * The profile effective date.
     */
    private Date effectiveDate;

    /**
     * The profile status (active/suspended/expired).
     */
    private ProfileStatus profileStatus;

    /**
     * Indicates if the provider is employed by a PHS Indian Hospital.
     */
    private String worksOnReservationInd;

    /**
     * Indicates if applicant has own private practice.
     */
    private String maintainsOwnPrivatePractice;

    /**
     * Indicates if applicant has additional practice locations.
     */
    private String employedOrContractedByGroup;

    /**
     * Answer to the applicant/owner criminal conviction disclosure question.
     */
    private String criminalConvictionInd;

    /**
     * Answer to the applicant/owner civil penalty disclosure question.
     */
    private String civilPenaltyInd;

    /**
     * Answer to the applicant/owner previous exclusion disclosure question.
     */
    private String previousExclusionInd;

    /**
     * Answer to the applicant/owner criminal conviction disclosure question.
     */
    private String employeeCriminalConvictionInd;

    /**
     * Answer to the applicant/owner civil penalty disclosure question.
     */
    private String employeeCivilPenaltyInd;

    /**
     * Answer to the applicant/owner previous exclusion disclosure question.
     */
    private String employeePreviousExclusionInd;

    /**
     * Answer to the question 18 years old and above (PCA).
     */
    private String adultInd;

    /**
     * County.
     */
    private String county;

    /**
     * If person has been employed in primary agency continuously since BGS completion (PCA).
     */
    private String employedSinceClearance;

    /**
     * The risk level.
     */
    private RiskLevel riskLevel;

    /**
     * Licenses and certifications.
     */
    private List<License> certifications;

    /**
     * Licenses and certifications.
     */
    private List<Document> attachments;

    /**
     * Profile notes.
     */
    private List<Note> notes;

    /**
     * Provider entity.
     */
    private Entity entity;

    /**
     * Provider statement.
     */
    private ProviderStatement statement;

    /**
     * Designated contacts.
     */
    private List<DesignatedContact> designatedContacts;

    /**
     * Group/Member affiliations.
     */
    private List<Affiliation> affiliations;

    /**
     * Documents the applicant agreed to.
     */
    private List<AcceptedAgreements> agreements;

    /**
     * Provider setup.
     */
    private List<PayToProvider> payToProviders;

    /**
     * Provider services.
     */
    private List<ProviderService> services;

    /**
     * Ownership information record.
     */
    private OwnershipInformation ownershipInformation;

    /**
     * Number of beds for facility.
     */
    private Integer numberOfBeds;

    private Integer title18NumberOfBeds;

    private Integer title19NumberOfBeds;

    private Integer dualCertifiedNumberOfBeds;

    private Integer icfNumberOfBeds;

    private String physicalAndOccupationalTherapyInd;

    /**
     * Number of beds effectivity date.
     */
    private Date numberOfBedsEffectiveDate;

    /**
     * Only for approved profiles, the ticket that was used for this approved request.
     */
    private long referenceTicketId;

    /**
     * The profile owner.
     */
    private String ownerId;

    /**
     * Person who filled up the form.
     */
    private String accomplishedBy;

    /**
     * If the clinic is a health board.
     */
    private String healthBoardInd;

    /**
     * Creator.
     */
    private String createdBy;

    /**
     * Timestamp.
     */
    private Date createdOn;

    /**
     * Updater.
     */
    private String modifiedBy;

    /**
     * Timestamp.
     */
    private Date modifiedOn;

    /**
     * Represents the assured statements required for Chemical Dependency Program.
     */
    private List<AssuredService> assuredStatements;

    /**
     * The categories of service.
     */
    private List<ProviderCategoryOfService> categoriesOfServiceTypes;
    
    /**
     * Empty constructor.
     */
    public ProviderProfile() {
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
     * @param profileId
     *            the profileId to set
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
     * @param ticketId
     *            the ticketId to set
     */
    public void setTicketId(long ticketId) {
        this.ticketId = ticketId;
    }

    /**
     * Gets the value of the field <code>referenceTicketId</code>.
     * 
     * @return the referenceTicketId
     */
    public long getReferenceTicketId() {
        return referenceTicketId;
    }

    /**
     * Sets the value of the field <code>referenceTicketId</code>.
     * 
     * @param referenceTicketId
     *            the referenceTicketId to set
     */
    public void setReferenceTicketId(long referenceTicketId) {
        this.referenceTicketId = referenceTicketId;
    }

    /**
     * Gets the value of the field <code>affiliations</code>.
     * 
     * @return the affiliations
     */
    public List<Affiliation> getAffiliations() {
        return affiliations;
    }

    /**
     * Sets the value of the field <code>affiliations</code>.
     * 
     * @param affiliations
     *            the affiliations to set
     */
    public void setAffiliations(List<Affiliation> affiliations) {
        this.affiliations = affiliations;
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
     * @param entity
     *            the entity to set
     */
    public void setEntity(Entity entity) {
        this.entity = entity;
    }

    /**
     * Gets the value of the field <code>designatedContacts</code>.
     * 
     * @return the designatedContacts
     */
    public List<DesignatedContact> getDesignatedContacts() {
        return designatedContacts;
    }

    /**
     * Sets the value of the field <code>designatedContacts</code>.
     * 
     * @param designatedContacts
     *            the designatedContacts to set
     */
    public void setDesignatedContacts(List<DesignatedContact> designatedContacts) {
        this.designatedContacts = designatedContacts;
    }

    /**
     * Gets the value of the field <code>worksOnReservationInd</code>.
     * 
     * @return the worksOnReservationInd
     */
    public String getWorksOnReservationInd() {
        return worksOnReservationInd;
    }

    /**
     * Sets the value of the field <code>worksOnReservationInd</code>.
     * 
     * @param worksOnReservationInd
     *            the worksOnReservationInd to set
     */
    public void setWorksOnReservationInd(String worksOnReservationInd) {
        this.worksOnReservationInd = worksOnReservationInd;
    }

    /**
     * Gets the value of the field <code>certifications</code>.
     * 
     * @return the certifications
     */
    public List<License> getCertifications() {
        return certifications;
    }

    /**
     * Sets the value of the field <code>certifications</code>.
     * 
     * @param certifications
     *            the certifications to set
     */
    public void setCertifications(List<License> certifications) {
        this.certifications = certifications;
    }

    /**
     * Gets the value of the field <code>attachments</code>.
     * 
     * @return the attachments
     */
    public List<Document> getAttachments() {
        return attachments;
    }

    /**
     * Sets the value of the field <code>attachments</code>.
     * 
     * @param attachments
     *            the attachments to set
     */
    public void setAttachments(List<Document> attachments) {
        this.attachments = attachments;
    }

    /**
     * Gets the value of the field <code>createdBy</code>.
     * 
     * @return the createdBy
     */
    public String getCreatedBy() {
        return createdBy;
    }

    /**
     * Sets the value of the field <code>createdBy</code>.
     * 
     * @param createdBy
     *            the createdBy to set
     */
    public void setCreatedBy(String createdBy) {
        this.createdBy = createdBy;
    }

    /**
     * Gets the value of the field <code>createdOn</code>.
     * 
     * @return the createdOn
     */
    public Date getCreatedOn() {
        return createdOn;
    }

    /**
     * Sets the value of the field <code>createdOn</code>.
     * 
     * @param createdOn
     *            the createdOn to set
     */
    public void setCreatedOn(Date createdOn) {
        this.createdOn = createdOn;
    }

    /**
     * Gets the value of the field <code>modifiedBy</code>.
     * 
     * @return the modifiedBy
     */
    public String getModifiedBy() {
        return modifiedBy;
    }

    /**
     * Sets the value of the field <code>modifiedBy</code>.
     * 
     * @param modifiedBy
     *            the modifiedBy to set
     */
    public void setModifiedBy(String modifiedBy) {
        this.modifiedBy = modifiedBy;
    }

    /**
     * Gets the value of the field <code>modifiedOn</code>.
     * 
     * @return the modifiedOn
     */
    public Date getModifiedOn() {
        return modifiedOn;
    }

    /**
     * Sets the value of the field <code>modifiedOn</code>.
     * 
     * @param modifiedOn
     *            the modifiedOn to set
     */
    public void setModifiedOn(Date modifiedOn) {
        this.modifiedOn = modifiedOn;
    }

    /**
     * Gets the value of the field <code>maintainsOwnPrivatePractice</code>.
     * 
     * @return the maintainsOwnPrivatePractice
     */
    public String getMaintainsOwnPrivatePractice() {
        return maintainsOwnPrivatePractice;
    }

    /**
     * Sets the value of the field <code>maintainsOwnPrivatePractice</code>.
     * 
     * @param maintainsOwnPrivatePractice
     *            the maintainsOwnPrivatePractice to set
     */
    public void setMaintainsOwnPrivatePractice(String maintainsOwnPrivatePractice) {
        this.maintainsOwnPrivatePractice = maintainsOwnPrivatePractice;
    }

    /**
     * Gets the value of the field <code>employedOrContractedByGroup</code>.
     * 
     * @return the employedOrContractedByGroup
     */
    public String getEmployedOrContractedByGroup() {
        return employedOrContractedByGroup;
    }

    /**
     * Sets the value of the field <code>employedOrContractedByGroup</code>.
     * 
     * @param employedOrContractedByGroup
     *            the employedOrContractedByGroup to set
     */
    public void setEmployedOrContractedByGroup(String employedOrContractedByGroup) {
        this.employedOrContractedByGroup = employedOrContractedByGroup;
    }

    /**
     * Gets the value of the field <code>criminalConvictionInd</code>.
     * 
     * @return the criminalConvictionInd
     */
    public String getCriminalConvictionInd() {
        return criminalConvictionInd;
    }

    /**
     * Sets the value of the field <code>criminalConvictionInd</code>.
     * 
     * @param criminalConvictionInd
     *            the criminalConvictionInd to set
     */
    public void setCriminalConvictionInd(String criminalConvictionInd) {
        this.criminalConvictionInd = criminalConvictionInd;
    }

    /**
     * Gets the value of the field <code>civilPenaltyInd</code>.
     * 
     * @return the civilPenaltyInd
     */
    public String getCivilPenaltyInd() {
        return civilPenaltyInd;
    }

    /**
     * Sets the value of the field <code>civilPenaltyInd</code>.
     * 
     * @param civilPenaltyInd
     *            the civilPenaltyInd to set
     */
    public void setCivilPenaltyInd(String civilPenaltyInd) {
        this.civilPenaltyInd = civilPenaltyInd;
    }

    /**
     * Gets the value of the field <code>previousExclusionInd</code>.
     * 
     * @return the previousExclusionInd
     */
    public String getPreviousExclusionInd() {
        return previousExclusionInd;
    }

    /**
     * Sets the value of the field <code>previousExclusionInd</code>.
     * 
     * @param previousExclusionInd
     *            the previousExclusionInd to set
     */
    public void setPreviousExclusionInd(String previousExclusionInd) {
        this.previousExclusionInd = previousExclusionInd;
    }

    /**
     * Gets the value of the field <code>agreements</code>.
     * 
     * @return the agreements
     */
    public List<AcceptedAgreements> getAgreements() {
        return agreements;
    }

    /**
     * Sets the value of the field <code>agreements</code>.
     * 
     * @param agreements
     *            the agreements to set
     */
    public void setAgreements(List<AcceptedAgreements> agreements) {
        this.agreements = agreements;
    }

    /**
     * Gets the value of the field <code>statement</code>.
     * 
     * @return the statement
     */
    public ProviderStatement getStatement() {
        return statement;
    }

    /**
     * Sets the value of the field <code>statement</code>.
     * 
     * @param statement
     *            the statement to set
     */
    public void setStatement(ProviderStatement statement) {
        this.statement = statement;
    }

    /**
     * Gets the value of the field <code>payToProviders</code>.
     * 
     * @return the payToProviders
     */
    public List<PayToProvider> getPayToProviders() {
        return payToProviders;
    }

    /**
     * Sets the value of the field <code>payToProviders</code>.
     * 
     * @param payToProviders
     *            the payToProviders to set
     */
    public void setPayToProviders(List<PayToProvider> payToProviders) {
        this.payToProviders = payToProviders;
    }

    /**
     * Gets the value of the field <code>riskLevel</code>.
     * 
     * @return the riskLevel
     */
    public RiskLevel getRiskLevel() {
        return riskLevel;
    }

    /**
     * Sets the value of the field <code>riskLevel</code>.
     * 
     * @param riskLevel
     *            the riskLevel to set
     */
    public void setRiskLevel(RiskLevel riskLevel) {
        this.riskLevel = riskLevel;
    }

    /**
     * Gets the value of the field <code>notes</code>.
     * 
     * @return the notes
     */
    public List<Note> getNotes() {
        return notes;
    }

    /**
     * Sets the value of the field <code>notes</code>.
     * 
     * @param notes
     *            the notes to set
     */
    public void setNotes(List<Note> notes) {
        this.notes = notes;
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
     * @param effectiveDate
     *            the effectiveDate to set
     */
    public void setEffectiveDate(Date effectiveDate) {
        this.effectiveDate = effectiveDate;
    }

    /**
     * Gets the value of the field <code>profileStatus</code>.
     * 
     * @return the profileStatus
     */
    public ProfileStatus getProfileStatus() {
        return profileStatus;
    }

    /**
     * Sets the value of the field <code>profileStatus</code>.
     * 
     * @param profileStatus
     *            the profileStatus to set
     */
    public void setProfileStatus(ProfileStatus profileStatus) {
        this.profileStatus = profileStatus;
    }

    /**
     * Full clone of this object.
     * 
     * @return a deep clone
     */
    public ProviderProfile clone() {
        ProviderProfile obj = this;
        return BinderUtils.clone(obj);
    }

    /**
     * Gets the value of the field <code>adultInd</code>.
     * 
     * @return the adultInd
     */
    public String getAdultInd() {
        return adultInd;
    }

    /**
     * Sets the value of the field <code>adultInd</code>.
     * 
     * @param adultInd
     *            the adultInd to set
     */
    public void setAdultInd(String adultInd) {
        this.adultInd = adultInd;
    }

    /**
     * Gets the value of the field <code>employedSinceClearance</code>.
     * 
     * @return the employedSinceClearance
     */
    public String getEmployedSinceClearance() {
        return employedSinceClearance;
    }

    /**
     * Sets the value of the field <code>employedSinceClearance</code>.
     * 
     * @param employedSinceClearance
     *            the employedSinceClearance to set
     */
    public void setEmployedSinceClearance(String employedSinceClearance) {
        this.employedSinceClearance = employedSinceClearance;
    }

    /**
     * Gets the value of the field <code>county</code>.
     * 
     * @return the county
     */
    public String getCounty() {
        return county;
    }

    /**
     * Sets the value of the field <code>county</code>.
     * 
     * @param county
     *            the county to set
     */
    public void setCounty(String county) {
        this.county = county;
    }

    /**
     * Gets the value of the field <code>ownershipInformation</code>.
     * 
     * @return the ownershipInformation
     */
    public OwnershipInformation getOwnershipInformation() {
        return ownershipInformation;
    }

    /**
     * Sets the value of the field <code>ownershipInformation</code>.
     * 
     * @param ownershipInformation
     *            the ownershipInformation to set
     */
    public void setOwnershipInformation(OwnershipInformation ownershipInformation) {
        this.ownershipInformation = ownershipInformation;
    }

    /**
     * Gets the value of the field <code>ownerId</code>.
     * 
     * @return the ownerId
     */
    public String getOwnerId() {
        return ownerId;
    }

    /**
     * Sets the value of the field <code>ownerId</code>.
     * 
     * @param ownerId
     *            the ownerId to set
     */
    public void setOwnerId(String ownerId) {
        this.ownerId = ownerId;
    }

    /**
     * Gets the value of the field <code>employeeCriminalConvictionInd</code>.
     * 
     * @return the employeeCriminalConvictionInd
     */
    public String getEmployeeCriminalConvictionInd() {
        return employeeCriminalConvictionInd;
    }

    /**
     * Sets the value of the field <code>employeeCriminalConvictionInd</code>.
     * 
     * @param employeeCriminalConvictionInd
     *            the employeeCriminalConvictionInd to set
     */
    public void setEmployeeCriminalConvictionInd(String employeeCriminalConvictionInd) {
        this.employeeCriminalConvictionInd = employeeCriminalConvictionInd;
    }

    /**
     * Gets the value of the field <code>employeeCivilPenaltyInd</code>.
     * 
     * @return the employeeCivilPenaltyInd
     */
    public String getEmployeeCivilPenaltyInd() {
        return employeeCivilPenaltyInd;
    }

    /**
     * Sets the value of the field <code>employeeCivilPenaltyInd</code>.
     * 
     * @param employeeCivilPenaltyInd
     *            the employeeCivilPenaltyInd to set
     */
    public void setEmployeeCivilPenaltyInd(String employeeCivilPenaltyInd) {
        this.employeeCivilPenaltyInd = employeeCivilPenaltyInd;
    }

    /**
     * Gets the value of the field <code>employeePreviousExclusionInd</code>.
     * 
     * @return the employeePreviousExclusionInd
     */
    public String getEmployeePreviousExclusionInd() {
        return employeePreviousExclusionInd;
    }

    /**
     * Sets the value of the field <code>employeePreviousExclusionInd</code>.
     * 
     * @param employeePreviousExclusionInd
     *            the employeePreviousExclusionInd to set
     */
    public void setEmployeePreviousExclusionInd(String employeePreviousExclusionInd) {
        this.employeePreviousExclusionInd = employeePreviousExclusionInd;
    }

    /**
     * Gets the value of the field <code>numberOfBeds</code>.
     * 
     * @return the numberOfBeds
     */
    public Integer getNumberOfBeds() {
        return numberOfBeds;
    }

    /**
     * Sets the value of the field <code>numberOfBeds</code>.
     * 
     * @param numberOfBeds
     *            the numberOfBeds to set
     */
    public void setNumberOfBeds(Integer numberOfBeds) {
        this.numberOfBeds = numberOfBeds;
    }

    /**
     * Gets the value of the field <code>numberOfBedsEffectiveDate</code>.
     * 
     * @return the numberOfBedsEffectiveDate
     */
    public Date getNumberOfBedsEffectiveDate() {
        return numberOfBedsEffectiveDate;
    }

    /**
     * Sets the value of the field <code>numberOfBedsEffectiveDate</code>.
     * 
     * @param numberOfBedsEffectiveDate
     *            the numberOfBedsEffectiveDate to set
     */
    public void setNumberOfBedsEffectiveDate(Date numberOfBedsEffectiveDate) {
        this.numberOfBedsEffectiveDate = numberOfBedsEffectiveDate;
    }

    /**
     * Gets the value of the field <code>accomplishedBy</code>.
     * 
     * @return the accomplishedBy
     */
    public String getAccomplishedBy() {
        return accomplishedBy;
    }

    /**
     * Sets the value of the field <code>accomplishedBy</code>.
     * 
     * @param accomplishedBy
     *            the accomplishedBy to set
     */
    public void setAccomplishedBy(String accomplishedBy) {
        this.accomplishedBy = accomplishedBy;
    }

    /**
     * Gets the value of the field <code>healthBoardInd</code>.
     * 
     * @return the healthBoardInd
     */
    public String getHealthBoardInd() {
        return healthBoardInd;
    }

    /**
     * Sets the value of the field <code>healthBoardInd</code>.
     * 
     * @param healthBoardInd
     *            the healthBoardInd to set
     */
    public void setHealthBoardInd(String healthBoardInd) {
        this.healthBoardInd = healthBoardInd;
    }

    /**
     * Gets the value of the field <code>services</code>.
     * 
     * @return the services
     */
    public List<ProviderService> getServices() {
        return services;
    }

    /**
     * Sets the value of the field <code>services</code>.
     * 
     * @param services
     *            the services to set
     */
    public void setServices(List<ProviderService> services) {
        this.services = services;
    }

    /**
     * Gets the value of the field <code>title18NumberOfBeds</code>.
     * 
     * @return the title18NumberOfBeds
     */
    public Integer getTitle18NumberOfBeds() {
        return title18NumberOfBeds;
    }

    /**
     * Sets the value of the field <code>title18NumberOfBeds</code>.
     * 
     * @param title18NumberOfBeds
     *            the title18NumberOfBeds to set
     */
    public void setTitle18NumberOfBeds(Integer title18NumberOfBeds) {
        this.title18NumberOfBeds = title18NumberOfBeds;
    }

    /**
     * Gets the value of the field <code>title19NumberOfBeds</code>.
     * 
     * @return the title19NumberOfBeds
     */
    public Integer getTitle19NumberOfBeds() {
        return title19NumberOfBeds;
    }

    /**
     * Sets the value of the field <code>title19NumberOfBeds</code>.
     * 
     * @param title19NumberOfBeds
     *            the title19NumberOfBeds to set
     */
    public void setTitle19NumberOfBeds(Integer title19NumberOfBeds) {
        this.title19NumberOfBeds = title19NumberOfBeds;
    }

    /**
     * Gets the value of the field <code>dualCertifiedNumberOfBeds</code>.
     * 
     * @return the dualCertifiedNumberOfBeds
     */
    public Integer getDualCertifiedNumberOfBeds() {
        return dualCertifiedNumberOfBeds;
    }

    /**
     * Sets the value of the field <code>dualCertifiedNumberOfBeds</code>.
     * 
     * @param dualCertifiedNumberOfBeds
     *            the dualCertifiedNumberOfBeds to set
     */
    public void setDualCertifiedNumberOfBeds(Integer dualCertifiedNumberOfBeds) {
        this.dualCertifiedNumberOfBeds = dualCertifiedNumberOfBeds;
    }

    /**
     * Gets the value of the field <code>icfNumberOfBeds</code>.
     * 
     * @return the icfNumberOfBeds
     */
    public Integer getIcfNumberOfBeds() {
        return icfNumberOfBeds;
    }

    /**
     * Sets the value of the field <code>icfNumberOfBeds</code>.
     * 
     * @param icfNumberOfBeds
     *            the icfNumberOfBeds to set
     */
    public void setIcfNumberOfBeds(Integer icfNumberOfBeds) {
        this.icfNumberOfBeds = icfNumberOfBeds;
    }

    /**
     * Gets the value of the field <code>physicalAndOccupationalTherapyInd</code>.
     * 
     * @return the physicalAndOccupationalTherapyInd
     */
    public String getPhysicalAndOccupationalTherapyInd() {
        return physicalAndOccupationalTherapyInd;
    }

    /**
     * Sets the value of the field <code>physicalAndOccupationalTherapyInd</code>.
     * 
     * @param physicalAndOccupationalTherapyInd
     *            the physicalAndOccupationalTherapyInd to set
     */
    public void setPhysicalAndOccupationalTherapyInd(String physicalAndOccupationalTherapyInd) {
        this.physicalAndOccupationalTherapyInd = physicalAndOccupationalTherapyInd;
    }

    /**
     * Gets the <code>assuredStatements</code>.
     * 
     * @return the assuredStatements
     */
    public List<AssuredService> getAssuredStatements() {
        return assuredStatements;
    }

    /**
     * Sets the <code>assuredStatements</code>.
     * 
     * @param assuredStatements
     *            the assuredStatements to set
     */
    public void setAssuredStatements(List<AssuredService> assuredStatements) {
        this.assuredStatements = assuredStatements;
    }

    /**
     * Gets the value of the field <code>categoriesOfServiceTypes</code>.
     * @return the categoriesOfServiceTypes
     */
    public List<ProviderCategoryOfService> getCategoriesOfServiceTypes() {
        return categoriesOfServiceTypes;
    }

    /**
     * Sets the value of the field <code>categoriesOfServiceTypes</code>.
     * @param categoriesOfServiceTypes the categoriesOfServiceTypes to set
     */
    public void setCategoriesOfServiceTypes(List<ProviderCategoryOfService> categoriesOfServiceTypes) {
        this.categoriesOfServiceTypes = categoriesOfServiceTypes;
    }
}
