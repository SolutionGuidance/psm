package gov.medicaid.controllers.admin.report

import java.time.LocalDate
import java.time.LocalDateTime
import java.time.ZoneId

import org.apache.commons.csv.CSVFormat
import org.apache.commons.csv.CSVParser
import org.springframework.mock.web.MockHttpServletResponse

import gov.medicaid.entities.Enrollment
import gov.medicaid.entities.Person
import gov.medicaid.entities.ProviderType
import gov.medicaid.entities.SearchResult
import gov.medicaid.services.ProviderEnrollmentService
import gov.medicaid.services.ProviderTypeService
import spock.lang.Specification

class ProviderTypesReportControllerTest extends Specification {
    private ProviderTypesReportController controller
    private ProviderEnrollmentService enrollmentService
    private ProviderTypeService providerTypeService
    private static LocalDateTime noonMiddleThisMonth

    void setupSpec() {
        noonMiddleThisMonth = LocalDate.now().withDayOfMonth(15).atTime(12, 0)
    }

    void setup() {
        controller = new ProviderTypesReportController()
        enrollmentService = Mock(ProviderEnrollmentService)
        providerTypeService = Mock(ProviderTypeService)

        providerTypeService.search(_) >>
                new SearchResult<ProviderType>(
                [items:
                    [
                        new ProviderType([code: "PT 1", description: "PT 1"]),
                        new ProviderType([code: "PT 2", description: "PT 2"]),
                        new ProviderType([code: "PT 3", description: "PT 3"]),
                        new ProviderType([code: "PT 4", description: "PT 4"])
                    ]
                ]
                )

        controller.setEnrollmentService(enrollmentService)
        controller.setProviderTypeService(providerTypeService)
    }

    private toDate(d) {
        Date.from(d.atZone(ZoneId.systemDefault()).toInstant())
    }

    private makeEnrollment(ticketId, statusDate) {
        return new Enrollment([
            ticketId: ticketId,
            statusDate: toDate(statusDate)
        ])
    }

    private testEnrollmentData() {
        def results = new SearchResult<Enrollment>()
        results.setItems([
            makeEnrollment(1, noonMiddleThisMonth),
            makeEnrollment(2, noonMiddleThisMonth),
            makeEnrollment(3, noonMiddleThisMonth),
            makeEnrollment(4, noonMiddleThisMonth.minusMonths(1)),
            makeEnrollment(5, noonMiddleThisMonth.minusMonths(1)),
            makeEnrollment(6, noonMiddleThisMonth.minusMonths(2))
        ].sort{it.getCreatedOn()})
        results
    }

    private makePerson(description) {
        new Person([providerType: new ProviderType([code: description, description: description])])
    }

    private setupTestEntities() {
        enrollmentService.findEntityByProviderKey(null, 1) >> makePerson("PT 1")
        enrollmentService.findEntityByProviderKey(null, 2) >> makePerson("PT 1")
        enrollmentService.findEntityByProviderKey(null, 3) >> makePerson("PT 2")
        enrollmentService.findEntityByProviderKey(null, 4) >> makePerson("PT 2")
        enrollmentService.findEntityByProviderKey(null, 5) >> makePerson("PT 2")
        enrollmentService.findEntityByProviderKey(null, 6) >> makePerson("PT 1")
    }

    def "csv with no enrollments - header"() {
        given:
        def results = new SearchResult<Enrollment>()
        results.setItems([])
        1 * enrollmentService.searchEnrollments(_) >> results
        def response = new MockHttpServletResponse()

        when:
        controller.getProviderTypesCsv(null, response)
        def csv = CSVParser.parse(response.getContentAsString(), CSVFormat.DEFAULT)
        def records = csv.getRecords()

        then:
        records[0][0] == "Month Reviewed"
        records[0][1] == "Provider Type"
        records[0][2] == "Applications Reviewed"
        records.size == 1
        records[0].size() == 3
    }

    def "csv with enrollments"() {
        given:
        1 * enrollmentService.searchEnrollments(_) >> testEnrollmentData()
        setupTestEntities()

        def response = new MockHttpServletResponse()

        when:
        controller.getProviderTypesCsv(null, response)
        def csv = CSVParser.parse(response.getContentAsString(), CSVFormat.DEFAULT)
        def records = csv.getRecords()

        then:
        records.size == 5
        records[1].size() == 3
        records[1][0] == noonMiddleThisMonth.withDayOfMonth(1).toLocalDate().toString()
        records[1][1] == "PT 1"
        records[1][2] == "2"
        records[2][0] == noonMiddleThisMonth.withDayOfMonth(1).toLocalDate().toString()
        records[2][1] == "PT 2"
        records[2][2] == "1"
        records[3][0] == noonMiddleThisMonth.minusMonths(1).withDayOfMonth(1).toLocalDate().toString()
        records[3][1] == "PT 2"
        records[3][2] == "2"
        records[4][0] == noonMiddleThisMonth.minusMonths(2).withDayOfMonth(1).toLocalDate().toString()
        records[4][1] == "PT 1"
        records[4][2] == "1"
    }

    def "mv with enrollments"() {
        given:
        1 * enrollmentService.searchEnrollments(_) >> testEnrollmentData()
        setupTestEntities()

        when:
        def mv = controller.getProviderTypes(["PT 1", "PT 2"]).model

        then:
        mv["months"].size == 3
        mv["months"][0].month == noonMiddleThisMonth.withDayOfMonth(1).toLocalDate()
        mv["months"][0].getProviderTypes().get(0).description == "PT 1"
        mv["months"][0].getEnrollments(new ProviderType([code: "PT 1"])).size == 2
        mv["months"][0].getEnrollments(new ProviderType([code: "PT 2"])).size == 1
        mv["months"][2].month == noonMiddleThisMonth.withDayOfMonth(1).minusMonths(2).toLocalDate()
        mv["months"][2].containsEnrollments(new ProviderType([code: "PT 2"])) == false

        mv["providerTypes"].size == 4

        mv["providerTypeCodesQueryString"] == "providerType=PT 1&providerType=PT 2"
    }
}
