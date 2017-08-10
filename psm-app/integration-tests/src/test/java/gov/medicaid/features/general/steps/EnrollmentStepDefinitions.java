package gov.medicaid.features.general.steps;

import cucumber.api.PendingException;
import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;
import gov.medicaid.features.enrollment.EnrollmentSteps;
import gov.medicaid.features.general.ui.EnrollmentPage;
import net.thucydides.core.annotations.Steps;
import org.apache.commons.lang3.StringUtils;

import static org.assertj.core.api.Assertions.assertThat;


@SuppressWarnings("unused")
public class EnrollmentStepDefinitions {
    @Steps
    EnrollmentSteps enrollmentSteps;

    private EnrollmentPage enrollmentPage;

    @Given("^I have provided all required information for an organizational enrollment$")
    public void i_have_provided_all_required_information_for_an_organizational_enrollment() throws Throwable {
        enrollmentSteps.selectOrganizationalProviderType();
        enrollmentSteps.enterOrganizationInfo();
        enrollmentSteps.enterContactInfo();
        enrollmentPage.clickNext();
        enrollmentPage.enterIndividualMember();
        enrollmentPage.setIndividualOwnerNPI("1234567893");
        enrollmentPage.setIndividualOwnerName("Test Owner");
        enrollmentPage.setIndividualProviderType("Dentist");
        enrollmentPage.setIndividualOwnerSoSec("123456789");
    }

    @When("^I click 'next' on the Ownership Info Page$")
    public void i_click_next_on_the_Ownership_Info_Page() throws Throwable {
        // Write code here that turns the phrase above into concrete actions
        throw new PendingException();
    }

    @Then("^I should be able to verify all entered information$")
    public void i_should_be_able_to_verify_all_entered_information() throws Throwable {
        // Write code here that turns the phrase above into concrete actions
        throw new PendingException();
    }

}
