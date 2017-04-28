/*
 * Copyright 2012-2013 TopCoder, Inc.
 *
 * This code was developed under U.S. government contract NNH10CD71C. 
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * You may not use this file except in compliance with the License.
 * You may obtain a copy of the License at:
 *     http://www.apache.org/licenses/LICENSE-2.0
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
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
