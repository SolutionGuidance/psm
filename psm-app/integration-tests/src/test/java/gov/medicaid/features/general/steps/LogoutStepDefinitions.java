package gov.medicaid.features.general.steps;

import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;
import gov.medicaid.features.general.ui.DashboardPage;
import gov.medicaid.features.general.ui.LoginPage;
import net.thucydides.core.annotations.Steps;

@SuppressWarnings("unused")
public class LogoutStepDefinitions {
    @Steps
    GeneralSteps generalSteps;

    // This property is set by serenity at test time.
    private LoginPage loginPage;
    private DashboardPage dashboardPage;

    @Given("I am logged in as a provider$")
    public void i_am_logged_in_as_a_provider() {
        generalSteps.login("p1", "p1");
    }

    @When("^I click on Logout$")
    public void clickLogout() {
        dashboardPage.logout();
    }

    @Then("^I should see the login page$")
    public void checkLogout() {
        loginPage.checkUserLoggedOut();
    }

}
