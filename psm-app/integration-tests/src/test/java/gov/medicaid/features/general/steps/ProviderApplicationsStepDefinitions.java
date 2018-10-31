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

import cucumber.api.java.en.When;
import net.thucydides.core.annotations.Steps;

@SuppressWarnings("unused")
public class ProviderApplicationsStepDefinitions {
    @Steps
    GeneralSteps generalSteps;

    @When("^I am on the provider Draft page$")
    public void i_am_on_the_provider_draft_page() {
        generalSteps.goToProviderDraftPage();
    }

    @When("^I am on the provider Pending page$")
    public void i_am_on_the_provider_pending_page() {
        generalSteps.goToProviderPendingPage();
    }

    @When("^I am on the provider Approved page$")
    public void i_am_on_the_provider_approved_page() {
        generalSteps.goToProviderApprovedPage();
    }

    @When("^I am on the provider Denied page$")
    public void i_am_on_the_provider_denied_page() {
        generalSteps.goToProviderDeniedPage();
    }

    @When("^I open the filter panel$")
    public void i_open_the_filter_panel() {
        generalSteps.openFilterPanel();
    }
}
