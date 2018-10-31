/*
 * Copyright 2018 The MITRE Corporation
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package gov.medicaid.features.application.steps;

import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;
import gov.medicaid.features.application.ui.ApplicationPage;
import gov.medicaid.features.application.ui.LicenseInfoPage;
import gov.medicaid.features.application.ui.OwnershipInfoPage;
import gov.medicaid.features.general.steps.GeneralSteps;
import net.thucydides.core.annotations.Steps;

import java.io.IOException;

import static org.assertj.core.api.Assertions.assertThat;

@SuppressWarnings("unused")
public class ApplicationStepDefinitions {
    @Steps
    ApplicationSteps applicationSteps;
    @Steps
    GeneralSteps generalSteps;

    private ApplicationPage applicationPage;
    private OwnershipInfoPage ownershipInfoPage;
    private LicenseInfoPage licenseInfoPage;

    @Given("^I have started an application$")
    public void i_have_started_an_application() {
        generalSteps.login("p1", "p1");
        applicationSteps.prepareSpeechLanguagePathologistApplication();
        applicationSteps.createApplication();
    }

    @When("^I am on the organization page$")
    public void i_am_on_the_organization_page() {
        applicationSteps.prepareHeadStart();
        applicationSteps.selectProviderType();
    }

    @When("^I am on the facility credentials page$")
    public void i_am_on_the_facility_credentials_page() {
        i_am_on_the_organization_page();
        applicationSteps.enterOrganizationInfo();
        applicationSteps.enterContactInfo();
        applicationSteps.advanceFromOrganizationInfoToLicenseInfo();
    }

    @When("^I open an add a license panel$")
    public void i_open_an_add_a_license_panel() {
        applicationSteps.clickAddLicense();
    }

    @When("^I am on the individual member info page$")
    public void i_am_on_the_individual_member_info_page() throws IOException {
        i_am_on_the_facility_credentials_page();
        applicationSteps.enterLicenseInfo();
        applicationSteps.uploadLicense();
        applicationSteps.advanceFromOrganizationLicenseInfoToIndividualMemberInfo();
    }

    @When("^I open an individual member panel")
    public void i_open_an_individual_member_panel() {
        applicationSteps.openIndividualMemberPanel();
    }

    @When("^I am on the ownership info page$")
    public void i_am_on_the_ownership_info_page() throws IOException {
        i_am_on_the_individual_member_info_page();
        applicationSteps.enterIndividualMember();
        applicationSteps.advanceFromOrganizationIndividualMemberInfoToOwnershipInfo();
    }

    @When("^I open the individual owner panel$")
    public void i_open_the_individual_owner_panels() {
        applicationSteps.addIndividualOwnership();
    }

    @When("^I open the business owner panel$")
    public void i_open_the_business_owner_panel() {
        applicationSteps.addBusinessOwnership();
    }

    @When("^I am on the organization summary page$")
    public void i_am_on_the_organization_summary_page() throws IOException {
        i_am_on_the_ownership_info_page();
        applicationSteps.enterOrganizationOwnershipInfo();
        applicationSteps.setNoToAllDisclosures();
        applicationSteps.advanceFromOrganizationOwnershipInfoToSummaryPage();
    }

    @When("^I save as draft$")
    public void i_save_as_draft() {
        applicationSteps.clickSaveAsDraft();
    }

    @When("^I am on the organization provider statement page$")
    public void i_am_on_the_organization_provider_statement_page() throws IOException {
        i_am_on_the_organization_summary_page();
        applicationSteps.advanceFromOrganizationSummaryToProviderStatementPage();
    }

    @When("^I enter my individual provider statement$")
    public void i_enter_my_provider_statement() {
        applicationSteps.checkNoOnProviderDisclosureQuestions();
        applicationSteps.signProviderStatement();
    }

    @When("^I enter my organization provider statement$")
    public void i_enter_my_organization_provider_statement() {
        applicationSteps.signProviderStatement();
    }

    @When("^I submit the application$")
    public void i_submit_the_application() {
        applicationSteps.submitApplication();
    }

    @When("^I am entering ownership information$")
    public void i_am_entering_ownership_information() throws IOException {
        i_am_on_the_ownership_info_page();
        applicationSteps.enterOrganizationOwnershipInfo();
    }

    @Given("^I have indicated that the owner has an interest in another Medicaid disclosing entity$")
    public void i_have_indicated_that_the_owner_has_an_interest_in_another_Medicaid_disclosing_entity() {
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

    @When("^I click 'next' on the license info page$")
    public void i_click_next_on_the_license_info_page() {
        licenseInfoPage.clickNext();
    }

    @Then("^the city should be accepted$")
    public void the_city_should_be_accepted() {
        assertThat(applicationPage.getTitle()).isEqualTo("Summary Information");
    }

    @When("^I enter valid personal information$")
    public void enter_valid_personal_information() {
        applicationSteps.enterIndividualPersonalInfo();
    }

    @Then("^I can move on from the personal info page with no errors$")
    public void i_will_move_on_from_the_personal_info_page_with_no_errors() {
        applicationSteps.advanceFromIndividualPersonalInfoToLicenseInfo();
    }

    @When("^I start to renew Individual Application '(.+)'$")
    public void i_start_to_renew_individual_application(String npi) {
        applicationSteps.startToRenewIndividualApplication(npi);
    }

    @When("^I start to renew Organizational Application '(.+)'$")
    public void i_start_to_renew_organizational_application(String npi) {
        applicationSteps.startToRenewOrganizationalApplication(npi);
    }

    @When("^I renew Individual Application '(.+)'$")
    public void i_renew_individual_application(String npi) {
        applicationSteps.renewIndividualApplication(npi);
    }

    @When("^I renew Organizational Application '(.+)'$")
    public void i_renew_organizational_application(String npi) {
        applicationSteps.renewOrganizationalApplication(npi);
    }

    @When("^I update Individual Application '(.+)'$")
    public void i_update_individual_application(String npi) {
        applicationSteps.updateIndividualApplication(npi);
    }

    @When("^I update Organizational Application '(.+)'$")
    public void i_update_organizational_application(String npi) {
        applicationSteps.updateOrganizationalApplication(npi);
    }

    @When("^I edit the Individual Application '(.+)'$")
    public void i_edit_the_individual_application(String npi) {
        applicationSteps.editIndividualApplication(npi);
    }

    @When("^I edit the Organizational Application '(.+)'$")
    public void i_edit_the_organizational_application(String npi) {
        applicationSteps.editOrganizationalApplication(npi);
    }

    @Given("^I am going to use NPI '(.+)'$")
    public void i_am_going_to_use_npi(String npi) {
        applicationSteps.setNpi(npi);
    }

    @Given("^I am going to enroll as a Durable Medical Equipment provider$")
    public void i_am_going_to_enroll_as_a_durable_medical_equipment_provider() {
        applicationSteps.prepareDurableMedicalEquipment();
    }

    @Given("^I am going to enroll as a County Contracted Mental Health Rehab$")
    public void i_am_going_to_enroll_as_a_county_contracted_mental_health_rehab() {
        applicationSteps.prepareCountyContractedMentalHealthRehab();
    }

    @When("^I create and submit an application using the generic organization workflow$")
    public void i_create_and_submit_an_application_using_the_generic_organization_workflow() throws IOException {
        generalSteps.login("p1", "p1");
        applicationSteps.createApplication();
        applicationSteps.selectProviderType();
        applicationSteps.enterOrganizationInfo();
        applicationSteps.enterContactInfo();
        applicationSteps.advanceFromOrganizationInfoToOwnershipInfo();
        applicationSteps.enterOrganizationOwnershipInfo();
        applicationSteps.setNoToAllDisclosures();
        applicationSteps.advanceFromOrganizationOwnershipInfoToSummaryPage();
        applicationSteps.advanceFromOrganizationSummaryToProviderStatementPage();
        applicationSteps.signProviderStatement();
        applicationSteps.submitApplication();
    }

    @Given("^I am going to enroll as a Child and Teen Checkup Clinic")
    public void i_am_going_to_enroll_as_a_child_and_teen_checkup_clinic() {
        applicationSteps.prepareChildTeenCheckupClinic();
    }

    @When("^I create and submit an application using the organization with healthboard workflow$")
    public void i_create_and_submit_an_application_using_the_organization_with_healthboard_workflow() throws IOException {
        generalSteps.login("p1", "p1");
        applicationSteps.createApplication();
        applicationSteps.selectProviderType();
        applicationSteps.enterOrganizationInfo();
        applicationSteps.enterContactInfo();
        applicationSteps.advanceFromOrganizationInfoToLicenseInfo();
        applicationSteps.checkCommunityHealthboard();
        applicationSteps.advanceFromLicenseInfoToOwnershipInfo();
        applicationSteps.enterOrganizationOwnershipInfo();
        applicationSteps.setNoToAllDisclosures();
        applicationSteps.advanceFromOrganizationOwnershipInfoToSummaryPage();
        applicationSteps.advanceFromOrganizationSummaryToProviderStatementPage();
        applicationSteps.signProviderStatement();
        applicationSteps.submitApplication();
    }

    @When("^I create and submit an application using the county contracted mental health rehab workflow$")
    public void i_create_and_submit_an_application_using_the_county_contracted_mental_health_rehab_workflow() throws IOException {
        generalSteps.login("p1", "p1");
        applicationSteps.createApplication();
        applicationSteps.selectProviderType();
        applicationSteps.enterOrganizationInfo();
        applicationSteps.enterContactInfo();
        applicationSteps.advanceFromOrganizationInfoToLicenseInfo();
        applicationSteps.enterCcmhrInfo();
        applicationSteps.advanceFromOrganizationLicenseInfoToIndividualMemberInfo();
        applicationSteps.enterIndividualMember();
        applicationSteps.advanceFromOrganizationIndividualMemberInfoToOwnershipInfo();
        applicationSteps.enterOrganizationOwnershipInfo();
        applicationSteps.setNoToAllDisclosures();
        applicationSteps.advanceFromOrganizationOwnershipInfoToSummaryPage();
        applicationSteps.advanceFromOrganizationSummaryToProviderStatementPage();
        applicationSteps.signProviderStatement();
        applicationSteps.submitApplication();
    }
}
