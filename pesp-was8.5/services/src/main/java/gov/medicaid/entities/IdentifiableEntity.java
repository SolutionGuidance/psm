/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.entities;

import java.io.Serializable;

/**
 * This serves as the base class for all persisted entities.
 *
 * @author TCSASSEMBLER
 * @version 1.0
 */
public abstract class IdentifiableEntity implements Serializable {

    /**
     * The entity identifier.
     */
    private long id;

    /**
     * Default empty constructor.
     */
    protected IdentifiableEntity() {
    }

    /**
     * Gets the value of the field <code>id</code>.
     *
     * @return the id
     */
    public long getId() {
        return id;
    }

    /**
     * Sets the value of the field <code>id</code>.
     *
     * @param id the id to set
     */
    public void setId(long id) {
        this.id = id;
    }
}