/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.entities;

import java.util.Date;
import java.util.List;

/**
 * Represents a provider profile.
 *
 * @author argolite, j3_guile
 * @version 1.0
 */
public class ProviderProfile extends AuditableEntity {

    /**
     * The provider type.
     */
    private ProviderType type;

    /**
     * SSN.
     */
    private String SSN;

    /**
     * Date of birth.
     */
    private Date dob;

    /**
     * Request effective date.
     */
    private Date requestEffectiveDate;

    /**
     * Degree.
     */
    private Degree degree;

    /**
     * Specialties.
     */
    private List<Specialty> specialties;

    /**
     * Has private office flag.
     */
    private boolean hasPrivateOffice;

    /**
     * Employed or contracted flag.
     */
    private boolean employedAndOrContracted;

    /**
     * Private practice.
     */
    private PrivatePractice privatePractice;

    /**
     * All addresses.
     */
    private List<Address> addresses;

    /**
     * Mail preference for remittance advice.
     */
    private MailPreference remittanceAdviceEmailPreference;

    /**
     * Mail preference for reimbursement check.
     */
    private MailPreference reimbursementCheckEmailPreference;

    /**
     * Mail preference for provider correspondence.
     */
    private MailPreference providerCorrespondenceEmailPreference;

    /**
     * Mail preference for authorization request.
     */
    private MailPreference authorizationRequestNoticeEmailPreference;

    /**
     * Mail preference for enrollment status.
     */
    private MailPreference enrollmentStatusEmailPreference;

    /**
     * Remittance sequence order.
     */
    private RemittanceSequenceOrder remittanceSequenceOrder;

    /**
     * Group affiliations.
     */
    private List<GroupAffiliation> affiliations;

    /**
     * Has criminal conviction flag.
     */
    private boolean hasConvictedOfCriminalOffense;

    /**
     * Has civil penalty flag.
     */
    private boolean hasCivilMoneyPenalty;

    /**
     * Has termination flag.
     */
    private boolean hasTerminated;

    /**
     * Contact name.
     */
    private String contactName;

    /**
     * Contact phone number.
     */
    private String contactPhoneNumber;

    /**
     * Contact fax number.
     */
    private String contactFaxNumber;

    /**
     * Contact email address.
     */
    private String contactEmail;

    /**
     * Provider statement.
     */
    private ProviderStatement providerStatement;

    /**
     * Current enrollment.
     */
    private Enrollment currentEnrollment;

    /**
     * Current previous enrollment.
     */
    private List<Enrollment> previousEnrollment;

    /**
     * Finger prints scanned file.
     */
    private String fingerPrintsScannedFile;

    /**
     * Scanned EFTForm.
     */
    private String scannedEFTForm;

    /**
     * Enrollment fee required flag.
     */
    private boolean enrolmentFeeRequired;

    /**
     * Enrollment fee.
     */
    private double enrollmentFee;

    /**
     * Enrollment fee paid flag.
     */
    private boolean enrollmentFeePaid;

    /**
     * NPI.
     */
    private String NPI;

    /**
     * Provider agreement file.
     */
    private String providerAgreementFile;

    /**
     * Major program.
     */
    private MajorProgram majorProgram;

    /**
     * Category.
     */
    private CategoryService category;

    /**
     * Licenses.
     */
    private List<License> licenses;

    /**
     * Primary taxonomy.
     */
    private String primaryTaxonomy;

    /**
     * Prefix.
     */
    private String prefix;

    /**
     * Suffix.
     */
    private String suffix;

    /**
     * Credentials.
     */
    private String credentials;

    /**
     * Other prefix.
     */
    private String otherPrefix;
    /**
     * Other suffix.
     */
    private String otherSuffix;
    /**
     * Other first name.
     */
    private String otherFirstName;
    /**
     * Other middle name.
     */
    private String otherMiddleName;
    /**
     * Other last name.
     */
    private String otherLastName;
    /**
     * Zip lump sum.
     */
    private String zipLumpSum;
    /**
     * Deceased date.
     */
    private Date dateOfDeath;
    /**
     * Complaint type.
     */
    private ComplaintType complaintType;

    /**
     * SSN verified flag.
     */
    private boolean SSNVerified;

    /**
     * Employer id.
     */
    private String employerId;

    /**
     * Alias.
     */
    private String alias;

    /**
     * Action date to.
     */
    private Date actionDateTo;

    /**
     * Termination date from.
     */
    private Date terminationDateFrom;

    /**
     * Action date from.
     */
    private Date actionDateFrom;

    /**
     * Termination date to.
     */
    private Date terminationDateTo;

    /**
     * Create date from.
     */
    private Date createDateFrom;

    /**
     * Create date to.
     */
    private Date createDateTo;

    /**
     * Modify date from.
     */
    private Date modifyDateFrom;

    /**
     * Modify date to.
     */
    private Date modifyDateTo;

    /**
     * Reciprocal code.
     */
    private String reciprocalCode;

    /**
     * Procurement code.
     */
    private String procurementCode;

    /**
     * Agency.
     */
    private String agency;

    /**
     * Duns.
     */
    private long duns;

    /**
     * Cage code.
     */
    private String cageCode;
    /**
     * DBA.
     */
    private String dba;

    /**
     * Sex.
     */
    private Sex sex;

    /**
     * User.
     */
    private User user;

    /**
     * Exclusion type.
     */
    private ExclusionType exclusionType;

    /**
     * Business.
     */
    private Business business;

    /**
     * References.
     */
    private List<Reference> references;

    /**
     * Actions.
     */
    private List<Action> actions;

    /**
     * Agency identifiers.
     */
    private List<AgencyIdentifier> agencyIdentifiers;
    
    /**
     * The state classifications.
     */
    private String stateClassifications;
    
    /**
     * The federal classifications.
     */
    private String federalClassifications;

    /**
     * Default empty constructor.
     */
    public ProviderProfile() {
    }

    /**
     * Gets the value of the field <code>type</code>.
     *
     * @return the type
     */
    public ProviderType getProviderType() {
        return type;
    }

    /**
     * Sets the value of the field <code>type</code>.
     *
     * @param type the type to set
     */
    public void setProviderType(ProviderType type) {
        this.type = type;
    }

    /**
     * Gets the value of the field <code>sSN</code>.
     *
     * @return the sSN
     */
    public String getSSN() {
        return SSN;
    }

    /**
     * Sets the value of the field <code>sSN</code>.
     *
     * @param sSN the sSN to set
     */
    public void setSSN(String sSN) {
        SSN = sSN;
    }

    /**
     * Gets the value of the field <code>dob</code>.
     *
     * @return the dob
     */
    public Date getDob() {
        return dob;
    }

    /**
     * Sets the value of the field <code>dob</code>.
     *
     * @param dob the dob to set
     */
    public void setDob(Date dob) {
        this.dob = dob;
    }

    /**
     * Gets the value of the field <code>requestEffectiveDate</code>.
     *
     * @return the requestEffectiveDate
     */
    public Date getRequestEffectiveDate() {
        return requestEffectiveDate;
    }

    /**
     * Sets the value of the field <code>requestEffectiveDate</code>.
     *
     * @param requestEffectiveDate the requestEffectiveDate to set
     */
    public void setRequestEffectiveDate(Date requestEffectiveDate) {
        this.requestEffectiveDate = requestEffectiveDate;
    }

    /**
     * Gets the value of the field <code>degree</code>.
     *
     * @return the degree
     */
    public Degree getDegree() {
        return degree;
    }

    /**
     * Sets the value of the field <code>degree</code>.
     *
     * @param degree the degree to set
     */
    public void setDegree(Degree degree) {
        this.degree = degree;
    }

    /**
     * Gets the value of the field <code>specialties</code>.
     *
     * @return the specialties
     */
    public List<Specialty> getSpecialties() {
        return specialties;
    }

    /**
     * Sets the value of the field <code>specialties</code>.
     *
     * @param specialties the specialties to set
     */
    public void setSpecialties(List<Specialty> specialties) {
        this.specialties = specialties;
    }

    /**
     * Gets the value of the field <code>hasPrivateOffice</code>.
     *
     * @return the hasPrivateOffice
     */
    public boolean isHasPrivateOffice() {
        return hasPrivateOffice;
    }

    /**
     * Sets the value of the field <code>hasPrivateOffice</code>.
     *
     * @param hasPrivateOffice the hasPrivateOffice to set
     */
    public void setHasPrivateOffice(boolean hasPrivateOffice) {
        this.hasPrivateOffice = hasPrivateOffice;
    }

    /**
     * Gets the value of the field <code>employedAndOrContracted</code>.
     *
     * @return the employedAndOrContracted
     */
    public boolean isEmployedAndOrContracted() {
        return employedAndOrContracted;
    }

    /**
     * Sets the value of the field <code>employedAndOrContracted</code>.
     *
     * @param employedAndOrContracted the employedAndOrContracted to set
     */
    public void setEmployedAndOrContracted(boolean employedAndOrContracted) {
        this.employedAndOrContracted = employedAndOrContracted;
    }

    /**
     * Gets the value of the field <code>privatePractice</code>.
     *
     * @return the privatePractice
     */
    public PrivatePractice getPrivatePractice() {
        return privatePractice;
    }

    /**
     * Sets the value of the field <code>privatePractice</code>.
     *
     * @param privatePractice the privatePractice to set
     */
    public void setPrivatePractice(PrivatePractice privatePractice) {
        this.privatePractice = privatePractice;
    }

    /**
     * Gets the value of the field <code>remittanceAdviceEmailPreference</code>.
     *
     * @return the remittanceAdviceEmailPreference
     */
    public MailPreference getRemittanceAdviceEmailPreference() {
        return remittanceAdviceEmailPreference;
    }

    /**
     * Sets the value of the field <code>remittanceAdviceEmailPreference</code>.
     *
     * @param remittanceAdviceEmailPreference the remittanceAdviceEmailPreference to set
     */
    public void setRemittanceAdviceEmailPreference(MailPreference remittanceAdviceEmailPreference) {
        this.remittanceAdviceEmailPreference = remittanceAdviceEmailPreference;
    }

    /**
     * Gets the value of the field <code>reimbursementCheckEmailPreference</code>.
     *
     * @return the reimbursementCheckEmailPreference
     */
    public MailPreference getReimbursementCheckEmailPreference() {
        return reimbursementCheckEmailPreference;
    }

    /**
     * Sets the value of the field <code>reimbursementCheckEmailPreference</code>.
     *
     * @param reimbursementCheckEmailPreference the reimbursementCheckEmailPreference to set
     */
    public void setReimbursementCheckEmailPreference(MailPreference reimbursementCheckEmailPreference) {
        this.reimbursementCheckEmailPreference = reimbursementCheckEmailPreference;
    }

    /**
     * Gets the value of the field <code>providerCorrespondenceEmailPreference</code>.
     *
     * @return the providerCorrespondenceEmailPreference
     */
    public MailPreference getProviderCorrespondenceEmailPreference() {
        return providerCorrespondenceEmailPreference;
    }

    /**
     * Sets the value of the field <code>providerCorrespondenceEmailPreference</code>.
     *
     * @param providerCorrespondenceEmailPreference the providerCorrespondenceEmailPreference to set
     */
    public void setProviderCorrespondenceEmailPreference(MailPreference providerCorrespondenceEmailPreference) {
        this.providerCorrespondenceEmailPreference = providerCorrespondenceEmailPreference;
    }

    /**
     * Gets the value of the field <code>authorizationRequestNoticeEmailPreference</code>.
     *
     * @return the authorizationRequestNoticeEmailPreference
     */
    public MailPreference getAuthorizationRequestNoticeEmailPreference() {
        return authorizationRequestNoticeEmailPreference;
    }

    /**
     * Sets the value of the field <code>authorizationRequestNoticeEmailPreference</code>.
     *
     * @param authorizationRequestNoticeEmailPreference the authorizationRequestNoticeEmailPreference to set
     */
    public void setAuthorizationRequestNoticeEmailPreference(MailPreference authorizationRequestNoticeEmailPreference) {
        this.authorizationRequestNoticeEmailPreference = authorizationRequestNoticeEmailPreference;
    }

    /**
     * Gets the value of the field <code>enrollmentStatusEmailPreference</code>.
     *
     * @return the enrollmentStatusEmailPreference
     */
    public MailPreference getEnrollmentStatusEmailPreference() {
        return enrollmentStatusEmailPreference;
    }

    /**
     * Sets the value of the field <code>enrollmentStatusEmailPreference</code>.
     *
     * @param enrollmentStatusEmailPreference the enrollmentStatusEmailPreference to set
     */
    public void setEnrollmentStatusEmailPreference(MailPreference enrollmentStatusEmailPreference) {
        this.enrollmentStatusEmailPreference = enrollmentStatusEmailPreference;
    }

    /**
     * Gets the value of the field <code>remittanceSequenceOrder</code>.
     *
     * @return the remittanceSequenceOrder
     */
    public RemittanceSequenceOrder getRemittanceSequenceOrder() {
        return remittanceSequenceOrder;
    }

    /**
     * Sets the value of the field <code>remittanceSequenceOrder</code>.
     *
     * @param remittanceSequenceOrder the remittanceSequenceOrder to set
     */
    public void setRemittanceSequenceOrder(RemittanceSequenceOrder remittanceSequenceOrder) {
        this.remittanceSequenceOrder = remittanceSequenceOrder;
    }

    /**
     * Gets the value of the field <code>affiliations</code>.
     *
     * @return the affiliations
     */
    public List<GroupAffiliation> getAffiliations() {
        return affiliations;
    }

    /**
     * Sets the value of the field <code>affiliations</code>.
     *
     * @param affiliations the affiliations to set
     */
    public void setAffiliations(List<GroupAffiliation> affiliations) {
        this.affiliations = affiliations;
    }

    /**
     * Gets the value of the field <code>hasConvictedOfCriminalOffense</code>.
     *
     * @return the hasConvictedOfCriminalOffense
     */
    public boolean isHasConvictedOfCriminalOffense() {
        return hasConvictedOfCriminalOffense;
    }

    /**
     * Sets the value of the field <code>hasConvictedOfCriminalOffense</code>.
     *
     * @param hasConvictedOfCriminalOffense the hasConvictedOfCriminalOffense to set
     */
    public void setHasConvictedOfCriminalOffense(boolean hasConvictedOfCriminalOffense) {
        this.hasConvictedOfCriminalOffense = hasConvictedOfCriminalOffense;
    }

    /**
     * Gets the value of the field <code>hasCivilMoneyPenalty</code>.
     *
     * @return the hasCivilMoneyPenalty
     */
    public boolean isHasCivilMoneyPenalty() {
        return hasCivilMoneyPenalty;
    }

    /**
     * Sets the value of the field <code>hasCivilMoneyPenalty</code>.
     *
     * @param hasCivilMoneyPenalty the hasCivilMoneyPenalty to set
     */
    public void setHasCivilMoneyPenalty(boolean hasCivilMoneyPenalty) {
        this.hasCivilMoneyPenalty = hasCivilMoneyPenalty;
    }

    /**
     * Gets the value of the field <code>hasTerminated</code>.
     *
     * @return the hasTerminated
     */
    public boolean isHasTerminated() {
        return hasTerminated;
    }

    /**
     * Sets the value of the field <code>hasTerminated</code>.
     *
     * @param hasTerminated the hasTerminated to set
     */
    public void setHasTerminated(boolean hasTerminated) {
        this.hasTerminated = hasTerminated;
    }

    /**
     * Gets the value of the field <code>contactName</code>.
     *
     * @return the contactName
     */
    public String getContactName() {
        return contactName;
    }

    /**
     * Sets the value of the field <code>contactName</code>.
     *
     * @param contactName the contactName to set
     */
    public void setContactName(String contactName) {
        this.contactName = contactName;
    }

    /**
     * Gets the value of the field <code>contactPhoneNumber</code>.
     *
     * @return the contactPhoneNumber
     */
    public String getContactPhoneNumber() {
        return contactPhoneNumber;
    }

    /**
     * Sets the value of the field <code>contactPhoneNumber</code>.
     *
     * @param contactPhoneNumber the contactPhoneNumber to set
     */
    public void setContactPhoneNumber(String contactPhoneNumber) {
        this.contactPhoneNumber = contactPhoneNumber;
    }

    /**
     * Gets the value of the field <code>contactFaxNumber</code>.
     *
     * @return the contactFaxNumber
     */
    public String getContactFaxNumber() {
        return contactFaxNumber;
    }

    /**
     * Sets the value of the field <code>contactFaxNumber</code>.
     *
     * @param contactFaxNumber the contactFaxNumber to set
     */
    public void setContactFaxNumber(String contactFaxNumber) {
        this.contactFaxNumber = contactFaxNumber;
    }

    /**
     * Gets the value of the field <code>contactEmail</code>.
     *
     * @return the contactEmail
     */
    public String getContactEmail() {
        return contactEmail;
    }

    /**
     * Sets the value of the field <code>contactEmail</code>.
     *
     * @param contactEmail the contactEmail to set
     */
    public void setContactEmail(String contactEmail) {
        this.contactEmail = contactEmail;
    }

    /**
     * Gets the value of the field <code>providerStatement</code>.
     *
     * @return the providerStatement
     */
    public ProviderStatement getProviderStatement() {
        return providerStatement;
    }

    /**
     * Sets the value of the field <code>providerStatement</code>.
     *
     * @param providerStatement the providerStatement to set
     */
    public void setProviderStatement(ProviderStatement providerStatement) {
        this.providerStatement = providerStatement;
    }

    /**
     * Gets the value of the field <code>currentEnrollment</code>.
     *
     * @return the currentEnrollment
     */
    public Enrollment getCurrentEnrollment() {
        return currentEnrollment;
    }

    /**
     * Sets the value of the field <code>currentEnrollment</code>.
     *
     * @param currentEnrollment the currentEnrollment to set
     */
    public void setCurrentEnrollment(Enrollment currentEnrollment) {
        this.currentEnrollment = currentEnrollment;
    }

    /**
     * Gets the value of the field <code>previousEnrollment</code>.
     *
     * @return the previousEnrollment
     */
    public List<Enrollment> getPreviousEnrollment() {
        return previousEnrollment;
    }

    /**
     * Sets the value of the field <code>previousEnrollment</code>.
     *
     * @param previousEnrollment the previousEnrollment to set
     */
    public void setPreviousEnrollment(List<Enrollment> previousEnrollment) {
        this.previousEnrollment = previousEnrollment;
    }

    /**
     * Gets the value of the field <code>fingerPrintsScannedFile</code>.
     *
     * @return the fingerPrintsScannedFile
     */
    public String getFingerPrintsScannedFile() {
        return fingerPrintsScannedFile;
    }

    /**
     * Sets the value of the field <code>fingerPrintsScannedFile</code>.
     *
     * @param fingerPrintsScannedFile the fingerPrintsScannedFile to set
     */
    public void setFingerPrintsScannedFile(String fingerPrintsScannedFile) {
        this.fingerPrintsScannedFile = fingerPrintsScannedFile;
    }

    /**
     * Gets the value of the field <code>scannedEFTForm</code>.
     *
     * @return the scannedEFTForm
     */
    public String getScannedEFTForm() {
        return scannedEFTForm;
    }

    /**
     * Sets the value of the field <code>scannedEFTForm</code>.
     *
     * @param scannedEFTForm the scannedEFTForm to set
     */
    public void setScannedEFTForm(String scannedEFTForm) {
        this.scannedEFTForm = scannedEFTForm;
    }

    /**
     * Gets the value of the field <code>enrolmentFeeRequired</code>.
     *
     * @return the enrolmentFeeRequired
     */
    public boolean isEnrolmentFeeRequired() {
        return enrolmentFeeRequired;
    }

    /**
     * Sets the value of the field <code>enrolmentFeeRequired</code>.
     *
     * @param enrolmentFeeRequired the enrolmentFeeRequired to set
     */
    public void setEnrolmentFeeRequired(boolean enrolmentFeeRequired) {
        this.enrolmentFeeRequired = enrolmentFeeRequired;
    }

    /**
     * Gets the value of the field <code>enrollmentFee</code>.
     *
     * @return the enrollmentFee
     */
    public double getEnrollmentFee() {
        return enrollmentFee;
    }

    /**
     * Sets the value of the field <code>enrollmentFee</code>.
     *
     * @param enrollmentFee the enrollmentFee to set
     */
    public void setEnrollmentFee(double enrollmentFee) {
        this.enrollmentFee = enrollmentFee;
    }

    /**
     * Gets the value of the field <code>enrollmentFeePaid</code>.
     *
     * @return the enrollmentFeePaid
     */
    public boolean isEnrollmentFeePaid() {
        return enrollmentFeePaid;
    }

    /**
     * Sets the value of the field <code>enrollmentFeePaid</code>.
     *
     * @param enrollmentFeePaid the enrollmentFeePaid to set
     */
    public void setEnrollmentFeePaid(boolean enrollmentFeePaid) {
        this.enrollmentFeePaid = enrollmentFeePaid;
    }

    /**
     * Gets the value of the field <code>nPI</code>.
     *
     * @return the nPI
     */
    public String getNPI() {
        return NPI;
    }

    /**
     * Sets the value of the field <code>nPI</code>.
     *
     * @param nPI the nPI to set
     */
    public void setNPI(String nPI) {
        NPI = nPI;
    }

    /**
     * Gets the value of the field <code>providerAgreementFile</code>.
     *
     * @return the providerAgreementFile
     */
    public String getProviderAgreementFile() {
        return providerAgreementFile;
    }

    /**
     * Sets the value of the field <code>providerAgreementFile</code>.
     *
     * @param providerAgreementFile the providerAgreementFile to set
     */
    public void setProviderAgreementFile(String providerAgreementFile) {
        this.providerAgreementFile = providerAgreementFile;
    }

    /**
     * Gets the value of the field <code>majorProgram</code>.
     *
     * @return the majorProgram
     */
    public MajorProgram getMajorProgram() {
        return majorProgram;
    }

    /**
     * Sets the value of the field <code>majorProgram</code>.
     *
     * @param majorProgram the majorProgram to set
     */
    public void setMajorProgram(MajorProgram majorProgram) {
        this.majorProgram = majorProgram;
    }

    /**
     * Gets the value of the field <code>category</code>.
     *
     * @return the category
     */
    public CategoryService getCategory() {
        return category;
    }

    /**
     * Sets the value of the field <code>category</code>.
     *
     * @param category the category to set
     */
    public void setCategory(CategoryService category) {
        this.category = category;
    }

    /**
     * Gets the value of the field <code>licenses</code>.
     *
     * @return the licenses
     */
    public List<License> getLicenses() {
        return licenses;
    }

    /**
     * Sets the value of the field <code>licenses</code>.
     *
     * @param licenses the licenses to set
     */
    public void setLicenses(List<License> licenses) {
        this.licenses = licenses;
    }

    /**
     * Gets the value of the field <code>primaryTaxonomy</code>.
     *
     * @return the primaryTaxonomy
     */
    public String getPrimaryTaxonomy() {
        return primaryTaxonomy;
    }

    /**
     * Sets the value of the field <code>primaryTaxonomy</code>.
     *
     * @param primaryTaxonomy the primaryTaxonomy to set
     */
    public void setPrimaryTaxonomy(String primaryTaxonomy) {
        this.primaryTaxonomy = primaryTaxonomy;
    }

    /**
     * Gets the value of the field <code>prefix</code>.
     *
     * @return the prefix
     */
    public String getPrefix() {
        return prefix;
    }

    /**
     * Sets the value of the field <code>prefix</code>.
     *
     * @param prefix the prefix to set
     */
    public void setPrefix(String prefix) {
        this.prefix = prefix;
    }

    /**
     * Gets the value of the field <code>suffix</code>.
     *
     * @return the suffix
     */
    public String getSuffix() {
        return suffix;
    }

    /**
     * Sets the value of the field <code>suffix</code>.
     *
     * @param suffix the suffix to set
     */
    public void setSuffix(String suffix) {
        this.suffix = suffix;
    }

    /**
     * Gets the value of the field <code>credentials</code>.
     *
     * @return the credentials
     */
    public String getCredentials() {
        return credentials;
    }

    /**
     * Sets the value of the field <code>credentials</code>.
     *
     * @param credentials the credentials to set
     */
    public void setCredentials(String credentials) {
        this.credentials = credentials;
    }

    /**
     * Gets the value of the field <code>otherPrefix</code>.
     *
     * @return the otherPrefix
     */
    public String getOtherPrefix() {
        return otherPrefix;
    }

    /**
     * Sets the value of the field <code>otherPrefix</code>.
     *
     * @param otherPrefix the otherPrefix to set
     */
    public void setOtherPrefix(String otherPrefix) {
        this.otherPrefix = otherPrefix;
    }

    /**
     * Gets the value of the field <code>otherSuffix</code>.
     *
     * @return the otherSuffix
     */
    public String getOtherSuffix() {
        return otherSuffix;
    }

    /**
     * Sets the value of the field <code>otherSuffix</code>.
     *
     * @param otherSuffix the otherSuffix to set
     */
    public void setOtherSuffix(String otherSuffix) {
        this.otherSuffix = otherSuffix;
    }

    /**
     * Gets the value of the field <code>otherFirstName</code>.
     *
     * @return the otherFirstName
     */
    public String getOtherFirstName() {
        return otherFirstName;
    }

    /**
     * Sets the value of the field <code>otherFirstName</code>.
     *
     * @param otherFirstName the otherFirstName to set
     */
    public void setOtherFirstName(String otherFirstName) {
        this.otherFirstName = otherFirstName;
    }

    /**
     * Gets the value of the field <code>otherMiddleName</code>.
     *
     * @return the otherMiddleName
     */
    public String getOtherMiddleName() {
        return otherMiddleName;
    }

    /**
     * Sets the value of the field <code>otherMiddleName</code>.
     *
     * @param otherMiddleName the otherMiddleName to set
     */
    public void setOtherMiddleName(String otherMiddleName) {
        this.otherMiddleName = otherMiddleName;
    }

    /**
     * Gets the value of the field <code>otherLastName</code>.
     *
     * @return the otherLastName
     */
    public String getOtherLastName() {
        return otherLastName;
    }

    /**
     * Sets the value of the field <code>otherLastName</code>.
     *
     * @param otherLastName the otherLastName to set
     */
    public void setOtherLastName(String otherLastName) {
        this.otherLastName = otherLastName;
    }

    /**
     * Gets the value of the field <code>zipLumpSum</code>.
     *
     * @return the zipLumpSum
     */
    public String getZipLumpSum() {
        return zipLumpSum;
    }

    /**
     * Sets the value of the field <code>zipLumpSum</code>.
     *
     * @param zipLumpSum the zipLumpSum to set
     */
    public void setZipLumpSum(String zipLumpSum) {
        this.zipLumpSum = zipLumpSum;
    }

    /**
     * Gets the value of the field <code>dateOfDeath</code>.
     *
     * @return the dateOfDeath
     */
    public Date getDateOfDeath() {
        return dateOfDeath;
    }

    /**
     * Sets the value of the field <code>dateOfDeath</code>.
     *
     * @param dateOfDeath the dateOfDeath to set
     */
    public void setDateOfDeath(Date dateOfDeath) {
        this.dateOfDeath = dateOfDeath;
    }

    /**
     * Gets the value of the field <code>complaintType</code>.
     *
     * @return the complaintType
     */
    public ComplaintType getComplaintType() {
        return complaintType;
    }

    /**
     * Sets the value of the field <code>complaintType</code>.
     *
     * @param complaintType the complaintType to set
     */
    public void setComplaintType(ComplaintType complaintType) {
        this.complaintType = complaintType;
    }

    /**
     * Gets the value of the field <code>sSNVerified</code>.
     *
     * @return the sSNVerified
     */
    public boolean isSSNVerified() {
        return SSNVerified;
    }

    /**
     * Sets the value of the field <code>sSNVerified</code>.
     *
     * @param sSNVerified the sSNVerified to set
     */
    public void setSSNVerified(boolean sSNVerified) {
        SSNVerified = sSNVerified;
    }

    /**
     * Gets the value of the field <code>employerId</code>.
     *
     * @return the employerId
     */
    public String getEmployerId() {
        return employerId;
    }

    /**
     * Sets the value of the field <code>employerId</code>.
     *
     * @param employerId the employerId to set
     */
    public void setEmployerId(String employerId) {
        this.employerId = employerId;
    }

    /**
     * Gets the value of the field <code>alias</code>.
     *
     * @return the alias
     */
    public String getAlias() {
        return alias;
    }

    /**
     * Sets the value of the field <code>alias</code>.
     *
     * @param alias the alias to set
     */
    public void setAlias(String alias) {
        this.alias = alias;
    }

    /**
     * Gets the value of the field <code>actionDateTo</code>.
     *
     * @return the actionDateTo
     */
    public Date getActionDateTo() {
        return actionDateTo;
    }

    /**
     * Sets the value of the field <code>actionDateTo</code>.
     *
     * @param actionDateTo the actionDateTo to set
     */
    public void setActionDateTo(Date actionDateTo) {
        this.actionDateTo = actionDateTo;
    }

    /**
     * Gets the value of the field <code>terminationDateFrom</code>.
     *
     * @return the terminationDateFrom
     */
    public Date getTerminationDateFrom() {
        return terminationDateFrom;
    }

    /**
     * Sets the value of the field <code>terminationDateFrom</code>.
     *
     * @param terminationDateFrom the terminationDateFrom to set
     */
    public void setTerminationDateFrom(Date terminationDateFrom) {
        this.terminationDateFrom = terminationDateFrom;
    }

    /**
     * Gets the value of the field <code>actionDateFrom</code>.
     *
     * @return the actionDateFrom
     */
    public Date getActionDateFrom() {
        return actionDateFrom;
    }

    /**
     * Sets the value of the field <code>actionDateFrom</code>.
     *
     * @param actionDateFrom the actionDateFrom to set
     */
    public void setActionDateFrom(Date actionDateFrom) {
        this.actionDateFrom = actionDateFrom;
    }

    /**
     * Gets the value of the field <code>terminationDateTo</code>.
     *
     * @return the terminationDateTo
     */
    public Date getTerminationDateTo() {
        return terminationDateTo;
    }

    /**
     * Sets the value of the field <code>terminationDateTo</code>.
     *
     * @param terminationDateTo the terminationDateTo to set
     */
    public void setTerminationDateTo(Date terminationDateTo) {
        this.terminationDateTo = terminationDateTo;
    }

    /**
     * Gets the value of the field <code>createDateFrom</code>.
     *
     * @return the createDateFrom
     */
    public Date getCreateDateFrom() {
        return createDateFrom;
    }

    /**
     * Sets the value of the field <code>createDateFrom</code>.
     *
     * @param createDateFrom the createDateFrom to set
     */
    public void setCreateDateFrom(Date createDateFrom) {
        this.createDateFrom = createDateFrom;
    }

    /**
     * Gets the value of the field <code>createDateTo</code>.
     *
     * @return the createDateTo
     */
    public Date getCreateDateTo() {
        return createDateTo;
    }

    /**
     * Sets the value of the field <code>createDateTo</code>.
     *
     * @param createDateTo the createDateTo to set
     */
    public void setCreateDateTo(Date createDateTo) {
        this.createDateTo = createDateTo;
    }

    /**
     * Gets the value of the field <code>modifyDateFrom</code>.
     *
     * @return the modifyDateFrom
     */
    public Date getModifyDateFrom() {
        return modifyDateFrom;
    }

    /**
     * Sets the value of the field <code>modifyDateFrom</code>.
     *
     * @param modifyDateFrom the modifyDateFrom to set
     */
    public void setModifyDateFrom(Date modifyDateFrom) {
        this.modifyDateFrom = modifyDateFrom;
    }

    /**
     * Gets the value of the field <code>modifyDateTo</code>.
     *
     * @return the modifyDateTo
     */
    public Date getModifyDateTo() {
        return modifyDateTo;
    }

    /**
     * Sets the value of the field <code>modifyDateTo</code>.
     *
     * @param modifyDateTo the modifyDateTo to set
     */
    public void setModifyDateTo(Date modifyDateTo) {
        this.modifyDateTo = modifyDateTo;
    }

    /**
     * Gets the value of the field <code>reciprocalCode</code>.
     *
     * @return the reciprocalCode
     */
    public String getReciprocalCode() {
        return reciprocalCode;
    }

    /**
     * Sets the value of the field <code>reciprocalCode</code>.
     *
     * @param reciprocalCode the reciprocalCode to set
     */
    public void setReciprocalCode(String reciprocalCode) {
        this.reciprocalCode = reciprocalCode;
    }

    /**
     * Gets the value of the field <code>procurementCode</code>.
     *
     * @return the procurementCode
     */
    public String getProcurementCode() {
        return procurementCode;
    }

    /**
     * Sets the value of the field <code>procurementCode</code>.
     *
     * @param procurementCode the procurementCode to set
     */
    public void setProcurementCode(String procurementCode) {
        this.procurementCode = procurementCode;
    }

    /**
     * Gets the value of the field <code>agency</code>.
     *
     * @return the agency
     */
    public String getAgency() {
        return agency;
    }

    /**
     * Sets the value of the field <code>agency</code>.
     *
     * @param agency the agency to set
     */
    public void setAgency(String agency) {
        this.agency = agency;
    }

    /**
     * Gets the value of the field <code>duns</code>.
     *
     * @return the duns
     */
    public long getDuns() {
        return duns;
    }

    /**
     * Sets the value of the field <code>duns</code>.
     *
     * @param duns the duns to set
     */
    public void setDuns(long duns) {
        this.duns = duns;
    }

    /**
     * Gets the value of the field <code>cageCode</code>.
     *
     * @return the cageCode
     */
    public String getCageCode() {
        return cageCode;
    }

    /**
     * Sets the value of the field <code>cageCode</code>.
     *
     * @param cageCode the cageCode to set
     */
    public void setCageCode(String cageCode) {
        this.cageCode = cageCode;
    }

    /**
     * Gets the value of the field <code>dba</code>.
     *
     * @return the dba
     */
    public String getDba() {
        return dba;
    }

    /**
     * Sets the value of the field <code>dba</code>.
     *
     * @param dba the dba to set
     */
    public void setDba(String dba) {
        this.dba = dba;
    }

    /**
     * Gets the value of the field <code>sex</code>.
     *
     * @return the sex
     */
    public Sex getSex() {
        return sex;
    }

    /**
     * Sets the value of the field <code>sex</code>.
     *
     * @param sex the sex to set
     */
    public void setSex(Sex sex) {
        this.sex = sex;
    }

    /**
     * Gets the value of the field <code>user</code>.
     *
     * @return the user
     */
    public User getUser() {
        return user;
    }

    /**
     * Sets the value of the field <code>user</code>.
     *
     * @param user the user to set
     */
    public void setUser(User user) {
        this.user = user;
    }

    /**
     * Gets the value of the field <code>exclusionType</code>.
     *
     * @return the exclusionType
     */
    public ExclusionType getExclusionType() {
        return exclusionType;
    }

    /**
     * Sets the value of the field <code>exclusionType</code>.
     *
     * @param exclusionType the exclusionType to set
     */
    public void setExclusionType(ExclusionType exclusionType) {
        this.exclusionType = exclusionType;
    }

    /**
     * Gets the value of the field <code>business</code>.
     *
     * @return the business
     */
    public Business getBusiness() {
        return business;
    }

    /**
     * Sets the value of the field <code>business</code>.
     *
     * @param business the business to set
     */
    public void setBusiness(Business business) {
        this.business = business;
    }

    /**
     * Gets the value of the field <code>references</code>.
     *
     * @return the references
     */
    public List<Reference> getReferences() {
        return references;
    }

    /**
     * Sets the value of the field <code>references</code>.
     *
     * @param references the references to set
     */
    public void setReferences(List<Reference> references) {
        this.references = references;
    }

    /**
     * Gets the value of the field <code>actions</code>.
     *
     * @return the actions
     */
    public List<Action> getActions() {
        return actions;
    }

    /**
     * Sets the value of the field <code>actions</code>.
     *
     * @param actions the actions to set
     */
    public void setActions(List<Action> actions) {
        this.actions = actions;
    }

    /**
     * Gets the value of the field <code>agencyIdentifiers</code>.
     *
     * @return the agencyIdentifiers
     */
    public List<AgencyIdentifier> getAgencyIdentifiers() {
        return agencyIdentifiers;
    }

    /**
     * Sets the value of the field <code>agencyIdentifiers</code>.
     *
     * @param agencyIdentifiers the agencyIdentifiers to set
     */
    public void setAgencyIdentifiers(List<AgencyIdentifier> agencyIdentifiers) {
        this.agencyIdentifiers = agencyIdentifiers;
    }

    /**
     * Gets the value of the field <code>addresses</code>.
     *
     * @return the addresses
     */
    public List<Address> getAddresses() {
        return addresses;
    }

    /**
     * Sets the value of the field <code>addresses</code>.
     *
     * @param addresses the addresses to set
     */
    public void setAddresses(List<Address> addresses) {
        this.addresses = addresses;
    }

    /**
     * Gets the value of the field <code>stateClassifications</code>.
     * @return the stateClassifications
     */
    public String getStateClassifications() {
        return stateClassifications;
    }

    /**
     * Sets the value of the field <code>stateClassifications</code>.
     * @param stateClassifications the stateClassifications to set
     */
    public void setStateClassifications(String stateClassifications) {
        this.stateClassifications = stateClassifications;
    }

    /**
     * Gets the value of the field <code>federalClassifications</code>.
     * @return the federalClassifications
     */
    public String getFederalClassifications() {
        return federalClassifications;
    }

    /**
     * Sets the value of the field <code>federalClassifications</code>.
     * @param federalClassifications the federalClassifications to set
     */
    public void setFederalClassifications(String federalClassifications) {
        this.federalClassifications = federalClassifications;
    }

}
