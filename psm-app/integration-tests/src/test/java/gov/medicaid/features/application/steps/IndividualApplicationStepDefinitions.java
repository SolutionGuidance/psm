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
import cucumber.api.java.en.When;

import gov.medicaid.features.general.steps.GeneralSteps;

import net.thucydides.core.annotations.Steps;

import java.io.IOException;

@SuppressWarnings("unused")
public class IndividualApplicationStepDefinitions {
    @Steps
    ApplicationStepDefinitions applicationStepDefinitions;

    @Steps
    ApplicationSteps applicationSteps;

    @Steps
    GeneralSteps generalSteps;

    @When("^I am on the personal info page$")
    public void i_am_on_the_personal_info_page() {
        applicationSteps.prepareSpeechLanguagePathologistApplication();
        applicationSteps.selectProviderType();
    }

    @When("I am on the individual provider license info page")
    public void i_am_on_the_individual_provider_license_info_page() {
        i_am_on_the_personal_info_page();
        applicationSteps.enterIndividualPersonalInfo();
        applicationSteps.advanceFromIndividualPersonalInfoToLicenseInfo();
    }

    @When("^I indicate I am a provider at a Public Health Service Indian Hospital$")
    public void i_indicate_i_am_a_provider_at_a_public_health_service_indian_hospital() {
        applicationSteps.inputProviderAtPublicHealthServiceIndianHospital(true);
    }

    @When("^I indicate I am not a provider at a Public Health Service Indian Hospital$")
    public void i_indicate_i_am_not_a_provider_at_a_public_health_service_indian_hospital() {
        applicationSteps.inputProviderAtPublicHealthServiceIndianHospital(false);
    }

    @When("^I am on the individual provider practice info page$")
    public void i_am_on_the_individual_provider_practice_info_page() throws IOException {
        i_am_on_the_individual_provider_license_info_page();
        i_indicate_i_am_not_a_provider_at_a_public_health_service_indian_hospital();
        applicationSteps.enterLicenseInfo();
        applicationSteps.uploadLicense();
        applicationSteps.advanceFromIndividualLicenseInfoToPracticeInfo();
    }

    @When("^I indicate I maintain my own private practice$")
    public void i_indicate_i_maintain_my_own_private_practice() {
        applicationSteps.indicateMaintainOwnPrivatePractice(true);
    }

    @When("^I indicate I do not maintain my own private practice$")
    public void i_indicate_i_do_not_maintain_my_own_private_practice() {
        applicationSteps.indicateMaintainOwnPrivatePractice(false);
    }

    @When("^I indicate I am employed or independently contracted by a group practice$")
    public void i_indicate_i_am_employed_or_independently_contracted_by_a_group_practice() {
        applicationSteps.indicateGroupPractice(true);
    }

    @When("^I start to add a practice location$")
    public void i_start_to_add_a_practice_location() {
        applicationSteps.clickAddPracticeLocation();
    }

    @When("^I open the practice lookup modal$")
    public void i_open_the_practice_lookup_modal() {
        applicationSteps.openPracticeLookupModal();
    }

    @When("^I am on the individual summary page$")
    public void i_am_on_the_individual_summary_page() throws IOException {
        i_am_on_the_individual_provider_practice_info_page();
        applicationSteps.enterIndividualPrivatePracticeInfo();
        applicationSteps.advanceFromIndividualPracticeInfoToSummaryPage();
    }

    @When("^I am on the individual provider statement page$")
    public void i_am_on_the_individual_provider_statement_page() throws IOException {
        i_am_on_the_individual_summary_page();
        applicationSteps.advanceFromIndividualSummaryToProviderStatementPage();
    }

    @When("^I save the application as a draft$")
    public void i_save_the_application_as_a_draft() {
        applicationSteps.clickSaveAsDraft();
        applicationSteps.closeSaveAsDraftModal();
    }

    @Given("^I am going to enroll as a Personal Care Assistant$")
    public void i_am_going_to_enroll_as_a_personal_care_assistant() {
        applicationSteps.preparePersonalCareAssistantApplication();
    }

    @When("^I create and submit an application using the PCA workflow$")
    public void i_create_and_submit_an_application_using_the_pca_workflow() throws IOException {
        applicationStepDefinitions.i_have_started_an_application();
        applicationSteps.selectProviderType();
        applicationSteps.enterPersonCareAssistantIndividualPersonalInfo();
        applicationSteps.enterPersonCareAssistantLicenseInfoWithRenewalDate();
        applicationSteps.uploadLicense();
        applicationSteps.advanceFromPersonalCareAssistantLicenseInfoToPracticeInfo();
        applicationSteps.enterPersonCareAssistantAgencyInfo();
        applicationSteps.advanceFromIndividualSummaryToProviderStatementPage();
        applicationStepDefinitions.i_enter_my_provider_statement();
        applicationSteps.submitApplication();
    }
}
