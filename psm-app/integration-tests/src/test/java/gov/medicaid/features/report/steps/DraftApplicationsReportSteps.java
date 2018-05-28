package gov.medicaid.features.report.steps;

import gov.medicaid.features.report.ui.DraftApplicationsPage;

import net.thucydides.core.annotations.Step;

public class DraftApplicationsReportSteps {
    private DraftApplicationsPage draftApplicationsPage;

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
