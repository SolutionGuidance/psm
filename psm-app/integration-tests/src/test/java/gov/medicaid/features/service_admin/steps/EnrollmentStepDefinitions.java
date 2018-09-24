package gov.medicaid.features.service_admin.steps;

import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;

import net.thucydides.core.annotations.Steps;

public class EnrollmentStepDefinitions {
    @Steps
    EnrollmentSteps enrollmentSteps;

    @Given("^I am on the Review Enrollment Page for '(\\d+)'$")
    public void i_am_on_the_review_enrollment_page_for(String npi) {
        enrollmentSteps.navigateToReviewPageFor(npi);
    }

    @Given("^I Approve the Enrollment$")
    public void i_approve_the_enrollment() {
        enrollmentSteps.approveEnrollment();
    }

    @Given("^I Reject the Enrollment$")
    public void i_reject_the_enrollment() {
        enrollmentSteps.rejectEnrollment();
    }

    @When("^I view the Reviewed Enrollment$")
    public void i_view_the_reviewed_enrollment() {
        enrollmentSteps.navigateToMostRecentEnrollment();
    }

    @Then("^The Enrollment should be in the '(.+)' state$")
    public void the_enrollment_should_be_in_the_state(String state) throws Exception {
        enrollmentSteps.verifyState(state);
    }
}