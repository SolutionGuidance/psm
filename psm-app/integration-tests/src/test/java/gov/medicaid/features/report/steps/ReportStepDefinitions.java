package gov.medicaid.features.report.steps;

import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;

import gov.medicaid.features.general.steps.GeneralSteps;

import net.thucydides.core.annotations.Steps;

public class ReportStepDefinitions {
    @Steps
    private ReportSteps reportSteps;

    @Steps
    private GeneralSteps generalSteps;

    @Given("^I am on the reports page$")
    public void i_am_on_the_reports_page() {
        generalSteps.clickLinkAssertTitle(".reportsLink", "Reports");
    }

    @Given("^I am on the applications by reviewer page$")
    public void i_am_on_the_applications_by_reviewer_page() {
        i_am_on_the_reports_page();
        generalSteps.clickLinkAssertTitle(
                ".applicationsByReviewerLink",
                "Applications by Reviewer"
        );
    }

    @Given("^I download the applications by reviewer report$")
    public void i_download_the_applications_by_reviewer_report() {
        reportSteps.downloadApplicationsByReviewerReport();
    }

    @Given("^I search for applications by reviewer between '([^']*)' and '([^']*)'$")
    public void i_search_for_applications_by_reviewer_between_and(String d1, String d2) throws Exception {
        reportSteps.searchApplicationsInReviewBetween(d1, d2);
    }

    @Given("^I search for applications by reviewer$")
    public void i_search_for_applications_by_reviewer() throws Exception {
        reportSteps.searchApplicationsInReview();
    }

    @Then("^I should see no results message$")
    public void i_should_see_no_results_message() throws Exception {
        reportSteps.checkNoApplicationsByReviewerResults();
    }

    @Then("^I should see results$")
    public void i_should_see_results() throws Exception {
        reportSteps.checkApplicationsByReviewerHasResults();
    }

    @Then("^I should see the reports page$")
    public void i_should_see_the_reports_page() {
        reportSteps.checkOnReportPage();
    }

    @Given("^I download the draft applications report$")
    public void i_download_the_draft_applications_report() throws Exception {
        reportSteps.downloadDraftReportCsv();
    }

    @Given("^I am on the draft applications page$")
    public void i_am_on_the_draft_applications_page() throws Exception {
        i_am_on_the_reports_page();
        reportSteps.navigateToDraftApplicationsReport();
    }

    @Then("^I should see the draft applications page$")
    public void i_should_see_the_draft_applications_page() throws Exception {
        reportSteps.checkOnDraftApplicationsPage();
    }

    @Then("^I should see some draft applications for '(.*)'$")
    public void i_should_see_some_draft_applications_for(String month) throws Exception {
        reportSteps.checkDraftApplicationsPageHasTableFor(month);
    }

    @Then("^I should have no errors$")
    public void i_should_have_no_errors() throws Exception {
        generalSteps.hasNoServerError();
    }
}
