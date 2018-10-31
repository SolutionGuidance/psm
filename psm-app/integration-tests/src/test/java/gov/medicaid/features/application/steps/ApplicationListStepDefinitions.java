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

package gov.medicaid.features.application.steps;

import cucumber.api.java.en.Then;

import net.thucydides.core.annotations.Steps;

public class ApplicationListStepDefinitions {
    @Steps
    ApplicationListSteps applicationListSteps;

    @Then("^I should see applications$")
    public void i_should_see_applications() {
        applicationListSteps.verifyApplicationsInTable();
    }
}
