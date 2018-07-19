package gov.medicaid.controllers.admin.report;

import gov.medicaid.controllers.admin.report.ReportControllerUtils.EnrollmentMonth;
import gov.medicaid.entities.Enrollment;
import gov.medicaid.entities.EnrollmentSearchCriteria;
import gov.medicaid.entities.SearchResult;
import gov.medicaid.services.PortalServiceException;
import gov.medicaid.services.ProviderEnrollmentService;

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
    private final ProviderEnrollmentService enrollmentService;

    public TimeToReviewReportController(ProviderEnrollmentService enrollmentService) {
        this.enrollmentService = enrollmentService;
    }

    @RequestMapping(value = "/admin/reports/time-to-review", method = RequestMethod.GET)
    public ModelAndView getTimeToReview() {
        ModelAndView mv = new ModelAndView("admin/reports/time_to_review");
        SearchResult<Enrollment> enrollments = getEnrollmentsFromDB();
        List<EnrollmentMonth> ems = groupEnrollments(enrollments.getItems());
        List<Month> months = buildMonths(ems);

        mv.addObject("months", months);
        return mv;
    }

    @RequestMapping(value = "/admin/reports/timetoreview.csv", method = RequestMethod.GET)
    public void getTimeToReviewCsv(HttpServletResponse response) throws PortalServiceException {
        String csvFileName = ReportControllerUtils.buildCsvName("timetoreview");
        response.setContentType("text/csv");
        response.setHeader("Content-Disposition", String.format("attachment; filename=\"%s\"", csvFileName));

        SearchResult<Enrollment> enrollments = getEnrollmentsFromDB();
        List<EnrollmentMonth> ems = groupEnrollments(enrollments.getItems());
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
                   month.getEnrollments().size(),
                   month.getMean().isZero() ? "N/A" : month.getMeanAsString(),
                   month.getMedian().isZero() ? "N/A" : month.getMedianAsString()
               );
            }
            csvPrinter.close();
        } catch (IOException e) {
          throw new PortalServiceException("Couldn't generate CSV", e);
        }
    }

    private SearchResult<Enrollment> getEnrollmentsFromDB() {
        EnrollmentSearchCriteria criteria = new EnrollmentSearchCriteria();
        return enrollmentService.searchEnrollments(criteria);
    }

    private List<EnrollmentMonth> groupEnrollments(List<Enrollment> enrollments) {
        return ReportControllerUtils.groupEnrollments(
            enrollments,
            Enrollment::getStatusDate,
            (e, monthStart, monthEnd) -> {
                return !(
                    monthStart.isAfter(ReportControllerUtils.toLocalDate(e.getStatusDate())) ||
                    monthEnd.isBefore(ReportControllerUtils.toLocalDate(e.getStatusDate()))
                );
            });
    }

    private List<Month> buildMonths(List<EnrollmentMonth> ems) {
        return ems.stream().map(em -> new Month(em)).collect(Collectors.toList());
    }

    public static class Month {
        private Duration mean;
        private Duration median;
        private LocalDate month;
        private List<Enrollment> enrollments;

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

        public List<Enrollment> getEnrollments() {
            return enrollments;
        }

        public Month(EnrollmentMonth em) {
            month = em.getMonth();
            enrollments = em.getEnrollments();

            List<Duration> periods = em.getEnrollments().stream().map(
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
