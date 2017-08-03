package gov.medicaid.features.general.steps;

import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;
import net.serenitybdd.core.Serenity;
import net.thucydides.core.annotations.Steps;
import gov.medicaid.features.general.ui.SubmitPage;
import gov.medicaid.features.general.stepLibrary.SubmitSteps;
import static org.assertj.core.api.Assertions.assertThat;
//import static org.hamcrest.MatcherAssert.assertThat;
//import static org.hamcrest.core.StringContains.containsString;

public class SubmitStepDefinitions {
    @Steps
    SubmitSteps submitSteps;

    @Given("^I am at the submit information page as a (.*) with license (.*)$")
    public void i_am_at_the_submit_information_page_as_a_provider_with_license(String aProviderType, String licenseType) throws Throwable {
        submitSteps.getToSubmitPage(aProviderType, licenseType);
    }

    @Given("^I select no to all the disclosure questions$")
    public void i_select_no_to_all_the_disclosure_questions() throws Throwable {
        submitSteps.checkNoCriminalConviction();
        submitSteps.checkNoCivilPenalty();
        submitSteps.checkNoPreviousExclusion();
    }

    @Given("^I input (.*) and (.*) as provider name and title$")
    public void i_input_p_and_p(String providerName, String providerTitle) throws Throwable {
        submitSteps.enterProviderName(providerName);
        submitSteps.enterProviderTitle(providerTitle);
    }

    @Given("^I check the terms of agreement$")
    public void i_check_the_terms_of_agreement() throws Throwable {
        submitSteps.clickReadAgreement();
    }

    @Given("^I fill in today's date$")
    public void i_fill_in_today_s_date() throws Throwable {
        submitSteps.enterValidDate();
    }

    @When("^I hit submit enrollment$")
    public void i_hit_submit_enrollment() throws Throwable {
        submitSteps.clickSubmitButton();
    }

    @Then("^I should have successfully submitted the form$")
    public void i_should_have_successfully_submitted_the_form() throws Throwable {
        submitSteps.closePopup();
        submitSteps.checkEnrollmentPage();
    }

}
