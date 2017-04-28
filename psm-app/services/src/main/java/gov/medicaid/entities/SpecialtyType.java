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
package gov.medicaid.entities;

/**
 * This represents a specialty type.
 *
 * @author TCSASSEMBLER
 * @version 1.0
 */
public class SpecialtyType extends LookupEntity {

    /**
     * Specialty subcategory.
     */
    private String subCategory;

    /**
     * Default empty constructor.
     */
    public SpecialtyType() {
    }

    /**
     * Gets the value of the field <code>subCategory</code>.
     * @return the subCategory
     */
    public String getSubCategory() {
        return subCategory;
    }

    /**
     * Sets the value of the field <code>subCategory</code>.
     * @param subCategory the subCategory to set
     */
    public void setSubCategory(String subCategory) {
        this.subCategory = subCategory;
    }
}