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
import javax.persistence.Id;
import javax.persistence.MappedSuperclass;
import java.io.Serializable;

/**
 * Represents a lookup entity.
 */
@MappedSuperclass
public class LookupEntity implements Serializable {

    /**
     * Lookup code.
     */
    @Id
    private String code;

    /**
     * Lookup description.
     */
    @Column(unique = true)
    private String description;

    /**
     * Empty constructor.
     */
    public LookupEntity() {
    }

    /**
     * Gets the value of the field <code>code</code>.
     *
     * @return the code
     */
    public String getCode() {
        return code;
    }

    /**
     * Sets the value of the field <code>code</code>.
     *
     * @param code the code to set
     */
    public void setCode(String code) {
        this.code = code;
    }

    /**
     * Gets the value of the field <code>description</code>.
     *
     * @return the description
     */
    public String getDescription() {
        return description;
    }

    /**
     * Sets the value of the field <code>description</code>.
     *
     * @param description the description to set
     */
    public void setDescription(String description) {
        this.description = description;
    }
}
