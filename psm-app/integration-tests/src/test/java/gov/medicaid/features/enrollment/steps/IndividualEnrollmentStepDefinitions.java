package gov.medicaid.features.enrollment.steps;

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

    @When("^I am on the personal info page$")
    public void i_am_on_the_personal_info_page() {
        enrollmentSteps.selectIndividualProviderType();
    }

    @When("I am on the individual provider license info page")
    public void i_am_on_the_individual_provider_license_info_page() {
        i_am_on_the_personal_info_page();
        enrollmentSteps.enterIndividualPersonalInfo();
        enrollmentSteps.advanceFromIndividualPersonalInfoToLicenseInfo();
    }

    @When("^I indicate I am a provider at a Public Health Service Indian Hospital$")
    public void i_indicate_i_am_a_provider_at_a_public_health_service_indian_hospital() {
        enrollmentSteps.inputProviderAtPublicHealthServiceIndianHospital(true);
    }

    @When("^I indicate I am not a provider at a Public Health Service Indian Hospital$")
    public void i_indicate_i_am_not_a_provider_at_a_public_health_service_indian_hospital() {
        enrollmentSteps.inputProviderAtPublicHealthServiceIndianHospital(false);
    }

    @When("^I am on the individual provider practice info page$")
    public void i_am_on_the_individual_provider_practice_info_page() throws IOException {
        i_am_on_the_individual_provider_license_info_page();
        i_indicate_i_am_not_a_provider_at_a_public_health_service_indian_hospital();
        enrollmentSteps.enterLicenseInfo();
        enrollmentSteps.uploadLicense();
        enrollmentSteps.advanceFromIndividualLicenseInfoToPracticeInfo();
    }

    @When("^I am on the individual provider statement page$")
    public void i_am_on_the_individual_provider_statement_page() throws IOException {
        i_am_on_the_individual_provider_practice_info_page();
        enrollmentSteps.enterIndividualPrivatePracticeInfo();
        enrollmentSteps.advanceFromIndividualPracticeInfoToSummaryPage();
        enrollmentSteps.advanceFromIndividualSummaryToProviderStatementPage();
    }
}
