package gov.medicaid.features.service_admin.steps;

import cucumber.api.java.en.When;
import gov.medicaid.features.general.steps.GeneralSteps;
import net.thucydides.core.annotations.Steps;

@SuppressWarnings("unused")
public class ViewEnrollmentStepDefinitions {
    @Steps
    GeneralSteps generalSteps;

    @Steps
    AdminSteps adminSteps;

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

    @When("^I am on the View Enrollment Ownership Info page$")
    public void i_am_on_the_view_enrollment_ownership_info_page() {
        i_am_on_the_view_enrollment_organization_info_page();
        generalSteps.clickLinkAssertTitle(".ownership", "Ownership Information");
    }

    @When("^I am on the View Enrollment Provider Statement page$")
    public void i_am_on_the_view_enrollment_provider_statement_page() {
        i_am_on_the_view_enrollment_organization_info_page();
        generalSteps.clickLinkAssertTitle(".provider", "Provider Statement");
    }
}
