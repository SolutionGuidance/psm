/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
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
