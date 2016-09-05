/*
 * Copyright (C) 2013 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.entities;

import java.io.Serializable;

/**
 * This entity holds reference data of SAMSearch web service response.
 *
 * @author flexme
 * @version 1.0
 */
public class SAMReference implements Serializable {
    /**
     * Represents the name.
     */
    private String name;
    /**
     * Represents the type.
     */
    private String type;

    /**
     * Empty constructor.
     */
    public SAMReference() {
    }

    /**
     * Gets the name.
     *
     * @return the name.
     */
    public String getName() {
        return name;
    }

    /**
     * Sets the name.
     *
     * @param name the name.
     */
    public void setName(String name) {
        this.name = name;
    }

    /**
     * Gets the type.
     *
     * @return the type.
     */
    public String getType() {
        return type;
    }

    /**
     * Sets the type.
     *
     * @param type the type.
     */
    public void setType(String type) {
        this.type = type;
    }
}
