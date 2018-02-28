package gov.medicaid.features.general.steps;

import cucumber.api.java.en.Given;
import net.thucydides.core.annotations.Steps;

@SuppressWarnings("unused")
public class AccountSetupStepDefinitions {
    @Steps
    GeneralSteps generalSteps;

    @Given("^I am on the Account Setup page$")
    public void i_am_on_the_account_setup_page() {
        generalSteps.navigateToAccountSetupPage();
    }
}
