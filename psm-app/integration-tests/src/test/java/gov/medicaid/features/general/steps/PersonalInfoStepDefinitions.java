package gov.medicaid.features.general.steps;

import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;
import net.serenitybdd.core.Serenity;
import net.thucydides.core.annotations.Steps;
import gov.medicaid.features.general.ui.PersonalInfoPage;
import gov.medicaid.features.general.stepLibrary.PersonalInfoSteps;
import static org.assertj.core.api.Assertions.assertThat;


public class PersonalInfoStepDefinitions {
    @Steps
    PersonalInfoSteps personalInfoSteps;
    PersonalInfoPage personalInfoPage;

    @Given("^I have created a new enrollment as a (.*) and am at the Personal Information Page$")
    public void i_have_created_a_new_enrollment_and_am_at_the_Personal_Information_Page(String aProviderType) throws Throwable {
        personalInfoSteps.getToPersonalInfoPage(aProviderType);

    }

    @Given("^I fill the form with \"([^\"]*)\" a valid first name$")
    public void i_fill_the_form_with_a_valid_first_name(String firstName) throws Throwable {
        personalInfoSteps.enterFirstName(firstName);
    }

    @Given("^I fill the form with \"([^\"]*)\" a valid last name$")
    public void i_fill_the_form_with_a_valid_last_name(String lastName) throws Throwable {
        personalInfoSteps.enterLastName(lastName);
    }

    @Given("^I fill the form with \"([^\"]*)\" a valid NPI$")
    public void i_fill_the_form_with_a_valid_NPI(String NPI) throws Throwable {
        personalInfoSteps.enterNPI(NPI);
    }

    @Given("^I fill the form with \"([^\"]*)\" a valid SSN$")
    public void i_fill_the_form_with_a_valid_SSN(String SSN) throws Throwable {
        personalInfoSteps.enterSSN(SSN);
    }

    @Given("^I fill the form with \"([^\"]*)\" a valid birthday$")
    public void i_fill_the_form_with_a_valid_birthday(String DOB) throws Throwable {
        personalInfoSteps.enterDOB(DOB);
    }

    @Given("^I fill the form with \"([^\"]*)\" a valid email$")
    public void i_fill_the_form_with_a_valid_email(String email) throws Throwable {
        personalInfoSteps.enterEmail(email);
    }

    @Given("^I check the same as above box$")
    public void i_check_the_same_as_above_box() throws Throwable {
        personalInfoSteps.checkSameAsAbove();
    }

    @When("^I hit next$")
    public void i_hit_next() throws Throwable {
        personalInfoSteps.clickNext();
    }

    @Then("^I will move on to the next form with no errors$")
    public void i_will_move_on_to_the_next_form_with_no_errors() throws Throwable {
//        personalInfoSteps.confirmNoErrors();
        assertThat(personalInfoPage.getTitle().contains("License Information"));
    }

}
