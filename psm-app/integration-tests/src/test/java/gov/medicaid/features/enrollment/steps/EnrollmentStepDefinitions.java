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
        enrollmentSteps.createEnrollment();
    }

    @When("^I am on the organization page$")
    public void i_am_on_the_organization_page() {
        enrollmentSteps.selectOrganizationalProviderType();
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
}
