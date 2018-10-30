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
 * Represents a provider type search criteria.
 */
public class ProviderTypeSearchCriteria extends SearchCriteria {

    /**
     * Type name.
     */
    private String typeName;

    /**
     * Default empty constructor.
     */
    public ProviderTypeSearchCriteria() {
    }

    /**
     * Gets the value of the field <code>typeName</code>.
     * @return the typeName
     */
    public String getTypeName() {
        return typeName;
    }

    /**
     * Sets the value of the field <code>typeName</code>.
     * @param typeName the typeName to set
     */
    public void setTypeName(String typeName) {
        this.typeName = typeName;
    }
}
