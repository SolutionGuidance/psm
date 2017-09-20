package gov.medicaid.features.general.steps;

import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;
import net.serenitybdd.core.Serenity;
import net.thucydides.core.annotations.Steps;
import gov.medicaid.features.general.stepLibrary.EnrollmentSteps;
import static org.assertj.core.api.Assertions.assertThat;

public class EnrollmentStepDefinitions {
    @Steps
    EnrollmentSteps enroll;

    @Given("I am logged in as a provider")
    public void givenIAmLoggedInAsProvider() {
        enroll.login();
    }
    @Given("I click on Create a new enrollment to start enrollment")
    public void andIClickOnStartEnrollment() {
        enroll.createEnrollment();
    }
    @When("I select (.*) as provider type")
    public void andISelectValidProviderType(String aProviderType) {
        enroll.selectProviderType(aProviderType);
    }
    @Then("I will see Personal Information in the title")
    public void thenIWillBeOnPersonalInfoPage() {
        enroll.checkPersonalInfo();
    }
}
