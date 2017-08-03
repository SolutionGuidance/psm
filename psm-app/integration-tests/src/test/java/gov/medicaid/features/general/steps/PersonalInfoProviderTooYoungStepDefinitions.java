package gov.medicaid.features.general.steps;

import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;
import net.serenitybdd.core.Serenity;
import net.thucydides.core.annotations.Steps;
import gov.medicaid.features.general.stepLibrary.PersonalInfoSteps;
//import static org.hamcrest.MatcherAssert.assertThat;
//import static org.hamcrest.core.StringContains.containsString;

public class PersonalInfoProviderTooYoungStepDefinitions {
    @Steps
    PersonalInfoSteps personalInfoSteps;

    @Given("^I fill the form with (.*) a birthday under eighteen$")
    public void i_fill_the_form_with_a_birthday_under_eighteen(String DOB) throws Throwable {
        personalInfoSteps.enterDOB(DOB);
    }
    @Then("^I will get a provider too young error$")
    public void i_will_get_a_provider_too_young_error() throws Exception {
        personalInfoSteps.checkForTooYoungError();
    }



}
