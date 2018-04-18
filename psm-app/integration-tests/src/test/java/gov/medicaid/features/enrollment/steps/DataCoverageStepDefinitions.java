package gov.medicaid.features.enrollment.steps;

import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;
import gov.medicaid.features.enrollment.ui.OrganizationInfoPage;
import gov.medicaid.features.general.steps.GeneralSteps;
import net.thucydides.core.annotations.Steps;

import java.io.IOException;

@SuppressWarnings("unused")
public class DataCoverageStepDefinitions {
    @Steps
    EnrollmentSteps enrollmentSteps;

    @Steps
    GeneralSteps generalSteps;

    private OrganizationInfoPage organizationInfoPage;

    @When("^I enter valid license information$")
    public void enter_valid_license_information() {
        enrollmentSteps.enterLicenseInfo();
    }

    @When("^I enter license info where renewal date is before issue date$")
    public void enter_license_info_where_renewal_date_is_before_issue_date() {
        enrollmentSteps.enterLicenseInfoWithRenewalDateBeforeIssueDate();
    }

    @When("^I upload a valid license$")
    public void upload_valid_license() throws IOException {
        enrollmentSteps.uploadLicense();
    }

    @When("^I enter a valid private practice$")
    public void enter_valid_private_practice_information() {
        enrollmentSteps.enterIndividualPrivatePracticeInfo();
    }

    @Then("^I should be asked to enter Applicant Name, Contact Person, Contact phone$")
    public void i_should_be_asked_to_enter_Applicant_Name_Contact_Person_Contact_phone_Contact_email() {
        organizationInfoPage.verifyApplicantNameAccepted();
        organizationInfoPage.verifyContactNameAccepted();
        organizationInfoPage.verifyContactPhoneAccepted();
        organizationInfoPage.verifyContactEmailAccepted();
    }

    @Then("^I should be asked to enter Medicaid number$")
    public void i_should_be_asked_to_enter_Medicaid() {
        organizationInfoPage.verifyMedicaidNumberAccepted();
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

    @Then("^the enrollment is successfully submitted$")
    public void enrollment_is_successfully_submitted() {
        enrollmentSteps.verifySubmitModal();
        enrollmentSteps.closeSubmitModal();
    }
}
