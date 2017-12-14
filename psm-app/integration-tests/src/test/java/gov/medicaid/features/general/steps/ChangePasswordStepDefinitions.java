package gov.medicaid.features.general.steps;

import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;
import net.thucydides.core.annotations.Steps;

import gov.medicaid.features.general.ui.DashboardPage;
import gov.medicaid.features.general.ui.MyProfilePage;

@SuppressWarnings("unused")
public class ChangePasswordStepDefinitions {
    @Steps
    GeneralSteps generalSteps;

    private DashboardPage dashboardPage;
    private MyProfilePage profilePage;

    @Given("^I am on the dashboard page$")
    public void check_dashboard_page() {
        dashboardPage.checkOnDashboard();
    }

    @When("^I click on My Profile$")
    public void i_click_on_my_profile()  {
        dashboardPage.clickMyProfile();
    }

    @Then("^I should see the Change Password link$")
    public void i_should_see_change_password()  {
        profilePage.checkChangePassword();
    }
}
