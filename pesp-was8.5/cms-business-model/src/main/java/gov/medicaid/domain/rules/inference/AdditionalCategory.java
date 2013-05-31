/*
 * Copyright 2012-2013 TopCoder, Inc.
 *
 * This code was developed under U.S. government contract NNH10CD71C. 
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * You may not use this file except in compliance with the License.
 * You may obtain a copy of the License at:
 *     http://www.apache.org/licenses/LICENSE-2.0
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package gov.medicaid.domain.rules.inference;

/**
 * Represents a possible dual license selection for a provider type.
 *
 * @author TCSASSEMBLER
 * @version 1.0
 * @since Provider Enrollment Drools Front End Validation Part 2
 */
public class AdditionalCategory {

    /**
     * The provider type.
     */
    private String providerType;

    /**
     * The category/dual license type.
     */
    private String category;

    /**
     * Creates a new additional category option.
     *
     * @param providerType the provider type
     * @param category the dual license category that can be added
     */
    public AdditionalCategory(String providerType, String category) {
        super();
        this.providerType = providerType;
        this.category = category;
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
     * Gets the value of the field <code>category</code>.
     *
     * @return the category
     */
    public String getCategory() {
        return category;
    }

    /**
     * Sets the value of the field <code>category</code>.
     *
     * @param category the category to set
     */
    public void setCategory(String category) {
        this.category = category;
    }
}
