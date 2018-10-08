/*
 * Copyright 2018 The MITRE Corporation
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package gov.medicaid.controllers.admin.report

import java.time.LocalDate
import java.time.ZoneId

import org.apache.commons.csv.CSVFormat
import org.apache.commons.csv.CSVParser
import org.springframework.mock.web.MockHttpServletResponse

import gov.medicaid.entities.CMSUser
import gov.medicaid.entities.Application
import gov.medicaid.entities.ApplicationStatus
import gov.medicaid.entities.Person
import gov.medicaid.entities.ProviderProfile
import gov.medicaid.entities.ProviderType
import gov.medicaid.entities.SearchResult
import gov.medicaid.services.ProviderApplicationService
import spock.lang.Specification

class ApplicationsByReviewerReportControllerTest extends Specification {
    private ApplicationsByReviewerReportController controller
    private ProviderApplicationService service
    private static TimeZone originalTimeZone

    private toDate(dateStr) {
        Date.parse("yyyy-MM-dd HH:mm:ss zzz", dateStr)
    }

    private makeApplication(id, createdOn, lastUpdatedBy, statusDate, status) {
        return new Application([
            applicationId: id,
            profileReferenceId: id,
            createdOn: toDate(createdOn),
            lastUpdatedBy: new CMSUser([username: lastUpdatedBy]),
            statusDate: toDate(statusDate),
            status: new ApplicationStatus([description: status])
        ])
    }

    private makeProviderProfile(providerName, providerType) {
        return new ProviderProfile([
            entity: new Person([
                name: providerName,
                providerType: new ProviderType([description: providerType])
            ])
        ])
    }

    void setupSpec() {
        originalTimeZone = TimeZone.getDefault()
    }

    void cleanupSpec() {
        TimeZone.setDefault(originalTimeZone)
    }

    void setup() {
        service = Mock(ProviderApplicationService)
        controller = new ApplicationsByReviewerReportController(service)

        TimeZone.setDefault(TimeZone.getTimeZone("UTC"))
    }

    def "csv with no applications - header"() {
        given:
        def results = new SearchResult<Application>()
        results.setItems([])
        1 * service.searchApplications(_) >> results
        def response = new MockHttpServletResponse()

        when:
        controller.getApplicationsByReviewerCsv(null, null, response)
        def csv = CSVParser.parse(response.getContentAsString(), CSVFormat.DEFAULT)
        def records = csv.getRecords()

        then:
        records[0][0] == "Application ID"
        records[0][1] == "Provider Name"
        records[0][2] == "Provider Type"
        records[0][3] == "Submission Date"
        records[0][4] == "Reviewed By"
        records[0][5] == "Review Date"
        records[0][6] == "Status"
        records.size == 1
        records[0].size() == 7
    }

    def "csv with an applications"() {
        given:
        def results = new SearchResult<Application>()
        results.setItems([
            makeApplication(1234, "2018-05-05 12:32:33 PST", "admin", "2018-05-08 5:03:55 PST", "TEST")
        ])
        1 * service.searchApplications(_) >> results
        1 * service.getProviderDetails(1234, true) >> makeProviderProfile("Provider", "Type");

        def response = new MockHttpServletResponse()

        when:
        controller.getApplicationsByReviewerCsv(null, null, response)
        def csv = CSVParser.parse(response.getContentAsString(), CSVFormat.DEFAULT)
        def records = csv.getRecords()

        then:
        records.size == 2
        records[1].size() == 7
        records[1][0] == "1234"
        records[1][1] == "Provider"
        records[1][2] == "Type"
        records[1][3] == "Sat May 05 20:32:33 UTC 2018"
        records[1][4] == "admin"
        records[1][5] == "Tue May 08 13:03:55 UTC 2018"
        records[1][6] == "TEST"
    }

    private testData() {
        def results = new SearchResult<Application>()
        results.setItems([
            makeApplication(1234, "2018-05-05 12:32:33 PST", "admin", "2018-05-08 5:03:55 PST", "TEST"),
            makeApplication(1235, "2018-05-04 12:32:33 PST", "p1", "2018-05-09 5:03:55 PST", "APPROVED"),
            makeApplication(1236, "2018-05-03 12:32:33 PST", "p1", "2018-05-10 5:03:55 PST", "DRAFT"),
            makeApplication(1237, "2018-05-02 12:32:33 PST", "admin", "2018-05-11 5:03:55 PST", "TEST")
        ].sort{it.getCreatedOn()})
        results
    }

    def "base mv"() {
        when:
        def results = new SearchResult<Application>()
        results.setItems([])
        1 * service.searchApplications(_) >> results
        def mv = controller.getApplicationsByReviewer(null, null, null).model

        then:
        mv["startDate"] == Date.from(LocalDate.now().withDayOfMonth(1).atStartOfDay(ZoneId.systemDefault()).toInstant())
        mv["endDate"] == Date.from(LocalDate.now().plusMonths(1).withDayOfMonth(1).minusDays(1)
                .atStartOfDay(ZoneId.systemDefault()).toInstant())
        mv["applications"].size == 0
    }

    def "submitted mv"() {
        when:
        def mv = controller.getApplicationsByReviewer("", null, null).model

        then:
        1 * service.searchApplications(*_) >> { arguments ->
            assert null == arguments[0].createDateStart
            assert null == arguments[0].createDateEnd
            testData()
        }
        mv["startDate"] == null
        mv["endDate"] == null
        mv["applications"].size == 4
        mv["applications"][0].applicationId == 1237
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
        1 * service.searchApplications(*_) >> { arguments ->
            assert startDate == arguments[0].createDateStart
            assert endDate == arguments[0].createDateEnd
            testData()
        }
        mv["startDate"] == startDate
        mv["endDate"] == endDate
    }
}
