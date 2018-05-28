package gov.medicaid.features.report.steps;

import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;

import net.thucydides.core.annotations.Steps;

public class RiskLevelsReportStepDefinitions {
    @Steps
    private RiskLevelsReportSteps riskLevelsSteps;

    @Then("^I should see the risk levels page$")
    public void i_should_see_the_risk_levels_page() {
        riskLevelsSteps.checkOnRiskLevelsPage();
    }

    @Then("^I should see a risk levels row for '(.*)' with '(\\d+)' in the '(.*)' column$")
    public void i_should_see_a_risk_levels_row_for_with_in_the_risklevel_column(
        String month,
        String num,
        String riskLevel
    ) {
        riskLevelsSteps.checkRiskLevelsPageHasRowWithNumInColumn(month, num, riskLevel);
    }

    @Given("^I download the risk levels report$")
    public void i_download_the_risk_levels_report() {
        riskLevelsSteps.downloadRiskLevelsReportCsv();
    }
}
