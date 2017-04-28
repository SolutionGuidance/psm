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
 * Represents provider type settings.
 *
 * @author TCSASSEMBLER
 * @version 1.0
 */
public class ProviderTypeSetting extends IdentifiableEntity {

    /**
     * The provider type code.
     */
    private String providerTypeCode;

    /**
     * The setting relationship type.
     */
    private String relationshipType;

    /**
     * The related entity type.
     */
    private String relatedEntityType;

    /**
     * The related entity code.
     */
    private String relatedEntityCode;

    /**
     * Empty constructor.
     */
    public ProviderTypeSetting() {

    }

    /**
     * Gets the value of the field <code>providerTypeCode</code>.
     *
     * @return the providerTypeCode
     */
    public String getProviderTypeCode() {
        return providerTypeCode;
    }

    /**
     * Sets the value of the field <code>providerTypeCode</code>.
     *
     * @param providerTypeCode the providerTypeCode to set
     */
    public void setProviderTypeCode(String providerTypeCode) {
        this.providerTypeCode = providerTypeCode;
    }

    /**
     * Gets the value of the field <code>relatedEntityType</code>.
     *
     * @return the relatedEntityType
     */
    public String getRelatedEntityType() {
        return relatedEntityType;
    }

    /**
     * Sets the value of the field <code>relatedEntityType</code>.
     *
     * @param relatedEntityType the relatedEntityType to set
     */
    public void setRelatedEntityType(String relatedEntityType) {
        this.relatedEntityType = relatedEntityType;
    }

    /**
     * Gets the value of the field <code>relatedEntityCode</code>.
     *
     * @return the relatedEntityCode
     */
    public String getRelatedEntityCode() {
        return relatedEntityCode;
    }

    /**
     * Sets the value of the field <code>relatedEntityCode</code>.
     *
     * @param relatedEntityCode the relatedEntityCode to set
     */
    public void setRelatedEntityCode(String relatedEntityCode) {
        this.relatedEntityCode = relatedEntityCode;
    }

    /**
     * Gets the value of the field <code>relationshipType</code>.
     * @return the relationshipType
     */
    public String getRelationshipType() {
        return relationshipType;
    }

    /**
     * Sets the value of the field <code>relationshipType</code>.
     * @param relationshipType the relationshipType to set
     */
    public void setRelationshipType(String relationshipType) {
        this.relationshipType = relationshipType;
    }
}
