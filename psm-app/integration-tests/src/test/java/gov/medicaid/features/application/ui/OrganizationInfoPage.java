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

import cucumber.api.PendingException;

public class OrganizationInfoPage extends ApplicationPage {
    private static final String ORGANIZATION_FEIN_ERROR_MESSAGE =
            "Organization FEIN length must be 9 characters.";

    public void setFEIN(String feinValue) {
        $("#fein").typeAndTab(feinValue);
    }

    public void verifyApplicantNameAccepted() {
        if (isOrganizaionalApplication()) {
            $("#legalName").sendKeys("verify_name");
        } else {
            $("#firstName").sendKeys("first_name");
            $("#middleName").sendKeys("MI");
            $("[name='_02_lastName']").sendKeys("last_name");
        }
    }

    public void verifyContactNameAccepted() {
        $("#contactName").sendKeys("contact_name");
    }

    public void verifyContactPhoneAccepted() {
        if (isOrganizaionalApplication()) {
            $("[name='_15_contactPhone1']").sendKeys("217");
            $("[name='_15_contactPhone2']").sendKeys("217");
            $("[name='_15_contactPhone3']").sendKeys("217");
        } else {
            throw new PendingException("Issue #346 - Capture contact phone # for individual provider applications");
        }
    }

    public void verifyContactEmailAccepted() {
        $("#contactEmail").sendKeys("contact_email");
    }

    public void verifyMedicaidNumberAccepted() {
        throw new PendingException("Issue #347 - Capture Medicaid Number for new Applications");
    }

    public boolean isPersonalApplication() {
        return this.getTitle().equals("Personal Information");
    }

    public boolean isOrganizaionalApplication() {
        return this.getTitle().equals("Organization Information");
    }

    public void setNPI(String npi) {
        $("[name='_15_npi']").type(npi);
    }

    public void setEffectiveDate(String effectiveDate) {
        sendKeysIndividually("[name='_15_effectiveDate']", effectiveDate);
    }

    public void setDoingBusinessAs(String dba) {
        $("#name").clear();
        $("#name").sendKeys(dba);
    }

    public void setLegalName(String legalName) {
        $("#legalName").sendKeys(legalName);
    }

    public void setCity(String city) {
        $(".cityInputFor").sendKeys(city);
    }

    public void selectState(String state) {
        $(".stateSelectFor").selectByVisibleText(state);
    }

    public void setAddr1(String addr1) {
        $("[name='_15_addressLine1']").sendKeys(addr1);
    }

    public void setZipcode(String zipcode) {
        $(".zipInputFor").sendKeys(zipcode);
    }

    public void selectCounty(String countyName) {
        $(".countySelectFor").selectByVisibleText(countyName);
    }

    public void setPhoneNumber(String phoneNumber) {
        $("[name='_15_phone1']").sendKeys(phoneNumber);
    }

    public void setContactName(String contactName) {
        $("#contactName").sendKeys(contactName);
    }

    public void setContactPhone(String contactPhone) {
        $("[name='_15_contactPhone1']").sendKeys(contactPhone);
    }

    public void setContactEmail(String contactEmail) {
        $("[name='_15_contactEmail']").sendKeys(contactEmail);
    }

    public void checkForFeinError() throws Exception {
        checkForFormError("_15_fein", ORGANIZATION_FEIN_ERROR_MESSAGE);
    }
}
