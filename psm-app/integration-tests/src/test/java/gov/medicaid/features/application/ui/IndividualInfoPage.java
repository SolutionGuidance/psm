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

package gov.medicaid.features.application.ui;

public class IndividualInfoPage extends ApplicationPage {

    public void enterIndividualMember() {
        click($("#addMember"));
    }

    public void setIndividualOwnerNPI(String npi) {
        $("[name='_16_npi_0']").type(npi);
    }

    public void setIndividualOwnerName(String ownerName) {
        $("[name='_16_name_0']").sendKeys(ownerName);
    }

    public void setIndividualProviderType(String providerType) {
        $("[name='_16_providerType_0']").selectByVisibleText(providerType);
    }

    public void setIndividualOwnerSoSec(String soSec) {
        $("[name='_16_ssn_0']").sendKeys(soSec);
    }

    public void setIndividualHireDate(String hireDate) {
        sendKeysIndividually("[name='_16_startDate_0'", hireDate);
    }

    public void setIndividualOwnerDOB(String dob) {
        sendKeysIndividually("[name='_16_dob_0']", dob);
    }
}
