/*
 * Copyright 2012, 2013 TopCoder, Inc.
 * Copyright 2018 The MITRE Corporation
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package gov.medicaid.entities;

/**
 * This serves as the base class for all search criteria objects.
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
