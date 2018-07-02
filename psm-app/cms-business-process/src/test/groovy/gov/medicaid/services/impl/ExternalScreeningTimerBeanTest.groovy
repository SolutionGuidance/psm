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
