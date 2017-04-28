/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.entities;

/**
 * This represents the search criteria for Nurse Anesthetists licenses.
 *
 * <p>
 * <code>Thread Safety</code> This class is mutable and is not thread safe.
 * </p>
 *
 * @author argolite, j3_guile
 * @version 1.0
 */
public class NurseAnesthetistsSearchCriteria extends SearchCriteria {

    /**
     * SSN number.
     */
    private String ssn;

    /**
     * AANA number.
     */
    private long aanaNumber;

    /**
     * Recertification flag.
     */
    private boolean recertification;

    /**
     * Default empty constructor.
     */
    public NurseAnesthetistsSearchCriteria() {
    }

    /**
     * Gets the value of the field <code>ssn</code>.
     *
     * @return the ssn
     */
    public String getSsn() {
        return ssn;
    }

    /**
     * Sets the value of the field <code>ssn</code>.
     *
     * @param ssn the ssn to set
     */
    public void setSsn(String ssn) {
        this.ssn = ssn;
    }

    /**
     * Gets the value of the field <code>aanaNumber</code>.
     *
     * @return the aanaNumber
     */
    public long getAanaNumber() {
        return aanaNumber;
    }

    /**
     * Sets the value of the field <code>aanaNumber</code>.
     *
     * @param aanaNumber the aanaNumber to set
     */
    public void setAanaNumber(long aanaNumber) {
        this.aanaNumber = aanaNumber;
    }

    /**
     * Gets the value of the field <code>recertification</code>.
     *
     * @return the recertification
     */
    public boolean isRecertification() {
        return recertification;
    }

    /**
     * Sets the value of the field <code>recertification</code>.
     *
     * @param recertification the recertification to set
     */
    public void setRecertification(boolean recertification) {
        this.recertification = recertification;
    }
}