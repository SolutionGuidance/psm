package gov.medicaid.features.enrollment.steps;

import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;
import gov.medicaid.features.enrollment.ui.OrganizationInfoPage;
import net.thucydides.core.annotations.Steps;


@SuppressWarnings("unused")
public class DataCoverageStepDefinitions {
    @Steps
    EnrollmentSteps enrollmentSteps;

    private OrganizationInfoPage organizationInfoPage;

    @When("^I move to the organization page$")
    public void i_move_to_the_organization_page() {
        enrollmentSteps.selectOrganizationalProviderType();
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
}
