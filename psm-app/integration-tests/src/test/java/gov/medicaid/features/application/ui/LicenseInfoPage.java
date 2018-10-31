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

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;

import static org.assertj.core.api.Assertions.assertThat;

public class LicenseInfoPage extends PsmPage {
    private static final String RENEWAL_DATE_ERROR_MESSAGE =
            "cannot be earlier than Original Issue Date";

    public void checkProviderAtPublicHealthServiceIndianHospital(boolean checkYes) {
        if (checkYes) {
            click$("input[value='Y'");
            assertThat($(".reservationTableHeader").getText().contains("Reservation"));
        } else {
            click$("input[value='N'");
        }
    }

    public void addLicense() {
        click($("#addLicense, #addFacilityLicense"));
    }

    public void addLicenseType(String licenseType) {
        $("[name=_03_licenseType_0], [name=_21_licenseType_0]").selectByVisibleText(licenseType);
    }

    public void uploadSampleFile() throws IOException {
        File temporaryFile = File.createTempFile("License.", ".txt");
        try (PrintWriter writer = new PrintWriter(
                new FileOutputStream(temporaryFile))) {
            writer.println("License");
        }
        upload(temporaryFile.getAbsolutePath()).to($("[name=_03_attachment_0], [name=_21_attachment_0]"));
        temporaryFile.deleteOnExit();
    }

    public void enterLicenseNumber(String licenseNumber) {
        $("[name=_03_licenseNumber_0], [name=_21_licenseNumber_0]").type(licenseNumber);
    }

    public void enterIssueDate(LocalDate issueDate) {
        $("[name=_03_originalIssueDate_0], [name=_21_originalIssueDate_0]").type(
                format(issueDate)
        );
    }

    public void enterRenewalDate(LocalDate renewalDate) {
        $("[name=_03_renewalDate_0], [name=_21_renewalDate_0]").type(
                format(renewalDate)
        );
    }

    public void enterIssueState(String issueState) {
        $("[name=_03_issuingState_0], [name=_21_issuingState_0]").selectByVisibleText(issueState);
    }

    public void clickNext() {
        click($(".nextBtn"));
    }

    public void checkForRenewalDateError() throws Exception {
        assertThat($(".errorInfo > [class*='renewalDate']").getText())
                .contains(RENEWAL_DATE_ERROR_MESSAGE);
    }
}
