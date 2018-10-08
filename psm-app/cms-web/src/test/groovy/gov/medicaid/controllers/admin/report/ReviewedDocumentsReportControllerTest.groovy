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
import gov.medicaid.entities.SearchResult
import gov.medicaid.services.ProviderApplicationService
import spock.lang.Specification

class ReviewedDocumentsReportControllerTest extends Specification {
    private ReviewedDocumentsReportController controller
    private ProviderApplicationService applicationService
    private static LocalDateTime noonMiddleThisMonth

    void setupSpec() {
        noonMiddleThisMonth = LocalDate.now().withDayOfMonth(15).atTime(12, 0)
    }

    void setup() {
        applicationService = Mock(ProviderApplicationService)
        controller = new ReviewedDocumentsReportController(applicationService)
    }

    private toDate(d) {
        Date.from(d.atZone(ZoneId.systemDefault()).toInstant())
    }

    private makeApplication(profielId, statusDate) {
        return new Application([
            profileReferenceId: profielId,
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

    // It doesn't matter that it doesn't actually return documents
    private setupTestDocuments() {
        applicationService.findAttachments(1) >> (0..<2)
        applicationService.findAttachments(2) >> (0..<1)
        applicationService.findAttachments(3) >> (0..<4)
        applicationService.findAttachments(4) >> (0..<1)
        applicationService.findAttachments(5) >> (0..<2)
        applicationService.findAttachments(6) >> (0..<0)
        applicationService.findAttachments(7) >> (0..<8)
    }

    def "csv with no applications - header"() {
        given:
        def results = new SearchResult<Application>()
        results.setItems([])
        1 * applicationService.searchApplications(_) >> results
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

    def "csv with applications"() {
        given:
        1 * applicationService.searchApplications(_) >> testApplicationData()
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

    def "mv with applications"() {
        given:
        1 * applicationService.searchApplications(_) >> testApplicationData()
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
