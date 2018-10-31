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

import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;
import gov.medicaid.features.application.ui.OrganizationInfoPage;
import gov.medicaid.features.general.steps.GeneralSteps;
import net.thucydides.core.annotations.Steps;

import java.io.IOException;

@SuppressWarnings("unused")
public class DataCoverageStepDefinitions {
    @Steps
    ApplicationSteps applicationSteps;

    @Steps
    GeneralSteps generalSteps;

    private OrganizationInfoPage organizationInfoPage;

    @When("^I enter valid license information$")
    public void enter_valid_license_information() {
        applicationSteps.enterLicenseInfo();
    }

    @When("^I enter valid personal care assistant license information with a renewal date$")
    public void enter_valid_personal_care_assistant_license_information_with_renewal_date() {
        applicationSteps.enterPersonCareAssistantLicenseInfoWithRenewalDate();
    }

    @When("^I enter valid personal care assistant license information without a renewal date$")
    public void enter_valid_personal_care_assistant_license_information_without_renewal_date() {
        applicationSteps.enterPersonCareAssistantLicenseInfoWithoutRenewalDate();
    }

    @When("^I enter license info where renewal date is before issue date$")
    public void enter_license_info_where_renewal_date_is_before_issue_date() {
        applicationSteps.enterLicenseInfoWithRenewalDateBeforeIssueDate();
    }

    @When("^I upload a valid license$")
    public void upload_valid_license() throws IOException {
        applicationSteps.uploadLicense();
    }

    @When("^I enter a valid private practice$")
    public void enter_valid_private_practice_information() {
        applicationSteps.enterIndividualPrivatePracticeInfo();
    }

    @Then("^I should be asked to enter Applicant Name, Contact Person, Contact phone$")
    public void i_should_be_asked_to_enter_Applicant_Name_Contact_Person_Contact_phone_Contact_email() {
        organizationInfoPage.verifyApplicantNameAccepted();
        organizationInfoPage.verifyContactNameAccepted();
        organizationInfoPage.verifyContactPhoneAccepted();
        organizationInfoPage.verifyContactEmailAccepted();
    }

    @Then("^I should be asked to enter Medicaid number$")
    public void i_should_be_asked_to_enter_Medicaid() {
        organizationInfoPage.verifyMedicaidNumberAccepted();
    }

    @Then("^I should be asked to enter Applicant Name, Contact Person$")
    public void i_should_be_asked_to_enter_Applicant_Name_Contact_Person() {
        organizationInfoPage.verifyApplicantNameAccepted();
        organizationInfoPage.verifyContactNameAccepted();
    }

    @Then("^I should be asked to enter Contact phone, Medicaid number$")
    public void i_should_be_asked_to_enter_Contact_phone_Medicaid_number() {
        organizationInfoPage.verifyContactPhoneAccepted();
        organizationInfoPage.verifyMedicaidNumberAccepted();
    }

    @Then("^the license is accepted$")
    public void license_is_accepted() {
        applicationSteps.advanceFromIndividualLicenseInfoToPracticeInfo();
    }

    @Then("^the personal care assistant license is accepted$")
    public void personal_care_assistant_license_is_accepted() {
        applicationSteps.
                advanceFromPersonalCareAssistantLicenseInfoToPracticeInfo();
    }

    @Then("^the practice information is accepted$")
    public void practice_information_is_accepted() {
        applicationSteps.advanceFromIndividualPracticeInfoToSummaryPage();
    }

    @Then("^the summary page shows expected information$")
    public void summary_information_is_correct() {
        applicationSteps.validatePersonalSummaryInformation();
        applicationSteps.validateLicenseSummaryInfo();
        applicationSteps.validatePracticeSummaryInformation();
    }

    @Then("^the application is successfully submitted$")
    public void application_is_successfully_submitted() {
        applicationSteps.verifySubmitModal();
        applicationSteps.closeSubmitModal();
    }
}
