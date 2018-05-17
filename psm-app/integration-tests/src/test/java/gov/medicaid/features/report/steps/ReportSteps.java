package gov.medicaid.features.report.steps;

import gov.medicaid.features.report.ui.ApplicationsByReviewerPage;
import gov.medicaid.features.report.ui.DraftApplicationsPage;
import gov.medicaid.features.report.ui.ProviderTypesPage;
import gov.medicaid.features.report.ui.ReportPage;
import gov.medicaid.features.report.ui.TimeToReviewPage;

import net.thucydides.core.annotations.Step;

public class ReportSteps {
    private ReportPage reportPage;
    private DraftApplicationsPage draftApplicationsPage;
    private TimeToReviewPage timeToReviewPage;
    private ProviderTypesPage providerTypesPage;
    private ApplicationsByReviewerPage applicationsByReviewerPage;

    @Step
    public void searchApplicationsInReviewBetween(String d1, String d2) {
        applicationsByReviewerPage.submitSearch(d1, d2);
    }

    @Step
    public void searchApplicationsInReviewWithClearedDates() {
        applicationsByReviewerPage.clearDates();
        applicationsByReviewerPage.clickViewReportButton();
    }

    @Step
    public void checkNoApplicationsByReviewerResults() {
        applicationsByReviewerPage.checkHasNoResults();
    }

    @Step
    public void checkApplicationsByReviewerHasResults() {
        applicationsByReviewerPage.checkHasResults();
    }

    @Step
    public void downloadApplicationsByReviewerReport() {
        reportPage.click$(".downloadApplicationsByReviewerLink");
    }

    @Step
    public void navigateToDraftApplicationsReport() {
        reportPage.click$(".draftApplicationsLink");
    }

    @Step
    public void navigateToTimeToReviewReport() {
        reportPage.click$(".timeToReviewLink");
    }

    @Step
    public void checkOnReportPage() {
        reportPage.checkOnReportPage();
    }

    @Step
    public void checkDraftApplicationsPageHasTableFor(String month) {
        draftApplicationsPage.checkHasTableFor(month);
    }

    @Step
    public void checkOnDraftApplicationsPage() {
        draftApplicationsPage.checkOnPage();
    }

    @Step
    public void checkOnTimeToReviewPage() {
        timeToReviewPage.checkOnPage();
    }

    @Step
    public void checkTimeToReviewPageHasNARowFor(String month) {
        timeToReviewPage.checkHasRowFor(month);
        timeToReviewPage.checkRowHasMean(month, "N/A");
        timeToReviewPage.checkRowHasMedian(month, "N/A");
    }

    @Step
    public void checkTimeToReviewPageHasRowWithEnrollments(String month, String numEnrollments) {
        timeToReviewPage.checkHasRowFor(month);
        timeToReviewPage.checkRowHasNumber(month, numEnrollments);
    }

    @Step
    public void downloadDraftReportCsv() {
        draftApplicationsPage.click$(".downloadDraftApplications");
    }

    @Step
    public void downloadTimeToReviewReportCsv() {
        timeToReviewPage.click$(".downloadTimeToReview");
    }

    @Step
    public void navigateToProviderTypesReport() {
        reportPage.click$(".providerTypesLink");
    }

    @Step
    public void checkProviderTypesPageHasEnrollmentsForMonth(
        int numEnrollments,
        String providerTypeDesc,
        String month
    ) {
        providerTypesPage.checkEnrollmentsForMonth(numEnrollments, providerTypeDesc, month);
    }

    @Step
    public void checkProviderTypesPageHasNoResultsForMonth(String month) {
        providerTypesPage.checkHasNoResultsForMonth(month);
    }

    @Step
    public void selectProviderTypeOption(String providerTypeDesc) {
        providerTypesPage.selectProviderType(providerTypeDesc);
    }

    @Step
    public void filterProviderTypes() {
        providerTypesPage.click$(".viewProviderTypesButton");
    }

    @Step
    public void checkProviderTypeSelected(String providerTypeDesc) {
        providerTypesPage.checkProviderTypeSelected(providerTypeDesc);
    }

    @Step
    public void checkOnProviderTypesPage() {
        providerTypesPage.checkOnPage();
    }

    @Step
    public void downloadProviderTypesReportCsv() {
        providerTypesPage.click$(".downloadProviderTypes");
    }
}
