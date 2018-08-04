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

package gov.medicaid.features.service_admin.steps;

import cucumber.api.PendingException;
import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;
import gov.medicaid.features.general.steps.GeneralSteps;
import net.thucydides.core.annotations.Steps;

@SuppressWarnings("unused")
public class AdminStepDefinitions {
    @Steps
    GeneralSteps generalSteps;

    @Steps
    AdminSteps adminSteps;

    @Given("^I am logged in as an admin$")
    public void i_am_logged_in_as_an_admin() {
        generalSteps.login("admin", "admin");
    }

    @When("^I am on the admin All Enrollments page$")
    public void i_am_on_the_admin_all_enrollments_page() {
        adminSteps.goToAdminAllEnrollmentsPage();
    }

    @When("^I am on the admin Draft page$")
    public void i_am_on_the_admin_draft_page() {
        adminSteps.goToAdminDraftPage();
    }

    @When("^I am on the admin Pending page$")
    public void i_am_on_the_admin_pending_page() {
        adminSteps.goToAdminPendingPage();
    }

    @When("^I am on the admin Approved page$")
    public void i_am_on_the_admin_approved_page() {
        adminSteps.goToAdminApprovedPage();
    }

    @When("^I am on the admin Denied page$")
    public void i_am_on_the_admin_denied_page() {
        adminSteps.goToAdminDeniedPage();
    }

    @When("^I open the Write Note modal$")
    public void i_open_the_write_note_modal() {
        adminSteps.openWriteNoteModal();
    }

    @When("^I am on the Review Enrollment page$")
    public void i_am_on_the_review_enrollment_page() {
        adminSteps.goToAdminPendingPage();
        generalSteps.clickLinkAssertTitle(".reviewLink", "Review Enrollment");
    }

    @When("^I open the Review Enrollment page for NPI '(\\d+)'$")
    public void i_open_the_Review_Enrollment_page_for_NPI(String npi) {
        if (!adminSteps.npiRowExists(npi)) {
            throw new PendingException("No enrollment row for NPI: " + npi);
        }
        adminSteps.advanceFromPendingPageToReview(npi);
    }

    @Given("^I open the DMF Details page$")
    public void i_open_the_DMF_Details_page() {
        adminSteps.openDmfDetailsPage();
    }

    @When("^I am on the Screening Log page$")
    public void i_am_on_the_screening_log_page() {
        i_am_on_the_review_enrollment_page();
        // assert fails because the page is opened in a separate tab
        generalSteps.clickLinkAssertTitle(".autoScreeningResultLink", "Screening Log");
    }

    @When("^I am on the Screenings page$")
    public void i_am_on_the_screenings_page() {
        generalSteps.clickLinkAssertTitle(".screeningsLink", "Screenings");
    }

    @Then("^I am on the Personal Information page$")
    public void i_am_on_the_personal_information_page() {
        adminSteps.checkOnPersonalInformationPage();
    }
}
