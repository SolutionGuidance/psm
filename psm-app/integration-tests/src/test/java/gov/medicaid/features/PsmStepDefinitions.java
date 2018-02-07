package gov.medicaid.features;

import cucumber.api.java.en.Then;

@SuppressWarnings("unused")
public class PsmStepDefinitions {

    // This property is set by serenity at test time.
    private PsmPage page;

    @Then("^I should have no accessibility issues$")
    public void i_should_have_no_accessibility_issues() {
        page.checkAccessibility();
    }
}
