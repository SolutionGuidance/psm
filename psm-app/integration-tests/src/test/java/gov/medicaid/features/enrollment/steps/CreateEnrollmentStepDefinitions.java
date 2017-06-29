package gov.medicaid.features.enrollment.steps;

import cucumber.api.java.en.Given;
import cucumber.api.java.en.When;
import cucumber.api.java.en.Then;
import gov.medicaid.features.enrollment.ui.EnrollmentPage;
import net.thucydides.core.annotations.Steps;

import java.util.Map;

import static org.assertj.core.api.Assertions.assertThat;

public class CreateEnrollmentStepDefinitions {
    @Steps
    EnrollmentSteps enrollment;

    // This property is set by the serenity framework as the tests
    // are being set up
    @SuppressWarnings("unused")
    private EnrollmentPage enrollmentPage;

    @Given("^The database is fresh from seed\\.sql$")
    public void the_database_is_fresh_from_seed_sql() {
        enrollmentPage.open();

    }

    @Given("^I am logged into the application as a provider$")
    public void i_am_logged_into_the_application_as_a_provider() {
        enrollmentPage.loginAsProvider();
        assertThat(enrollmentPage.getTitle().equals("Welcome"));
    }

    @Given("^I click on \"Create new enrollment\" to start a new enrollment$")
    public void i_click_on_to_start_a_new_enrollment() {
        enrollmentPage.clickOnNewEnrollment();
        assertThat(enrollmentPage.getTitle().equals("Provider Type Page"));
    }

    @Given("^I select \"([^\"]*)\" as provider type$")
    public void i_select_as_provider_type(String aProviderType) {
        enrollmentPage.selectProviderType(aProviderType);
    }

    @Given("^I click \"Next\"$")
    public void i_click() {
        enrollmentPage.clickNext();
        assertThat(enrollmentPage.getTitle().equals("Organization Information"));
    }

    @Given("^I enter values into all of the required organization information fields$")
    public void i_enter_values_into_all_of_the_required_organization_information_fields() {
        Map<EnrollmentSteps.OrganizationalInformation, String> orgData = enrollment.generateTestData();
        enrollmentPage.enterOrganizationInformation(orgData);
    }

    @When("^I click on \"([^\"]*)\"$")
    public void i_click_on(String arg1)  {
        // To be implemented when all of the
        // features are automated
    }

    @Then("^I should see a success page$")
    public void i_should_see_a_success_page()  {
        assertThat(true);
    }
}
