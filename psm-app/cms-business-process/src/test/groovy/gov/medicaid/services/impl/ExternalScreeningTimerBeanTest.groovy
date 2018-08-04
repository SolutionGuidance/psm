/*
 * Copyright 2018 The MITRE Corporation
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package gov.medicaid.services.impl

import gov.medicaid.entities.ScreeningSchedule
import gov.medicaid.services.ScreeningService
import spock.lang.Specification

import java.time.Clock
import java.time.LocalDateTime
import java.time.ZoneId

class ExternalScreeningTimerBeanTest extends Specification {
    private static final ZoneId zoneId = ZoneId.systemDefault()
    private ExternalScreeningTimerBean externalScreeningTimerBean
    private ScreeningService screeningService

    void setup() {
        screeningService = Mock(ScreeningService)
    }

    def "the wrong time of day is not the scheduled time"() {
        given:
        screeningService.getScreeningSchedule() >> new ScreeningSchedule([
            dayOfMonth: 1,
            hourOfDay : 0
        ])
        setTime(dayOfMonth: 1, hourOfDay: 12)

        expect:
        !externalScreeningTimerBean.isScheduledTime()
    }

    def "the wrong day is not the scheduled time"() {
        given:
        screeningService.getScreeningSchedule() >> new ScreeningSchedule([
            dayOfMonth: 1,
            hourOfDay : 0
        ])
        setTime(dayOfMonth: 20, hourOfDay: 0)

        expect:
        !externalScreeningTimerBean.isScheduledTime()
    }

    def "the right time on the right day is the scheduled time"() {
        given:
        screeningService.getScreeningSchedule() >> new ScreeningSchedule([
            dayOfMonth: 1,
            hourOfDay : 1
        ])
        setTime(dayOfMonth: 1, hourOfDay: 1)

        expect:
        externalScreeningTimerBean.isScheduledTime()
    }

    private setTime(Map args) {
        Clock clock = Clock.fixed(LocalDateTime.of(
            2018,
            01,
            args.dayOfMonth as Integer,
            args.hourOfDay as Integer,
            00
        ).atZone(zoneId).toInstant(), zoneId);
        externalScreeningTimerBean = new ExternalScreeningTimerBean(
            screeningService,
            clock
        )
    }
}
