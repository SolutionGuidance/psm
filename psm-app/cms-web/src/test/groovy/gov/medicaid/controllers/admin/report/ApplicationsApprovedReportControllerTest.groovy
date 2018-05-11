package gov.medicaid.controllers.admin.report

import gov.medicaid.entities.SearchResult
import org.springframework.web.servlet.ModelAndView
import gov.medicaid.services.ProviderEnrollmentService
import javax.servlet.http.HttpServletResponse
import org.springframework.mock.web.MockHttpServletResponse
import gov.medicaid.entities.Enrollment
import gov.medicaid.entities.EnrollmentStatus
import spock.lang.Specification
import org.apache.commons.csv.CSVFormat
import org.apache.commons.csv.CSVParser

class ApplicationsApprovedReportControllerTest extends Specification {
    private ApplicationsApprovedReportController controller
    private ProviderEnrollmentService service
    private static TimeZone originalTimeZone

    private toDate(dateStr) {
        Date.parse("yyyy-MM-dd HH:mm:ss zzz", dateStr)
    }

    private makeEnrollment(id, createdOn, lastUpdatedBy, statusDate, status) {
        return new Enrollment([
            ticketId: id,
            createdOn: toDate(createdOn),
            lastUpdatedBy: lastUpdatedBy,
            statusDate: toDate(statusDate),
            status: new EnrollmentStatus([description: status])
        ])
    }
  
    void setupSpec() {
        originalTimeZone = TimeZone.getDefault()
    }
  
    void cleanupSpec() {
        TimeZone.setDefault(originalTimeZone)
    }
  
    void setup() {
        controller = new ApplicationsApprovedReportController();
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
            controller.getApplicationsByReviewerCsv(null, null, response)
            def csv = CSVParser.parse(response.getContentAsString(), CSVFormat.DEFAULT)
            def records = csv.getRecords();
  
        then:
            records[0][0] == "Application ID"
            records[0][1] == "Submission Date"
            records[0][2] == "Reviewed By"
            records[0][3] == "Review Date"
            records[0][4] == "Status"
            records.size == 1
            records[0].size() == 5
    }
  
    def "csv with an enrollment"() {
        given:
            def results = new SearchResult<Enrollment>()
            results.setItems([
                makeEnrollment(1234, "2018-05-05 12:32:33 PST", "ADMIN", "2018-05-08 5:03:55 PST", "TEST")
                ])
            1 * service.searchEnrollments(_) >> results
  
            def response = new MockHttpServletResponse()
  
        when:
            controller.getApplicationsByReviewerCsv(null, null, response)
            def csv = CSVParser.parse(response.getContentAsString(), CSVFormat.DEFAULT)
            def records = csv.getRecords();
  
        then:
            records.size == 2
            records[1].size() == 5
            records[1][0] == "1234"
            records[1][1] == "Sat May 05 20:32:33 UTC 2018"
            records[1][2] == "ADMIN"
            records[1][3] == "Tue May 08 13:03:55 UTC 2018"
            records[1][4] == "TEST"
    }
  
    private testData() {
        def results = new SearchResult<Enrollment>()
        results.setItems([
            makeEnrollment(1234, "2018-05-05 12:32:33 PST", "ADMIN", "2018-05-08 5:03:55 PST", "TEST"),
            makeEnrollment(1235, "2018-05-04 12:32:33 PST", "p1", "2018-05-09 5:03:55 PST", "APPROVED"),
            makeEnrollment(1236, "2018-05-03 12:32:33 PST", "p1", "2018-05-10 5:03:55 PST", "DRAFT"),
            makeEnrollment(1237, "2018-05-02 12:32:33 PST", "ADMIN", "2018-05-11 5:03:55 PST", "TEST")
        ].sort{it.getCreatedOn()})
        results
    }
  
    def "base mv"() {
        when:
            def mv = controller.getApplicationsByReviewer(null, null, null).model
  
        then:
            mv["submitted"] == false
    }
  
    def "submitted mv"() {
        when:
            def mv = controller.getApplicationsByReviewer("", null, null).model
  
        then:
            1 * service.searchEnrollments(*_) >> { arguments ->
              assert null == arguments[0].createDateStart
              assert null == arguments[0].createDateEnd
              testData()
            }
            mv["submitted"] == true
            mv["startDate"] == null
            mv["endDate"] == null
            mv["enrollments"].size == 4
            mv["enrollments"][0].ticketId == 1237
    }
  
    def "submitted mv with dates"() {
        given:
            def startDate = toDate("2018-05-05 12:32:33 PST")
            def endDate = toDate("2018-05-08 12:32:33 PST")
  
        when:
            def mv = controller.getApplicationsByReviewer(
                "2018-05-05 12:32:33 PST",
                startDate,
                endDate
            ).model
  
        then:
            1 * service.searchEnrollments(*_) >> { arguments ->
              assert startDate == arguments[0].createDateStart
              assert endDate == arguments[0].createDateEnd
              testData()
            }
            mv["submitted"] == true
            mv["startDate"] == startDate
            mv["endDate"] == endDate
    }
}
