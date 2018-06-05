package gov.medicaid.services.impl

import gov.medicaid.entities.CMSUser
import gov.medicaid.entities.Document
import gov.medicaid.entities.Enrollment
import gov.medicaid.entities.Entity
import gov.medicaid.entities.ProviderProfile
import gov.medicaid.entities.Role
import spock.lang.Specification

import javax.persistence.EntityManager
import javax.persistence.TypedQuery
import javax.persistence.Query

class ProviderEnrollmentServiceBeanTest extends Specification {
    private static final long TICKET_ID = 1
    private static final String PROFILE_QUERY =
            "FROM ProviderProfile p WHERE ticketId = :ticketId"
    private ProviderEnrollmentServiceBean service
    private EntityManager entityManager
    private CMSUser systemUser

    void setup() {
        service = new ProviderEnrollmentServiceBean()
        entityManager = Mock(EntityManager)
        service.em = entityManager
        systemUser = new CMSUser()
        systemUser.role = new Role()
        systemUser.role.description = "System Administrator"
    }

    def "GetTicketDetails returns null on invalid ID"() {
        when:
        def result = service.getTicketDetails(systemUser, TICKET_ID)

        then:
        notThrown(NullPointerException)
        result == null
    }

    def "GetTicketDetails returns null on valid ID without profile"() {
        given:
        entityManager.find(Enrollment.class, TICKET_ID) >> new Enrollment()
        entityManager.createQuery(_ as String) >> mockQuery([])

        when:
        def result = service.getTicketDetails(systemUser, TICKET_ID)

        then:
        notThrown(NullPointerException)
        result == null
    }

    def "GetTicketDetails returns enrollment with profile on valid ID"() {
        given:
        Enrollment enrollment = new Enrollment()
        entityManager.find(Enrollment.class, TICKET_ID, _ as Map) >> enrollment
        entityManager.createQuery(PROFILE_QUERY, ProviderProfile.class) >>
                mockTypedQuery([new ProviderProfile()])
        entityManager.createQuery(_ as String) >> mockQuery([])
        entityManager.createQuery(_ as String, Entity.class) >> mockTypedQuery([] as List<Entity>)
        entityManager.createQuery(_ as String, Document.class) >> mockTypedQuery([] as List<Document>)

        when:
        def result = service.getTicketDetails(systemUser, TICKET_ID)

        then:
        notThrown(NullPointerException)
        result == enrollment
    }

    private <T> Query mockQuery(List<T> returnValue) {
        def query = Mock(Query)
        query.getResultList() >> returnValue
        return query
    }

    private <T> Query mockTypedQuery(List<T> returnValue) {
        def query = Mock(TypedQuery)
        query.getResultList() >> returnValue
        return query
    }
}
