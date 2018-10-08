package gov.medicaid.features.service_admin.steps;

import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;

import net.thucydides.core.annotations.Steps;

public class ApplicationStepDefinitions {
    @Steps
    ApplicationSteps applicationSteps;

    @Given("^I am on the Review Application Page for '(\\d+)'$")
    public void i_am_on_the_review_application_page_for(String npi) {
        applicationSteps.navigateToReviewPageFor(npi);
    }

    @Given("^I Approve the Application$")
    public void i_approve_the_application() {
        applicationSteps.approveApplication();
    }

    @Given("^I Reject the Application$")
    public void i_reject_the_application() {
        applicationSteps.rejectApplication();
    }

    @When("^I view the Reviewed Application$")
    public void i_view_the_reviewed_application() {
        applicationSteps.navigateToMostRecentApplication();
    }

    @Then("^The Application should be in the '(.+)' state$")
    public void the_application_should_be_in_the_state(String state) throws Exception {
        applicationSteps.verifyState(state);
    }
}
