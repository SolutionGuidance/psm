/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.entities;

import java.io.IOException;
import java.io.Serializable;

import org.codehaus.jackson.JsonGenerationException;
import org.codehaus.jackson.map.JsonMappingException;
import org.codehaus.jackson.map.ObjectMapper;

/**
 * This serves as the base class for all persisted entities.
 *
 * @author argolite, j3_guile
 * @version 1.0
 */
public abstract class IdentifiableEntity implements Serializable {

    /**
     * JSON string generator.
     */
    private static final ObjectMapper OBJECT_MAPPER = new ObjectMapper();

    /**
     * The entity identifier.
     */
    private long id;

    /**
     * Default empty constructor.
     */
    public IdentifiableEntity() {
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

    /**
     * Create a JSON representation of this entity.
     *
     * @return a JSON string representing all the fields of this entity
     */
    public String toJSONString() {
        try {
            return OBJECT_MAPPER.writeValueAsString(this);
        } catch (JsonGenerationException e) {
            e.printStackTrace();
            // ignore
        } catch (JsonMappingException e) {
            e.printStackTrace();
            // ignore
        } catch (IOException e) {
            e.printStackTrace();
            // ignore
        }
        return "";
    }
}