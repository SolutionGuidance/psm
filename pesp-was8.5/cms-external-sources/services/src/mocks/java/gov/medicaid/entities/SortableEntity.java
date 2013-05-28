/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.entities;

/**
 * This serves as the base class for all sortable entities.
 *
 * @author argolite, j3_guile
 * @version 1.0
 */
public abstract class SortableEntity extends IdentifiableEntity {

    /**
     * The lookup name.
     */
    private String sortColumn;

    /**
     * Default empty constructor.
     */
    public SortableEntity() {
    }

    /**
     * Gets the value of the field <code>sortColumn</code>.
     *
     * @return the sortColumn
     */
    public String getSortColumn() {
        return sortColumn;
    }

    /**
     * Sets the value of the field <code>sortColumn</code>.
     *
     * @param sortColumn the sortColumn to set
     */
    public void setSortColumn(String sortColumn) {
        this.sortColumn = sortColumn;
    }
}