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
import net.serenitybdd.core.annotations.findby.By;

import java.time.LocalDate;

/**
 * PageObject to interact with the "Personal Info" step of an individual
 * provider application. This page is reached by logging in, creating an
 * application, and selecting an individual provider type.
 */
public class IndividualSummaryPage extends PsmPage {
    private static final String FIRST_LICENSE_ROW_SELECTOR =
            "#licenseTable > tbody > tr:nth-child(1)";
    private static final String PRACTICE_ADDRESS_SELECTOR = ".h-adr.practice";
    private static final String BILLING_ADDRESS_SELECTOR = ".h-adr.billing";

    public String getFirstName() {
        return textOf("#firstName");
    }

    public String getMiddleName() {
        return textOf("#middleName");
    }

    public String getLastName() {
        return textOf("#lastName");
    }

    public String getNPI() {
        return textOf("#npi");
    }

    public String getSSN() {
        return textOf("#ssn");
    }

    public LocalDate getDOB() {
        return parseDateField("#dob");
    }

    public String getEmail() {
        return textOf("#email");
    }

    public boolean isProviderAtPublicHealthServiceIndianHospital() {
        return parseYesNoField("#worksOnReservation");
    }

    public String getFirstLicenseType() {
        return textOf(FIRST_LICENSE_ROW_SELECTOR + " > td:nth-child(2)");
    }

    public String getFirstLicenseNumber() {
        return textOf(FIRST_LICENSE_ROW_SELECTOR + " > td:nth-child(3)");
    }

    public LocalDate getFirstLicenseOriginalIssueDate() {
        return parseDateField(FIRST_LICENSE_ROW_SELECTOR + " > td:nth-child(4)");
    }

    public LocalDate getFirstLicenseRenewalEndDate() {
        return parseDateField(FIRST_LICENSE_ROW_SELECTOR + " > td:nth-child(5)");
    }

    public String getFirstLicenseIssuingState() {
        return textOf(FIRST_LICENSE_ROW_SELECTOR + " > td:nth-child(6)");
    }

    public boolean isPrivatePractice() {
        return parseYesNoField("#maintainsOwnPrivatePractice");
    }

    public boolean isPartOfGroupPractice() {
        return parseYesNoField("#employedOrContractedByGroup");
    }

    public String getPrivatePracticeName() {
        return textOf("#privatePracticeName");
    }

    public String getPrimaryPracticeName() {
        return textOf("#primaryPracticeName");
    }

    public String getGroupNPI() {
        return textOf("#groupNPI");
    }

    public LocalDate getEffectiveDate() {
        return parseDateField("#effectiveDate");
    }

    public String getPracticeAddressLine1() {
        return textOf(PRACTICE_ADDRESS_SELECTOR + " > .p-street-address");
    }

    public String getPracticeAddressLine2() {
        return textOf(PRACTICE_ADDRESS_SELECTOR + " > .p-extended-address");
    }

    public String getPracticeCity() {
        return textOf(PRACTICE_ADDRESS_SELECTOR + " > .p-locality");
    }

    public String getPracticeState() {
        return textOf(PRACTICE_ADDRESS_SELECTOR + " > .p-region.state");
    }

    public String getPracticeZip() {
        return textOf(PRACTICE_ADDRESS_SELECTOR + " > .p-postal-code");
    }

    public String getPracticeCounty() {
        return textOf(PRACTICE_ADDRESS_SELECTOR + " > .p-region.county");
    }

    public String getPracticePhoneNumber() {
        return textOf("#practicePhoneNumber");
    }

    public String getPracticeFaxNumber() {
        return textOf("#practiceFaxNumber");
    }

    public boolean isBillingAddressSameAsPracticeAddress() {
        return 0 < getDriver().findElements(By.id("billingSameAsPrimary")).size();
    }

    public String getBillingAddressLine1() {
        return textOf(BILLING_ADDRESS_SELECTOR + " > .p-street-address");
    }

    public String getBillingAddressLine2() {
        return textOf(BILLING_ADDRESS_SELECTOR + " > .p-extended-address");
    }

    public String getBillingCity() {
        return textOf(BILLING_ADDRESS_SELECTOR + " > .p-locality");
    }

    public String getBillingState() {
        return textOf(BILLING_ADDRESS_SELECTOR + " > .p-region.state");
    }

    public String getBillingZip() {
        return textOf(BILLING_ADDRESS_SELECTOR + " > .p-postal-code");
    }

    public String getBillingCounty() {
        return textOf(BILLING_ADDRESS_SELECTOR + " > .p-region.county");
    }

    public String getFein() {
        return textOf("#fein");
    }

    public String getStateTaxId() {
        return textOf("#stateTaxId");
    }

    public String getFiscalYearEnd() {
        return textOf("#fiscalYearEnd");
    }

    public Boolean getEftAccepted() {
        return parseYesNoField("#eftAccepted");
    }

    public String getRemittanceSequence() {
        return textOf("#remittanceSequence");
    }

    public void clickNext() {
        click($(".nextBtn"));
    }

    private String textOf(String xpathOrCssSelector) {
        return $(xpathOrCssSelector).getText();
    }

    private LocalDate parseDateField(String xpathOrCssSelector) {
        return LocalDate.parse(
                textOf(xpathOrCssSelector),
                DATE_FORMATTER
        );
    }

    private boolean parseYesNoField(String xpathOrCssSelector) {
        return textOf(xpathOrCssSelector).contains("Yes");
    }
}
