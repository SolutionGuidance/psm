package gov.medicaid.features.enrollment.steps;

import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;
import gov.medicaid.features.enrollment.ui.OrganizationInfoPage;
import net.thucydides.core.annotations.Steps;

import java.io.IOException;

@SuppressWarnings("unused")
public class DataCoverageStepDefinitions {
    @Steps
    EnrollmentSteps enrollmentSteps;

    private OrganizationInfoPage organizationInfoPage;

    @Given("I am on the individual provider license info page")
    public void enter_individual_provider_license_info_page() {
        navigateToLicensePage();
    }

    private void navigateToLicensePage() {
        enrollmentSteps.loginAsProvider();
        enrollmentSteps.createEnrollment();
        enrollmentSteps.selectIndividualProviderType();
        enrollmentSteps.enterIndividualPersonalInfo();
        enrollmentSteps.advanceFromIndividualPersonalInfoToLicenseInfo();
    }

    @Given("^I am on the individual provider practice info page$")
    public void enter_individual_provider_practice_info_page() throws IOException {
        navigateToLicensePage();
        enrollmentSteps.enterNotAProviderAtPublicHealthServiceIndianHospital();
        enrollmentSteps.enterIndividualLicenseInfo();
        enrollmentSteps.uploadLicense();
        enrollmentSteps.advanceFromIndividualLicenseInfoToPracticeInfo();
    }

    @When("^I enter valid license information$")
    public void enter_valid_license_information() {
        enrollmentSteps.enterNotAProviderAtPublicHealthServiceIndianHospital();
        enrollmentSteps.enterIndividualLicenseInfo();
    }

    @When("^I upload a valid license$")
    public void upload_valid_license() throws IOException {
        enrollmentSteps.uploadLicense();
    }

    @When("^I move to the organization page$")
    public void i_move_to_the_organization_page() {
        enrollmentSteps.selectOrganizationalProviderType();
    }

    @When("^I enter a valid private practice$")
    public void enter_valid_private_practice_information() {
        enrollmentSteps.enterIndividualPrivatePracticeInfo();
    }

    @Then("^I should be asked to enter Applicant Name, Contact Person, Contact phone$")
    public void i_should_be_asked_to_enter_Applicant_Name_Contact_Person_Contact_phone() {
        organizationInfoPage.verifyApplicantNameAccepted();
        organizationInfoPage.verifyContactNameAccepted();
        organizationInfoPage.verifyContactPhoneAccepted();
    }

    @Then("^I should be asked to enter Medicaid number$")
    public void i_should_be_asked_to_enter_Medicaid() {
        organizationInfoPage.verifyMedicaidNumberAccepted();
    }

    @When("^I move to the personal info page$")
    public void i_move_to_the_personal_info_page() {
        enrollmentSteps.selectIndividualProviderType();
    }

    @Then("^I should be asked to enter Applicant Name, Contact Person$")
    public void i_should_be_asked_to_enter_Applicant_Name_Contact_Person() {
        organizationInfoPage.verifyApplicantNameAccepted();
        organizationInfoPage.verifyContactNameAccepted();
    }

    @Then("^I should be asked to enter Contact phone, Medicaid number$")
    public void i_should_be_asked_to_enter_Contact_phone_Medicaid_number() {
        organizationInfoPage.verifyContactPhoneAccepted();
        organizationInfoPage.verifyMedicaidNumberAccepted();
    }

    @Then("^the license is accepted$")
    public void license_is_accepted() {
        enrollmentSteps.advanceFromIndividualLicenseInfoToPracticeInfo();
    }

    @Then("^the practice information is accepted$")
    public void practice_information_is_accepted() {
        enrollmentSteps.advanceFromIndividualPracticeInfoToSummaryPage();
    }

    @Then("^the summary page shows expected information$")
    public void summary_information_is_correct() {
        enrollmentSteps.validatePersonalSummaryInformation();
        enrollmentSteps.validateLicenseSummaryInfo();
        enrollmentSteps.validatePracticeSummaryInformation();
    }
}
