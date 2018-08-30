package gov.medicaid.features.enrollment.steps;

import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;
import gov.medicaid.features.enrollment.ui.OrganizationInfoPage;
import gov.medicaid.features.enrollment.ui.PersonalInfoPage;
import gov.medicaid.features.general.steps.GeneralSteps;
import net.thucydides.core.annotations.Steps;
import org.apache.commons.lang3.StringUtils;

import java.time.LocalDate;

@SuppressWarnings("unused")
public class ValidationStepDefinitions {
    @Steps
    EnrollmentSteps enrollmentSteps;

    @Steps
    GeneralSteps generalSteps;

    private OrganizationInfoPage organizationInfoPage;
    private PersonalInfoPage personalInfoPage;

    @When("^I enter an (\\d+) digit FEIN$")
    public void i_enter_an_digit_fein(int numDigits) {
        String generatedFEIN = StringUtils.repeat("0", numDigits);
        organizationInfoPage.setFEIN(generatedFEIN);
    }

    @When("^I enter a date of birth less than eighteen years ago")
    public void fill_form_with_under_age_date_of_birth() {
        LocalDate eighteenthBirthdayEve = LocalDate
                .now()
                .minusYears(18)
                .plusDays(1);
        personalInfoPage.enterDOB(eighteenthBirthdayEve);
    }

    @When("^I click 'next' on the personal info page$")
    public void click_next_on_personal_info_page() {
        personalInfoPage.clickNext();
    }

    @When("^I click 'next' on the organization info page$")
    public void i_click_next_on_the_organization_info_page() {
        organizationInfoPage.clickNext();
    }

    @When("^I check 'same as above' on the personal info page$")
    public void i_check_same_as_above_on_the_personal_info_page() {
        personalInfoPage.checkSameAsAbove();
    }

    @When("^I enter an empty email address on the personal info page$")
    public void i_enter_an_empty_email_address_on_the_personal_info_page() {
        enrollmentSteps.enterEmptyEmailAddress();
    }

    @Then("^I should get an FEIN error$")
    public void i_should_get_an_fein_error() throws Exception {
        enrollmentSteps.checkForFeinError();
    }

    @Then("^I should get a provider too young error$")
    public void i_should_get_a_provider_too_young_error() throws Exception {
        enrollmentSteps.checkForTooYoungError();
    }

    @Then("^I should get a renewal date error$")
    public void should_get_a_renewal_date_error() throws Exception {
        enrollmentSteps.checkForRenewalDateError();
    }

    @Then("^I should get a same as above email error$")
    public void should_get_a_same_as_above_email_error() throws Exception {
        personalInfoPage.checkForSameAsAboveEmailError();
    }

    @Then("^I should see email address is required$")
    public void should_see_email_address_is_required() throws Exception {
        personalInfoPage.checkEmailAddressDisplaysAsRequired();
}
}
