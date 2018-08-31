package gov.medicaid.features.general.steps;

import cucumber.api.java.en.When;
import net.thucydides.core.annotations.Steps;

@SuppressWarnings("unused")
public class ProviderEnrollmentsStepDefinitions {
    @Steps
    GeneralSteps generalSteps;

    @When("^I am on the provider Draft page$")
    public void i_am_on_the_provider_draft_page() {
        generalSteps.goToProviderDraftPage();
    }

    @When("^I am on the provider Pending page$")
    public void i_am_on_the_provider_pending_page() {
        generalSteps.goToProviderPendingPage();
    }

    @When("^I am on the provider Approved page$")
    public void i_am_on_the_provider_approved_page() {
        generalSteps.goToProviderApprovedPage();
    }

    @When("^I am on the provider Denied page$")
    public void i_am_on_the_provider_denied_page() {
        generalSteps.goToProviderDeniedPage();
    }

    @When("^I open the filter panel$")
    public void i_open_the_filter_panel() {
        generalSteps.openFilterPanel();
    }
}
