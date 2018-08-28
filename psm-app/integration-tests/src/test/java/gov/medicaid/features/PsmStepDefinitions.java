package gov.medicaid.features;

import cucumber.api.java.en.Then;

import gov.medicaid.features.general.steps.GeneralSteps;

import net.thucydides.core.annotations.Steps;

public class PsmStepDefinitions {

    // This property is set by serenity at test time.
    private PsmPage page;

    @Steps
    private GeneralSteps generalSteps;

    @Then("^I should have no accessibility issues$")
    public void i_should_have_no_accessibility_issues() {
        generalSteps.hasNoServerError();
        page.checkAccessibility();
    }
}
