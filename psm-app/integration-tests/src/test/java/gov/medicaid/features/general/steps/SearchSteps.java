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

import gov.medicaid.features.PsmPage;
import gov.medicaid.features.application.ui.ApplicationListPage;
import gov.medicaid.features.general.ui.AdvancedSearchPage;
import gov.medicaid.features.general.ui.AllApplicationsPage;
import net.thucydides.core.annotations.Step;

public class SearchSteps {
    PsmPage psmPage;
    AllApplicationsPage allApplicationsPage;
    AdvancedSearchPage advancedSearchPage;
    ApplicationListPage applicationListPage;

    @Step
    public void filterByNpi(String npi) {
        applicationListPage.filterByNpi(npi);
    }

    @Step
    public void quickSearchByNpi(String npi) {
        allApplicationsPage.quickSearch(npi);
    }

    @Step
    public void advancedSearchByNpi(String npi) {
        advancedSearchPage.searchByNpi(npi);
    }

    @Step
    public void verifySearchResults() {
        applicationListPage.checkApplicationsInTable();
    }
}
