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
        enrollmentPage.setIndividualOwnerDOB("01011970");
        enrollmentPage.setIndividualHireDate("01012000");
        enrollmentPage.clickNext();
        enrollmentPage.selectEntityType("Sole Proprietorship");
        enrollmentPage.addOwnership();
        enrollmentPage.selectOwnershipType("Managing Employee");
        enrollmentPage.setOwnershipFirstName("First");
        enrollmentPage.setOwnershipMiddleName("Middle");
        enrollmentPage.setOwnershipLastName("Last");
        enrollmentPage.setOwnershipSoSec("123456789");
        enrollmentPage.setOwnershipAddr1("OwnerAddr1");
        enrollmentPage.setOwnershipDOB("01011970");
        enrollmentPage.setOwnershipHireDate("01012000");
        enrollmentPage.setOwnershipCity("Ownertown");
        enrollmentPage.selectOwnershipState("Texas");
        enrollmentPage.setOwnershipZip("77706");
        enrollmentPage.selectOwnershipCounty("Beltrami");
        enrollmentPage.clickDisclosure();

        enrollmentPage.setControlOwnershipOtherLegalName("My Other Name");
        enrollmentPage.setControlOwnershipPctInterest(12.5);
        enrollmentPage.setControlOwnershipAddr1("333 Test Ln");
        enrollmentPage.setControlOwnershipCity("Tyler");
        enrollmentPage.setControlOwnershipZip("77707");
        enrollmentPage.selectControlOwnershipState("Texas");

        enrollmentPage.setNoToAllDisclosures();
        enrollmentPage.clickNext();

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
