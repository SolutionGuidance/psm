package gov.medicaid.features.general.steps;

import cucumber.api.java.en.Given;
import net.thucydides.core.annotations.Steps;

@SuppressWarnings("unused")
public class ForgotPasswordStepDefinitions {
    @Steps
    GeneralSteps generalSteps;

    @Given("^I am on the Forgot Password page$")
    public void i_am_on_the_forgot_password_page() {
        generalSteps.openForgotPasswordPage();
    }
}
