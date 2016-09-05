/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.entities;

/**
 * Represents a help item.
 *
 * @author argolite, TCSASSEMBLER
 * @version 1.0
 */
public class HelpItem extends IdentifiableEntity {

    /**
     * The title.
     */
    private String title;

    /**
     * The description.
     */
    private String description;

    /**
     * Default empty constructor.
     */
    public HelpItem() {
    }

    /**
     * Gets the value of the field <code>title</code>.
     * @return the title
     */
    public String getTitle() {
        return title;
    }

    /**
     * Sets the value of the field <code>title</code>.
     * @param title the title to set
     */
    public void setTitle(String title) {
        this.title = title;
    }

    /**
     * Gets the value of the field <code>description</code>.
     * @return the description
     */
    public String getDescription() {
        return description;
    }

    /**
     * Sets the value of the field <code>description</code>.
     * @param description the description to set
     */
    public void setDescription(String description) {
        this.description = description;
    }
}
