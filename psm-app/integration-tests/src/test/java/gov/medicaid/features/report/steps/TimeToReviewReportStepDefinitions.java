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

    @Then("^I should see a time to review row for '(.*)' with (\\d+) enrollments$")
    public void i_should_see_a_time_to_review_row_for_with_enrollments(String month, String numEnrollments) {
        timeToReviewSteps.checkTimeToReviewPageHasRowWithEnrollments(month, numEnrollments);
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
