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
        enrollmentSteps.enterNotAProviderAtPublicHealthServiceIndianHospital();
    }

    @When("^I am on the individual provider practice info page$")
    public void i_am_on_the_individual_provider_practice_info_page() throws IOException {
        i_am_on_the_individual_provider_license_info_page();
        enrollmentSteps.enterNotAProviderAtPublicHealthServiceIndianHospital();
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
