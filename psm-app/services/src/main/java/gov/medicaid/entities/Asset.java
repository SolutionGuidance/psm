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

import javax.persistence.*;
import java.io.Serializable;

/**
 * Represents owned assets.
 *
 * @author TCSASSEMBLER
 * @version 1.0
 */

@javax.persistence.Entity
@Table(name = "owner_assets")
public class Asset implements Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "owner_asset_id")
    private long id;

    /**
     * Asset name.
     */
    @Column(name = "name")
    private String name;

    /**
     * Asset location.
     */
    @ManyToOne
    @JoinColumn(name = "address_id")
    private Address location;

    /**
     * Ownership type.
     */
    @ManyToOne
    @JoinColumn(name = "ownership_type_code")
    private OwnershipType ownershipType;

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Address getLocation() {
        return location;
    }

    public void setLocation(Address location) {
        this.location = location;
    }

    public OwnershipType getOwnershipType() {
        return ownershipType;
    }

    public void setOwnershipType(OwnershipType ownershipType) {
        this.ownershipType = ownershipType;
    }
}
