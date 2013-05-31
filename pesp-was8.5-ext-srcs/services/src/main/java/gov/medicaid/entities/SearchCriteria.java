/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.entities;

import gov.medicaid.entities.IdentifiableEntity;
import gov.medicaid.entities.SortOrder;

/**
 * This serves as the base class for all search criteria objects.
 *
 * <b>Thread Safety</b> This class is mutable and not thread safe.
 *
 * @author argolite, j3_guile
 * @version 1.0
 */
public abstract class SearchCriteria extends IdentifiableEntity {

    /**
     * The entity identifier.
     */
    private String identifier;

    /**
     * The entity last name.
     */
    private String lastName;

    /**
     * The entity first name.
     */
    private String firstName;

    /**
     * The entity state.
     */
    private String state;

    /**
     * The requested page size.
     */
    private int pageSize;

    /**
     * The requested page number.
     */
    private int pageNumber;

    /**
     * The requested sort order.
     */
    private SortOrder sortOrder;

    /**
     * The requested sort column.
     */
    private String sortColumn;

    /**
     * Default empty constructor.
     */
    protected SearchCriteria() {
    }

    /**
     * Gets the value of the field <code>identifier</code>.
     *
     * @return the identifier
     */
    public String getIdentifier() {
        return identifier;
    }

    /**
     * Sets the value of the field <code>identifier</code>.
     *
     * @param identifier the identifier to set
     */
    public void setIdentifier(String identifier) {
        this.identifier = identifier;
    }

    /**
     * Gets the value of the field <code>lastName</code>.
     *
     * @return the lastName
     */
    public String getLastName() {
        return lastName;
    }

    /**
     * Sets the value of the field <code>lastName</code>.
     *
     * @param lastName the lastName to set
     */
    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    /**
     * Gets the value of the field <code>firstName</code>.
     *
     * @return the firstName
     */
    public String getFirstName() {
        return firstName;
    }

    /**
     * Sets the value of the field <code>firstName</code>.
     *
     * @param firstName the firstName to set
     */
    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    /**
     * Gets the value of the field <code>state</code>.
     *
     * @return the state
     */
    public String getState() {
        return state;
    }

    /**
     * Sets the value of the field <code>state</code>.
     *
     * @param state the state to set
     */
    public void setState(String state) {
        this.state = state;
    }

    /**
     * Gets the value of the field <code>pageSize</code>.
     *
     * @return the pageSize
     */
    public int getPageSize() {
        return pageSize;
    }

    /**
     * Sets the value of the field <code>pageSize</code>.
     *
     * @param pageSize the pageSize to set
     */
    public void setPageSize(int pageSize) {
        this.pageSize = pageSize;
    }

    /**
     * Gets the value of the field <code>pageNumber</code>.
     *
     * @return the pageNumber
     */
    public int getPageNumber() {
        return pageNumber;
    }

    /**
     * Sets the value of the field <code>pageNumber</code>.
     *
     * @param pageNumber the pageNumber to set
     */
    public void setPageNumber(int pageNumber) {
        this.pageNumber = pageNumber;
    }

    /**
     * Gets the value of the field <code>sortOrder</code>.
     *
     * @return the sortOrder
     */
    public SortOrder getSortOrder() {
        return sortOrder;
    }

    /**
     * Sets the value of the field <code>sortOrder</code>.
     *
     * @param sortOrder the sortOrder to set
     */
    public void setSortOrder(SortOrder sortOrder) {
        this.sortOrder = sortOrder;
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