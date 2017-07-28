package gov.medicaid.features.general.steps;

import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;
import gov.medicaid.features.general.ui.LoginPage;

public class LoginStepDefinitions {
    // This property is set by serenity at test time.
    @SuppressWarnings("unused")
    private LoginPage loginPage;

    @Given("^I have the application open in my browser$")
    public void i_have_the_application_open_in_my_browser() throws Throwable {
        loginPage.open();
    }

    @Given("^I enter my username and password$")
    public void i_enter_my_username_and_password() throws Throwable {
        loginPage.enterProviderCredentials();
    }

    @When("^I click on Login$")
    public void i_click_on_Login() throws Throwable {
        loginPage.login();
    }

    @Then("^I should see my dashboard page$")
    public void i_should_see_my_dashboard_page() throws Throwable {
        loginPage.checkUserLoggedIn("p1");
    }
}
