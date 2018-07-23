package gov.medicaid.features.service_admin.steps;

import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;

import gov.medicaid.features.general.steps.GeneralSteps;

import net.thucydides.core.annotations.Steps;

public class ProviderTypeStepDefinitions {
    @Steps
    ProviderTypeSteps providerTypeSteps;

    @Steps
    GeneralSteps generalSteps;

    @Given("^I create a Provider Type with Description '(.*)'$")
    public void i_create_a_Provider_Type_with_Description(String desc) {
        generalSteps.clickLinkAssertTitle(".addProviderBtn", "Create Provider Type");
        providerTypeSteps.setProviderTypeDescription(desc);
        providerTypeSteps.submitProviderType();
    }

    @Then("^I should see a Provider Type Description error '(.*)'$")
    public void i_should_see_a_provider_type_description_error(String errorText) {
        generalSteps.checkForFormError("providerTypeDescription", errorText);
    }

    @Given("^I am on the Functions View Provider Type page for '(.*)'$")
    public void i_am_on_the_Functions_View_Provider_Type_page_for(String desc) {
        providerTypeSteps.viewProviderType(desc);
    }

    @Then("^I should see a Provider Type with Description '(.*)'$")
    public void i_should_see_a_Provider_Type_with_Description(String desc) {
        providerTypeSteps.confirmOnViewPage(desc);
    }

    @Given("^I am on the Functions Edit Provider Type page for '(.*)'$")
    public void i_am_on_the_Functions_Edit_Provider_Type_page_for(String desc) {
        providerTypeSteps.editProviderType(desc);
    }

    @Given("^I change the Provider Type Description to '(.*)'$")
    public void i_change_the_Provider_Type_Description_to(String newDesc) {
        providerTypeSteps.setProviderTypeDescription(newDesc);
    }

    @Given("^I add Provider Type Agreements and Licenses$")
    public void i_add_Provider_Type_Agreements_and_Licenses() {
        providerTypeSteps.addProviderTypeAgreementsAndLicenses();
    }

    @Given("^I submit the Provider Type Edit$")
    public void i_submit_the_Provider_Type_Edit() {
        providerTypeSteps.submitProviderType();
    }

    @Given("^I delete the Provider Type '(.*)'$")
    public void i_delete_the_Provider_Type(String desc) {
        providerTypeSteps.deleteProviderType(desc);
    }

    @Then("^I should not see a Provider Type with Description '(.*)'$")
    public void i_should_not_see_a_Provider_Type_with_Description(String desc) {
        providerTypeSteps.confirmNoProviderTypeInList(desc);
    }
}
