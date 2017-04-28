/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.entities;

import java.util.List;

/**
 * Represents the search results.
 *
 * @author argolite, j3_guile
 * @version 1.0
 * @param <T> the type of the result list
 */
public class SearchResult<T> {

    /**
     * Result items.
     */
    private List<T> items;

    /**
     * Page size.
     */
    private int pageSize;

    /**
     * Page number.
     */
    private int pageNumber;

    /**
     * Total results.
     */
    private int total;

    /**
     * Total pages.
     */
    private int totalPages;

    /**
     * Default empty constructor.
     */
    public SearchResult() {
    }

    /**
     * Gets the value of the field <code>items</code>.
     *
     * @return the items
     */
    public List<T> getItems() {
        return items;
    }

    /**
     * Sets the value of the field <code>items</code>.
     *
     * @param items the items to set
     */
    public void setItems(List<T> items) {
        this.items = items;
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
     * Gets the value of the field <code>total</code>.
     *
     * @return the total
     */
    public int getTotal() {
        return total;
    }

    /**
     * Sets the value of the field <code>total</code>.
     *
     * @param total the total to set
     */
    public void setTotal(int total) {
        this.total = total;
    }

    /**
     * Gets the value of the field <code>totalPages</code>.
     *
     * @return the totalPages
     */
    public int getTotalPages() {
        return totalPages;
    }

    /**
     * Sets the value of the field <code>totalPages</code>.
     *
     * @param totalPages the totalPages to set
     */
    public void setTotalPages(int totalPages) {
        this.totalPages = totalPages;
    }
}
