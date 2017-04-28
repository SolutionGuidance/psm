/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.entities;

import gov.medicaid.entities.IdentifiableEntity;

/**
 * This represents the result log entry.
 *
 * <b>Thread Safety</b> This class is mutable and not thread safe.
 *
 * @author argolite, j3_guile
 * @version 1.0
 */
public class ResultLogEntry extends IdentifiableEntity {

    /**
     * The criteria for this entry.
     */
    private SearchCriteria criteria;

    /**
     * Default empty constructor.
     */
    public ResultLogEntry() {
    }

    /**
     * Gets the value of the field <code>criteria</code>.
     *
     * @return the criteria
     */
    public SearchCriteria getCriteria() {
        return criteria;
    }

    /**
     * Sets the value of the field <code>criteria</code>.
     *
     * @param criteria the criteria to set
     */
    public void setCriteria(SearchCriteria criteria) {
        this.criteria = criteria;
    }
}