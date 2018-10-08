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
import gov.medicaid.entities.SearchResult;
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
import java.time.Duration;
import java.time.LocalDate;
import java.util.List;
import java.util.stream.Collectors;

@Controller
public class TimeToReviewReportController extends gov.medicaid.controllers.BaseController {
    private final ProviderApplicationService applicationService;

    public TimeToReviewReportController(ProviderApplicationService applicationService) {
        this.applicationService = applicationService;
    }

    @RequestMapping(value = "/admin/reports/time-to-review", method = RequestMethod.GET)
    public ModelAndView getTimeToReview() {
        ModelAndView mv = new ModelAndView("admin/reports/time_to_review");
        SearchResult<Application> applications = getApplicationsFromDB();
        List<ApplicationMonth> ems = groupApplications(applications.getItems());
        List<Month> months = buildMonths(ems);

        mv.addObject("months", months);
        return mv;
    }

    @RequestMapping(value = "/admin/reports/timetoreview.csv", method = RequestMethod.GET)
    public void getTimeToReviewCsv(HttpServletResponse response) throws PortalServiceException {
        String csvFileName = ReportControllerUtils.buildCsvName("timetoreview");
        response.setContentType("text/csv");
        response.setHeader("Content-Disposition", String.format("attachment; filename=\"%s\"", csvFileName));

        SearchResult<Application> applications = getApplicationsFromDB();
        List<ApplicationMonth> ems = groupApplications(applications.getItems());
        List<Month> months = buildMonths(ems);

        try {
            CSVPrinter csvPrinter = new CSVPrinter(response.getWriter(), CSVFormat.DEFAULT);

            csvPrinter.printRecord(
                "Month",
                "Applications Reviewed",
                "Mean Review Time",
                "Median Review Time"
            );
            for (Month month : months) {
               csvPrinter.printRecord(
                   month.getMonth(),
                   month.getApplications().size(),
                   month.getMean().isZero() ? "N/A" : month.getMeanAsString(),
                   month.getMedian().isZero() ? "N/A" : month.getMedianAsString()
               );
            }
            csvPrinter.close();
        } catch (IOException e) {
          throw new PortalServiceException("Couldn't generate CSV", e);
        }
    }

    private SearchResult<Application> getApplicationsFromDB() {
        ApplicationSearchCriteria criteria = new ApplicationSearchCriteria();
        return applicationService.searchApplications(criteria);
    }

    private List<ApplicationMonth> groupApplications(List<Application> applications) {
        return ReportControllerUtils.groupApplications(
            applications,
            Application::getStatusDate,
            (e, monthStart, monthEnd) -> {
                return !(
                    monthStart.isAfter(ReportControllerUtils.toLocalDate(e.getStatusDate())) ||
                    monthEnd.isBefore(ReportControllerUtils.toLocalDate(e.getStatusDate()))
                );
            });
    }

    private List<Month> buildMonths(List<ApplicationMonth> ems) {
        return ems.stream().map(em -> new Month(em)).collect(Collectors.toList());
    }

    public static class Month {
        private Duration mean;
        private Duration median;
        private LocalDate month;
        private List<Application> applications;

        public Duration getMean() {
            return mean;
        }

        public String getMeanAsString() {
            return durationAsString(mean);
        }

        public Duration getMedian() {
            return median;
        }

        public String getMedianAsString() {
            return durationAsString(median);
        }

        public LocalDate getMonth() {
            return month;
        }

        private String durationAsString(Duration dur) {
            return dur.toDays() + " days, " + (dur.toHours() % 24) + " hours";
        }

        public List<Application> getApplications() {
            return applications;
        }

        public Month(ApplicationMonth em) {
            month = em.getMonth();
            applications = em.getApplications();

            List<Duration> periods = em.getApplications().stream().map(
                e -> Duration.between(
                    ReportControllerUtils.toLocalDateTime(e.getSubmissionDate()),
                    ReportControllerUtils.toLocalDateTime(e.getStatusDate())
                )
            ).collect(Collectors.toList());

            if (periods.size() > 0) {
                Duration totalDuration = Duration.ZERO;
                for (Duration p : periods) {
                    totalDuration = totalDuration.plus(p);
                }

                mean = totalDuration.dividedBy(periods.size());
                median = periods.get(periods.size() / 2);
            } else {
                mean = Duration.ZERO;
                median = Duration.ZERO;
            }
        }
    }
}
