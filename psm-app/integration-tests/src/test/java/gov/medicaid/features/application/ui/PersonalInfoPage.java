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

import static org.assertj.core.api.Assertions.assertThat;

/**
 * PageObject to interact with the "Personal Info" step of an individual
 * provider application. This page is reached by logging in, creating an
 * application, and selecting an individual provider type.
 */
public class PersonalInfoPage extends PsmPage {
    private static final String PROVIDER_TOO_YOUNG_ERROR_MESSAGE =
            "Provider age should be 18 or above during application.";

    private static final String SAME_AS_ABOVE_EMAIL_ERROR_MESSAGE =
            "Email Address is required when same as above is checked.";

    public void enterDOB(LocalDate dateOfBirth) {
        $("[name=_02_dob]").type(format(dateOfBirth));
    }

    public void enterFirstName(String firstName) {
        $("#firstName").type(firstName);
    }

    public void enterMiddleName(String middleName) {
        $("#middleName").type(middleName);
    }

    public void enterLastName(String lastName) {
        $("[name=_02_lastName]").type(lastName);
    }

    public void enterNPI(String NPI) {
        $("[name=_02_npi]").type(NPI);
    }

    public void enterSSN(String SSN) {
        $("[name=_02_ssn]").type(SSN);
    }

    public void enterEmail(String email) {
        $("#emailAddress").type(email);
    }

    public void checkSameAsAbove() {
        click($("#sameAsAbove"));
    }

    public void clickNext() {
        click($(".nextBtn"));
    }

    public void checkForTooYoungError() throws Exception {
        checkForFormError("_02_dob", PROVIDER_TOO_YOUNG_ERROR_MESSAGE);
    }

    public void checkForSameAsAboveEmailError() throws Exception {
        assertThat($(".errorInfo > ._02_email").getText())
                .contains(SAME_AS_ABOVE_EMAIL_ERROR_MESSAGE);
    }

    public void checkEmailAddressDisplaysAsRequired() throws Exception {
        assertThat($("#requireEmailAddressLabel.required") != null);
        assertThat($("requireEmailAddressLabel.required.hidden") == null);
    }
}
