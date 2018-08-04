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
 * This class is used by the rules logically insert exceptions based on the provider type.
 */
public class ProviderTypeException {

    /**
     * The type of exception.
     */
    private String type;

    /**
     * The provider type.
     */
    private String providerType;

    /**
     * The specialty type.
     */
    private String specialtyType;

    /**
     * Creates a new instance using the given fields.
     *
     * @param type the type
     * @param providerType the provider type
     */
    public ProviderTypeException(String type, String providerType) {
        super();
        this.type = type;
        this.providerType = providerType;
    }

    /**
     * Gets the value of the field <code>type</code>.
     *
     * @return the type
     */
    public String getType() {
        return type;
    }

    /**
     * Sets the value of the field <code>type</code>.
     *
     * @param type the type to set
     */
    public void setType(String type) {
        this.type = type;
    }

    /**
     * Gets the value of the field <code>providerType</code>.
     *
     * @return the providerType
     */
    public String getProviderType() {
        return providerType;
    }

    /**
     * Sets the value of the field <code>providerType</code>.
     *
     * @param providerType the providerType to set
     */
    public void setProviderType(String providerType) {
        this.providerType = providerType;
    }

    /**
     * Gets the value of the field <code>specialtyType</code>.
     *
     * @return the specialtyType
     */
    public String getSpecialtyType() {
        return specialtyType;
    }

    /**
     * Sets the value of the field <code>specialtyType</code>.
     *
     * @param specialtyType the specialtyType to set
     */
    public void setSpecialtyType(String specialtyType) {
        this.specialtyType = specialtyType;
    }
}
