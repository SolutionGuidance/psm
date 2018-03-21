package gov.medicaid.api

import ca.uhn.fhir.rest.param.StringOrListParam
import ca.uhn.fhir.rest.param.StringParam
import ca.uhn.fhir.rest.server.exceptions.InvalidRequestException
import gov.medicaid.entities.CMSUser
import gov.medicaid.entities.Enrollment
import gov.medicaid.entities.Organization
import gov.medicaid.entities.ProviderProfile
import gov.medicaid.entities.ProviderSearchCriteria
import gov.medicaid.entities.ProviderType
import gov.medicaid.entities.SearchResult
import gov.medicaid.entities.UserRequest
import gov.medicaid.services.ProviderEnrollmentService
import org.hl7.fhir.dstu3.model.IdType
import org.hl7.fhir.dstu3.model.Task
import spock.lang.Specification
import spock.lang.Unroll

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
        mockEnrollmentService.getTicketDetails(_, ticketId) >> createEnrollment()

        when:
        def result = provider.getResourceById(id)

        then:
        result instanceof Task
        result.hasId()
        result.getId() == Long.toString(ticketId)
    }

    def "Search all with no applications returns empty list"() {
        given:
        def searchResults = new SearchResult<UserRequest>()
        searchResults.items = []
        mockEnrollmentService.searchTickets(_, _) >> searchResults

        when:
        def result = provider.search(null, null, null, null)

        then:
        result.size() == 0
    }

    def "Search all with one application returns a list with that application"() {
        given:
        def searchResults = new SearchResult<UserRequest>()
        def userRequest = new UserRequest(
                123,
                null,
                null,
                null,
                null,
                null,
                null,
                null,
                null,
                null,
                null,
                0,
                0
        )
        searchResults.items = [userRequest]
        mockEnrollmentService.searchTickets(_, _) >> searchResults
        mockEnrollmentService.getTicketDetails(_, ticketId) >> createEnrollment()

        when:
        def result = provider.search(null, null, null, null)

        then:
        result.size() == 1
        result.first().getId() == Long.toString(ticketId)
    }

    def "Search by NPI includes NPI in query"() {
        given:
        def searchResults = new SearchResult<UserRequest>()
        searchResults.items = []

        when:
        provider.search("1234567893", null, null, null)

        then:
        1 * mockEnrollmentService.searchTickets(
                _ as CMSUser,
                { it.npi == "1234567893" } as ProviderSearchCriteria
        ) >> searchResults
    }

    def "Search by provider type includes provider type in query"() {
        given:
        def searchResults = new SearchResult<UserRequest>()
        searchResults.items = []

        when:
        provider.search(null, null, "Acupuncturist", null)

        then:
        1 * mockEnrollmentService.searchTickets(
                _ as CMSUser,
                { it.providerType == "Acupuncturist" } as ProviderSearchCriteria
        ) >> searchResults
    }

    def "Search by name includes name in query"() {
        given:
        def searchResults = new SearchResult<UserRequest>()
        searchResults.items = []

        when:
        provider.search(null, null, null, "name")

        then:
        1 * mockEnrollmentService.searchTickets(
                _ as CMSUser,
                { it.providerName == "name" } as ProviderSearchCriteria
        ) >> searchResults
    }

    def "Search by single status includes status in query"() {
        given:
        def searchResults = new SearchResult<UserRequest>()
        searchResults.items = []

        when:
        def statuses = new StringOrListParam()
        statuses.addOr(new StringParam("Accepted"))
        provider.search(null, statuses, null, null)

        then:
        1 * mockEnrollmentService.searchTickets(
                _ as CMSUser,
                { it.statuses == ["Approved"] } as ProviderSearchCriteria
        ) >> searchResults
    }

    def "Search by multiple statuses includes statuses in query"() {
        given:
        def searchResults = new SearchResult<UserRequest>()
        searchResults.items = []

        when:
        def statuses = new StringOrListParam()
        statuses.addOr(new StringParam("Rejected"))
        statuses.addOr(new StringParam("Accepted"))

        provider.search(null, statuses, null, null)

        then:
        1 * mockEnrollmentService.searchTickets(
                _ as CMSUser,
                {
                    it.statuses == ["Rejected", "Approved"]
                } as ProviderSearchCriteria
        ) >> searchResults
    }

    @Unroll
    def "Search with an invalid (#reason) NPI returns an error"(
            String reason,
            String invalidNpi
    ) {
        when:
        provider.search(invalidNpi, null, null, null)

        then:
        thrown(InvalidRequestException)

        where:
        reason        | invalidNpi
        "too short"   | "123456789"
        "too long"    | "12345678901"
        "non-numeric" | "12345abcde"
    }

    private static Enrollment createEnrollment() {
        Enrollment enrollment = new Enrollment()
        enrollment.ticketId = 123
        enrollment.details = new ProviderProfile()
        enrollment.details.entity = new Organization()
        enrollment.details.entity.providerType = new ProviderType()
        return enrollment
    }
}
