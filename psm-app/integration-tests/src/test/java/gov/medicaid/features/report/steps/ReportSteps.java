package gov.medicaid.features.report.steps;

import gov.medicaid.features.report.ui.ApplicationsByReviewerPage;
import gov.medicaid.features.report.ui.DraftApplicationsPage;
import gov.medicaid.features.report.ui.TimeToReviewPage;
import gov.medicaid.features.report.ui.ReportPage;

import net.thucydides.core.annotations.Step;

public class ReportSteps {
    private ReportPage reportPage;
    private DraftApplicationsPage draftApplicationsPage;
    private TimeToReviewPage timeToReviewPage;
    private ApplicationsByReviewerPage applicationsByReviewerPage;

    @Step
    public void searchApplicationsInReviewBetween(String d1, String d2) {
        applicationsByReviewerPage.submitSearch(d1, d2);
    }

    @Step
    public void searchApplicationsInReview() {
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
        draftApplicationsPage.click$(".downloadTimeToReview");
    }
}
