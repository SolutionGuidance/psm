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

    @Given("^I search for applications by reviewer with cleared dates$")
    public void i_search_for_applications_by_reviewer_with_cleared_dates() throws Exception {
        reportSteps.searchApplicationsInReviewWithClearedDates();
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

    @Given("^I am on the time to review page$")
    public void i_am_on_the_time_to_review_page() throws Exception {
        i_am_on_the_reports_page();
        reportSteps.navigateToTimeToReviewReport();
    }

    @Then("^I should see the time to review page$")
    public void i_should_see_the_time_to_review_page() throws Exception {
        reportSteps.checkOnTimeToReviewPage();
    }

    @Then("^I should see a time to review row for '(.*)' with (\\d+) enrollments$")
    public void i_should_see_a_time_to_review_row_for_with_enrollments(String month, String numEnrollments) throws Exception {
        reportSteps.checkTimeToReviewPageHasRowWithEnrollments(month, numEnrollments);
    }

    @Then("^I should see a N/A time to review row for '(.*)'$")
    public void i_should_see_a_N_A_time_to_review_row_for(String month) throws Exception {
        reportSteps.checkTimeToReviewPageHasNARowFor(month);
    }

    @Given("^I download the time to review report$")
    public void i_download_the_time_to_review_report() throws Exception {
        reportSteps.downloadTimeToReviewReportCsv();
    }

    @Given("^I am on the provider types page$")
    public void i_am_on_the_provider_types_page() {
        i_am_on_the_reports_page();
        reportSteps.navigateToProviderTypesReport();
    }

    @Then("^I should see the provider types page$")
    public void i_should_see_the_provider_types_page() {
        reportSteps.checkOnProviderTypesPage();
    }

    @Then("^I should see a provider types table with '(\\d+)' enrollments for '(.*)' in month '(.*)'$")
    public void i_should_see_a_provider_types_table_with_enrollments_for_type_in_month(
        int numEnrollments,
        String providerTypeDesc,
        String month
    ) {
        reportSteps.checkProviderTypesPageHasEnrollmentsForMonth(numEnrollments, providerTypeDesc, month);
    }

    @Then("^I should see no results for month '(.*)'$")
    public void i_should_see_no_results_for_month(String month) {
        reportSteps.checkProviderTypesPageHasNoResultsForMonth(month);
    }

    @Given("^I select the provider type '(.*)'$")
    public void i_select_the_provider_type(String providerTypeDesc) {
        reportSteps.selectProviderTypeOption(providerTypeDesc);
    }

    @Given("^I filter for provider types$")
    public void i_filter_for_provider_types() {
        reportSteps.filterProviderTypes();
    }

    @Given("^I download the provider types report$")
    public void i_download_the_provider_types_report() {
        reportSteps.downloadProviderTypesReportCsv();
    }

    @Then("^I should see provider type '(.*)' selected$")
    public void i_should_see_provider_type_selected(String providerTypeDesc) {
        reportSteps.checkProviderTypeSelected(providerTypeDesc);
    }

    @Then("^I should have no errors$")
    public void i_should_have_no_errors() throws Exception {
        generalSteps.hasNoServerError();
    }
}
