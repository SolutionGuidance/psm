/*
 * Copyright 2018 The MITRE Corporation
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

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
