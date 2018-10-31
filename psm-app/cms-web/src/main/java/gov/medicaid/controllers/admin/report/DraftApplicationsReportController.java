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
import java.util.List;

@Controller
public class DraftApplicationsReportController extends gov.medicaid.controllers.BaseController {
    private final ProviderApplicationService applicationService;

    public DraftApplicationsReportController(ProviderApplicationService applicationService) {
        this.applicationService = applicationService;
    }

    @RequestMapping(value = "/admin/reports/draft-applications", method = RequestMethod.GET)
    public ModelAndView getDraftApplications() {
        ModelAndView mv = new ModelAndView("admin/reports/draft_applications");
        List<Application> applications = getApplicationsFromDB();
        List<ApplicationMonth> months = groupApplications(applications);

        mv.addObject("applicationMonths", months);
        return mv;
    }

    @RequestMapping(value = "/admin/reports/draftapplications.csv", method = RequestMethod.GET)
    public void getDraftApplicationsCsv(HttpServletResponse response) throws PortalServiceException {
        String csvFileName = ReportControllerUtils.buildCsvName("draftapplications");
        response.setContentType("text/csv");
        response.setHeader("Content-Disposition", String.format("attachment; filename=\"%s\"", csvFileName));

        List<Application> applications = getApplicationsFromDB();

        List<ApplicationMonth> months = groupApplications(applications);

        try {
            CSVPrinter csvPrinter = new CSVPrinter(response.getWriter(), CSVFormat.DEFAULT);

            csvPrinter.printRecord(
                "Month in Draft",
                "Application ID",
                "NPI",
                "Provider Name",
                "Provider Type",
                "Creation Date",
                "Submission Date"
            );
            for (ApplicationMonth month : months) {
                for (Application application : month.getApplications()) {
                    csvPrinter.printRecord(
                        month.getMonth(),
                        application.getApplicationId(),
                        application.getDetails().getEntity().getNpi(),
                        application.getDetails().getEntity().getName(),
                        application.getDetails().getEntity().getProviderType().getDescription(),
                        application.getCreatedOn(),
                        application.getSubmissionDate()
                    );
                }
            }
            csvPrinter.close();
        } catch (IOException e) {
          throw new PortalServiceException("Couldn't generate CSV", e);
        }
    }

    private List<Application> getApplicationsFromDB() {
        ApplicationSearchCriteria criteria = new ApplicationSearchCriteria();
        criteria.setAscending(true);
        criteria.setSortColumn("created_at");

        List<Application> results = applicationService.getDraftAtEomApplications(criteria).getItems();

        results.stream()
            .forEach(e -> {
                e.setDetails(
                    applicationService.getProviderDetails(e.getProfileReferenceId(), true)
                );
            });
        return results;
    }

    private List<ApplicationMonth> groupApplications(List<Application> applications) {
        return ReportControllerUtils.groupApplications(
            applications,
            Application::getCreatedOn,
            (e, monthStart, monthEnd) -> {
                return
                    monthEnd.plusDays(1).isAfter(ReportControllerUtils.toLocalDate(e.getCreatedOn())) &&
                    (
                        e.getSubmissionDate() == null ||
                        monthEnd.isBefore(ReportControllerUtils.toLocalDate(e.getSubmissionDate()))
                    );
            });
    }
}
