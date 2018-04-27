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
          controller.getEnrollments(null, null, response)
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

  def "csv with an enrollments"() {
      given:
          def results = new SearchResult<Enrollment>()
          results.setItems([
                  new Enrollment([
                      ticketId: 1234,
                      createdOn: Date.parse("yyyy-MM-dd HH:mm:ss zzz", "2018-05-05 12:32:33 PST"),
                      lastUpdatedBy: "ADMIN",
                      statusDate: Date.parse("yyyy-MM-dd HH:mm:ss zzz", "2018-05-08 5:03:55 PST"),
                      status: new EnrollmentStatus([description: "TEST"])
                  ])
              ])
          1 * service.searchEnrollments(_) >> results

          System.out.println();

          def response = new MockHttpServletResponse()

      when:
          controller.getEnrollments(null, null, response)
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
}
