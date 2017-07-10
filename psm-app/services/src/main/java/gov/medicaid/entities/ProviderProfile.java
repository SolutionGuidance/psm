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

@javax.persistence.Entity
@Table(name = "provider_profiles")
public class ProviderProfile implements Cloneable, Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "control_no")
    private long id;

    @Column(
            name = "profile_id",
            nullable = false
    )
    private long profileId = 0;

    /**
     * References the ticket for this request, if 0, this means it is already approved.
     */
    @Column(
            name = "ticket_id",
            nullable = false
    )
    private long ticketId = 0;

    @Column(name = "effective_date")
    private Date effectiveDate;

    /**
     * The profile status (active/suspended/expired).
     */
    @ManyToOne
    @JoinColumn(name = "profile_status_code")
    private ProfileStatus profileStatus;

    /**
     * Indicates if the provider is employed by a PHS Indian Hospital.
     */
    @Column(name = "works_on_reservation")
    private String worksOnReservationInd;

    /**
     * Indicates if applicant has own private practice.
     */
    @Column(name = "maintains_own_private_practice")
    private String maintainsOwnPrivatePractice;

    /**
     * Indicates if applicant has additional practice locations.
     */
    @Column(name = "employed_or_contracted_by_group")
    private String employedOrContractedByGroup;

    /**
     * Answer to the applicant/owner criminal conviction disclosure question.
     */
    @Column(name = "criminal_conviction")
    private String criminalConvictionInd;

    /**
     * Answer to the applicant/owner civil penalty disclosure question.
     */
    @Column(name = "civil_penalty")
    private String civilPenaltyInd;

    /**
     * Answer to the applicant/owner previous exclusion disclosure question.
     */
    @Column(name = "previous_exclusion")
    private String previousExclusionInd;

    /**
     * Answer to the applicant/owner criminal conviction disclosure question.
     */
    @Column(name = "employee_criminal_conviction")
    private String employeeCriminalConvictionInd;

    /**
     * Answer to the applicant/owner civil penalty disclosure question.
     */
    @Column(name = "employee_civil_penalty")
    private String employeeCivilPenaltyInd;

    /**
     * Answer to the applicant/owner previous exclusion disclosure question.
     */
    @Column(name = "employee_previous_exclusion")
    private String employeePreviousExclusionInd;

    /**
     * Answer to the question 18 years old and above (PCA).
     */
    @Column(name = "adult")
    private String adultInd;

    @Column
    private String county;

    /**
     * If person has been employed in primary agency continuously since BGS completion (PCA).
     */
    @Column(name = "employed_since_clearance")
    private String employedSinceClearance;

    @ManyToOne
    @JoinColumn(name = "risk_level_code")
    private RiskLevel riskLevel;

    @Transient
    private List<License> certifications;

    /**
     * Licenses and certifications.
     */
    @Transient
    private List<Document> attachments;

    @Transient
    private List<Note> notes;

    @Transient
    private Entity entity;

    @Transient
    private ProviderStatement statement;

    @Transient
    private List<DesignatedContact> designatedContacts;

    /**
     * Group/Member affiliations.
     */
    @Transient
    private List<Affiliation> affiliations;

    /**
     * Documents the applicant agreed to.
     */
    @Transient
    private List<AcceptedAgreements> agreements;

    /**
     * Provider setup.
     */
    @Transient
    private List<PayToProvider> payToProviders;

    @Transient
    private List<ProviderService> services;

    @Transient
    private OwnershipInformation ownershipInformation;

    /**
     * Number of beds for facility.
     */
    @Column(name = "bed_count")
    private Integer numberOfBeds;

    @Column(name = "bed_count_title_18")
    private Integer title18NumberOfBeds;

    @Column(name = "bed_count_title_19")
    private Integer title19NumberOfBeds;

    @Column(name = "bed_count_dual_certified")
    private Integer dualCertifiedNumberOfBeds;

    @Column(name = "bed_count_icf")
    private Integer icfNumberOfBeds;

    @Column(name = "physical_and_occupational_therapy")
    private String physicalAndOccupationalTherapyInd;

    @Column(name = "bed_count_effective_date")
    private Date numberOfBedsEffectiveDate;

    /**
     * Only for approved profiles, the ticket that was used for this approved request.
     */
    @Column(
            name = "reference_ticket_id",
            nullable = false
    )
    private long referenceTicketId = 0;

    @Column(name = "owner_id")
    private String ownerId;

    /**
     * Person who filled up the form.
     */
    @Column(name = "form_completed_by")
    private String accomplishedBy;

    /**
     * If the clinic is a health board.
     */
    @Column(name = "health_board")
    private String healthBoardInd;

    @Column(name = "created_by")
    private String createdBy;

    @Column(name = "created_at")
    private Date createdOn;

    @Column(name = "last_modified_by")
    private String modifiedBy;

    @Column(name = "last_modified_at")
    private Date modifiedOn;

    @Transient
    private List<ProviderCategoryOfService> categoriesOfServiceTypes;

    public ProviderProfile() {
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
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

    public long getReferenceTicketId() {
        return referenceTicketId;
    }

    public void setReferenceTicketId(long referenceTicketId) {
        this.referenceTicketId = referenceTicketId;
    }

    public List<Affiliation> getAffiliations() {
        return affiliations;
    }

    public void setAffiliations(List<Affiliation> affiliations) {
        this.affiliations = affiliations;
    }

    public Entity getEntity() {
        return entity;
    }

    public void setEntity(Entity entity) {
        this.entity = entity;
    }

    public List<DesignatedContact> getDesignatedContacts() {
        return designatedContacts;
    }

    public void setDesignatedContacts(List<DesignatedContact> designatedContacts) {
        this.designatedContacts = designatedContacts;
    }

    public String getWorksOnReservationInd() {
        return worksOnReservationInd;
    }

    public void setWorksOnReservationInd(String worksOnReservationInd) {
        this.worksOnReservationInd = worksOnReservationInd;
    }

    public List<License> getCertifications() {
        return certifications;
    }

    public void setCertifications(List<License> certifications) {
        this.certifications = certifications;
    }

    public List<Document> getAttachments() {
        return attachments;
    }

    public void setAttachments(List<Document> attachments) {
        this.attachments = attachments;
    }

    public String getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(String createdBy) {
        this.createdBy = createdBy;
    }

    public Date getCreatedOn() {
        return createdOn;
    }

    public void setCreatedOn(Date createdOn) {
        this.createdOn = createdOn;
    }

    public String getModifiedBy() {
        return modifiedBy;
    }

    public void setModifiedBy(String modifiedBy) {
        this.modifiedBy = modifiedBy;
    }

    public Date getModifiedOn() {
        return modifiedOn;
    }

    public void setModifiedOn(Date modifiedOn) {
        this.modifiedOn = modifiedOn;
    }

    public String getMaintainsOwnPrivatePractice() {
        return maintainsOwnPrivatePractice;
    }

    public void setMaintainsOwnPrivatePractice(String maintainsOwnPrivatePractice) {
        this.maintainsOwnPrivatePractice = maintainsOwnPrivatePractice;
    }

    public String getEmployedOrContractedByGroup() {
        return employedOrContractedByGroup;
    }

    public void setEmployedOrContractedByGroup(String employedOrContractedByGroup) {
        this.employedOrContractedByGroup = employedOrContractedByGroup;
    }

    public String getCriminalConvictionInd() {
        return criminalConvictionInd;
    }

    public void setCriminalConvictionInd(String criminalConvictionInd) {
        this.criminalConvictionInd = criminalConvictionInd;
    }

    public String getCivilPenaltyInd() {
        return civilPenaltyInd;
    }

    public void setCivilPenaltyInd(String civilPenaltyInd) {
        this.civilPenaltyInd = civilPenaltyInd;
    }

    public String getPreviousExclusionInd() {
        return previousExclusionInd;
    }

    public void setPreviousExclusionInd(String previousExclusionInd) {
        this.previousExclusionInd = previousExclusionInd;
    }

    public List<AcceptedAgreements> getAgreements() {
        return agreements;
    }

    public void setAgreements(List<AcceptedAgreements> agreements) {
        this.agreements = agreements;
    }

    public ProviderStatement getStatement() {
        return statement;
    }

    public void setStatement(ProviderStatement statement) {
        this.statement = statement;
    }

    public List<PayToProvider> getPayToProviders() {
        return payToProviders;
    }

    public void setPayToProviders(List<PayToProvider> payToProviders) {
        this.payToProviders = payToProviders;
    }

    public RiskLevel getRiskLevel() {
        return riskLevel;
    }

    public void setRiskLevel(RiskLevel riskLevel) {
        this.riskLevel = riskLevel;
    }

    public List<Note> getNotes() {
        return notes;
    }

    public void setNotes(List<Note> notes) {
        this.notes = notes;
    }

    public Date getEffectiveDate() {
        return effectiveDate;
    }

    public void setEffectiveDate(Date effectiveDate) {
        this.effectiveDate = effectiveDate;
    }

    public ProfileStatus getProfileStatus() {
        return profileStatus;
    }

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

    public String getAdultInd() {
        return adultInd;
    }

    public void setAdultInd(String adultInd) {
        this.adultInd = adultInd;
    }

    public String getEmployedSinceClearance() {
        return employedSinceClearance;
    }

    public void setEmployedSinceClearance(String employedSinceClearance) {
        this.employedSinceClearance = employedSinceClearance;
    }

    public String getCounty() {
        return county;
    }

    public void setCounty(String county) {
        this.county = county;
    }

    public OwnershipInformation getOwnershipInformation() {
        return ownershipInformation;
    }

    public void setOwnershipInformation(OwnershipInformation ownershipInformation) {
        this.ownershipInformation = ownershipInformation;
    }

    public String getOwnerId() {
        return ownerId;
    }

    public void setOwnerId(String ownerId) {
        this.ownerId = ownerId;
    }

    public String getEmployeeCriminalConvictionInd() {
        return employeeCriminalConvictionInd;
    }

    public void setEmployeeCriminalConvictionInd(String employeeCriminalConvictionInd) {
        this.employeeCriminalConvictionInd = employeeCriminalConvictionInd;
    }

    public String getEmployeeCivilPenaltyInd() {
        return employeeCivilPenaltyInd;
    }

    public void setEmployeeCivilPenaltyInd(String employeeCivilPenaltyInd) {
        this.employeeCivilPenaltyInd = employeeCivilPenaltyInd;
    }

    public String getEmployeePreviousExclusionInd() {
        return employeePreviousExclusionInd;
    }

    public void setEmployeePreviousExclusionInd(String employeePreviousExclusionInd) {
        this.employeePreviousExclusionInd = employeePreviousExclusionInd;
    }

    public Integer getNumberOfBeds() {
        return numberOfBeds;
    }

    public void setNumberOfBeds(Integer numberOfBeds) {
        this.numberOfBeds = numberOfBeds;
    }

    public Date getNumberOfBedsEffectiveDate() {
        return numberOfBedsEffectiveDate;
    }

    public void setNumberOfBedsEffectiveDate(Date numberOfBedsEffectiveDate) {
        this.numberOfBedsEffectiveDate = numberOfBedsEffectiveDate;
    }

    public String getAccomplishedBy() {
        return accomplishedBy;
    }

    public void setAccomplishedBy(String accomplishedBy) {
        this.accomplishedBy = accomplishedBy;
    }

    public String getHealthBoardInd() {
        return healthBoardInd;
    }

    public void setHealthBoardInd(String healthBoardInd) {
        this.healthBoardInd = healthBoardInd;
    }

    public List<ProviderService> getServices() {
        return services;
    }

    public void setServices(List<ProviderService> services) {
        this.services = services;
    }

    public Integer getTitle18NumberOfBeds() {
        return title18NumberOfBeds;
    }

    public void setTitle18NumberOfBeds(Integer title18NumberOfBeds) {
        this.title18NumberOfBeds = title18NumberOfBeds;
    }

    public Integer getTitle19NumberOfBeds() {
        return title19NumberOfBeds;
    }

    public void setTitle19NumberOfBeds(Integer title19NumberOfBeds) {
        this.title19NumberOfBeds = title19NumberOfBeds;
    }

    public Integer getDualCertifiedNumberOfBeds() {
        return dualCertifiedNumberOfBeds;
    }

    public void setDualCertifiedNumberOfBeds(Integer dualCertifiedNumberOfBeds) {
        this.dualCertifiedNumberOfBeds = dualCertifiedNumberOfBeds;
    }

    public Integer getIcfNumberOfBeds() {
        return icfNumberOfBeds;
    }

    public void setIcfNumberOfBeds(Integer icfNumberOfBeds) {
        this.icfNumberOfBeds = icfNumberOfBeds;
    }

    public String getPhysicalAndOccupationalTherapyInd() {
        return physicalAndOccupationalTherapyInd;
    }

    public void setPhysicalAndOccupationalTherapyInd(String physicalAndOccupationalTherapyInd) {
        this.physicalAndOccupationalTherapyInd = physicalAndOccupationalTherapyInd;
    }

    public List<ProviderCategoryOfService> getCategoriesOfServiceTypes() {
        return categoriesOfServiceTypes;
    }

    public void setCategoriesOfServiceTypes(List<ProviderCategoryOfService> categoriesOfServiceTypes) {
        this.categoriesOfServiceTypes = categoriesOfServiceTypes;
    }
}
