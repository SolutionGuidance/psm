package gov.medicaid.features.general.steps;

import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;
import net.thucydides.core.annotations.Steps;

@SuppressWarnings("unused")
public class ChangePasswordStepDefinitions {
    @Steps
    GeneralSteps generalSteps;

    @Given("^I am on the dashboard page$")
    public void check_dashboard_page() {
        generalSteps.checkOnDashboard();
    }

    @When("^I click on My Profile$")
    public void i_click_on_my_profile()  {
        generalSteps.clickMyProfile();
    }

    @Then("^I should see the Change Password link$")
    public void i_should_see_change_password()  {
        generalSteps.seeChangePassword();
    }

    @When("^I click on Change Password$")
    public void i_click_on_change_password() {
        generalSteps.clickChangePassword();
    }

    @Then("^I should see the Update Password page$")
    public void i_should_see_the_update_password_page() {
        generalSteps.seeUpdatePassword();
    }
}
