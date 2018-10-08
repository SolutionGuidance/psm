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

import static org.assertj.core.api.Assertions.assertThat;

public class ApplicationDetailsPage extends PsmPage {
    public void verifySubmitModal() {
        assertThat($("#submitApplicationModal > div.inner > " +
                "div.modal-content > div.right > div.middle").getText())
                .contains("The application has been successfully submitted");
    }

    public void closeSubmitModal() {
        click($("#submitApplicationModal a.okBtn"));
    }

    public void closeSaveAsDraftModal() {
        click$("#saveAsDraftModal a.okBtn");
    }
}
