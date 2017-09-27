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

import javax.persistence.Column;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import java.io.Serializable;
import java.util.Date;

@javax.persistence.Entity 
@Table(name = "screening_schedules")
public class ScreeningSchedule implements Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "screening_schedule_id")
    private long id;
    
    /* 
     * Next screening date.
     */
    @Column(name = "upcoming_screening_date")
    private Date upcomingScreeningDate;

    /*
     * Interval between screenings.
     */
    @Column(name = "interval_value")
    private int interval;

    @Enumerated(EnumType.STRING)
    @Column(name = "interval_type")
    private ScreeningIntervalType intervalType;

    public Date getUpcomingScreeningDate() {
        return upcomingScreeningDate;
    }

    public void setUpcomingScreeningDate(Date upcomingScreeningDate) {
        this.upcomingScreeningDate = upcomingScreeningDate;
    }

    public int getInterval() {
        return interval;
    }

    public void setInterval(int interval) {
        this.interval = interval;
    }

    public ScreeningIntervalType getIntervalType() {
        return intervalType;
    }

    public void setIntervalType(ScreeningIntervalType intervalType) {
        this.intervalType = intervalType;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

}
