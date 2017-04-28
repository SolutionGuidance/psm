/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.entities;

import java.util.Date;

/**
 * Represents a criminal conviction.
 *
 * @author argolite, j3_guile
 * @version 1.0
 */
public class CriminalConviction extends IdentifiableEntity {

    /**
     * Description.
     */
    private String crimeDescription;

    /**
     * Court jurisdiction.
     */
    private String courtOfJurisdiction;

    /**
     * Sentence.
     */
    private String sentence;

    /**
     * Conviction date.
     */
    private Date convictionDate;

    /**
     * Effective end date.
     */
    private Date effectiveEndDate;

    /**
     * Default empty constructor.
     */
    public CriminalConviction() {
    }

    /**
     * Gets the value of the field <code>crimeDescription</code>.
     * @return the crimeDescription
     */
    public String getCrimeDescription() {
        return crimeDescription;
    }

    /**
     * Sets the value of the field <code>crimeDescription</code>.
     * @param crimeDescription the crimeDescription to set
     */
    public void setCrimeDescription(String crimeDescription) {
        this.crimeDescription = crimeDescription;
    }

    /**
     * Gets the value of the field <code>courtOfJurisdiction</code>.
     * @return the courtOfJurisdiction
     */
    public String getCourtOfJurisdiction() {
        return courtOfJurisdiction;
    }

    /**
     * Sets the value of the field <code>courtOfJurisdiction</code>.
     * @param courtOfJurisdiction the courtOfJurisdiction to set
     */
    public void setCourtOfJurisdiction(String courtOfJurisdiction) {
        this.courtOfJurisdiction = courtOfJurisdiction;
    }

    /**
     * Gets the value of the field <code>sentence</code>.
     * @return the sentence
     */
    public String getSentence() {
        return sentence;
    }

    /**
     * Sets the value of the field <code>sentence</code>.
     * @param sentence the sentence to set
     */
    public void setSentence(String sentence) {
        this.sentence = sentence;
    }

    /**
     * Gets the value of the field <code>convictionDate</code>.
     * @return the convictionDate
     */
    public Date getConvictionDate() {
        return convictionDate;
    }

    /**
     * Sets the value of the field <code>convictionDate</code>.
     * @param convictionDate the convictionDate to set
     */
    public void setConvictionDate(Date convictionDate) {
        this.convictionDate = convictionDate;
    }

    /**
     * Gets the value of the field <code>effectiveEndDate</code>.
     * @return the effectiveEndDate
     */
    public Date getEffectiveEndDate() {
        return effectiveEndDate;
    }

    /**
     * Sets the value of the field <code>effectiveEndDate</code>.
     * @param effectiveEndDate the effectiveEndDate to set
     */
    public void setEffectiveEndDate(Date effectiveEndDate) {
        this.effectiveEndDate = effectiveEndDate;
    }
}
