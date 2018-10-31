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

package gov.medicaid.features.general.steps;

import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;
import net.thucydides.core.annotations.Steps;

@SuppressWarnings("unused")
public class ChangePasswordStepDefinitions {
    @Steps
    GeneralSteps generalSteps;

    @Given("^I am on the All Applications page$")
    public void i_am_on_the_all_applications_page() {
        generalSteps.checkOnAllApplicationsPage();
    }

    @When("^I click on My Profile$")
    public void i_click_on_my_profile() {
        generalSteps.clickMyProfile();
    }

    @Then("^I should see the Change Password link$")
    public void i_should_see_change_password() {
        generalSteps.seeChangePassword();
    }

    @When("^I click on Change Password$")
    public void i_click_on_change_password() {
        generalSteps.clickChangePassword();
    }

    @Then("^I should see the Update Password page$")
    public void i_should_see_the_update_password_page() {
        generalSteps.seeUpdatePassword();
    }

    @Given("^I am on the Update Password page$")
    public void i_am_on_the_update_password_page() {
        generalSteps.navigateToUpdatePasswordPage();
    }
}
