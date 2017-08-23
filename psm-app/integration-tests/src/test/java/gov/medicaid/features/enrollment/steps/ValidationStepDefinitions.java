package gov.medicaid.features.enrollment.steps;

import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;
import gov.medicaid.features.enrollment.ui.OrganizationInfoPage;
import net.thucydides.core.annotations.Steps;
import org.apache.commons.lang3.StringUtils;

import static org.assertj.core.api.Assertions.assertThat;


@SuppressWarnings("unused")
public class ValidationStepDefinitions {
    @Steps
    EnrollmentSteps enrollmentSteps;

    private OrganizationInfoPage organizationInfoPage;

    @Given("^I have started an enrollment$")
    public void i_have_started_an_enrollment() {
        enrollmentSteps.loginAsProvider();
        enrollmentSteps.createEnrollment();
    }

    @Given("^I am on the organization page$")
    public void i_am_on_the_organization_page() {
        enrollmentSteps.selectOrganizationalProviderType();
    }

    @When("^when I enter an (\\d+) digit FEIN$")
    public void when_I_enter_an_digit_FEIN(int numDigits) {
        String generatedFEIN = StringUtils.repeat("0", numDigits);
        organizationInfoPage.setFEIN(generatedFEIN);
    }

    @Then("^It should be rejected$")
    public void it_should_be_rejected() {
        String feinValue = organizationInfoPage.getFEINValue();
        assertThat(feinValue.length()).isEqualTo(0);
    }
}
