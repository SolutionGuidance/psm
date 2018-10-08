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

package gov.medicaid.controllers.admin.report;

import gov.medicaid.controllers.admin.report.ReportControllerUtils.ApplicationMonth;
import gov.medicaid.entities.Application;
import gov.medicaid.entities.ApplicationSearchCriteria;
import gov.medicaid.services.PortalServiceException;
import gov.medicaid.services.ProviderApplicationService;

import org.apache.commons.csv.CSVFormat;
import org.apache.commons.csv.CSVPrinter;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.time.LocalDate;
import java.util.List;
import java.util.stream.Collectors;

@Controller
public class ReviewedDocumentsReportController extends gov.medicaid.controllers.BaseController {
    private final ProviderApplicationService applicationService;

    public ReviewedDocumentsReportController(ProviderApplicationService applicationService) {
        this.applicationService = applicationService;
    }

    @RequestMapping(value = "/admin/reports/reviewed-documents", method = RequestMethod.GET)
    public ModelAndView getReviewedDocuments() {
        ModelAndView mv = new ModelAndView("admin/reports/reviewed_documents");

        List<Application> applications = getApplicationsFromDB();
        List<ApplicationMonth> ems = groupApplications(applications);
        mv.addObject("months", ems.stream().map(e -> new DocumentsMonth(e, applicationService)).collect(Collectors.toList()));

        return mv;
    }

    @RequestMapping(value = "/admin/reports/revieweddocuments.csv", method = RequestMethod.GET)
    public void getReviewedDocumentsCsv(HttpServletResponse response) throws PortalServiceException {
        String csvFileName = ReportControllerUtils.buildCsvName("revieweddocuments");
        response.setContentType("text/csv");
        response.setHeader("Content-Disposition", String.format("attachment; filename=\"%s\"", csvFileName));

        List<Application> applications = getApplicationsFromDB();
        List<ApplicationMonth> ems = groupApplications(applications);
        List<DocumentsMonth> dms = ems.stream().map(e -> new DocumentsMonth(e, applicationService)).collect(Collectors.toList());

        try {
            CSVPrinter csvPrinter = new CSVPrinter(response.getWriter(), CSVFormat.DEFAULT);
            csvPrinter.printRecord(
                "Month",
                "Number of Documents");

            for (DocumentsMonth dm : dms) {
                csvPrinter.printRecord(
                    dm.getMonth(),
                    dm.getNumDocuments()
                );
            }
            csvPrinter.close();
        } catch (IOException e) {
            throw new PortalServiceException("Couldn't generate CSV", e);
        }
    }

    private List<Application> getApplicationsFromDB() {
        ApplicationSearchCriteria criteria = new ApplicationSearchCriteria();
        criteria.setAscending(true);
        criteria.setSortColumn("t.createdOn");
        return applicationService.searchApplications(criteria).getItems();
    }

    private List<ApplicationMonth> groupApplications(List<Application> applications) {
        return ReportControllerUtils.groupApplications(
            applications,
            Application::getStatusDate,
            (e, monthStart, monthEnd) -> {
                LocalDate statusDate = ReportControllerUtils.toLocalDate(e.getStatusDate());
                return !(monthStart.isAfter(statusDate) || monthEnd.isBefore(statusDate));
            });
    }

    public static class DocumentsMonth {
        private int numDocuments;
        private LocalDate month;

        public DocumentsMonth(ApplicationMonth em, ProviderApplicationService applicationService) {
            numDocuments = 0;
            month = em.getMonth();

            for (Application e : em.getApplications()) {
                numDocuments += applicationService.findAttachments(e.getProfileReferenceId()).size();
            }
        }

        public int getNumDocuments() {
            return numDocuments;
        }

        public LocalDate getMonth() {
            return month;
        }

    }
}
