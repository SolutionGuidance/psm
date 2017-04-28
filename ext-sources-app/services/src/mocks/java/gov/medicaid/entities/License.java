/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.entities;

import java.util.Date;
import java.util.List;

/**
 * Represents a license.
 *
 * @author argolite, j3_guile
 * @version 1.0
 */
public class License extends SortableEntity {

    /**
     * Description.
     */
    private String description;

    /**
     * License number.
     */
    private String licenseNumber;

    /**
     * Original issue date.
     */
    private Date originalIssueDate;

    /**
     * Renewal date.
     */
    private Date renewalEndDate;

    /**
     * Issuing state.
     */
    private String issuingUSState;

    /**
     * Renewal date.
     */
    private Date renewalDate;

    /**
     * Permit type.
     */
    private PermitType permitType;

    /**
     * License type.
     */
    private LicenseType type;

    /**
     * Permit number.
     */
    private long permitNumber;

    /**
     * Password.
     */
    private String password;

    /**
     * Status date.
     */
    private Date statusDate;

    /**
     * Discipline.
     */
    private boolean discipline;

    /**
     * Corrective action flag.
     */
    private boolean correctiveAction;

    /**
     * Level.
     */
    private LicenseLevel level;

    /**
     * Expire date.
     */
    private Date expireDate;

    /**
     * Profile.
     */
    private ProviderProfile profile;

    /**
     * Status.
     */
    private LicenseStatus status;

    /**
     * Discipline BD order.
     */
    private boolean disciplineBdOrder;

    /**
     * City.
     */
    private String city;

    /**
     * Medical school.
     */
    private MedicalSchool medicalSchool;

    /**
     * Programs.
     */
    private List<Program> programs;

    /**
     * Criminal convictions.
     */
    private List<CriminalConviction> criminalConvictions;

    /**
     * CE date.
     */
    private Date ceDate;

    /**
     * Default empty constructor.
     */
    public License() {
    }

    /**
     * Gets the value of the field <code>description</code>.
     * @return the description
     */
    public String getDescription() {
        return description;
    }

    /**
     * Sets the value of the field <code>description</code>.
     * @param description the description to set
     */
    public void setDescription(String description) {
        this.description = description;
    }

    /**
     * Gets the value of the field <code>licenseNumber</code>.
     * @return the licenseNumber
     */
    public String getLicenseNumber() {
        return licenseNumber;
    }

    /**
     * Sets the value of the field <code>licenseNumber</code>.
     * @param licenseNumber the licenseNumber to set
     */
    public void setLicenseNumber(String licenseNumber) {
        this.licenseNumber = licenseNumber;
    }

    /**
     * Gets the value of the field <code>originalIssueDate</code>.
     * @return the originalIssueDate
     */
    public Date getOriginalIssueDate() {
        return originalIssueDate;
    }

    /**
     * Sets the value of the field <code>originalIssueDate</code>.
     * @param originalIssueDate the originalIssueDate to set
     */
    public void setOriginalIssueDate(Date originalIssueDate) {
        this.originalIssueDate = originalIssueDate;
    }

    /**
     * Gets the value of the field <code>renewalEndDate</code>.
     * @return the renewalEndDate
     */
    public Date getRenewalEndDate() {
        return renewalEndDate;
    }

    /**
     * Sets the value of the field <code>renewalEndDate</code>.
     * @param renewalEndDate the renewalEndDate to set
     */
    public void setRenewalEndDate(Date renewalEndDate) {
        this.renewalEndDate = renewalEndDate;
    }

    /**
     * Gets the value of the field <code>issuingUSState</code>.
     * @return the issuingUSState
     */
    public String getIssuingUSState() {
        return issuingUSState;
    }

    /**
     * Sets the value of the field <code>issuingUSState</code>.
     * @param issuingUSState the issuingUSState to set
     */
    public void setIssuingUSState(String issuingUSState) {
        this.issuingUSState = issuingUSState;
    }

    /**
     * Gets the value of the field <code>renewalDate</code>.
     * @return the renewalDate
     */
    public Date getRenewalDate() {
        return renewalDate;
    }

    /**
     * Sets the value of the field <code>renewalDate</code>.
     * @param renewalDate the renewalDate to set
     */
    public void setRenewalDate(Date renewalDate) {
        this.renewalDate = renewalDate;
    }

    /**
     * Gets the value of the field <code>permitType</code>.
     * @return the permitType
     */
    public PermitType getPermitType() {
        return permitType;
    }

    /**
     * Sets the value of the field <code>permitType</code>.
     * @param permitType the permitType to set
     */
    public void setPermitType(PermitType permitType) {
        this.permitType = permitType;
    }

    /**
     * Gets the value of the field <code>type</code>.
     * @return the type
     */
    public LicenseType getType() {
        return type;
    }

    /**
     * Sets the value of the field <code>type</code>.
     * @param type the type to set
     */
    public void setType(LicenseType type) {
        this.type = type;
    }

    /**
     * Gets the value of the field <code>permitNumber</code>.
     * @return the permitNumber
     */
    public long getPermitNumber() {
        return permitNumber;
    }

    /**
     * Sets the value of the field <code>permitNumber</code>.
     * @param permitNumber the permitNumber to set
     */
    public void setPermitNumber(long permitNumber) {
        this.permitNumber = permitNumber;
    }

    /**
     * Gets the value of the field <code>password</code>.
     * @return the password
     */
    public String getPassword() {
        return password;
    }

    /**
     * Sets the value of the field <code>password</code>.
     * @param password the password to set
     */
    public void setPassword(String password) {
        this.password = password;
    }

    /**
     * Gets the value of the field <code>statusDate</code>.
     * @return the statusDate
     */
    public Date getStatusDate() {
        return statusDate;
    }

    /**
     * Sets the value of the field <code>statusDate</code>.
     * @param statusDate the statusDate to set
     */
    public void setStatusDate(Date statusDate) {
        this.statusDate = statusDate;
    }

    /**
     * Gets the value of the field <code>discipline</code>.
     * @return the discipline
     */
    public boolean isDiscipline() {
        return discipline;
    }

    /**
     * Sets the value of the field <code>discipline</code>.
     * @param discipline the discipline to set
     */
    public void setDiscipline(boolean discipline) {
        this.discipline = discipline;
    }

    /**
     * Gets the value of the field <code>correctiveAction</code>.
     * @return the correctiveAction
     */
    public boolean isCorrectiveAction() {
        return correctiveAction;
    }

    /**
     * Sets the value of the field <code>correctiveAction</code>.
     * @param correctiveAction the correctiveAction to set
     */
    public void setCorrectiveAction(boolean correctiveAction) {
        this.correctiveAction = correctiveAction;
    }

    /**
     * Gets the value of the field <code>level</code>.
     * @return the level
     */
    public LicenseLevel getLevel() {
        return level;
    }

    /**
     * Sets the value of the field <code>level</code>.
     * @param level the level to set
     */
    public void setLevel(LicenseLevel level) {
        this.level = level;
    }

    /**
     * Gets the value of the field <code>expireDate</code>.
     * @return the expireDate
     */
    public Date getExpireDate() {
        return expireDate;
    }

    /**
     * Sets the value of the field <code>expireDate</code>.
     * @param expireDate the expireDate to set
     */
    public void setExpireDate(Date expireDate) {
        this.expireDate = expireDate;
    }

    /**
     * Gets the value of the field <code>profile</code>.
     * @return the profile
     */
    public ProviderProfile getProfile() {
        return profile;
    }

    /**
     * Sets the value of the field <code>profile</code>.
     * @param profile the profile to set
     */
    public void setProfile(ProviderProfile profile) {
        this.profile = profile;
    }

    /**
     * Gets the value of the field <code>status</code>.
     * @return the status
     */
    public LicenseStatus getStatus() {
        return status;
    }

    /**
     * Sets the value of the field <code>status</code>.
     * @param status the status to set
     */
    public void setStatus(LicenseStatus status) {
        this.status = status;
    }

    /**
     * Gets the value of the field <code>disciplineBdOrder</code>.
     * @return the disciplineBdOrder
     */
    public boolean isDisciplineBdOrder() {
        return disciplineBdOrder;
    }

    /**
     * Sets the value of the field <code>disciplineBdOrder</code>.
     * @param disciplineBdOrder the disciplineBdOrder to set
     */
    public void setDisciplineBdOrder(boolean disciplineBdOrder) {
        this.disciplineBdOrder = disciplineBdOrder;
    }

    /**
     * Gets the value of the field <code>city</code>.
     * @return the city
     */
    public String getCity() {
        return city;
    }

    /**
     * Sets the value of the field <code>city</code>.
     * @param city the city to set
     */
    public void setCity(String city) {
        this.city = city;
    }

    /**
     * Gets the value of the field <code>medicalSchool</code>.
     * @return the medicalSchool
     */
    public MedicalSchool getMedicalSchool() {
        return medicalSchool;
    }

    /**
     * Sets the value of the field <code>medicalSchool</code>.
     * @param medicalSchool the medicalSchool to set
     */
    public void setMedicalSchool(MedicalSchool medicalSchool) {
        this.medicalSchool = medicalSchool;
    }

    /**
     * Gets the value of the field <code>programs</code>.
     * @return the programs
     */
    public List<Program> getPrograms() {
        return programs;
    }

    /**
     * Sets the value of the field <code>programs</code>.
     * @param programs the programs to set
     */
    public void setPrograms(List<Program> programs) {
        this.programs = programs;
    }

    /**
     * Gets the value of the field <code>criminalConvictions</code>.
     * @return the criminalConvictions
     */
    public List<CriminalConviction> getCriminalConvictions() {
        return criminalConvictions;
    }

    /**
     * Sets the value of the field <code>criminalConvictions</code>.
     * @param criminalConvictions the criminalConvictions to set
     */
    public void setCriminalConvictions(List<CriminalConviction> criminalConvictions) {
        this.criminalConvictions = criminalConvictions;
    }

    /**
     * Gets the value of the field <code>ceDate</code>.
     * @return the ceDate
     */
    public Date getCeDate() {
        return ceDate;
    }

    /**
     * Sets the value of the field <code>ceDate</code>.
     * @param ceDate the ceDate to set
     */
    public void setCeDate(Date ceDate) {
        this.ceDate = ceDate;
    }
}
