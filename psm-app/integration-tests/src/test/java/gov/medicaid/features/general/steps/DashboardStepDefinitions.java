package gov.medicaid.features.general.steps;

import cucumber.api.java.en.Given;
import cucumber.api.java.en.When;
import net.thucydides.core.annotations.Steps;

@SuppressWarnings("unused")
public class DashboardStepDefinitions {
    @Steps
    GeneralSteps generalSteps;
    @Steps
    DashboardSteps dashboardSteps;

    @Given("^I am on the Dashboard Draft page$")
    public void i_am_on_the_dashboard_draft_page() {
        generalSteps.loginAsProvider();
        dashboardSteps.openDashboardDraftPage();
    }

    @When("^I open the filter panel on the Dashboard Draft page")
    public void i_open_the_filter_panel_on_the_dashboard_draft_page() {
        dashboardSteps.clickDashboardDraftPageFilterButton();
    }

    @Given("^I am on the Dashboard Pending page$")
    public void i_am_on_the_dashboard_pending_page() {
        generalSteps.loginAsProvider();
        dashboardSteps.openDashboardPendingPage();
    }

    @When("^I open the filter panel on the Dashboard Pending page")
    public void i_open_the_filter_panel_on_the_dashboard_pending_page() {
        dashboardSteps.clickDashboardPendingPageFilterButton();
    }

    @Given("^I am on the Dashboard Approved page$")
    public void i_am_on_the_dashboard_approved_page() {
        generalSteps.loginAsProvider();
        dashboardSteps.openDashboardApprovedPage();
    }

    @When("^I open the filter panel on the Dashboard Approved page")
    public void i_open_the_filter_panel_on_the_dashboard_approved_page() {
        dashboardSteps.clickDashboardApprovedPageFilterButton();
    }

    @Given("^I am on the Dashboard Denied page$")
    public void i_am_on_the_dashboard_denied_page() {
        generalSteps.loginAsProvider();
        dashboardSteps.openDashboardDeniedPage();
    }

    @When("^I open the filter panel on the Dashboard Denied page")
    public void i_open_the_filter_panel_on_the_dashboard_denied_page() {
        dashboardSteps.clickDashboardDeniedPageFilterButton();
    }
}
