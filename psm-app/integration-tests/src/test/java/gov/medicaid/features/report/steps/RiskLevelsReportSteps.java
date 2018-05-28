package gov.medicaid.features.report.steps;

import gov.medicaid.features.report.ui.RiskLevelsPage;

import net.thucydides.core.annotations.Step;

public class RiskLevelsReportSteps {
    private RiskLevelsPage riskLevelsPage;

    @Step
    public void checkOnRiskLevelsPage() {
        riskLevelsPage.checkOnPage();
    }

    @Step
    public void downloadRiskLevelsReportCsv() {
        riskLevelsPage.click$(".downloadRiskLevels");
    }

    @Step
    public void checkRiskLevelsPageHasRowWithNumInColumn(String month, String num, String riskLevel) {
        riskLevelsPage.checkHasRowFor(month);
        riskLevelsPage.checkRowHasNumInColumn(month, num, riskLevel);
    }
}
