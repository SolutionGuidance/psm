package gov.medicaid.controllers.admin.report

import gov.medicaid.entities.SearchResult
import gov.medicaid.services.ProviderEnrollmentService
import gov.medicaid.entities.Enrollment
import gov.medicaid.entities.EnrollmentStatus
import gov.medicaid.entities.dto.ViewStatics

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.ZoneId;
import javax.servlet.http.HttpServletResponse

import org.springframework.web.servlet.ModelAndView
import org.springframework.mock.web.MockHttpServletResponse
import org.apache.commons.csv.CSVFormat
import org.apache.commons.csv.CSVParser

import spock.lang.Specification

class TimeToReviewReportControllerTest extends Specification {
    private TimeToReviewReportController controller
    private ProviderEnrollmentService service
    private static TimeZone originalTimeZone
    private static LocalDateTime noonMiddleThisMonth

    void setupSpec() {
        originalTimeZone = TimeZone.getDefault()
        noonMiddleThisMonth = LocalDate.now().withDayOfMonth(15).atTime(12, 0);
    }

    void cleanupSpec() {
        TimeZone.setDefault(originalTimeZone)
    }

    void setup() {
        controller = new TimeToReviewReportController();
        service = Mock(ProviderEnrollmentService);

        controller.setEnrollmentService(service);

        TimeZone.setDefault(TimeZone.getTimeZone("UTC"))
    }

    def "csv with no enrollments - header"() {
        given:
            def results = new SearchResult<Enrollment>()
            results.setItems([])
            1 * service.searchEnrollments(_) >> results
            def response = new MockHttpServletResponse()

        when:
            controller.getTimeToReviewCsv(response)
            def csv = CSVParser.parse(response.getContentAsString(), CSVFormat.DEFAULT)
            def records = csv.getRecords();

        then:
            records[0][0] == "Month"
            records[0][1] == "Number Reviewed"
            records[0][2] == "Mean Review Time"
            records[0][3] == "Median Review Time"
            records.size == 1
            records[0].size() == 4
    }

    private toDate(d) {
        Date.from(d.atZone(ZoneId.systemDefault()).toInstant())
    }

    private makeEnrollment(submissionDate, statusDate) {
        return new Enrollment([
            submissionDate: toDate(submissionDate),
            statusDate: toDate(statusDate)
        ])
    }

    private testData() {
        def results = new SearchResult<Enrollment>()
        results.setItems([
            makeEnrollment(noonMiddleThisMonth.minusDays(2), noonMiddleThisMonth),
            makeEnrollment(
                noonMiddleThisMonth.minusMonths(1).minusDays(2).minusHours(2),
                noonMiddleThisMonth.minusMonths(1)
            ),
            makeEnrollment(
                noonMiddleThisMonth.minusMonths(1).minusDays(3).minusHours(4),
                noonMiddleThisMonth.minusMonths(1)
            ),
            makeEnrollment(
                noonMiddleThisMonth.minusMonths(1).minusDays(4).minusHours(6),
                noonMiddleThisMonth.minusMonths(1)
            ),
            makeEnrollment(
                noonMiddleThisMonth.minusMonths(3).minusHours(5),
                noonMiddleThisMonth.minusMonths(3)
            )
        ].sort{it.getCreatedOn()})
        results
    }

    def "csv with enrollments"() {
        given:
            1 * service.searchEnrollments(_) >> testData()

            def response = new MockHttpServletResponse()

        when:
            controller.getTimeToReviewCsv(response)
            def csv = CSVParser.parse(response.getContentAsString(), CSVFormat.DEFAULT)
            def records = csv.getRecords();

        then:
            records.size == 5
            records[1].size() == 4
            records[3].size() == 4
            records[1][0] == noonMiddleThisMonth.withDayOfMonth(1).toLocalDate().toString()
            records[1][1] == "1"
            records[1][2] == "2 days, 0 hours"
            records[1][3] == "2 days, 0 hours"
            records[2][0] == noonMiddleThisMonth.withDayOfMonth(1).minusMonths(1).toLocalDate().toString()
            records[2][1] == "3"
            records[2][2] == "3 days, 4 hours"
            records[2][3] == "3 days, 4 hours"
            records[3][0] == noonMiddleThisMonth.withDayOfMonth(1).minusMonths(2).toLocalDate().toString()
            records[3][1] == "0"
            records[3][2] == "N/A"
            records[3][3] == "N/A"
            records[4][0] == noonMiddleThisMonth.withDayOfMonth(1).minusMonths(3).toLocalDate().toString()
            records[4][1] == "1"
            records[4][2] == "0 days, 5 hours"
            records[4][3] == "0 days, 5 hours"
    }

    def "mv with enrollments"() {
        given:
            1 * service.searchEnrollments(_) >> testData()

        when:
            def mv = controller.getTimeToReview().getModel()

        then:
            mv["months"].size == 4
            mv["months"][0].month == noonMiddleThisMonth.withDayOfMonth(1).toLocalDate()
            mv["months"][0].enrollments.size == 1
            mv["months"][0].meanAsString == "2 days, 0 hours"
            mv["months"][2].month == noonMiddleThisMonth.withDayOfMonth(1).minusMonths(2).toLocalDate()
            mv["months"][2].medianAsString == "0 days, 0 hours"
    }
}
