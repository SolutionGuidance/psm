package gov.medicaid.features.general.steps;

import cucumber.api.java.en.When;
import net.thucydides.core.annotations.Steps;

@SuppressWarnings("unused")
public class DashboardStepDefinitions {
    @Steps
    GeneralSteps generalSteps;

    @When("^I am on the Dashboard Draft page$")
    public void i_am_on_the_dashboard_draft_page() {
        generalSteps.navigateToDashboardDraftPage();
    }

    @When("^I am on the Dashboard Pending page$")
    public void i_am_on_the_dashboard_pending_page() {
        generalSteps.navigateToDashboardPendingPage();
    }

    @When("^I am on the Dashboard Approved page$")
    public void i_am_on_the_dashboard_approved_page() {
        generalSteps.navigateToDashboardApprovedPage();
    }

    @When("^I am on the Dashboard Denied page$")
    public void i_am_on_the_dashboard_denied_page() {
        generalSteps.navigateToDashboardDeniedPage();
    }

    @When("^I open the filter panel$")
    public void i_open_the_filter_panel() {
        generalSteps.openFilterPanel();
    }
}
