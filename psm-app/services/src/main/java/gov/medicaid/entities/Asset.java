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
 * Represents owned assets.
 *
 * @author TCSASSEMBLER
 * @version 1.0
 */
public class Asset extends IdentifiableEntity {

    /**
     * The asset type.
     */
    private AssetType type;

    /**
     * Asset name.
     */
    private String name;

    /**
     * Asset location.
     */
    private Address location;

    /**
     * Ownership type.
     */
    private OwnershipType ownershipType;

    /**
     * Empty constructor.
     */
    public Asset() {
    }

    /**
     * Gets the value of the field <code>type</code>.
     *
     * @return the type
     */
    public AssetType getType() {
        return type;
    }

    /**
     * Sets the value of the field <code>type</code>.
     *
     * @param type the type to set
     */
    public void setType(AssetType type) {
        this.type = type;
    }

    /**
     * Gets the value of the field <code>name</code>.
     *
     * @return the name
     */
    public String getName() {
        return name;
    }

    /**
     * Sets the value of the field <code>name</code>.
     *
     * @param name the name to set
     */
    public void setName(String name) {
        this.name = name;
    }

    /**
     * Gets the value of the field <code>location</code>.
     *
     * @return the location
     */
    public Address getLocation() {
        return location;
    }

    /**
     * Sets the value of the field <code>location</code>.
     *
     * @param location the location to set
     */
    public void setLocation(Address location) {
        this.location = location;
    }

    /**
     * Gets the value of the field <code>ownershipType</code>.
     *
     * @return the ownershipType
     */
    public OwnershipType getOwnershipType() {
        return ownershipType;
    }

    /**
     * Sets the value of the field <code>ownershipType</code>.
     *
     * @param ownershipType the ownershipType to set
     */
    public void setOwnershipType(OwnershipType ownershipType) {
        this.ownershipType = ownershipType;
    }
}
