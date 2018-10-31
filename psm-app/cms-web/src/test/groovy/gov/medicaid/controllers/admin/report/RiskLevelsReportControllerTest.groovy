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
import gov.medicaid.entities.ProviderProfile
import gov.medicaid.entities.RiskLevel
import gov.medicaid.entities.SearchResult
import gov.medicaid.entities.dto.ViewStatics
import gov.medicaid.services.ProviderApplicationService
import spock.lang.Specification

class RiskLevelsReportControllerTest extends Specification {
    private RiskLevelsReportController controller
    private ProviderApplicationService applicationService
    private static LocalDateTime noonMiddleThisMonth

    void setupSpec() {
        noonMiddleThisMonth = LocalDate.now().withDayOfMonth(15).atTime(12, 0)
    }

    void setup() {
        applicationService = Mock(ProviderApplicationService)
        controller = new RiskLevelsReportController(applicationService)
    }

    private toDate(d) {
        Date.from(d.atZone(ZoneId.systemDefault()).toInstant())
    }

    private makeApplication(applicationId, statusDate) {
        return new Application([
            applicationId: applicationId,
            profileReferenceId: applicationId,
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
            makeApplication(6, noonMiddleThisMonth.minusMonths(2)),
            makeApplication(7, noonMiddleThisMonth.minusMonths(3))
        ].sort{it.getCreatedOn()})
        results
    }

    private makeProvider(riskLevel) {
        return new ProviderProfile([
            riskLevel: new RiskLevel([description: riskLevel])
        ])
    }

    private setupTestProviders() {
        applicationService.getProviderDetails(1, false) >> makeProvider(ViewStatics.LIMITED_RISK)
        applicationService.getProviderDetails(2, false) >> makeProvider(ViewStatics.LIMITED_RISK)
        applicationService.getProviderDetails(3, false) >> makeProvider(ViewStatics.MODERATE_RISK)
        applicationService.getProviderDetails(4, false) >> makeProvider(ViewStatics.HIGH_RISK)
        applicationService.getProviderDetails(5, false) >> makeProvider(ViewStatics.HIGH_RISK)
        applicationService.getProviderDetails(6, false) >> makeProvider(ViewStatics.MODERATE_RISK)
        applicationService.getProviderDetails(7, false) >> makeProvider(ViewStatics.LIMITED_RISK)
    }

    def "csv with no applications - header"() {
        given:
        def results = new SearchResult<Application>()
        results.setItems([])
        1 * applicationService.searchApplications(_) >> results
        def response = new MockHttpServletResponse()

        when:
        controller.getRiskLevelsCsv(response)
        def csv = CSVParser.parse(response.getContentAsString(), CSVFormat.DEFAULT)
        def records = csv.getRecords()

        then:
        records.size == 1
        records[0].size() == 4
        records[0][0] == "Month"
        records[0][1] == ViewStatics.LIMITED_RISK
        records[0][2] == ViewStatics.MODERATE_RISK
        records[0][3] == ViewStatics.HIGH_RISK
    }

    def "csv with applications"() {
        given:
        def response = new MockHttpServletResponse()
        1 * applicationService.searchApplications(_) >> testApplicationData()
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

    def "mv with applications"() {
        given:
        1 * applicationService.searchApplications(_) >> testApplicationData()
        setupTestProviders()

        when:
        def mv = controller.getRiskLevels().model

        then:
        mv["months"].size == 4
        mv["months"][0].month == noonMiddleThisMonth.withDayOfMonth(1).toLocalDate()
        mv["months"][0].getNum(ViewStatics.LIMITED_RISK) == 2
        mv["months"][0].getNum(ViewStatics.HIGH_RISK) == 0
        mv["months"][2].month == noonMiddleThisMonth.minusMonths(2).withDayOfMonth(1).toLocalDate()
        mv["months"][2].getNum(ViewStatics.MODERATE_RISK) == 1
    }

    def "application without risk level does not cause exceptions"() {
        given:
        def results = new SearchResult<Application>()
        results.setItems([
            makeApplication(1, noonMiddleThisMonth),
        ])
        1 * applicationService.searchApplications(_) >> results
        applicationService.getProviderDetails(1, false) >>
            new ProviderProfile()

        when:
        def mv = controller.getRiskLevels().model

        then:
        mv["months"].size == 1
        mv["months"][0].month == noonMiddleThisMonth.withDayOfMonth(1).toLocalDate()
        mv["months"][0].getNum(ViewStatics.LIMITED_RISK) == 0
        mv["months"][0].getNum(ViewStatics.MODERATE_RISK) == 0
        mv["months"][0].getNum(ViewStatics.HIGH_RISK) == 0
    }
}
