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

package gov.medicaid.domain.rules.inference;

/**
 * Represents a possible selection for the provider's specialty.
 */
public class ProviderSpecialty {

    /**
     * The provider type.
     */
    private String providerType;

    /**
     * The specialty.
     */
    private String specialty;

    /**
     * Creates a new specialty option.
     *
     * @param providerType the provider type
     * @param specialty the specialty type
     */
    public ProviderSpecialty(String providerType, String specialty) {
        super();
        this.providerType = providerType;
        this.specialty = specialty;
    }

    /**
     * Gets the value of the field <code>providerType</code>.
     * @return the providerType
     */
    public String getProviderType() {
        return providerType;
    }

    /**
     * Sets the value of the field <code>providerType</code>.
     * @param providerType the providerType to set
     */
    public void setProviderType(String providerType) {
        this.providerType = providerType;
    }

    /**
     * Gets the value of the field <code>specialty</code>.
     * @return the specialty
     */
    public String getSpecialty() {
        return specialty;
    }

    /**
     * Sets the value of the field <code>specialty</code>.
     * @param specialty the specialty to set
     */
    public void setSpecialty(String specialty) {
        this.specialty = specialty;
    }
}
