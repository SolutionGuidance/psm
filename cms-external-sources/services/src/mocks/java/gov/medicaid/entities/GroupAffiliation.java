/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.entities;

/**
 * Represents a group affiliation.
 *
 * @author argolite, j3_guile
 * @version 1.0
 */
public class GroupAffiliation extends AuditableEntity {

    /**
     * Group Affiliation name.
     */
    private String name;

    /**
     * Group Affiliation NPI.
     */
    private String groupNPI;

    /**
     * Group Affiliation address.
     */
    private Address address;

    /**
     * Default empty constructor.
     */
    public GroupAffiliation() {
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
     * Gets the value of the field <code>groupNPI</code>.
     *
     * @return the groupNPI
     */
    public String getGroupNPI() {
        return groupNPI;
    }

    /**
     * Sets the value of the field <code>groupNPI</code>.
     *
     * @param groupNPI the groupNPI to set
     */
    public void setGroupNPI(String groupNPI) {
        this.groupNPI = groupNPI;
    }

    /**
     * Gets the value of the field <code>address</code>.
     *
     * @return the address
     */
    public Address getAddress() {
        return address;
    }

    /**
     * Sets the value of the field <code>address</code>.
     *
     * @param address the address to set
     */
    public void setAddress(Address address) {
        this.address = address;
    }
}
