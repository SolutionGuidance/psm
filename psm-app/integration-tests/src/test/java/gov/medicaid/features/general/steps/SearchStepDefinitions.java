package gov.medicaid.features.general.steps;

import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;

import net.thucydides.core.annotations.Steps;

public class SearchStepDefinitions {
    @Steps
    SearchSteps searchSteps;

    @Steps
    GeneralSteps generalSteps;

    @Given("^I am on the Advanced Search page$")
    public void i_am_on_the_advanced_search_page() {
        generalSteps.navigateToAdvancedSearchPage();
    }

    @When("^I filter by NPI '(.*)'$")
    public void i_filter_by_npi(String npi) {
        searchSteps.filterByNpi(npi);
    }

    @Then("^I should see search results$")
    public void i_should_see_search_results() {
        searchSteps.verifySearchResults();
    }

    @When("^I do a quick search for NPI '(.*)'$")
    public void i_do_a_quick_search_for_NPI(String npi) {
        searchSteps.quickSearchByNpi(npi);
    }

    @When("^I do an advanced search for NPI '(.*)'$")
    public void i_do_an_advanced_search_for_NPI(String npi) {
        searchSteps.advancedSearchByNpi(npi);
    }
}
