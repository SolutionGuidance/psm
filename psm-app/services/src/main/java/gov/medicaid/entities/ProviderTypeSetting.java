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

import javax.persistence.Column;
import javax.persistence.Id;
import javax.persistence.Table;
import java.io.Serializable;

/**
 * This class contains a polymorphic, application-side many-to-many relationship
 * between ProviderType and several other classes. It is a legacy pattern that
 * we are moving away from.
 */
@Deprecated
@javax.persistence.Entity
@Table(name = "provider_type_settings")
public class ProviderTypeSetting implements Serializable {
    @Id
    @Column(name = "provider_type_setting_id")
    private int id;

    /**
     * @see ProviderType
     */
    @Column(name = "provider_type_code")
    private String providerTypeCode;

    /**
     * Describes the relationship between the ProviderType and the related
     * entity; its value is one of a few constants.
     *
     * @see gov.medicaid.entities.dto.ViewStatics
     */
    @Column(name = "relationship_type")
    private String relationshipType;

    /**
     * The Java class name of the related entity.
     */
    @Column(name = "related_entity_type")
    private String relatedEntityType;

    /**
     * The primary key value of the related entity. The related entities always
     * inherit from LookupEntity, which defines the primary key as a string
     * named <code>code</code>.
     *
     * @see LookupEntity
     */
    @Column(name = "related_entity_code")
    private String relatedEntityCode;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getProviderTypeCode() {
        return providerTypeCode;
    }

    public void setProviderTypeCode(String providerTypeCode) {
        this.providerTypeCode = providerTypeCode;
    }

    public String getRelatedEntityType() {
        return relatedEntityType;
    }

    public void setRelatedEntityType(String relatedEntityType) {
        this.relatedEntityType = relatedEntityType;
    }

    public String getRelatedEntityCode() {
        return relatedEntityCode;
    }

    public void setRelatedEntityCode(String relatedEntityCode) {
        this.relatedEntityCode = relatedEntityCode;
    }

    public String getRelationshipType() {
        return relationshipType;
    }

    public void setRelationshipType(String relationshipType) {
        this.relationshipType = relationshipType;
    }
}
