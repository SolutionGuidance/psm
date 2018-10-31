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

import cucumber.api.java.en.When;
import gov.medicaid.features.general.steps.GeneralSteps;
import net.thucydides.core.annotations.Steps;

@SuppressWarnings("unused")
public class ViewApplicationStepDefinitions {
    @Steps
    GeneralSteps generalSteps;

    @Steps
    AdminSteps adminSteps;

    @When("^I am on the View Application Organization Info page$")
    public void i_am_on_the_view_application_organization_info_page() {
        adminSteps.goToAdminPendingPage();
        adminSteps.advanceFromPendingPageToViewOrganizationInfoPage();
    }

    @When("^I am on the View Application Facility Credentials page$")
    public void i_am_on_the_view_application_facility_credentials_page() {
        i_am_on_the_view_application_organization_info_page();
        generalSteps.clickLinkAssertTitle(".license", "Facility Credentials");
    }

    @When("^I am on the View Application Individual Member Info page$")
    public void i_am_on_the_view_application_individual_member_info_page() {
        i_am_on_the_view_application_organization_info_page();
        generalSteps.clickLinkAssertTitle(".practice", "Member Information");
    }

    @When("^I am on the View Application Ownership Info page$")
    public void i_am_on_the_view_application_ownership_info_page() {
        i_am_on_the_view_application_organization_info_page();
        generalSteps.clickLinkAssertTitle(".ownership", "Ownership Information");
    }

    @When("^I am on the View Application Provider Statement page$")
    public void i_am_on_the_view_application_provider_statement_page() {
        i_am_on_the_view_application_organization_info_page();
        generalSteps.clickLinkAssertTitle(".provider", "Provider Statement");
    }
}
