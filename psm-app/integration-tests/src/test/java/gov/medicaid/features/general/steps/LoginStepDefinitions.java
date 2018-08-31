package gov.medicaid.features.general.steps;

import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;
import gov.medicaid.features.general.ui.LoginPage;

@SuppressWarnings("unused")
public class LoginStepDefinitions {
    // This property is set by serenity at test time.
    private LoginPage loginPage;

    @Given("^I have the application open in my browser$")
    public void i_have_the_application_open_in_my_browser() {
        loginPage.open();
    }

    @Given("^I enter my username and password$")
    public void i_enter_my_username_and_password() {
        loginPage.enterCredentials("p1", "p1");
    }

    @When("^I click on Login$")
    public void i_click_on_Login() {
        loginPage.login();
    }

    @Then("^I should be logged in$")
    public void i_should_be_logged_in() {
        loginPage.checkUserLoggedIn("p1");
    }
}
