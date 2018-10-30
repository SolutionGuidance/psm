/*
 * Copyright 2012, 2013 TopCoder, Inc.
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

package gov.medicaid.entities;

/**
 * Represents supported Remittance sequence order.
 */
public enum RemittanceSequenceOrder {

    /**
     * By enrollee name.
     */
    BY_ENROLLEE_NAME(""),

    /**
     * By patient account.
     */
    PATIENT_ACCOUNT_OR_OWN_REFERENCE_ORDER("Patient Account or Own Reference Number Order"),

    /**
     * By transaction control.
     */
    DHS_TRANSACTION_CONTROL_ORDER("DHS Transaction Control Number Order"),

    /**
     * By MHCP ID.
     */
    RECIPIENT_MHCP_ID_NUMBER_ORDER("Recipient MHCP ID Number Order");

    private String description;

    RemittanceSequenceOrder(String desc) {
        this.setDescription(desc);
    }

    public String getDescription() {
        return this.description;
    }

    private void setDescription(String desc) {
        this.description = desc;
    }
}
