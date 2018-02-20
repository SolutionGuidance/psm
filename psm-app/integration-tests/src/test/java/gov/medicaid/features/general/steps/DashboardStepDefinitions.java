package gov.medicaid.features.general.steps;

import cucumber.api.java.en.When;
import net.thucydides.core.annotations.Steps;

@SuppressWarnings("unused")
public class DashboardStepDefinitions {
    @Steps
    GeneralSteps generalSteps;

    @When("^I am on the Draft page$")
    public void i_am_on_the_draft_page() {
        generalSteps.navigateToDraftPage();
    }

    @When("^I am on the Pending page$")
    public void i_am_on_the_pending_page() {
        generalSteps.navigateToPendingPage();
    }

    @When("^I am on the Approved page$")
    public void i_am_on_the_approved_page() {
        generalSteps.navigateToApprovedPage();
    }

    @When("^I am on the Denied page$")
    public void i_am_on_the_denied_page() {
        generalSteps.navigateToDeniedPage();
    }

    @When("^I am on the Notes page$")
    public void i_am_on_the_notes_page() {
        generalSteps.navigateToNotesPage();
    }

    @When("^I open the filter panel$")
    public void i_open_the_filter_panel() {
        generalSteps.openFilterPanel();
    }
}
