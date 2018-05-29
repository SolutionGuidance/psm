package gov.medicaid.features.report.steps;

import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;

import net.thucydides.core.annotations.Steps;

public class ApplicationsByReviewerReportStepDefinitions {
    @Steps
    private ApplicationsByReviewerReportSteps applicationsByReviewerSteps;

    @Given("^I download the applications by reviewer report$")
    public void i_download_the_applications_by_reviewer_report() {
        applicationsByReviewerSteps.downloadApplicationsByReviewerReport();
    }

    @Given("^I search for applications by reviewer between '([^']*)' and '([^']*)'$")
    public void i_search_for_applications_by_reviewer_between(String d1, String d2) {
        applicationsByReviewerSteps.searchApplicationsInReviewBetween(d1, d2);
    }

    @Given("^I search for applications by reviewer with cleared dates$")
    public void i_search_for_applications_by_reviewer_with_cleared_dates() {
        applicationsByReviewerSteps.searchApplicationsInReviewWithClearedDates();
    }

    @Given("^I click on enrollment '(\\d+)'$")
    public void i_click_on_enrollment(int enrollmentId) {
        applicationsByReviewerSteps.clickOnEnrollment(enrollmentId);
    }

    @Then("^I should see no applications by reviewer results$")
    public void i_should_see_no_applications_by_reviewer_results() {
        applicationsByReviewerSteps.checkNoApplicationsByReviewerResults();
    }

    @Then("^I should see applications by reviewer results$")
    public void i_should_see_applications_by_reviewer_results() {
        applicationsByReviewerSteps.checkApplicationsByReviewerHasResults();
    }
}
