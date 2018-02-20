package gov.medicaid.features.general.steps;

import cucumber.api.java.en.Given;
import net.thucydides.core.annotations.Steps;

@SuppressWarnings("unused")
public class AdvancedSearchStepDefinitions {
    @Steps
    GeneralSteps generalSteps;

    @Given("^I am on the Advanced Search page$")
    public void i_am_on_the_advanced_search_page() {
        generalSteps.navigateToAdvancedSearchPage();
    }
}
