package gov.medicaid.features.general.steps;

import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;
import net.serenitybdd.core.Serenity;
import net.thucydides.core.annotations.Steps;
import gov.medicaid.features.general.ui.PracticeInfoPage;
import gov.medicaid.features.general.stepLibrary.PracticeInfoSteps;
import static org.assertj.core.api.Assertions.assertThat;


public class PracticeInfoStepDefinitions {
    @Steps
    PracticeInfoSteps practiceInfoSteps;
    PracticeInfoPage practiceInfoPage;

    @Given("^I am at the personal information page as a valid (.*) with license (.*)$")
    public void i_am_at_the_personal_information_page_as_a_provider_with_license(String aProviderType, String license) throws Throwable {
        practiceInfoSteps.getToPracticeInfoPage(aProviderType, license);
    }

    @Given("^I select Yes to maintaining my own private practice$")
    public void i_select_Yes_to_maintaining_my_own_private_practice() throws Throwable {
        practiceInfoSteps.checkYesPrivatePractice();
    }

    @Given("^I select No to being contracted by a group practice$")
    public void i_select_No_to_being_contracted_by_a_group_practice() throws Throwable {
        practiceInfoSteps.checkNoGroupPractice();
    }

    @Given("^I fill the form with \"([^\"]*)\" for Private Practice Name$")
    public void i_fill_the_form_with_for_Private_Practice_Name(String practiceName) throws Throwable {
        practiceInfoSteps.enterPracticeName(practiceName);
    }

    @Given("^I fill the form with \"([^\"]*)\" for Effective Date$")
    public void i_fill_the_form_with_for_Effective_Date(String effectiveDate) throws Throwable {
        practiceInfoSteps.enterEffectiveDate(effectiveDate);
    }

    @Given("^I fill the form with \"([^\"]*)\" for Practice Address$")
    public void i_fill_the_form_with_for_Practice_Address(String practiceAddress) throws Throwable {
        practiceInfoSteps.enterPracticeAddress(practiceAddress);
    }

    @Given("^I fill the form with \"([^\"]*)\" for City$")
    public void i_fill_the_form_with_for_City(String city) throws Throwable {
        practiceInfoSteps.enterCity(city);
    }

    @Given("^I fill the form with \"([^\"]*)\" for State$")
    public void i_fill_the_form_with_for_State(String state) throws Throwable {
        practiceInfoSteps.enterState(state);
    }

    @Given("^I fill the form with \"([^\"]*)\" for Zip Code$")
    public void i_fill_the_form_with_for_Zip_Code(String zipCode) throws Throwable {
        practiceInfoSteps.enterZipCode(zipCode);
    }

    @Given("^I fill the form with \"([^\"]*)\" for Practice Phone Number$")
    public void i_fill_the_form_with_for_Practice_Phone_Number(String phoneNumber) throws Throwable {
        practiceInfoSteps.enterPhoneNumber(phoneNumber);
    }

    @Given("^I check Same as Above for Billing Address$")
    public void i_check_Same_as_Above_for_Billing_Address() throws Throwable {
        practiceInfoSteps.clickSameAsAbove();
    }

    @Given("^I fill the form with \"([^\"]*)\" for Fiscal Year End$")
    public void i_fill_the_form_with_for_Fiscal_Year_End(String year) throws Throwable {
        practiceInfoSteps.enterFiscalYear(year);
    }

    @Given("^I check the first Remittance Sequence$")
    public void i_check_the_first_Remittance_Sequence() throws Throwable {
        practiceInfoSteps.checkFirstRemittanceSequence();
    }

    @When("^I hit next to go to the next page$")
    public void i_hit_next_to_go_to_the_next_page() throws Throwable {
        practiceInfoSteps.clickNext();
    }

    @Then("^I should proceed to the next form with no errors$")
    public void i_should_proceed_to_the_next_form_with_no_errors() throws Throwable {
        practiceInfoSteps.checkSummaryPage();
        practiceInfoSteps.clickNext();
    }


}
