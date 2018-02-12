package gov.medicaid.features.general.steps;

import cucumber.api.java.en.Given;
import net.thucydides.core.annotations.Steps;

@SuppressWarnings("unused")
public class RegisterNewAccountStepDefinitions {
    @Steps
    GeneralSteps generalSteps;

    @Given("^I am on the Register New Account page$")
    public void i_am_on_the_register_new_account_page() {
        generalSteps.navigateToRegisterNewAccountPage();
    }
}
