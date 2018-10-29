/*
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

package gov.medicaid.features.application.steps;

import gov.medicaid.features.application.ui.ApplicationDetailsPage;
import gov.medicaid.features.application.ui.ApplicationListPage;
import gov.medicaid.features.application.ui.ApplicationPage;
import gov.medicaid.features.application.ui.CcmhrCredentialsPage;
import gov.medicaid.features.application.ui.CtccCredentialsPage;
import gov.medicaid.features.application.ui.IndividualInfoPage;
import gov.medicaid.features.application.ui.IndividualSummaryPage;
import gov.medicaid.features.application.ui.LicenseInfoPage;
import gov.medicaid.features.application.ui.OrganizationInfoPage;
import gov.medicaid.features.application.ui.OrganizationSummaryPage;
import gov.medicaid.features.application.ui.OwnershipInfoPage;
import gov.medicaid.features.application.ui.PersonalCareAssistantAgencyInfoPage;
import gov.medicaid.features.application.ui.PersonalCareAssistantPersonalInfoPage;
import gov.medicaid.features.application.ui.PersonalInfoPage;
import gov.medicaid.features.application.ui.PracticeInfoPage;
import gov.medicaid.features.application.ui.ProviderStatementPage;
import gov.medicaid.features.application.ui.SelectProviderTypePage;
import gov.medicaid.features.general.ui.AllApplicationsPage;
import gov.medicaid.features.general.ui.LoginPage;

import net.thucydides.core.annotations.Step;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;

import static org.assertj.core.api.Assertions.assertThat;

@SuppressWarnings("unused")
public class ApplicationSteps {
    private static final String FIRST_NAME = "FirstName";
    private static final String MIDDLE_NAME = "MiddleName";
    private static final String LAST_NAME = "LastName";
    private static final String SSN = "000-00-0000";
    private static final LocalDate DATE_OF_BIRTH =
            LocalDate.of(1970, 1, 1);
    private static final String EMAIL = "p1@example.com";

    private static String licenseType;
    private static final String LICENSE_NUMBER = "1";
    private static final LocalDate LICENSE_ISSUE_DATE =
            LocalDate.now().minusWeeks(30);
    private static final LocalDate BEFORE_LICENSE_ISSUE_DATE =
            LICENSE_ISSUE_DATE.minusDays(1);
    private static final LocalDate LICENSE_RENEWAL_DATE =
            LocalDate.now().plusWeeks(30);
    private static final String LICENSE_ISSUING_STATE_FULL = "Minnesota";
    private static final String LICENSE_ISSUING_STATE_ABBR = "MN";

    private static final String PRIVATE_PRACTICE_NAME = "My Private Practice";
    private static final String PRACTICE_GROUP_NPI = "1111111112";
    private static final LocalDate PRACTICE_EFFECTIVE_DATE =
            LocalDate.of(2000, 1, 1);
    private static final String PRACTICE_ADDRESS_1 = "1234 Main St";
    private static final String PRACTICE_ADDRESS_2 = "Suite 56";
    private static final String PRACTICE_CITY = "Springfield";
    private static final String PRACTICE_STATE_FULL = "Illinois";
    private static final String PRACTICE_STATE_ABBR = "IL";
    private static final String PRACTICE_ZIP = "12345-6789";
    private static final String PRACTICE_PHONE = "444-555-6666";
    private static final String PRACTICE_FEIN = "12-3456789";
    private static final String PRACTICE_STATE_TAX_ID = "1234567";
    private static final String PRACTICE_YEAR_END = "12/31";

    private static final String RESIDENTIAL_ADDRESS =
            "456 N. Main Street";
    private static final String RESIDENTIAL_CITY = "Duluth";
    private static final String RESIDENTIAL_STATE_FULL = "Minnesota";
    private static final String RESIDENTIAL_ZIP = "55802";
    private static final String RESIDENTIAL_COUNTY = "St. Louis";

    private LoginPage loginPage;
    private ApplicationListPage applicationListPage;
    private AllApplicationsPage allApplicationsPage;
    private ApplicationPage applicationPage;
    private SelectProviderTypePage selectProviderTypePage;
    private OrganizationInfoPage organizationInfoPage;
    private IndividualInfoPage individualInfoPage;
    private PersonalCareAssistantPersonalInfoPage personCareAssistantPersonalInfoPage;
    private PersonalCareAssistantAgencyInfoPage personCareAssistantAgencyInfoPage;
    private PersonalInfoPage personalInfoPage;
    private LicenseInfoPage licenseInfoPage;
    private PracticeInfoPage practiceInfoPage;
    private OwnershipInfoPage ownershipInfoPage;
    private IndividualSummaryPage individualSummaryPage;
    private OrganizationSummaryPage organizationSummaryPage;
    private ProviderStatementPage providerStatementPage;
    private ApplicationDetailsPage applicationDetailsPage;
    private CtccCredentialsPage ctccCredentialsPage;
    private CcmhrCredentialsPage ccmhrCredentialsPage;

    private SimpleDateFormat formFieldDateFormat = new SimpleDateFormat("MMddyyyy");

    private String providerType;
    private String npi = "0000000006";

    public void setNpi(String npi) {
        this.npi = npi;
    }

    public void createApplication() {
        allApplicationsPage.clickOnNewApplication();
    }

    public void prepareSpeechLanguagePathologistApplication() {
        licenseType = "Speech Language Pathologist";
        providerType = "Speech Language Pathologist";
    }

    public void preparePersonalCareAssistantApplication() {
        providerType = "Personal Care Assistant";
        licenseType = "Personal Care Assistant";
    }

    public void prepareDurableMedicalEquipment() {
        providerType = "Durable Medical Equipment";
    }

    public void prepareChildTeenCheckupClinic() {
        providerType = "Child And Teen Checkup Clinic";
    }

    public void prepareCountyContractedMentalHealthRehab() {
        providerType = "County Contracted Mental Health Rehab";
    }

    public void prepareHeadStart() {
        npi = "1234567893";
        providerType = "Head Start";
        licenseType = "Head Start Agency Certification";
    }

    public void selectProviderType() {
        selectProviderTypePage.selectProviderType(providerType);
        selectProviderTypePage.clickNext();
    }

    @Step
    void enterIndividualPersonalInfo() {
        personalInfoPage.enterFirstName(FIRST_NAME);
        personalInfoPage.enterMiddleName(MIDDLE_NAME);
        personalInfoPage.enterLastName(LAST_NAME);
        personalInfoPage.enterNPI(npi);
        personalInfoPage.enterSSN(SSN);
        personalInfoPage.enterDOB(DATE_OF_BIRTH);
        personalInfoPage.enterEmail(EMAIL);
        personalInfoPage.checkSameAsAbove();
    }

    @Step
    void enterPersonCareAssistantIndividualPersonalInfo() {
        personCareAssistantPersonalInfoPage.enterFirstName(FIRST_NAME);
        personCareAssistantPersonalInfoPage.enterMiddleName(MIDDLE_NAME);
        personCareAssistantPersonalInfoPage.enterLastName(LAST_NAME);
        personCareAssistantPersonalInfoPage.
                enterResidentialAddress(RESIDENTIAL_ADDRESS);
        personCareAssistantPersonalInfoPage.enterCity(RESIDENTIAL_CITY);
        personCareAssistantPersonalInfoPage.selectState(RESIDENTIAL_STATE_FULL);
        personCareAssistantPersonalInfoPage.setZipcode(RESIDENTIAL_ZIP);
        personCareAssistantPersonalInfoPage.selectCounty(RESIDENTIAL_COUNTY);
        personCareAssistantPersonalInfoPage.enterSSN(SSN);
        personCareAssistantPersonalInfoPage.enterDOB(DATE_OF_BIRTH);
        personCareAssistantPersonalInfoPage.selectEighteenOrOlder();
        personCareAssistantPersonalInfoPage.clickNext();
    }

    @Step
    void enterPersonCareAssistantAgencyInfo() {
        personCareAssistantAgencyInfoPage.enterAgencyName("Test Agency");
        personCareAssistantAgencyInfoPage.enterAgencyId(MIDDLE_NAME);
        personCareAssistantAgencyInfoPage.enterAgencyNpi("1111111112");
        personCareAssistantAgencyInfoPage.enterFaxNumber("123", "456", "7890");
        personCareAssistantAgencyInfoPage.enterAgencyContactName("Agency Contact Name");
        personCareAssistantAgencyInfoPage.enterBackgroundStudyId("Study Id");
        personCareAssistantAgencyInfoPage.enterClearanceDate(LocalDate.of(2000, 1, 1));
        personCareAssistantAgencyInfoPage.clickNext();
    }

    @Step
    void advanceFromIndividualPersonalInfoToLicenseInfo() {
        personalInfoPage.clickNext();
        assertThat(personalInfoPage.getTitle()).contains("License Information");
    }

    @Step
    void advanceFromOrganizationInfoToLicenseInfo() {
        organizationInfoPage.clickNext();
        assertThat(organizationInfoPage.getTitle()).contains("Facility Credentials");
    }

    @Step
    void advanceFromOrganizationInfoToOwnershipInfo() {
        organizationInfoPage.clickNext();
        assertThat(ownershipInfoPage.getTitle()).contains("Ownership Information");
    }

    @Step
    void clickAddLicense() {
        licenseInfoPage.addLicense();
    }

    public void enterOrganizationInfo() {
        organizationInfoPage.setNPI(npi);
        organizationInfoPage.setEffectiveDate(generateEffectiveDate());
        organizationInfoPage.setDoingBusinessAs("Test DBA");
        organizationInfoPage.setLegalName("Test Name");
        organizationInfoPage.setAddr1("123 Test St");
        organizationInfoPage.setCity("TestCity");
        organizationInfoPage.selectState("Texas");
        organizationInfoPage.setZipcode("77706");
        organizationInfoPage.selectCounty("Beltrami");
        organizationInfoPage.setPhoneNumber("2221113333");
        organizationInfoPage.setFEIN("123456789");
    }

    public void enterContactInfo() {
        organizationInfoPage.setContactName("Test Contact");
        organizationInfoPage.setContactPhone("4445556666");
        organizationInfoPage.setContactEmail("scontact@example.com");
    }

    public String generateEffectiveDate() {
        GregorianCalendar cal = new GregorianCalendar();
        cal.setTime(new Date());
        cal.add(Calendar.DAY_OF_YEAR, -6);
        String dateStr = formFieldDateFormat.format(cal.getTime());
        return dateStr;
    }

    public void openIndividualMemberPanel() {
        individualInfoPage.enterIndividualMember();
    }

    public void enterIndividualMember() {
        individualInfoPage.enterIndividualMember();
        individualInfoPage.setIndividualOwnerNPI("1234567893");
        individualInfoPage.setIndividualOwnerName("Test Owner");
        individualInfoPage.setIndividualProviderType("Dentist");
        individualInfoPage.setIndividualOwnerSoSec("123456789");
        individualInfoPage.setIndividualOwnerDOB("01011970");
        individualInfoPage.setIndividualHireDate("01012000");
    }

    @Step
    public void checkForTooYoungError() throws Exception {
        personalInfoPage.checkForTooYoungError();
    }

    @Step
    public void checkForRenewalDateError() throws Exception {
        licenseInfoPage.checkForRenewalDateError();
    }

    @Step
    public void checkForFeinError() throws Exception {
        organizationInfoPage.checkForFeinError();
    }

    @Step
    public void inputProviderAtPublicHealthServiceIndianHospital(boolean checkYes) {
        licenseInfoPage.checkProviderAtPublicHealthServiceIndianHospital(checkYes);
    }

    @Step
    public void enterLicenseInfo() {
        licenseInfoPage.addLicense();
        licenseInfoPage.addLicenseType(licenseType);
        licenseInfoPage.enterLicenseNumber(LICENSE_NUMBER);
        licenseInfoPage.enterIssueDate(LICENSE_ISSUE_DATE);
        licenseInfoPage.enterRenewalDate(LICENSE_RENEWAL_DATE);
        licenseInfoPage.enterIssueState(LICENSE_ISSUING_STATE_FULL);
    }

    @Step
    public void checkCommunityHealthboard() throws IOException {
        ctccCredentialsPage.checkCommunityHealthBoard();
        ctccCredentialsPage.uploadSampleFile();
    }

    @Step
    public void enterCcmhrInfo() throws IOException {
        ccmhrCredentialsPage.addCtssCertification(
            LICENSE_ISSUE_DATE,
            LICENSE_RENEWAL_DATE
        );
        ccmhrCredentialsPage.addCrisisStabilizationContract(
            LICENSE_ISSUE_DATE,
            LICENSE_RENEWAL_DATE
        );
    }

    @Step
    public void enterPersonCareAssistantLicenseInfoWithRenewalDate() {
        licenseInfoPage.addLicense();
        licenseInfoPage.enterLicenseNumber(LICENSE_NUMBER);
        licenseInfoPage.enterIssueDate(LICENSE_ISSUE_DATE);
        licenseInfoPage.enterRenewalDate(LICENSE_RENEWAL_DATE);
        licenseInfoPage.enterIssueState(LICENSE_ISSUING_STATE_FULL);
    }

    @Step
    public void enterPersonCareAssistantLicenseInfoWithoutRenewalDate() {
        licenseInfoPage.addLicense();
        licenseInfoPage.enterLicenseNumber(LICENSE_NUMBER);
        licenseInfoPage.enterIssueDate(LICENSE_ISSUE_DATE);
        licenseInfoPage.enterIssueState(LICENSE_ISSUING_STATE_FULL);
    }

    @Step
    public void enterLicenseInfoWithRenewalDateBeforeIssueDate() {
        licenseInfoPage.addLicense();
        licenseInfoPage.addLicenseType(licenseType);
        licenseInfoPage.enterLicenseNumber(LICENSE_NUMBER);
        licenseInfoPage.enterIssueDate(LICENSE_ISSUE_DATE);
        licenseInfoPage.enterRenewalDate(BEFORE_LICENSE_ISSUE_DATE);
        licenseInfoPage.enterIssueState(LICENSE_ISSUING_STATE_FULL);
    }

    @Step
    public void uploadLicense() throws IOException {
        licenseInfoPage.uploadSampleFile();
    }

    @Step
    public void advanceFromIndividualLicenseInfoToPracticeInfo() {
        licenseInfoPage.clickNext();
        assertThat(licenseInfoPage.getTitle()).contains("Practice Information");
    }

    @Step
    public void advanceFromPersonalCareAssistantLicenseInfoToPracticeInfo() {
        licenseInfoPage.clickNext();
        assertThat(licenseInfoPage.getTitle()).contains("Individual Agency Information");
    }

    @Step
    void advanceFromOrganizationLicenseInfoToIndividualMemberInfo() {
        licenseInfoPage.clickNext();
        assertThat(licenseInfoPage.getTitle()).contains("Member Information");
    }

    @Step
    public void indicateMaintainOwnPrivatePractice(boolean isPrivatePractice) {
        practiceInfoPage.checkPrivatePractice(isPrivatePractice);
    }

    @Step
    public void indicateGroupPractice(boolean isGroupPractice) {
        practiceInfoPage.checkGroupPractice(isGroupPractice);
    }

    @Step
    public void clickAddPracticeLocation() {
        practiceInfoPage.clickAddPracticeLocation();
    }

    @Step
    public void openPracticeLookupModal() {
        practiceInfoPage.clickPracticeLookupButton();
    }

    @Step
    void enterIndividualPrivatePracticeInfo() {
        practiceInfoPage.checkPrivatePractice(true);
        practiceInfoPage.checkGroupPractice(false);
        practiceInfoPage.enterPracticeName(PRIVATE_PRACTICE_NAME);
        practiceInfoPage.enterGroupNPI(PRACTICE_GROUP_NPI);
        practiceInfoPage.enterEffectiveDate(PRACTICE_EFFECTIVE_DATE);
        practiceInfoPage.enterPracticeAddress1(PRACTICE_ADDRESS_1);
        practiceInfoPage.enterPracticeAddress2(PRACTICE_ADDRESS_2);
        practiceInfoPage.enterCity(PRACTICE_CITY);
        practiceInfoPage.enterState(PRACTICE_STATE_FULL);
        practiceInfoPage.enterZipCode(PRACTICE_ZIP);
        practiceInfoPage.enterPhoneNumber(PRACTICE_PHONE);
        practiceInfoPage.clickSameAsAbove();
        practiceInfoPage.enterFein(PRACTICE_FEIN);
        practiceInfoPage.enterStateTaxId(PRACTICE_STATE_TAX_ID);
        practiceInfoPage.enterFiscalYearEnd(PRACTICE_YEAR_END);
        practiceInfoPage.checkYesEftAccepted();
        practiceInfoPage.checkFirstRemittanceSequence();
    }

    @Step
    public void enterOrganizationOwnershipInfo() {
        ownershipInfoPage.selectEntityType("Sole Proprietorship");
        ownershipInfoPage.addIndividualOwnership();
        ownershipInfoPage.selectOwnershipType("Managing Employee");
        ownershipInfoPage.setOwnershipFirstName("First");
        ownershipInfoPage.setOwnershipMiddleName("Middle");
        ownershipInfoPage.setOwnershipLastName("Last");
        ownershipInfoPage.setOwnershipSoSec("123456789");
        ownershipInfoPage.setOwnershipAddr1("OwnerAddr1");
        ownershipInfoPage.setOwnershipDOB("01011970");
        ownershipInfoPage.setOwnershipHireDate("01012000");
        ownershipInfoPage.setOwnershipCity("Ownertown");
        ownershipInfoPage.selectOwnershipState("Texas");
        ownershipInfoPage.setOwnershipZip("77706");
        ownershipInfoPage.selectOwnershipCounty("Beltrami");
    }

    @Step
    void advanceFromIndividualPracticeInfoToSummaryPage() {
        practiceInfoPage.clickNext();
        assertThat(individualSummaryPage.getTitle()).contains("Summary Information");
    }

    @Step
    void clickSaveAsDraft() {
        applicationPage.clickSaveAsDraft();
    }

    @Step
    void advanceFromOrganizationIndividualMemberInfoToOwnershipInfo() {
        individualInfoPage.clickNext();
        assertThat(ownershipInfoPage.getTitle()).contains("Ownership Information");
    }

    @Step
    void advanceFromLicenseInfoToOwnershipInfo() {
        licenseInfoPage.clickNext();
        assertThat(ownershipInfoPage.getTitle()).contains("Ownership Information");
    }

    @Step
    void addIndividualOwnership() {
        ownershipInfoPage.addIndividualOwnership();
    }

    @Step
    void addBusinessOwnership() {
        ownershipInfoPage.addBusinessOwnership();
    }

    @Step
    void setNoToAllDisclosures() {
        ownershipInfoPage.setNoToAllDisclosures();
    }

    @Step
    void validatePersonalSummaryInformation() {
        assertThat(individualSummaryPage.getFirstName())
                .isEqualToIgnoringWhitespace(FIRST_NAME);
        assertThat(individualSummaryPage.getMiddleName())
                .isEqualToIgnoringWhitespace(MIDDLE_NAME);
        assertThat(individualSummaryPage.getLastName())
                .isEqualToIgnoringWhitespace(LAST_NAME);
        assertThat(individualSummaryPage.getNPI())
                .isEqualToIgnoringWhitespace(npi);
        assertThat(individualSummaryPage.getSSN())
                .isEqualToIgnoringWhitespace(SSN);
        assertThat(individualSummaryPage.getDOB())
                .isEqualTo(DATE_OF_BIRTH);
        assertThat(individualSummaryPage.getEmail())
                .isEqualToIgnoringWhitespace(EMAIL);
    }

    @Step
    void validateLicenseSummaryInfo() {
        assertThat(individualSummaryPage.isProviderAtPublicHealthServiceIndianHospital())
                .isFalse();
        assertThat(individualSummaryPage.getFirstLicenseType())
                .isEqualToIgnoringWhitespace(licenseType);
        assertThat(individualSummaryPage.getFirstLicenseNumber())
                .isEqualToIgnoringWhitespace(LICENSE_NUMBER);
        assertThat(individualSummaryPage.getFirstLicenseOriginalIssueDate())
                .isEqualTo(LICENSE_ISSUE_DATE);
        assertThat(individualSummaryPage.getFirstLicenseRenewalEndDate())
                .isEqualTo(LICENSE_RENEWAL_DATE);
        assertThat(individualSummaryPage.getFirstLicenseIssuingState())
                .isEqualToIgnoringWhitespace(LICENSE_ISSUING_STATE_ABBR);
    }

    @Step
    void validatePracticeSummaryInformation() {
        assertThat(individualSummaryPage.isPrivatePractice()).isTrue();
        assertThat(individualSummaryPage.isPartOfGroupPractice()).isFalse();
        assertThat(individualSummaryPage.getPrivatePracticeName())
                .isEqualToIgnoringWhitespace(PRIVATE_PRACTICE_NAME);
        assertThat(individualSummaryPage.getGroupNPI())
                .isEqualToIgnoringWhitespace(PRACTICE_GROUP_NPI);
        assertThat(individualSummaryPage.getEffectiveDate())
                .isEqualTo(PRACTICE_EFFECTIVE_DATE);
        assertThat(individualSummaryPage.getPracticeAddressLine1())
                .isEqualToIgnoringWhitespace(PRACTICE_ADDRESS_1);
        assertThat(individualSummaryPage.getPracticeAddressLine2())
                .isEqualToIgnoringWhitespace(PRACTICE_ADDRESS_2);
        assertThat(individualSummaryPage.getPracticeCity())
                .isEqualToIgnoringWhitespace(PRACTICE_CITY);
        assertThat(individualSummaryPage.getPracticeState())
                .isEqualToIgnoringWhitespace(PRACTICE_STATE_ABBR);
        assertThat(individualSummaryPage.getPracticeZip())
                .isEqualToIgnoringWhitespace(PRACTICE_ZIP);
        assertThat(individualSummaryPage.getPracticePhoneNumber())
                .isEqualToIgnoringWhitespace(PRACTICE_PHONE);
        assertThat(individualSummaryPage.isBillingAddressSameAsPracticeAddress())
                .isTrue();
        assertThat(individualSummaryPage.getFein())
                .isEqualToIgnoringWhitespace(PRACTICE_FEIN);
        assertThat(individualSummaryPage.getStateTaxId())
                .isEqualToIgnoringWhitespace(PRACTICE_STATE_TAX_ID);
        assertThat(individualSummaryPage.getFiscalYearEnd())
                .isEqualToIgnoringWhitespace(PRACTICE_YEAR_END);
        assertThat(individualSummaryPage.getEftAccepted())
                .isTrue();
        assertThat(individualSummaryPage.getRemittanceSequence())
                .isEqualToIgnoringWhitespace("Patient Account or Own Reference Number Order");
    }

    @Step
    void advanceFromOrganizationOwnershipInfoToSummaryPage() {
        ownershipInfoPage.clickNext();
        assertThat(organizationSummaryPage.getTitle()).contains("Summary Information");
    }

    @Step
    void advanceFromIndividualSummaryToProviderStatementPage() {
        individualSummaryPage.clickNext();
    }

    @Step
    void advanceFromOrganizationSummaryToProviderStatementPage() {
        organizationSummaryPage.clickNext();
    }

    @Step
    void checkNoOnProviderDisclosureQuestions() {
        providerStatementPage.checkNoCriminalConviction();
        providerStatementPage.checkNoCivilPenalty();
        providerStatementPage.checkNoPreviousExclusion();
    }

    @Step
    void signProviderStatement() {
        providerStatementPage.acceptAllAgreements();
        providerStatementPage.enterProviderName(LAST_NAME);
        providerStatementPage.enterProviderTitle("Title");
    }

    @Step
    void submitApplication() {
        providerStatementPage.clickSubmitButton();
    }

    @Step
    void verifySubmitModal() {
        applicationDetailsPage.verifySubmitModal();
    }

    @Step
    void closeSubmitModal() {
        applicationDetailsPage.closeSubmitModal();
    }

    @Step
    void closeSaveAsDraftModal() {
        applicationDetailsPage.closeSaveAsDraftModal();
    }

    @Step
    void enterEmptyEmailAddress() {
        personalInfoPage.enterEmail("");
    }

    @Step
    void startToRenewIndividualApplication(String npi) {
        applicationListPage.clickActionForNpi(npi, ".renewLink");
        advanceFromIndividualPersonalInfoToLicenseInfo();
        advanceFromIndividualLicenseInfoToPracticeInfo();
        advanceFromIndividualPracticeInfoToSummaryPage();
        advanceFromIndividualSummaryToProviderStatementPage();
    }

    @Step
    void renewIndividualApplication(String npi) {
        startToRenewIndividualApplication(npi);
        checkNoOnProviderDisclosureQuestions();
        signProviderStatement();
        submitApplication();
    }

    @Step
    void startToRenewOrganizationalApplication(String npi) {
        applicationListPage.clickActionForNpi(npi, ".renewLink");
        advanceFromOrganizationInfoToLicenseInfo();
        advanceFromOrganizationLicenseInfoToIndividualMemberInfo();
        advanceFromOrganizationIndividualMemberInfoToOwnershipInfo();
        setNoToAllDisclosures();
        advanceFromOrganizationOwnershipInfoToSummaryPage();
        advanceFromOrganizationSummaryToProviderStatementPage();
    }

    @Step
    void renewOrganizationalApplication(String npi) {
        startToRenewOrganizationalApplication(npi);
        signProviderStatement();
        submitApplication();
    }

    @Step
    void editIndividualApplication(String npi) {
        applicationListPage.clickActionForNpi(npi, ".editLink");
        personalInfoPage.enterFirstName(FIRST_NAME + " Edited");
    }

    @Step
    void editOrganizationalApplication(String npi) {
        applicationListPage.clickActionForNpi(npi, ".editLink");
        organizationInfoPage.setDoingBusinessAs("Test DBA Edited");
    }

    @Step
    void updateIndividualApplication(String npi) {
        editIndividualApplication(npi);
        submitApplication();
    }

    @Step
    void updateOrganizationalApplication(String npi) {
        editOrganizationalApplication(npi);
        submitApplication();
    }

}
