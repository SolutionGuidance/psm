package gov.medicaid.controllers.admin.report

import java.time.LocalDate
import java.time.LocalDateTime
import java.time.ZoneId

import org.apache.commons.csv.CSVFormat
import org.apache.commons.csv.CSVParser
import org.springframework.mock.web.MockHttpServletResponse

import gov.medicaid.entities.Enrollment
import gov.medicaid.entities.SearchResult
import gov.medicaid.services.ProviderEnrollmentService
import spock.lang.Specification

class ReviewedDocumentsReportControllerTest extends Specification {
    private ReviewedDocumentsReportController controller
    private ProviderEnrollmentService enrollmentService
    private static LocalDateTime noonMiddleThisMonth

    void setupSpec() {
        noonMiddleThisMonth = LocalDate.now().withDayOfMonth(15).atTime(12, 0)
    }

    void setup() {
        controller = new ReviewedDocumentsReportController()
        enrollmentService = Mock(ProviderEnrollmentService)
        controller.setEnrollmentService(enrollmentService)
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
            makeEnrollment(6, noonMiddleThisMonth.minusMonths(2)),
            makeEnrollment(7, noonMiddleThisMonth.minusMonths(3))
        ].sort{it.getCreatedOn()})
        results
    }

    // It doesn't matter that it doesn't actually return documents
    private setupTestDocuments() {
        enrollmentService.findAttachments(null, 1) >> (0..<2)
        enrollmentService.findAttachments(null, 2) >> (0..<1)
        enrollmentService.findAttachments(null, 3) >> (0..<4)
        enrollmentService.findAttachments(null, 4) >> (0..<1)
        enrollmentService.findAttachments(null, 5) >> (0..<2)
        enrollmentService.findAttachments(null, 6) >> (0..<0)
        enrollmentService.findAttachments(null, 7) >> (0..<8)
    }

    def "csv with no enrollments - header"() {
        given:
        def results = new SearchResult<Enrollment>()
        results.setItems([])
        1 * enrollmentService.searchEnrollments(_) >> results
        def response = new MockHttpServletResponse()

        when:
        controller.getReviewedDocumentsCsv(response)
        def csv = CSVParser.parse(response.getContentAsString(), CSVFormat.DEFAULT)
        def records = csv.getRecords()

        then:
        records[0][0] == "Month"
        records[0][1] == "Number of Documents"
        records.size == 1
        records[0].size() == 2
    }

    def "csv with enrollments"() {
        given:
        1 * enrollmentService.searchEnrollments(_) >> testEnrollmentData()
        setupTestDocuments()

        def response = new MockHttpServletResponse()

        when:
        controller.getReviewedDocumentsCsv(response)
        def csv = CSVParser.parse(response.getContentAsString(), CSVFormat.DEFAULT)
        def records = csv.getRecords()

        then:
        records.size == 5
        records[1].size() == 2
        records[1][0] == noonMiddleThisMonth.withDayOfMonth(1).toLocalDate().toString()
        records[1][1] == "7"
        records[2][0] == noonMiddleThisMonth.minusMonths(1).withDayOfMonth(1).toLocalDate().toString()
        records[2][1] == "3"
        records[3][0] == noonMiddleThisMonth.minusMonths(2).withDayOfMonth(1).toLocalDate().toString()
        records[3][1] == "0"
        records[4][0] == noonMiddleThisMonth.minusMonths(3).withDayOfMonth(1).toLocalDate().toString()
        records[4][1] == "8"
    }

    def "mv with enrollments"() {
        given:
        1 * enrollmentService.searchEnrollments(_) >> testEnrollmentData()
        setupTestDocuments()

        when:
        def mv = controller.getReviewedDocuments().model

        then:
        mv["months"].size == 4
        mv["months"][0].month == noonMiddleThisMonth.withDayOfMonth(1).toLocalDate()
        mv["months"][0].numDocuments == 7
        mv["months"][2].month == noonMiddleThisMonth.minusMonths(2).withDayOfMonth(1).toLocalDate()
        mv["months"][2].numDocuments == 0
    }
}
