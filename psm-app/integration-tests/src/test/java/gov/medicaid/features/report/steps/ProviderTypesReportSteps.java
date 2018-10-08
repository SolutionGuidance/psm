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

import gov.medicaid.features.report.ui.ProviderTypesPage;

import net.thucydides.core.annotations.Step;

public class ProviderTypesReportSteps {
    private ProviderTypesPage providerTypesPage;

    @Step
    public void checkProviderTypesPageHasApplicationsForMonth(
        int numApplications,
        String providerTypeDesc,
        String month
    ) {
        providerTypesPage.checkApplicationsForMonth(numApplications, providerTypeDesc, month);
    }

    @Step
    public void checkProviderTypesPageHasNoResultsForMonth(String month) {
        providerTypesPage.checkHasNoResultsForMonth(month);
    }

    @Step
    public void selectProviderTypeOption(String providerTypeDesc) {
        providerTypesPage.selectProviderType(providerTypeDesc);
    }

    @Step
    public void filterProviderTypes() {
        providerTypesPage.click$(".viewProviderTypesButton");
    }

    @Step
    public void checkProviderTypeSelected(String providerTypeDesc) {
        providerTypesPage.checkProviderTypeSelected(providerTypeDesc);
    }

    @Step
    public void checkOnProviderTypesPage() {
        providerTypesPage.checkOnPage();
    }

    @Step
    public void downloadProviderTypesReportCsv() {
        providerTypesPage.click$(".downloadProviderTypes");
    }
}
