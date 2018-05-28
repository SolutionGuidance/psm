package gov.medicaid.features.report.steps;

import gov.medicaid.features.report.ui.ReportPage;

import net.thucydides.core.annotations.Step;

public class ReportSteps {
    private ReportPage reportPage;

    @Step
    public void checkOnReportPage() {
        reportPage.checkOnReportPage();
    }
}
