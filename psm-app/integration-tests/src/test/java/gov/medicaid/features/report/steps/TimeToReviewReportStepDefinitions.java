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

public class TimeToReviewReportStepDefinitions {
    @Steps
    private TimeToReviewReportSteps timeToReviewSteps;

    @Then("^I should see the time to review page$")
    public void i_should_see_the_time_to_review_page() {
        timeToReviewSteps.checkOnTimeToReviewPage();
    }

    @Then("^I should see a time to review row for '(.*)' with (\\d+) applications$")
    public void i_should_see_a_time_to_review_row_for_with_applications(String month, String numApplications) {
        timeToReviewSteps.checkTimeToReviewPageHasRowWithApplications(month, numApplications);
    }

    @Then("^I should see a N/A time to review row for '(.*)'$")
    public void i_should_see_a_N_A_time_to_review_row_for(String month) {
        timeToReviewSteps.checkTimeToReviewPageHasNARowFor(month);
    }

    @Given("^I download the time to review report$")
    public void i_download_the_time_to_review_report() {
        timeToReviewSteps.downloadTimeToReviewReportCsv();
    }
}
