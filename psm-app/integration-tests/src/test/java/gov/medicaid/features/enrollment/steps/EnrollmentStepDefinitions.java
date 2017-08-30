package gov.medicaid.features.enrollment.steps;

import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;
import gov.medicaid.features.enrollment.ui.EnrollmentPage;
import gov.medicaid.features.enrollment.ui.OwnershipInfoPage;
import net.thucydides.core.annotations.Steps;

import static org.assertj.core.api.Assertions.assertThat;


@SuppressWarnings("unused")
public class EnrollmentStepDefinitions {
    @Steps
    EnrollmentSteps enrollmentSteps;

    private EnrollmentPage enrollmentPage;
    private OwnershipInfoPage ownershipInfoPage;

    @Given("^I am entering ownership information$")
    public void i_am_entering_ownership_information() {
        enrollmentSteps.selectOrganizationalProviderType();
        enrollmentSteps.enterOrganizationInfo();
        enrollmentSteps.enterContactInfo();
        enrollmentPage.clickNext();
        enrollmentSteps.enterIndividualMember();
        enrollmentPage.clickNext();

        ownershipInfoPage.selectEntityType("Sole Proprietorship");
        ownershipInfoPage.addOwnership();
        ownershipInfoPage.selectOwnershipType("Managing Employee");
        ownershipInfoPage.setOwnershipFirstName("First");
        ownershipInfoPage.setOwnershipMiddleName("Middle");
        ownershipInfoPage.setOwnershipLastName("Last");
        ownershipInfoPage.setOwnershipSoSec("123456789");
        ownershipInfoPage.setOwnershipAddr1("OwnerAddr1");
        ownershipInfoPage.setOwnershipDOB("01011970");
        ownershipInfoPage.setOwnershipHireDate("01012000");
        ownershipInfoPage.setOwnershipCity("Ownertown");
        ownershipInfoPage.selectOwnershipState("Texas");
        ownershipInfoPage.setOwnershipZip("77706");
        ownershipInfoPage.selectOwnershipCounty("Beltrami");
    }

    @Given("^I have indicated that the owner has an interest in another Medicaid disclosing entity$")
    public void i_have_indicated_that_the_owner_has_an_interest_in_another_Medicaid_disclosing_entity()  {
        ownershipInfoPage.clickDisclosure();
    }

    @Given("^I have entered a city for that other entity$")
    public void i_have_entered_a_city_for_that_other_entity() {
        ownershipInfoPage.setControlOwnershipOtherLegalName("My Other Name");
        ownershipInfoPage.setControlOwnershipPctInterest(12.5);
        ownershipInfoPage.setControlOwnershipAddr1("333 Test Ln");
        ownershipInfoPage.setControlOwnershipCity("Check This City");
        ownershipInfoPage.setControlOwnershipZip("77707");
        ownershipInfoPage.selectControlOwnershipState("Texas");
        ownershipInfoPage.selectControlOwnershipCounty("Becker");
    }

    @When("^I click 'next' on the Ownership Info Page$")
    public void i_click_next_on_the_Ownership_Info_Page() {
        ownershipInfoPage.setNoToAllDisclosures();
        ownershipInfoPage.clickNext();

    }

    @Then("^the city should be accepted$")
    public void the_city_should_be_accepted() {
        assertThat(enrollmentPage.getTitle()).isEqualTo("Summary Information");
    }

    @When("^I enter valid personal information$")
    public void enter_valid_personal_information() {
        enrollmentSteps.enterIndividualPersonalInfo();
    }

    @Then("^I can move on from the personal info page with no errors$")
    public void i_will_move_on_from_the_personal_info_page_with_no_errors() {
        enrollmentSteps.advanceFromIndividualPersonalInfoToLicenseInfo();
    }
}
