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

public class ReviewedDocumentsReportStepDefinitions {
    @Steps
    private ReviewedDocumentsReportSteps reviewedDocumentsSteps;

    @Then("^I should see the reviewed documents page$")
    public void i_should_see_the_reviewed_documents_page() {
        reviewedDocumentsSteps.checkOnReviewedDocumentsPage();
    }

    @Then("^I should see a reviewed documents row for '(.*)' with '(\\d+)' documents$")
    public void i_should_see_a_reviewed_documents_row_for_with_documents(String month, String numDocuments) {
        reviewedDocumentsSteps.checkReviewedDocumentsPageHasRowWithApplications(month, numDocuments);
    }

    @Given("^I download the reviewed documents report$")
    public void i_download_the_reviewed_documents_report() {
        reviewedDocumentsSteps.downloadReviewedDocumentsReportCsv();
    }
}
