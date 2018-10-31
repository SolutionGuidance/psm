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

public class ProviderTypesReportStepDefinitions {
    @Steps
    private ProviderTypesReportSteps providerTypesSteps;

    @Then("^I should see the provider types page$")
    public void i_should_see_the_provider_types_page() {
        providerTypesSteps.checkOnProviderTypesPage();
    }

    @Then("^I should see a provider types table with '(\\d+)' applications for '(.*)' in month '(.*)'$")
    public void i_should_see_a_provider_types_table_with_applications_for_type_in_month(
        int numApplications,
        String providerTypeDesc,
        String month
    ) {
        providerTypesSteps.checkProviderTypesPageHasApplicationsForMonth(numApplications, providerTypeDesc, month);
    }

    @Then("^I should see no results for month '(.*)'$")
    public void i_should_see_no_results_for_month(String month) {
        providerTypesSteps.checkProviderTypesPageHasNoResultsForMonth(month);
    }

    @Given("^I select the provider type '(.*)'$")
    public void i_select_the_provider_type(String providerTypeDesc) {
        providerTypesSteps.selectProviderTypeOption(providerTypeDesc);
    }

    @Given("^I filter for provider types$")
    public void i_filter_for_provider_types() {
        providerTypesSteps.filterProviderTypes();
    }

    @Given("^I download the provider types report$")
    public void i_download_the_provider_types_report() {
        providerTypesSteps.downloadProviderTypesReportCsv();
    }

    @Then("^I should see provider type '(.*)' selected$")
    public void i_should_see_provider_type_selected(String providerTypeDesc) {
        providerTypesSteps.checkProviderTypeSelected(providerTypeDesc);
    }
}
