package gov.medicaid.services.impl

import gov.medicaid.entities.AutomaticScreening
import gov.medicaid.entities.LeieAutomaticScreening
import spock.lang.Specification

import javax.persistence.EntityGraph
import javax.persistence.EntityManager

class ScreeningServiceBeanTest extends Specification {
    ScreeningServiceBean screeningService
    EntityManager entityManager
    EntityGraph entityGraph

    def setup() {
        entityGraph = Mock(EntityGraph)
        entityManager = Mock(EntityManager)
        entityManager.getEntityGraph(_) >> entityGraph
        screeningService = new ScreeningServiceBean()
        screeningService.em = entityManager
    }

    def "FindScreening returns empty if not found"() {
        given:
        entityManager.find(_, _, _) >> null

        when:
        def result = screeningService.findScreening(1)

        then:
        !result.isPresent()
    }

    def "FindScreening returns value if found"() {
        given:
        def screening = new LeieAutomaticScreening()
        entityManager.find(_, _, _) >> screening

        when:
        def result = screeningService.findScreening(1)

        then:
        result.isPresent()
        result.get() == screening
    }

    def "FindScreening wants to include matches via entity graph"() {
        when:
        screeningService.findScreening(1)

        then:
        1 * entityManager.getEntityGraph(
                "Screening with matches"
        ) >> entityGraph

        1 * entityManager.find(
                AutomaticScreening,
                1,
                ["javax.persistence.loadgraph": entityGraph] as Map
        )
    }
}
