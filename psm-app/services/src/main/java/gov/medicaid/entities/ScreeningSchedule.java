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

public class ScreeningSchedule extends IdentifiableEntity {

    private Date upcomingScreeningDate;

    private int interval;

    private ScreeningIntervalType intervalType;

    /**
     * Default empty constructor.
     */
    public ScreeningSchedule() {
    }

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
}
