/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.entities;

/**
 * Represents a risk level.
 *
 * @author TCSASSEMBLER
 * @version 1.0
 */
public class RiskLevel extends LookupEntity {

    /**
     * Sorting index.
     */
    private int sortIndex;

    /**
     * Empty constructor.
     */
    public RiskLevel() {
    }

    /**
     * Gets the value of the field <code>sortIndex</code>.
     *
     * @return the sortIndex
     */
    public int getSortIndex() {
        return sortIndex;
    }

    /**
     * Sets the value of the field <code>sortIndex</code>.
     *
     * @param sortIndex the sortIndex to set
     */
    public void setSortIndex(int sortIndex) {
        this.sortIndex = sortIndex;
    }
}
