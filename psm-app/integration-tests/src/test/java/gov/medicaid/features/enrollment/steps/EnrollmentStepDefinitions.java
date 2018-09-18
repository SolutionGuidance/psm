package gov.medicaid.features.enrollment.steps;

import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;
import gov.medicaid.features.enrollment.ui.EnrollmentPage;
import gov.medicaid.features.enrollment.ui.LicenseInfoPage;
import gov.medicaid.features.enrollment.ui.OwnershipInfoPage;
import gov.medicaid.features.general.steps.GeneralSteps;
import net.thucydides.core.annotations.Steps;

import java.io.IOException;

import static org.assertj.core.api.Assertions.assertThat;

@SuppressWarnings("unused")
public class EnrollmentStepDefinitions {
    @Steps
    EnrollmentSteps enrollmentSteps;
    @Steps
    GeneralSteps generalSteps;

    private EnrollmentPage enrollmentPage;
    private OwnershipInfoPage ownershipInfoPage;
    private LicenseInfoPage licenseInfoPage;

    @Given("^I have started an enrollment$")
    public void i_have_started_an_enrollment() {
        generalSteps.login("p1", "p1");
        enrollmentSteps.prepareSpeechLanguagePathologistEnrollment();
        enrollmentSteps.createEnrollment();
    }

    @When("^I am on the organization page$")
    public void i_am_on_the_organization_page() {
        enrollmentSteps.prepareHeadStart();
        enrollmentSteps.selectProviderType();
    }

    @When("^I am on the facility credentials page$")
    public void i_am_on_the_facility_credentials_page() {
        i_am_on_the_organization_page();
        enrollmentSteps.enterOrganizationInfo();
        enrollmentSteps.enterContactInfo();
        enrollmentSteps.advanceFromOrganizationInfoToLicenseInfo();
    }

    @When("^I open an add a license panel$")
    public void i_open_an_add_a_license_panel() {
        enrollmentSteps.clickAddLicense();
    }

    @When("^I am on the individual member info page$")
    public void i_am_on_the_individual_member_info_page() throws IOException {
        i_am_on_the_facility_credentials_page();
        enrollmentSteps.enterLicenseInfo();
        enrollmentSteps.uploadLicense();
        enrollmentSteps.advanceFromOrganizationLicenseInfoToIndividualMemberInfo();
    }

    @When("^I open an individual member panel")
    public void i_open_an_individual_member_panel() {
        enrollmentSteps.openIndividualMemberPanel();
    }

    @When("^I am on the ownership info page$")
    public void i_am_on_the_ownership_info_page() throws IOException {
        i_am_on_the_individual_member_info_page();
        enrollmentSteps.enterIndividualMember();
        enrollmentSteps.advanceFromOrganizationIndividualMemberInfoToOwnershipInfo();
    }

    @When("^I open the individual owner panel$")
    public void i_open_the_individual_owner_panels() {
        enrollmentSteps.addIndividualOwnership();
    }

    @When("^I open the business owner panel$")
    public void i_open_the_business_owner_panel() {
        enrollmentSteps.addBusinessOwnership();
    }

    @When("^I am on the organization summary page$")
    public void i_am_on_the_organization_summary_page() throws IOException {
        i_am_on_the_ownership_info_page();
        enrollmentSteps.enterOrganizationOwnershipInfo();
        enrollmentSteps.setNoToAllDisclosures();
        enrollmentSteps.advanceFromOrganizationOwnershipInfoToSummaryPage();
    }

    @When("^I save as draft$")
    public void i_save_as_draft() {
        enrollmentSteps.clickSaveAsDraft();
    }

    @When("^I am on the organization provider statement page$")
    public void i_am_on_the_organization_provider_statement_page() throws IOException {
        i_am_on_the_organization_summary_page();
        enrollmentSteps.advanceFromOrganizationSummaryToProviderStatementPage();
    }

    @When("^I enter my individual provider statement$")
    public void i_enter_my_provider_statement() {
        enrollmentSteps.checkNoOnProviderDisclosureQuestions();
        enrollmentSteps.signProviderStatement();
    }

    @When("^I enter my organization provider statement$")
    public void i_enter_my_organization_provider_statement() {
        enrollmentSteps.signProviderStatement();
    }

    @When("^I submit the enrollment$")
    public void i_submit_the_enrollment() {
        enrollmentSteps.submitEnrollment();
    }

    @When("^I am entering ownership information$")
    public void i_am_entering_ownership_information() throws IOException {
        i_am_on_the_ownership_info_page();
        enrollmentSteps.enterOrganizationOwnershipInfo();
    }

    @Given("^I have indicated that the owner has an interest in another Medicaid disclosing entity$")
    public void i_have_indicated_that_the_owner_has_an_interest_in_another_Medicaid_disclosing_entity() {
        ownershipInfoPage.clickDisclosure();
    }

    @Given("^I have entered a city for that other entity$")
    public void i_have_entered_a_city_for_that_other_entity() {
        ownershipInfoPage.setControlOwnershipOtherLegalName("My Other Name");
        ownershipInfoPage.setControlOwnershipPctInterest(12.5);
        ownershipInfoPage.setControlOwnershipAddr1("333 Test Ln");
        ownershipInfoPage.setControlOwnershipCity("Check This City");
        ownershipInfoPage.setControlOwnershipZip("77707");
        ownershipInfoPage.selectControlOwnershipState("Texas");
        ownershipInfoPage.selectControlOwnershipCounty("Becker");
    }

    @When("^I click 'next' on the Ownership Info Page$")
    public void i_click_next_on_the_Ownership_Info_Page() {
        ownershipInfoPage.setNoToAllDisclosures();
        ownershipInfoPage.clickNext();
    }

    @When("^I click 'next' on the license info page$")
    public void i_click_next_on_the_license_info_page() {
        licenseInfoPage.clickNext();
    }

    @Then("^the city should be accepted$")
    public void the_city_should_be_accepted() {
        assertThat(enrollmentPage.getTitle()).isEqualTo("Summary Information");
    }

    @When("^I enter valid personal information$")
    public void enter_valid_personal_information() {
        enrollmentSteps.enterIndividualPersonalInfo();
    }

    @Then("^I can move on from the personal info page with no errors$")
    public void i_will_move_on_from_the_personal_info_page_with_no_errors() {
        enrollmentSteps.advanceFromIndividualPersonalInfoToLicenseInfo();
    }

    @When("^I renew Individual Enrollment '(.+)'$")
    public void i_renew_individual_enrollment(String npi) {
        enrollmentSteps.renewIndividualEnrollment(npi);
    }

    @When("^I renew Organizational Enrollment '(.+)'$")
    public void i_renew_organizational_enrollment(String npi) {
        enrollmentSteps.renewOrganizationalEnrollment(npi);
    }

    @When("^I update Individual Enrollment '(.+)'$")
    public void i_update_individual_enrollment(String npi) {
        enrollmentSteps.updateIndividualEnrollment(npi);
    }

    @When("^I update Organizational Enrollment '(.+)'$")
    public void i_update_organizational_enrollment(String npi) {
        enrollmentSteps.updateOrganizationalEnrollment(npi);
    }

    @Given("^I am going to use NPI '(.+)'$")
    public void i_am_going_to_use_npi(String npi) {
        enrollmentSteps.setNpi(npi);
    }

    @Given("^I am going to enroll as a Durable Medical Equipment provider$")
    public void i_am_going_to_enroll_as_a_durable_medical_equipment_provider() {
        enrollmentSteps.prepareDurableMedicalEquipment();
    }

    @Given("^I am going to enroll as a County Contracted Mental Health Rehab$")
    public void i_am_going_to_enroll_as_a_county_contracted_mental_health_rehab() {
        enrollmentSteps.prepareCountyContractedMentalHealthRehab();
    }

    @When("^I create and submit an enrollment using the generic organization workflow$")
    public void i_create_and_submit_an_enrollment_using_the_generic_organization_workflow() throws IOException {
        generalSteps.login("p1", "p1");
        enrollmentSteps.createEnrollment();
        enrollmentSteps.selectProviderType();
        enrollmentSteps.enterOrganizationInfo();
        enrollmentSteps.enterContactInfo();
        enrollmentSteps.advanceFromOrganizationInfoToOwnershipInfo();
        enrollmentSteps.enterOrganizationOwnershipInfo();
        enrollmentSteps.setNoToAllDisclosures();
        enrollmentSteps.advanceFromOrganizationOwnershipInfoToSummaryPage();
        enrollmentSteps.advanceFromOrganizationSummaryToProviderStatementPage();
        enrollmentSteps.signProviderStatement();
        enrollmentSteps.submitEnrollment();
    }

    @Given("^I am going to enroll as a Child and Teen Checkup Clinic")
    public void i_am_going_to_enroll_as_a_child_and_teen_checkup_clinic() {
        enrollmentSteps.prepareChildTeenCheckupClinic();
    }

    @When("^I create and submit an enrollment using the organization with healthboard workflow$")
    public void i_create_and_submit_an_enrollment_using_the_organization_with_healthboard_workflow() throws IOException {
        generalSteps.login("p1", "p1");
        enrollmentSteps.createEnrollment();
        enrollmentSteps.selectProviderType();
        enrollmentSteps.enterOrganizationInfo();
        enrollmentSteps.enterContactInfo();
        enrollmentSteps.advanceFromOrganizationInfoToLicenseInfo();
        enrollmentSteps.checkCommunityHealthboard();
        enrollmentSteps.advanceFromLicenseInfoToOwnershipInfo();
        enrollmentSteps.enterOrganizationOwnershipInfo();
        enrollmentSteps.setNoToAllDisclosures();
        enrollmentSteps.advanceFromOrganizationOwnershipInfoToSummaryPage();
        enrollmentSteps.advanceFromOrganizationSummaryToProviderStatementPage();
        enrollmentSteps.signProviderStatement();
        enrollmentSteps.submitEnrollment();
    }

    @When("^I create and submit an enrollment using the county contracted mental health rehab workflow$")
    public void i_create_and_submit_an_enrollment_using_the_county_contracted_mental_health_rehab_workflow() throws IOException {
        generalSteps.login("p1", "p1");
        enrollmentSteps.createEnrollment();
        enrollmentSteps.selectProviderType();
        enrollmentSteps.enterOrganizationInfo();
        enrollmentSteps.enterContactInfo();
        enrollmentSteps.advanceFromOrganizationInfoToLicenseInfo();
        enrollmentSteps.enterCcmhrInfo();
        enrollmentSteps.advanceFromOrganizationLicenseInfoToIndividualMemberInfo();
        enrollmentSteps.enterIndividualMember();
        enrollmentSteps.advanceFromOrganizationIndividualMemberInfoToOwnershipInfo();
        enrollmentSteps.enterOrganizationOwnershipInfo();
        enrollmentSteps.setNoToAllDisclosures();
        enrollmentSteps.advanceFromOrganizationOwnershipInfoToSummaryPage();
        enrollmentSteps.advanceFromOrganizationSummaryToProviderStatementPage();
        enrollmentSteps.signProviderStatement();
        enrollmentSteps.submitEnrollment();
    }
}
