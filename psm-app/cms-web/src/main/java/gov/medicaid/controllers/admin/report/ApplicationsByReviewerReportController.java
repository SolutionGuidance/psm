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

import gov.medicaid.entities.Application;
import gov.medicaid.entities.ApplicationSearchCriteria;
import gov.medicaid.services.PortalServiceException;
import gov.medicaid.services.ProviderApplicationService;

import org.apache.commons.csv.CSVFormat;
import org.apache.commons.csv.CSVPrinter;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.time.LocalDate;
import java.time.ZoneId;
import java.util.Date;
import java.util.List;

@Controller
public class ApplicationsByReviewerReportController extends gov.medicaid.controllers.BaseController {
    private final ProviderApplicationService applicationService;

    public ApplicationsByReviewerReportController(ProviderApplicationService applicationService) {
        this.applicationService = applicationService;
    }

    @RequestMapping(value = "/admin/reports/applications-by-reviewer", method = RequestMethod.GET)
    public ModelAndView getApplicationsByReviewer(
        @RequestParam(value = "startDate", required = false) String startDateSubmitted,
        @RequestParam(value = "startDate", required = false) Date inputStartDate,
        @RequestParam(value = "endDate", required = false) Date inputEndDate
    ) {
        ModelAndView mv = new ModelAndView("admin/reports/applications_by_reviewer");

        Date startDate = startDateSubmitted != null
          ? inputStartDate
          : Date.from(LocalDate.now().withDayOfMonth(1).atStartOfDay(ZoneId.systemDefault()).toInstant());
        Date endDate = startDateSubmitted != null
          ? inputEndDate
          : Date.from(LocalDate.now().plusMonths(1).withDayOfMonth(1).minusDays(1)
              .atStartOfDay(ZoneId.systemDefault()).toInstant());

        mv.addObject("startDate", startDate);
        mv.addObject("endDate", endDate);

        mv.addObject("applications", getApplicationsFromDB(startDate, endDate));
        return mv;
    }

    @RequestMapping(value = "/admin/reports/applicationreviewers.csv", method = RequestMethod.GET)
    public void getApplicationsByReviewerCsv(
        @RequestParam(value = "startDate", required = false) Date startDate,
        @RequestParam(value = "endDate", required = false) Date endDate,
        HttpServletResponse response
    ) throws PortalServiceException {
        String csvFileName = ReportControllerUtils.buildCsvName("applicationreviewers");
        response.setContentType("text/csv");
        response.setHeader("Content-Disposition", String.format("attachment; filename=\"%s\"", csvFileName));

        List<Application> applications = getApplicationsFromDB(startDate, endDate);

        try {
            CSVPrinter csvPrinter = new CSVPrinter(response.getWriter(), CSVFormat.DEFAULT);

            csvPrinter.printRecord(
                "Application ID",
                "Provider Name",
                "Provider Type",
                "Submission Date",
                "Reviewed By",
                "Review Date",
                "Status");
            for (Application application : applications) {
                csvPrinter.printRecord(
                    application.getApplicationId(),
                    application.getDetails().getEntity().getName(),
                    application.getDetails().getEntity().getProviderType().getDescription(),
                    application.getCreatedOn(),
                    application.getLastUpdatedBy().getUsername(),
                    application.getStatusDate(),
                    application.getStatus().getDescription()
                );
            }
            csvPrinter.close();
        } catch (IOException e) {
          throw new PortalServiceException("Couldn't generate CSV", e);
        }
    }

    private List<Application> getApplicationsFromDB(
        Date startDate,
        Date endDate
    ) {
        ApplicationSearchCriteria criteria = new ApplicationSearchCriteria();
        criteria.setCreateDateStart(startDate);
        criteria.setCreateDateEnd(endDate);
        criteria.setAscending(true);
        criteria.setSortColumn("t.createdOn");

        List<Application> results = applicationService.searchApplications(criteria).getItems();

        results.stream()
            .forEach(e -> {
                e.setDetails(
                    applicationService.getProviderDetails(e.getProfileReferenceId(), true)
                );
            });

        return results;
    }
}
