/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.entities;

import java.util.Date;

/**
 * Represents a program.
 *
 * @author argolite, j3_guile
 * @version 1.0
 */
public class Program extends IdentifiableEntity {

    /**
     * Specialty.
     */
    private Specialty specialty;

    /**
     * Start date.
     */
    private Date startDate;

    /**
     * End date.
     */
    private Date endDate;

    /**
     * Name.
     */
    private String name;

    /**
     * Completed flag.
     */
    private boolean completed;

    /**
     * Default empty constructor.
     */
    public Program() {
    }

    /**
     * Gets the value of the field <code>specialty</code>.
     * @return the specialty
     */
    public Specialty getSpecialty() {
        return specialty;
    }

    /**
     * Sets the value of the field <code>specialty</code>.
     * @param specialty the specialty to set
     */
    public void setSpecialty(Specialty specialty) {
        this.specialty = specialty;
    }

    /**
     * Gets the value of the field <code>startDate</code>.
     * @return the startDate
     */
    public Date getStartDate() {
        return startDate;
    }

    /**
     * Sets the value of the field <code>startDate</code>.
     * @param startDate the startDate to set
     */
    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    /**
     * Gets the value of the field <code>endDate</code>.
     * @return the endDate
     */
    public Date getEndDate() {
        return endDate;
    }

    /**
     * Sets the value of the field <code>endDate</code>.
     * @param endDate the endDate to set
     */
    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }

    /**
     * Gets the value of the field <code>name</code>.
     * @return the name
     */
    public String getName() {
        return name;
    }

    /**
     * Sets the value of the field <code>name</code>.
     * @param name the name to set
     */
    public void setName(String name) {
        this.name = name;
    }

    /**
     * Gets the value of the field <code>completed</code>.
     * @return the completed
     */
    public boolean isCompleted() {
        return completed;
    }

    /**
     * Sets the value of the field <code>completed</code>.
     * @param completed the completed to set
     */
    public void setCompleted(boolean completed) {
        this.completed = completed;
    }
}
