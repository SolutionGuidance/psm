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

    @Given("I am logged in$")
    public void enter_dashboard_page() {
        loginAsProvider();
    }

    private void loginAsProvider() {
        generalSteps.loginAsProvider();
    }

    @When("^I click on Logout$")
    public void clickLogout()  {
        dashboardPage.logout();
    }

    @Then("^I should see the login page$")
    public void checkLogout() {
        loginPage.checkUserLoggedOut();
    }

}
