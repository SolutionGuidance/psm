/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.entities;

/**
 * This serves as the base class for all search criteria objects.
 *
 * @author sampath01, TCSASSEMBLER
 * @version 1.0
 */
public abstract class SearchCriteria {

    /**
     * The requested page size.
     */
    private int pageSize;

    /**
     * The requested page number.
     */
    private int pageNumber;

    /**
     * The requested sort column.
     */
    private String sortColumn;

    /**
     * Ascending flag.
     */
    private boolean ascending;

    /**
     * Show filter panel flag.
     */
    private boolean showFilterPanel;

    /**
     * Default empty constructor.
     */
    public SearchCriteria() {
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

    /**
     * Gets the value of the field <code>ascending</code>.
     * @return the ascending
     */
    public boolean isAscending() {
        return ascending;
    }

    /**
     * Sets the value of the field <code>ascending</code>.
     * @param ascending the ascending to set
     */
    public void setAscending(boolean ascending) {
        this.ascending = ascending;
    }

    /**
     * Gets the value of the field <code>showFilterPanel</code>.
     * @return the showFilterPanel
     */
    public boolean isShowFilterPanel() {
        return showFilterPanel;
    }

    /**
     * Sets the value of the field <code>showFilterPanel</code>.
     * @param showFilterPanel the showFilterPanel to set
     */
    public void setShowFilterPanel(boolean showFilterPanel) {
        this.showFilterPanel = showFilterPanel;
    }
}