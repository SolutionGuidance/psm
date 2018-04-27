package gov.medicaid.controllers.admin.report

import gov.medicaid.entities.SearchResult
import gov.medicaid.services.ProviderEnrollmentService
import gov.medicaid.entities.Enrollment
import gov.medicaid.entities.EnrollmentStatus

import java.time.LocalDate;
import java.time.ZoneId;
import javax.servlet.http.HttpServletResponse

import org.springframework.web.servlet.ModelAndView
import org.springframework.mock.web.MockHttpServletResponse
import org.apache.commons.csv.CSVFormat
import org.apache.commons.csv.CSVParser

import spock.lang.Specification

class ApplicationsInDraftReportControllerTest extends Specification {
    private ApplicationsInDraftReportController controller
    private ProviderEnrollmentService service
    private static TimeZone originalTimeZone
    private static LocalDate middleThisMonth
  
    void setupSpec() {
        originalTimeZone = TimeZone.getDefault()
        middleThisMonth = LocalDate.now().withDayOfMonth(15);
    }
  
    void cleanupSpec() {
        TimeZone.setDefault(originalTimeZone)
    }
  
    void setup() {
        controller = new ApplicationsInDraftReportController();
        service = Mock(ProviderEnrollmentService);
  
        controller.setEnrollmentService(service);
  
        TimeZone.setDefault(TimeZone.getTimeZone("UTC"))
    }
  
    def "csv with no enrollments - header"() {
        given:
            def results = new SearchResult<Enrollment>()
            results.setItems([])
            1 * service.getDraftAtEOMEnrollments(_) >> results
            def response = new MockHttpServletResponse()
  
        when:
            controller.getEnrollments(response)
            def csv = CSVParser.parse(response.getContentAsString(), CSVFormat.DEFAULT)
            def records = csv.getRecords();
  
        then:
            records[0][0] == "Month with Draft"
            records[0][1] == "Application ID"
            records[0][2] == "Creation Date"
            records[0][3] == "Submission Date"
            records.size == 1
            records[0].size() == 4
    }
  
    private toDate(localDate) {
        Date.from(localDate.atStartOfDay(ZoneId.systemDefault()).toInstant())
    }
  
    private makeEnrollment(id, createdOn, submissionDate) {
        return new Enrollment([
            ticketId: id,
            createdOn: toDate(createdOn),
            submissionDate: submissionDate != null ?  toDate(submissionDate) : null
        ])
    }
  
    private testData() {
        def results = new SearchResult<Enrollment>()
        results.setItems([
            makeEnrollment(1, middleThisMonth.minusMonths(1), middleThisMonth),
            makeEnrollment(2, middleThisMonth.minusMonths(2), null),
            makeEnrollment(3, middleThisMonth.minusMonths(3), middleThisMonth.minusMonths(2)),
            makeEnrollment(4, middleThisMonth.minusMonths(3).minusDays(1), null),
            makeEnrollment(5, middleThisMonth.minusMonths(2), middleThisMonth.minusMonths(2)),
            makeEnrollment(6, middleThisMonth, middleThisMonth.plusMonths(1)),
            makeEnrollment(7, middleThisMonth, null)
        ].sort{it.getCreatedOn()})
        results
    }
  
    def "csv with enrollments"() {
        given:
            1 * service.getDraftAtEOMEnrollments(_) >> testData()
  
            def response = new MockHttpServletResponse()
  
        when:
            controller.getEnrollments(response)
            def csv = CSVParser.parse(response.getContentAsString(), CSVFormat.DEFAULT)
            def records = csv.getRecords();
  
        then:
            records.size == 10
            records[1].size() == 4
            records[6].size() == 4
            records[1][0] == middleThisMonth.withDayOfMonth(1).toString()
            records[1][1] == "4"
            records[1][2] == toDate(middleThisMonth.minusMonths(3).minusDays(1)).toString()
            records[1][3] == ""
            records[7][0] == middleThisMonth.withDayOfMonth(1).minusMonths(1).toString()
            records[7][1] == "1"
            records[7][2] == toDate(middleThisMonth.minusMonths(1)).toString()
            records[7][3] == toDate(middleThisMonth).toString()
    }
  
    def "mv with enrollments"() {
        given:
            1 * service.getDraftAtEOMEnrollments(_) >> testData()
  
            def response = new MockHttpServletResponse()
  
        when:
            def mv = controller.getEnrollments().getModel()
  
        then:
            mv["enrollmentMonths"].size == 3
            mv["enrollmentMonths"][0].month == middleThisMonth.withDayOfMonth(1)
            mv["enrollmentMonths"][0].enrollments[0].ticketId == 4
            mv["enrollmentMonths"][2].month == middleThisMonth.withDayOfMonth(1).minusMonths(2)
            mv["enrollmentMonths"][2].enrollments[1].createdOn == toDate(middleThisMonth.minusMonths(2))
            mv["enrollmentMonths"][1].enrollments[0].submissionDate == null
            mv["enrollmentMonths"][1].enrollments[2].submissionDate == toDate(middleThisMonth)
    }
}
