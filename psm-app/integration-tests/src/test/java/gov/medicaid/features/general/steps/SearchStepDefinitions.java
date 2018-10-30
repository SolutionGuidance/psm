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

package gov.medicaid.features.general.steps;

import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;

import net.thucydides.core.annotations.Steps;

public class SearchStepDefinitions {
    @Steps
    SearchSteps searchSteps;

    @Steps
    GeneralSteps generalSteps;

    @Given("^I am on the Advanced Search page$")
    public void i_am_on_the_advanced_search_page() {
        generalSteps.navigateToAdvancedSearchPage();
    }

    @When("^I filter by NPI '(.*)'$")
    public void i_filter_by_npi(String npi) {
        searchSteps.filterByNpi(npi);
    }

    @Then("^I should see search results$")
    public void i_should_see_search_results() {
        searchSteps.verifySearchResults();
    }

    @When("^I do a quick search for NPI '(.*)'$")
    public void i_do_a_quick_search_for_NPI(String npi) {
        searchSteps.quickSearchByNpi(npi);
    }

    @When("^I do an advanced search for NPI '(.*)'$")
    public void i_do_an_advanced_search_for_NPI(String npi) {
        searchSteps.advancedSearchByNpi(npi);
    }
}
