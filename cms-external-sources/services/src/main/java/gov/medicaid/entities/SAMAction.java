/*
 * Copyright (C) 2013 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.entities;

import java.io.Serializable;
import java.util.Date;

/**
 * This entity holds action data of SAMSearch web service response.
 *
 * @author flexme
 * @version 1.0
 */
public class SAMAction implements Serializable {
    /**
     * Represents the action date.
     */
    private Date actionDate;
    /**
     * Represents the agency component.
     */
    private String agencyComponent;
    /**
     * Represents the ct code.
     */
    private String ctCode;
    /**
     * Represents the term type.
     */
    private String termType;
    /**
     * Represents the term date.
     */
    private Date termDate;

    /**
     * Empty constructor.
     */
    public SAMAction() {
    }

    /**
     * Gets the action date.
     *
     * @return the action date.
     */
    public Date getActionDate() {
        return actionDate;
    }

    /**
     * Sets the action date.
     *
     * @param actionDate the action date.
     */
    public void setActionDate(Date actionDate) {
        this.actionDate = actionDate;
    }

    /**
     * Gets the agency component.
     *
     * @return the agency component.
     */
    public String getAgencyComponent() {
        return agencyComponent;
    }

    /**
     * Sets the agency component.
     *
     * @param agencyComponent the agency component.
     */
    public void setAgencyComponent(String agencyComponent) {
        this.agencyComponent = agencyComponent;
    }

    /**
     * Gets the ct code.
     *
     * @return the ct code.
     */
    public String getCtCode() {
        return ctCode;
    }

    /**
     * Sets the ct code.
     *
     * @param ctCode the ct code.
     */
    public void setCtCode(String ctCode) {
        this.ctCode = ctCode;
    }

    /**
     * Gets the term type.
     *
     * @return the term type.
     */
    public String getTermType() {
        return termType;
    }

    /**
     * Sets the term type.
     *
     * @param termType the term type.
     */
    public void setTermType(String termType) {
        this.termType = termType;
    }

    /**
     * Gets the term date.
     *
     * @return the term date.
     */
    public Date getTermDate() {
        return termDate;
    }

    /**
     * Sets the term date.
     *
     * @param termDate the term date.
     */
    public void setTermDate(Date termDate) {
        this.termDate = termDate;
    }
}
