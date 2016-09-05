/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.entities;


/**
 * Represents a help search criteria.
 *
 * @author argolite, TCSASSEMBLER
 * @version 1.0
 */
public class HelpSearchCriteria extends SearchCriteria {

    /**
     * Term.
     */
    private String term;

    /**
     * Default empty constructor.
     */
    public HelpSearchCriteria() {
    }

    /**
     * Gets the value of the field <code>term</code>.
     *
     * @return the term
     */
    public String getTerm() {
        return term;
    }

    /**
     * Sets the value of the field <code>term</code>.
     *
     * @param term the term to set
     */
    public void setTerm(String term) {
        this.term = term;
    }
}
