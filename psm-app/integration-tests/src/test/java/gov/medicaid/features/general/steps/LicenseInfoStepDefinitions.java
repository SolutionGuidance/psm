package gov.medicaid.features.general.steps;

import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;
import net.serenitybdd.core.Serenity;
import net.thucydides.core.annotations.Steps;
import gov.medicaid.features.general.ui.LicenseInfoPage;
import gov.medicaid.features.general.stepLibrary.LicenseInfoSteps;
import static org.assertj.core.api.Assertions.assertThat;

public class LicenseInfoStepDefinitions {
    @Steps
    LicenseInfoSteps licenseInfoSteps;
    LicenseInfoPage licenseInfoPage;

    @Given("^I am logged in as a (.*) and I am at the license information form$")
    public void i_am_logged_in_and_I_am_at_the_license_information_form(String aProviderType) throws Throwable {
        licenseInfoSteps.getToLicenseInfoPage(aProviderType);

    }

    @Given("^I choose a valid type of license of (.*)")
    public void i_choose_a_valid_type_of_license(String licenseType) throws Throwable {
        licenseInfoSteps.clickNo();
        licenseInfoSteps.addLicense();
        licenseInfoSteps.addLicenseType(licenseType);
    }

    @Given("^I upload an acceptable file from location \"([^\"]*)\"$")
    public void i_upload_an_acceptable_file_from_location(String filepath) throws Throwable {
        licenseInfoSteps.uploadFile(filepath);
    }

    @Given("^I use a valid certification number of \"([^\"]*)\"$")
    public void i_use_a_valid_certification_number_of(String licenseNumber) throws Throwable {
        licenseInfoSteps.enterLicenseNumber(licenseNumber);
    }

    @Given("^I use a valid origin date of \"([^\"]*)\"$")
    public void i_use_a_valid_origin_date_of(String issueDate) throws Throwable {
        licenseInfoSteps.enterIssueDate(issueDate);
    }

    @Given("^I use a valid renewal date of \"([^\"]*)\"$")
    public void i_use_a_valid_renewal_date_of(String renewalDate) throws Throwable {
        licenseInfoSteps.enterRenewalDate(renewalDate);
    }

    @Given("^I use a valid issuing state of \"([^\"]*)\"$")
    public void i_use_a_valid_issuing_state_of(String issueState) throws Throwable {
        licenseInfoSteps.enterIssueState(issueState);
    }

    @When("I hit the next button")
    public void i_hit_next() {
        licenseInfoSteps.clickNext();
    }

    @Then("^I should be on the next step of the form$")
    public void i_should_be_on_the_next_step_of_the_form() throws Throwable {
        assertThat(licenseInfoPage.getTitle().contains("Practice Information"));
    }


}
