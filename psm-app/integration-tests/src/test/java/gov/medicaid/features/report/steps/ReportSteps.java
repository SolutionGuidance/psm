package gov.medicaid.features.report.steps;

import net.thucydides.core.annotations.Step;

import gov.medicaid.features.report.ui.ReportPage;
import gov.medicaid.features.report.ui.DraftApplicationsPage;

public class ReportSteps {
    private ReportPage reportPage;
    private DraftApplicationsPage draftApplicationsPage;

    @Step
    public void downloadApplicationsByReviewerReport() {
        reportPage.click$(".downloadApplicationsByReviewerButton");
    }

    @Step
    public void navigateToDraftApplicationsReport() {
        reportPage.click$(".draftApplicationsLink");
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
    public void downloadDraftReportCsv() {
        draftApplicationsPage.click$(".downloadDraftApplications");
    }
}
