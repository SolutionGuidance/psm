package gov.medicaid.api

import gov.medicaid.entities.CMSUser
import gov.medicaid.entities.Enrollment
import gov.medicaid.entities.Organization
import gov.medicaid.entities.ProviderProfile
import gov.medicaid.entities.ProviderType
import gov.medicaid.services.ProviderEnrollmentService
import org.hl7.fhir.dstu3.model.IdType
import org.hl7.fhir.dstu3.model.Task
import spock.lang.Specification

class TaskResourceProviderTest extends Specification {
    TaskResourceProvider provider
    ProviderEnrollmentService mockEnrollmentService
    long ticketId = 123
    IdType id

    def setup() {
        mockEnrollmentService = Mock(ProviderEnrollmentService)
        provider = new TaskResourceProvider(mockEnrollmentService)
        id = new IdType(ticketId)
    }

    def "GetResourceById queries with system user"() {
        when:
        provider.getResourceById(id)

        then:
        1 * mockEnrollmentService.getTicketDetails(
                { it.role.description == "System Administrator" } as CMSUser,
                _ as Long
        )
    }

    def "GetResourceById queries with expected ID"() {
        when:
        provider.getResourceById(id)

        then:
        1 * mockEnrollmentService.getTicketDetails(_, ticketId)
    }

    def "GetResourceById returns null for unknown enrollment ID"() {
        when:
        def result = provider.getResourceById(id)

        then:
        result == null
    }

    def "GetResourceById returns Task for valid enrollment ID"() {
        given:
        Enrollment enrollment = new Enrollment()
        enrollment.ticketId = 123
        enrollment.details = new ProviderProfile()
        enrollment.details.entity = new Organization()
        enrollment.details.entity.providerType = new ProviderType()

        mockEnrollmentService.getTicketDetails(_, ticketId) >> enrollment

        when:
        def result = provider.getResourceById(id)

        then:
        result instanceof Task
        result.identifier.size() == 1
        result.identifier.first().value == Long.toString(ticketId)
    }
}
