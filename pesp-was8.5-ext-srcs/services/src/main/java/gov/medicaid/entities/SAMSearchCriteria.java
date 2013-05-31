/*
 * Copyright (C) 2013 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.entities;

import java.io.Serializable;

/**
 * This class contains the search criteria for SAM service.
 * 
 * <b>Thread Safety</b> This class is mutable and not thread safe.
 * 
 * @author flexme
 * @version 1.0
 */
public class SAMSearchCriteria implements Serializable {
    /**
     * The first name to search.
     */
    private String firstName;
    /**
     * The last name to search.
     */
    private String lastName;
    /**
     * The middle name to search.
     */
    private String middleName;
    /**
     * The partial name to search.
     */
    private String partialName;

    /**
     * Empty constructor.
     */
    public SAMSearchCriteria() {
    }

    /**
     * Gets the first name.
     * 
     * @return the first name.
     */
    public String getFirstName() {
        return firstName;
    }

    /**
     * Sets the first name.
     * 
     * @param firstName
     *            the first name.
     */
    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    /**
     * Gets the last name.
     * 
     * @return the last name.
     */
    public String getLastName() {
        return lastName;
    }

    /**
     * Sets the last name.
     * 
     * @param lastName
     *            the last name.
     */
    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    /**
     * Gets the middle name.
     * 
     * @return the middle name.
     */
    public String getMiddleName() {
        return middleName;
    }

    /**
     * Sets the middle name.
     * 
     * @param middleName
     *            the middle name.
     */
    public void setMiddleName(String middleName) {
        this.middleName = middleName;
    }

    /**
     * Gets the partial name.
     * 
     * @return the partial name.
     */
    public String getPartialName() {
        return partialName;
    }

    /**
     * Sets the partial name.
     * 
     * @param partialName
     *            the partial name.
     */
    public void setPartialName(String partialName) {
        this.partialName = partialName;
    }
}
