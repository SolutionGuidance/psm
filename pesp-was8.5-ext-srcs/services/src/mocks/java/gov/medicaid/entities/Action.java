/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.entities;

import java.util.Date;

/**
 * Maps the EPLS actions. http://apps.topcoder.com/forums/?module=Thread&threadID=759419&start=0&mc=10#1597113
 *
 * @author sampath01, j3_guile
 * @version 1.0
 */
public class Action {

    /**
     * Action date.
     */
    private Date actionDate;

    /**
     * Term date (null for indefinite).
     */
    private Date termDate;

    /**
     * CTcode.
     */
    private String ctCode;

    /**
     * Agency component.
     */
    private String agencyComponent;

    /**
     * Create date.
     */
    private Date createDate;

    /**
     * Default empty constructor.
     */
    public Action() {
    }

    /**
     * Gets the value of the field <code>actionDate</code>.
     *
     * @return the actionDate
     */
    public Date getActionDate() {
        return actionDate;
    }

    /**
     * Sets the value of the field <code>actionDate</code>.
     *
     * @param actionDate the actionDate to set
     */
    public void setActionDate(Date actionDate) {
        this.actionDate = actionDate;
    }

    /**
     * Gets the value of the field <code>termDate</code>.
     *
     * @return the termDate
     */
    public Date getTermDate() {
        return termDate;
    }

    /**
     * Sets the value of the field <code>termDate</code>.
     *
     * @param termDate the termDate to set
     */
    public void setTermDate(Date termDate) {
        this.termDate = termDate;
    }

    /**
     * Gets the value of the field <code>ctCode</code>.
     *
     * @return the ctCode
     */
    public String getCtCode() {
        return ctCode;
    }

    /**
     * Sets the value of the field <code>ctCode</code>.
     *
     * @param ctCode the ctCode to set
     */
    public void setCtCode(String ctCode) {
        this.ctCode = ctCode;
    }

    /**
     * Gets the value of the field <code>agencyComponent</code>.
     *
     * @return the agencyComponent
     */
    public String getAgencyComponent() {
        return agencyComponent;
    }

    /**
     * Sets the value of the field <code>agencyComponent</code>.
     *
     * @param agencyComponent the agencyComponent to set
     */
    public void setAgencyComponent(String agencyComponent) {
        this.agencyComponent = agencyComponent;
    }

    /**
     * Gets the value of the field <code>createDate</code>.
     *
     * @return the createDate
     */
    public Date getCreateDate() {
        return createDate;
    }

    /**
     * Sets the value of the field <code>createDate</code>.
     *
     * @param createDate the createDate to set
     */
    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }
}
