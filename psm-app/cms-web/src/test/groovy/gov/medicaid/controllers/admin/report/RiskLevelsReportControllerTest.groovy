package gov.medicaid.controllers.admin.report

import java.time.LocalDate
import java.time.LocalDateTime
import java.time.ZoneId

import org.apache.commons.csv.CSVFormat
import org.apache.commons.csv.CSVParser
import org.springframework.mock.web.MockHttpServletResponse

import gov.medicaid.entities.Enrollment
import gov.medicaid.entities.ProviderProfile
import gov.medicaid.entities.RiskLevel
import gov.medicaid.entities.SearchResult
import gov.medicaid.entities.dto.ViewStatics
import gov.medicaid.services.ProviderEnrollmentService
import spock.lang.Specification

class RiskLevelsReportControllerTest extends Specification {
    private RiskLevelsReportController controller
    private ProviderEnrollmentService enrollmentService
    private static LocalDateTime noonMiddleThisMonth

    void setupSpec() {
        noonMiddleThisMonth = LocalDate.now().withDayOfMonth(15).atTime(12, 0)
    }

    void setup() {
        controller = new RiskLevelsReportController()
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

    private makeProvider(riskLevel) {
        return new ProviderProfile([
            riskLevel: new RiskLevel([description: riskLevel])
        ])
    }

    private setupTestProviders() {
        enrollmentService.getProviderDetailsByTicket(1, false) >> makeProvider(ViewStatics.LOW_RISK)
        enrollmentService.getProviderDetailsByTicket(2, false) >> makeProvider(ViewStatics.LOW_RISK)
        enrollmentService.getProviderDetailsByTicket(3, false) >> makeProvider(ViewStatics.MODERATE_RISK)
        enrollmentService.getProviderDetailsByTicket(4, false) >> makeProvider(ViewStatics.HIGH_RISK)
        enrollmentService.getProviderDetailsByTicket(5, false) >> makeProvider(ViewStatics.HIGH_RISK)
        enrollmentService.getProviderDetailsByTicket(6, false) >> makeProvider(ViewStatics.MODERATE_RISK)
        enrollmentService.getProviderDetailsByTicket(7, false) >> makeProvider(ViewStatics.LOW_RISK)
    }

    def "csv with no enrollments - header"() {
        given:
        def results = new SearchResult<Enrollment>()
        results.setItems([])
        1 * enrollmentService.searchEnrollments(_) >> results
        def response = new MockHttpServletResponse()

        when:
        controller.getRiskLevelsCsv(response)
        def csv = CSVParser.parse(response.getContentAsString(), CSVFormat.DEFAULT)
        def records = csv.getRecords()

        then:
        records.size == 1
        records[0].size() == 4
        records[0][0] == "Month"
        records[0][1] == ViewStatics.LOW_RISK
        records[0][2] == ViewStatics.MODERATE_RISK
        records[0][3] == ViewStatics.HIGH_RISK
    }

    def "csv with enrollments"() {
        given:
        def response = new MockHttpServletResponse()
        1 * enrollmentService.searchEnrollments(_) >> testEnrollmentData()
        setupTestProviders()

        when:
        controller.getRiskLevelsCsv(response)
        def csv = CSVParser.parse(response.getContentAsString(), CSVFormat.DEFAULT)
        def records = csv.getRecords()

        then:
        records.size == 5
        records[1].size() == 4
        records[1][0] == noonMiddleThisMonth.withDayOfMonth(1).toLocalDate().toString()
        records[1][1] == "2"
        records[1][2] == "1"
        records[1][3] == "0"
        records[2][0] == noonMiddleThisMonth.minusMonths(1).withDayOfMonth(1).toLocalDate().toString()
        records[2][1] == "0"
        records[2][2] == "0"
        records[2][3] == "2"
        records[3][0] == noonMiddleThisMonth.minusMonths(2).withDayOfMonth(1).toLocalDate().toString()
        records[3][1] == "0"
        records[3][2] == "1"
        records[3][3] == "0"
        records[4][0] == noonMiddleThisMonth.minusMonths(3).withDayOfMonth(1).toLocalDate().toString()
        records[4][1] == "1"
        records[4][2] == "0"
        records[4][3] == "0"
    }

    def "mv with enrollments"() {
        given:
        1 * enrollmentService.searchEnrollments(_) >> testEnrollmentData()
        setupTestProviders()

        when:
        def mv = controller.getRiskLevels().model

        then:
        mv["months"].size == 4
        mv["months"][0].month == noonMiddleThisMonth.withDayOfMonth(1).toLocalDate()
        mv["months"][0].getNum(ViewStatics.LOW_RISK) == 2
        mv["months"][0].getNum(ViewStatics.HIGH_RISK) == 0
        mv["months"][2].month == noonMiddleThisMonth.minusMonths(2).withDayOfMonth(1).toLocalDate()
        mv["months"][2].getNum(ViewStatics.MODERATE_RISK) == 1
    }
}
