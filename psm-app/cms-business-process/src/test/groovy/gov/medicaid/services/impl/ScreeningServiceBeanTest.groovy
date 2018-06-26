package gov.medicaid.services.impl

import gov.medicaid.entities.AutomaticScreening
import gov.medicaid.entities.LeieAutomaticScreening
import spock.lang.Specification

import javax.persistence.EntityGraph
import javax.persistence.EntityManager

class ScreeningServiceBeanTest extends Specification {
    ScreeningServiceBean screeningService
    EntityManager entityManager

    def setup() {
        entityManager = Mock(EntityManager)
        screeningService = new ScreeningServiceBean()
        screeningService.em = entityManager
    }

    def "FindScreening returns empty if not found"() {
        given:
        entityManager.find(_, _) >> null

        when:
        def result = screeningService.findScreening(1)

        then:
        !result.isPresent()
    }

    def "FindScreening returns value if found"() {
        given:
        def screening = new LeieAutomaticScreening()
        entityManager.find(_, _) >> screening

        when:
        def result = screeningService.findScreening(1)

        then:
        result.isPresent()
        result.get() == screening
    }
}
