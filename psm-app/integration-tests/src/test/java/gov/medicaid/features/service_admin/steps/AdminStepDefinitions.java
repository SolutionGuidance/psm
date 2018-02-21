package gov.medicaid.features.service_admin.steps;

import cucumber.api.java.en.Given;
import cucumber.api.java.en.When;
import gov.medicaid.features.general.steps.GeneralSteps;
import net.thucydides.core.annotations.Steps;

@SuppressWarnings("unused")
public class AdminStepDefinitions {
    @Steps
    GeneralSteps generalSteps;

    @Steps
    AdminSteps adminSteps;

    @Given("^I am logged in as an admin$")
    public void i_am_logged_in_as_an_admin() {
        generalSteps.login("admin", "admin");
    }

    @When("^I open the Write Note modal$")
    public void i_open_the_write_note_modal() {
        adminSteps.openWriteNoteModal();
    }

    @When("^I am on the COS page$")
    public void i_am_on_the_cos_page() {
        generalSteps.navigateToDraftPage();
        generalSteps.clickLinkAssertTitle(".cosLink", "Category of Service");
    }

    @When("^I am on the Print Enrollment page$")
    public void i_am_on_the_print_enrollment_page() {
        generalSteps.navigateToDraftPage();
        // assert fails because print page is opened in a new window
        generalSteps.clickLinkAssertTitle(".printEnrollment", "View Enrollment");
    }

    @When("^I am on the Review Enrollment page$")
    public void i_am_on_the_review_enrollment_page() {
        generalSteps.navigateToPendingPage();
        generalSteps.clickLinkAssertTitle(".reviewLink", "Review Enrollment");
    }

    @When("^I am on the Screening Log page$")
    public void i_am_on_the_screening_log_page() {
        i_am_on_the_review_enrollment_page();
        // assert fails because the page is opened in a separate tab
        generalSteps.clickLinkAssertTitle(".autoScreeningResultLink", "Screening Log");
    }

    @When("^I am on the View Enrollment Organization Info page$")
    public void i_am_on_the_view_enrollment_organization_info_page() {
        generalSteps.navigateToPendingPage();
        adminSteps.advanceFromPendingPageToViewOrganizationInfoPage();
    }

    @When("^I am on the View Enrollment Facility Credentials page$")
    public void i_am_on_the_view_enrollment_facility_credentials_page() {
        i_am_on_the_view_enrollment_organization_info_page();
        generalSteps.clickLinkAssertTitle(".license", "Facility Credentials");
    }

    @When("^I am on the View Enrollment Individual Member Info page$")
    public void i_am_on_the_view_enrollment_individual_member_info_page() {
        i_am_on_the_view_enrollment_organization_info_page();
        generalSteps.clickLinkAssertTitle(".practice", "Member Information");
    }
}
