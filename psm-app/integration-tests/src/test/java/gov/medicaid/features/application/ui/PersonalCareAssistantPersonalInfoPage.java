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

import gov.medicaid.features.PsmPage;

import java.time.LocalDate;

/**
 * PageObject to interact with the "Individual PCA Info" step of an individual
 * provider application. This page is reached by logging in, creating an
 * application, and selecting an individual provider type.
 */
public class PersonalCareAssistantPersonalInfoPage extends PsmPage {

    public void enterDOB(LocalDate dateOfBirth) {
        $("[name=_10_dob]").type(format(dateOfBirth));
    }

    public void enterFirstName(String firstName) {
        $("#firstName").type(firstName);
    }

    public void enterMiddleName(String middleName) {
        $("#middleName").type(middleName);
    }

    public void enterLastName(String lastName) {
        $("[name=_10_lastName]").type(lastName);
    }

    public void enterSSN(String SSN) {
        $("[name=_10_ssn]").type(SSN);
    }

    public void enterResidentialAddress(String residentialAddress) {
        $("[name=_10_addressLine1]")
                .type(residentialAddress);
    }

    public void enterCity(String city) {
        $("#ind_pca_information__10_city").type(city);
    }

    public void selectCounty(String countyName) {
        $(".countySelectFor").selectByVisibleText(countyName);
    }

    public void selectState(String state) {
        $(".stateSelectFor").selectByVisibleText(state);
    }

    public void setZipcode(String zipcode) {
        $(".zipInputFor").sendKeys(zipcode);
    }

    public void enterEmail(String email) {
        $("#emailAddress").type(email);
    }

    public void selectEighteenOrOlder() {
        click($("#ind_pca_information__10_adultInd_yes"));
    }

    public void clickNext() {
        click($(".nextBtn"));
    }

    public void addLicense() {
        click($("#addLicense"));
    }
}
