package gov.medicaid.features.service_admin.steps;

import cucumber.api.java.en.When;
import gov.medicaid.features.general.steps.GeneralSteps;
import net.thucydides.core.annotations.Steps;

@SuppressWarnings("unused")
public class FunctionsStepDefinitions {
    @Steps
    GeneralSteps generalSteps;

    @Steps
    AdminSteps adminSteps;

    @When("^I am on the Functions Provider Types page$")
    public void i_am_on_the_functions_provider_types_page() {
        generalSteps.clickLinkAssertTitle(".functionsLink", "Provider Types - Functions (Service Admin)");
    }

    @When("^I am on the Functions Screening Schedules page$")
    public void i_am_on_the_functions_screening_schedules_page() {
        i_am_on_the_functions_provider_types_page();
        generalSteps.clickLinkAssertTitle(".screeningSchedulesTab", "Screening Schedules - Functions (Service Admin)");
    }
}
