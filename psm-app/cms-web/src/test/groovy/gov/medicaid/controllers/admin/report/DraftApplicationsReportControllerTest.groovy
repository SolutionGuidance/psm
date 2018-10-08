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

import gov.medicaid.entities.Application
import gov.medicaid.entities.Person
import gov.medicaid.entities.ProviderProfile
import gov.medicaid.entities.ProviderType
import gov.medicaid.entities.SearchResult
import gov.medicaid.services.ProviderApplicationService
import spock.lang.Specification

class DraftApplicationsReportControllerTest extends Specification {
    private DraftApplicationsReportController controller
    private ProviderApplicationService service
    private static TimeZone originalTimeZone
    private static LocalDate middleThisMonth

    void setupSpec() {
        originalTimeZone = TimeZone.getDefault()
        middleThisMonth = LocalDate.now().withDayOfMonth(15)
    }

    void cleanupSpec() {
        TimeZone.setDefault(originalTimeZone)
    }

    void setup() {
        service = Mock(ProviderApplicationService)
        controller = new DraftApplicationsReportController(service)

        TimeZone.setDefault(TimeZone.getTimeZone("UTC"))
    }

    def "csv with no applications - header"() {
        given:
        def results = new SearchResult<Application>()
        results.setItems([])
        1 * service.getDraftAtEomApplications(_) >> results
        def response = new MockHttpServletResponse()

        when:
        controller.getDraftApplicationsCsv(response)
        def csv = CSVParser.parse(response.getContentAsString(), CSVFormat.DEFAULT)
        def records = csv.getRecords()

        then:
        records[0][0] == "Month in Draft"
        records[0][1] == "Application ID"
        records[0][2] == "NPI"
        records[0][3] == "Provider Name"
        records[0][4] == "Provider Type"
        records[0][5] == "Creation Date"
        records[0][6] == "Submission Date"
        records.size == 1
        records[0].size() == 7
    }

    private toDate(localDate) {
        Date.from(localDate.atStartOfDay(ZoneId.systemDefault()).toInstant())
    }

    private makeApplication(id, createdOn, submissionDate) {
        return new Application([
            applicationId: id,
            profileReferenceId: id,
            createdOn: toDate(createdOn),
            submissionDate: submissionDate != null ?  toDate(submissionDate) : null
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

    private testApplicationData() {
        def results = new SearchResult<Application>()
        results.setItems([
            makeApplication(1, middleThisMonth.minusMonths(1), middleThisMonth),
            makeApplication(2, middleThisMonth.minusMonths(2), null),
            makeApplication(3, middleThisMonth.minusMonths(3), middleThisMonth.minusMonths(2)),
            makeApplication(4, middleThisMonth.minusMonths(3).minusDays(1), null),
            makeApplication(5, middleThisMonth.minusMonths(2), middleThisMonth.minusMonths(2)),
            makeApplication(6, middleThisMonth, middleThisMonth.plusMonths(1)),
            makeApplication(7, middleThisMonth, null)
        ].sort{it.getCreatedOn()})
        results
    }

    def "csv with applications"() {
        given:
        1 * service.getDraftAtEomApplications(_) >> testApplicationData()
        (1..7).each {
            1 * service.getProviderDetails(it, true) >> makeProviderProfile("Provider", "Type");
        }

        def response = new MockHttpServletResponse()

        when:
        controller.getDraftApplicationsCsv(response)
        def csv = CSVParser.parse(response.getContentAsString(), CSVFormat.DEFAULT)
        def records = csv.getRecords()

        then:
        records.size == 12
        records[1].size() == 7
        records[6].size() == 7
        records[1][0] == middleThisMonth.withDayOfMonth(1).toString()
        records[1][1] == "4"
        records[1][2] == ""
        records[1][3] == "Provider"
        records[1][4] == "Type"
        records[1][5] == toDate(middleThisMonth.minusMonths(3).minusDays(1)).toString()
        records[1][6] == ""

        records[7][0] == middleThisMonth.withDayOfMonth(1).minusMonths(1).toString()
        records[7][1] == "1"
        records[7][2] == ""
        records[7][3] == "Provider"
        records[7][4] == "Type"
        records[7][5] == toDate(middleThisMonth.minusMonths(1)).toString()
        records[7][6] == toDate(middleThisMonth).toString()
    }

    def "mv with applications"() {
        given:
        1 * service.getDraftAtEomApplications(_) >> testApplicationData()

        when:
        def mv = controller.getDraftApplications().getModel()

        then:
        mv["applicationMonths"].size == 4
        mv["applicationMonths"][0].month == middleThisMonth.withDayOfMonth(1)
        mv["applicationMonths"][0].applications[0].applicationId == 4
        mv["applicationMonths"][2].month == middleThisMonth.withDayOfMonth(1).minusMonths(2)
        mv["applicationMonths"][2].applications[1].createdOn == toDate(middleThisMonth.minusMonths(2))
        mv["applicationMonths"][1].applications[0].submissionDate == null
        mv["applicationMonths"][1].applications[2].submissionDate == toDate(middleThisMonth)
    }
}
