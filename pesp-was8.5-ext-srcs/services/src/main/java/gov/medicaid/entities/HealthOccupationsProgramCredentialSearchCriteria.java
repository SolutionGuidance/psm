/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.entities;

/**
 * This represents the search criteria for health occupations program credentials.
 *
 * <p>
 * <code>Thread Safety</code> This class is mutable and is not thread safe.
 * </p>
 *
 * @author argolite, j3_guile
 * @version 1.0
 */
public class HealthOccupationsProgramCredentialSearchCriteria extends SearchCriteria {

    /**
     * City filter.
     */
    private String city;

    /**
     * County filter.
     */
    private String county;

    /**
     * Occupation type filter.
     */
    private OccupationType occupationType;

    /**
     * Credential status filter.
     */
    private CredentialStatus status;

    /**
     * Discipline filter.
     */
    private Discipline discipline;

    /**
     * Credential number.
     */
    private long credentialNumber;

    /**
     * Default empty constructor.
     */
    public HealthOccupationsProgramCredentialSearchCriteria() {
    }

    /**
     * Gets the value of the field <code>city</code>.
     *
     * @return the city
     */
    public String getCity() {
        return city;
    }

    /**
     * Sets the value of the field <code>city</code>.
     *
     * @param city the city to set
     */
    public void setCity(String city) {
        this.city = city;
    }

    /**
     * Gets the value of the field <code>county</code>.
     *
     * @return the county
     */
    public String getCounty() {
        return county;
    }

    /**
     * Sets the value of the field <code>county</code>.
     *
     * @param county the county to set
     */
    public void setCounty(String county) {
        this.county = county;
    }

    /**
     * Gets the value of the field <code>occupationType</code>.
     *
     * @return the occupationType
     */
    public OccupationType getOccupationType() {
        return occupationType;
    }

    /**
     * Sets the value of the field <code>occupationType</code>.
     *
     * @param occupationType the occupationType to set
     */
    public void setOccupationType(OccupationType occupationType) {
        this.occupationType = occupationType;
    }

    /**
     * Gets the value of the field <code>status</code>.
     *
     * @return the status
     */
    public CredentialStatus getStatus() {
        return status;
    }

    /**
     * Sets the value of the field <code>status</code>.
     *
     * @param status the status to set
     */
    public void setStatus(CredentialStatus status) {
        this.status = status;
    }

    /**
     * Gets the value of the field <code>discipline</code>.
     *
     * @return the discipline
     */
    public Discipline getDiscipline() {
        return discipline;
    }

    /**
     * Sets the value of the field <code>discipline</code>.
     *
     * @param discipline the discipline to set
     */
    public void setDiscipline(Discipline discipline) {
        this.discipline = discipline;
    }

    /**
     * Gets the value of the field <code>credentialNumber</code>.
     *
     * @return the credentialNumber
     */
    public long getCredentialNumber() {
        return credentialNumber;
    }

    /**
     * Sets the value of the field <code>credentialNumber</code>.
     *
     * @param credentialNumber the credentialNumber to set
     */
    public void setCredentialNumber(long credentialNumber) {
        this.credentialNumber = credentialNumber;
    }
}