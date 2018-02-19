package gov.medicaid.features.enrollment.steps;

import cucumber.api.java.en.Given;
import cucumber.api.java.en.When;
import gov.medicaid.features.general.steps.GeneralSteps;
import net.thucydides.core.annotations.Steps;

import java.io.IOException;

@SuppressWarnings("unused")
public class IndividualEnrollmentStepDefinitions {
    @Steps
    EnrollmentSteps enrollmentSteps;

    @Steps
    GeneralSteps generalSteps;

    @When("^I move to the personal info page$")
    public void i_move_to_the_personal_info_page() {
        enrollmentSteps.selectIndividualProviderType();
    }

    @Given("I am on the individual provider license info page")
    public void enter_individual_provider_license_info_page() {
        navigateToIndividualProviderLicensePage();
    }

    private void navigateToIndividualProviderLicensePage() {
        generalSteps.loginAsProvider();
        enrollmentSteps.createEnrollment();
        enrollmentSteps.selectIndividualProviderType();
        enrollmentSteps.enterIndividualPersonalInfo();
        enrollmentSteps.advanceFromIndividualPersonalInfoToLicenseInfo();
        enrollmentSteps.enterNotAProviderAtPublicHealthServiceIndianHospital();
    }

    @Given("^I am on the individual provider practice info page$")
    public void enter_individual_provider_practice_info_page() throws IOException {
        navigateToProviderPracticePage();
    }

    private void navigateToProviderPracticePage() throws IOException {
        navigateToIndividualProviderLicensePage();
        enrollmentSteps.enterNotAProviderAtPublicHealthServiceIndianHospital();
        enrollmentSteps.enterLicenseInfo();
        enrollmentSteps.uploadLicense();
        enrollmentSteps.advanceFromIndividualLicenseInfoToPracticeInfo();
    }

    @Given("^I am on the individual provider statement page$")
    public void enter_individual_provider_statement_page() throws IOException {
        navigateToProviderPracticePage();
        enrollmentSteps.enterIndividualPrivatePracticeInfo();
        enrollmentSteps.advanceFromIndividualPracticeInfoToSummaryPage();
        enrollmentSteps.advanceFromIndividualSummaryToProviderStatementPage();
    }
}
