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

package gov.medicaid.features.report.steps;

import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;

import net.thucydides.core.annotations.Steps;

public class DraftApplicationsReportStepDefinitions {
    @Steps
    private DraftApplicationsReportSteps draftApplicationsSteps;

    @Given("^I download the draft applications report$")
    public void i_download_the_draft_applications_report() {
        draftApplicationsSteps.downloadDraftReportCsv();
    }

    @Then("^I should see the draft applications page$")
    public void i_should_see_the_draft_applications_page() {
        draftApplicationsSteps.checkOnDraftApplicationsPage();
    }

    @Then("^I should see some draft applications for '(.*)'$")
    public void i_should_see_some_draft_applications_for(String month) {
        draftApplicationsSteps.checkDraftApplicationsPageHasTableFor(month);
    }
}
