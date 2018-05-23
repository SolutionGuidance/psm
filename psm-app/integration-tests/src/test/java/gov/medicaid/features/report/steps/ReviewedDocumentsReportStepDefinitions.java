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
        reviewedDocumentsSteps.checkReviewedDocumentsPageHasRowWithEnrollments(month, numDocuments);
    }

    @Given("^I download the reviewed documents report$")
    public void i_download_the_reviewed_documents_report() {
        reviewedDocumentsSteps.downloadReviewedDocumentsReportCsv();
    }
}
