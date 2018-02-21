package gov.medicaid.features.service_admin.steps;

import cucumber.api.java.en.Given;
import cucumber.api.java.en.When;
import gov.medicaid.features.general.steps.GeneralSteps;
import net.thucydides.core.annotations.Steps;

@SuppressWarnings("unused")
public class AdminStepDefinitions {
    @Steps
    GeneralSteps generalSteps;

    @Steps
    AdminSteps adminSteps;

    @Given("^I am logged in as an admin$")
    public void i_am_logged_in_as_an_admin() {
        generalSteps.login("admin", "admin");
    }

    @When("^I am on the COS page$")
    public void i_am_on_the_cos_page() {
        generalSteps.navigateToDraftPage();
        generalSteps.clickLinkAssertTitle(".cosLink", "Category of Service");
    }
}
