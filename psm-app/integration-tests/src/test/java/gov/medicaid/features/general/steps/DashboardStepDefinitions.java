package gov.medicaid.features.general.steps;

import cucumber.api.java.en.Given;
import cucumber.api.java.en.When;
import net.thucydides.core.annotations.Steps;

@SuppressWarnings("unused")
public class DashboardStepDefinitions {
    @Steps
    GeneralSteps generalSteps;

    @Given("^I am on the Dashboard Draft page$")
    public void i_am_on_the_dashboard_draft_page() {
        generalSteps.loginAsProvider();
        generalSteps.openDashboardDraftPage();
    }

    @When("^I open the filter panel on the Dashboard Draft page")
    public void i_open_the_filter_panel_on_the_dashboard_draft_page() {
        generalSteps.clickDashboardDraftPageFilterButton();
    }

    @Given("^I am on the Dashboard Pending page$")
    public void i_am_on_the_dashboard_pending_page() {
        generalSteps.loginAsProvider();
        generalSteps.openDashboardPendingPage();
    }

    @When("^I open the filter panel on the Dashboard Pending page")
    public void i_open_the_filter_panel_on_the_dashboard_pending_page() {
        generalSteps.clickDashboardPendingPageFilterButton();
    }

    @Given("^I am on the Dashboard Approved page$")
    public void i_am_on_the_dashboard_approved_page() {
        generalSteps.loginAsProvider();
        generalSteps.openDashboardApprovedPage();
    }

    @When("^I open the filter panel on the Dashboard Approved page")
    public void i_open_the_filter_panel_on_the_dashboard_approved_page() {
        generalSteps.clickDashboardApprovedPageFilterButton();
    }
}
