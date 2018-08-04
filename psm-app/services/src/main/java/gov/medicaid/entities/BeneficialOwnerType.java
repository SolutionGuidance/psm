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

import javax.persistence.Column;
import javax.persistence.Table;

@javax.persistence.Entity
@Table(name = "beneficial_owner_types")
public class BeneficialOwnerType extends LookupEntity {
    /**
     * Type of owner (P- person/O-org/A-any);
     */
    @Column(name = "owner_type")
    private String ownerType;

    /**
     * Gets the value of the field <code>ownerType</code>.
     * @return the ownerType
     */
    public String getOwnerType() {
        return ownerType;
    }

    /**
     * Sets the value of the field <code>ownerType</code>.
     * @param ownerType the ownerType to set
     */
    public void setOwnerType(String ownerType) {
        this.ownerType = ownerType;
    }
}
