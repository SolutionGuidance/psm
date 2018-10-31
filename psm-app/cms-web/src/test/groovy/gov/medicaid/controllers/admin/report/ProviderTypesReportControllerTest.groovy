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
import java.time.LocalDateTime
import java.time.ZoneId

import org.apache.commons.csv.CSVFormat
import org.apache.commons.csv.CSVParser
import org.springframework.mock.web.MockHttpServletResponse

import gov.medicaid.entities.Application
import gov.medicaid.entities.Person
import gov.medicaid.entities.ProviderType
import gov.medicaid.entities.SearchResult
import gov.medicaid.services.ProviderApplicationService
import gov.medicaid.services.ProviderTypeService
import spock.lang.Specification

class ProviderTypesReportControllerTest extends Specification {
    private ProviderTypesReportController controller
    private ProviderApplicationService applicationService
    private ProviderTypeService providerTypeService
    private static LocalDateTime noonMiddleThisMonth

    void setupSpec() {
        noonMiddleThisMonth = LocalDate.now().withDayOfMonth(15).atTime(12, 0)
    }

    void setup() {
        applicationService = Mock(ProviderApplicationService)
        providerTypeService = Mock(ProviderTypeService)
        controller = new ProviderTypesReportController(applicationService, providerTypeService)

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
    }

    private toDate(d) {
        Date.from(d.atZone(ZoneId.systemDefault()).toInstant())
    }

    private makeApplication(profileId, statusDate) {
        return new Application([
            profileReferenceId: profileId,
            statusDate: toDate(statusDate)
        ])
    }

    private testApplicationData() {
        def results = new SearchResult<Application>()
        results.setItems([
            makeApplication(1, noonMiddleThisMonth),
            makeApplication(2, noonMiddleThisMonth),
            makeApplication(3, noonMiddleThisMonth),
            makeApplication(4, noonMiddleThisMonth.minusMonths(1)),
            makeApplication(5, noonMiddleThisMonth.minusMonths(1)),
            makeApplication(6, noonMiddleThisMonth.minusMonths(2))
        ].sort{it.getCreatedOn()})
        results
    }

    private makePerson(description) {
        new Person([providerType: new ProviderType([code: description, description: description])])
    }

    private setupTestEntities() {
        applicationService.findEntityByProviderKey(1) >> makePerson("PT 1")
        applicationService.findEntityByProviderKey(2) >> makePerson("PT 1")
        applicationService.findEntityByProviderKey(3) >> makePerson("PT 2")
        applicationService.findEntityByProviderKey(4) >> makePerson("PT 2")
        applicationService.findEntityByProviderKey(5) >> makePerson("PT 2")
        applicationService.findEntityByProviderKey(6) >> makePerson("PT 1")
    }

    def "csv with no applications - header"() {
        given:
        def results = new SearchResult<Application>()
        results.setItems([])
        1 * applicationService.searchApplications(_) >> results
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

    def "csv with applications"() {
        given:
        1 * applicationService.searchApplications(_) >> testApplicationData()
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

    def "mv with applications"() {
        given:
        1 * applicationService.searchApplications(_) >> testApplicationData()
        setupTestEntities()

        when:
        def mv = controller.getProviderTypes(["PT 1", "PT 2"]).model

        then:
        mv["months"].size == 3
        mv["months"][0].month == noonMiddleThisMonth.withDayOfMonth(1).toLocalDate()
        mv["months"][0].getProviderTypes().get(0).description == "PT 1"
        mv["months"][0].getApplications(new ProviderType([code: "PT 1"])).size == 2
        mv["months"][0].getApplications(new ProviderType([code: "PT 2"])).size == 1
        mv["months"][2].month == noonMiddleThisMonth.withDayOfMonth(1).minusMonths(2).toLocalDate()
        mv["months"][2].containsApplications(new ProviderType([code: "PT 2"])) == false

        mv["providerTypes"].size == 4

        mv["providerTypeCodesQueryString"] == "providerType=PT 1&providerType=PT 2"
    }
}
