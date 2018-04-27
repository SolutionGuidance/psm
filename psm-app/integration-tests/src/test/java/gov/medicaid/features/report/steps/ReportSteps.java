package gov.medicaid.features.report.steps;

import net.thucydides.core.annotations.Step;

import gov.medicaid.features.report.ui.ReportPage;

public class ReportSteps {
    private ReportPage reportPage;

    @Step
    public void downloadApplicationsApprovedReport() {
        reportPage.downloadApplicationsApprovedReport();
    }

    @Step
    public void checkOnReportPage() {
        reportPage.checkOnReportPage();
    }
}
