/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.entities;

import java.util.Date;

/**
 * Represents a screening schedule.
 *
 * @author argolite, TCSASSEMBLER
 * @version 1.0
 */
public class ScreeningSchedule extends IdentifiableEntity {

    /**
     * Upcoming screening date.
     */
    private Date upcomingScreeningDate;

    /**
     * Interval.
     */
    private int interval;

    /**
     * Interval type.
     */
    private ScreeningIntervalType intervalType;

    /**
     * Default empty constructor.
     */
    public ScreeningSchedule() {
    }

    /**
     * Gets the value of the field <code>upcomingScreeningDate</code>.
     *
     * @return the upcomingScreeningDate
     */
    public Date getUpcomingScreeningDate() {
        return upcomingScreeningDate;
    }

    /**
     * Sets the value of the field <code>upcomingScreeningDate</code>.
     *
     * @param upcomingScreeningDate the upcomingScreeningDate to set
     */
    public void setUpcomingScreeningDate(Date upcomingScreeningDate) {
        this.upcomingScreeningDate = upcomingScreeningDate;
    }

    /**
     * Gets the value of the field <code>interval</code>.
     *
     * @return the interval
     */
    public int getInterval() {
        return interval;
    }

    /**
     * Sets the value of the field <code>interval</code>.
     *
     * @param interval the interval to set
     */
    public void setInterval(int interval) {
        this.interval = interval;
    }

    /**
     * Gets the value of the field <code>intervalType</code>.
     *
     * @return the intervalType
     */
    public ScreeningIntervalType getIntervalType() {
        return intervalType;
    }

    /**
     * Sets the value of the field <code>intervalType</code>.
     *
     * @param intervalType the intervalType to set
     */
    public void setIntervalType(ScreeningIntervalType intervalType) {
        this.intervalType = intervalType;
    }
}
