package gov.medicaid.controllers.admin.report;

import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.PostConstruct;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.csv.CSVFormat;
import org.apache.commons.csv.CSVPrinter;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import gov.medicaid.entities.Enrollment;
import gov.medicaid.entities.EnrollmentSearchCriteria;
import gov.medicaid.entities.SearchResult;
import gov.medicaid.services.PortalServiceConfigurationException;
import gov.medicaid.services.PortalServiceException;
import gov.medicaid.services.ProviderEnrollmentService;

@Controller
public class ApplicationsInDraftReportController extends gov.medicaid.controllers.BaseController {
    private ProviderEnrollmentService enrollmentService;

    public void setEnrollmentService(ProviderEnrollmentService enrollmentService) {
        this.enrollmentService = enrollmentService;
    }

    @PostConstruct
    protected void init() {
        super.init();
        if (enrollmentService == null) {
            throw new PortalServiceConfigurationException("enrollmentService is not configured correctly.");
        }
    }

    @RequestMapping(value = "/admin/reports/applications-in-draft", method = RequestMethod.GET)
    public ModelAndView getEnrollments() throws PortalServiceException {
        ModelAndView mv = new ModelAndView("admin/reports/applications_in_draft_page");
        SearchResult<Enrollment> enrollments = getEnrollmentsFromDB();
        List<EnrollmentMonth> months = groupEnrollments(enrollments.getItems());

        mv.addObject("enrollmentMonths", months);
        return mv;
    }

    @RequestMapping(value = "/admin/reports/draftapplications.csv", method = RequestMethod.GET)
    public void getEnrollments(HttpServletResponse response) throws PortalServiceException {
        String csvFileName = "draftapplications" +
            LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMdd-hhmm")) +
            ".csv";
        response.setContentType("text/csv");
        response.setHeader("Content-Disposition", String.format("attachment; filename=\"%s\"", csvFileName));

        SearchResult<Enrollment> enrollments = getEnrollmentsFromDB();

        List<EnrollmentMonth> months = groupEnrollments(enrollments.getItems());

        try {
            CSVPrinter csvPrinter = new CSVPrinter(response.getWriter(), CSVFormat.DEFAULT);

            csvPrinter.printRecord(
                "Month with Draft",
                "Application ID",
                "Creation Date",
                "Submission Date"
            );
            for (EnrollmentMonth month : months) {
                for (Enrollment enrollment : month.getEnrollments()) {
                    csvPrinter.printRecord(
                        month.getMonth(),
                        enrollment.getTicketId(),
                        enrollment.getCreatedOn(),
                        enrollment.getSubmissionDate()
                        );
                }
            }
            csvPrinter.close();
        } catch (IOException e) {
          throw new PortalServiceException("Couldn't generate CSV", e);
        }
    }

    private SearchResult<Enrollment> getEnrollmentsFromDB() throws PortalServiceException {
        EnrollmentSearchCriteria criteria = new EnrollmentSearchCriteria();
        criteria.setAscending(true);
        criteria.setSortColumn("created_at");
        return enrollmentService.getDraftAtEomEnrollments(criteria);
    }

    private List<EnrollmentMonth> groupEnrollments(List<Enrollment> enrollments) {
        List<EnrollmentMonth> enrollmentMonths = new ArrayList<>();

        if (enrollments.size() > 0) {
            LocalDate firstMonth = toLocalDate(enrollments.get(0).getCreatedOn()).withDayOfMonth(1);
            LocalDate thisMonth = LocalDate.now().withDayOfMonth(1);

            LocalDate workingMonth = thisMonth;
            while (workingMonth.isAfter(firstMonth)) {
                EnrollmentMonth em = new EnrollmentMonth(workingMonth);
                enrollmentMonths.add(em);

                for (Enrollment enrollment : enrollments) {
                    em.addEnrollment(enrollment);
                }

                workingMonth = workingMonth.minusMonths(1);
            }
        }
        return enrollmentMonths;
    }

    /**
     * Helper class for arranging the Enrollments into months.
     */
    public static class EnrollmentMonth {
        private LocalDate month;
        List<Enrollment> enrollments;

        public EnrollmentMonth(LocalDate month) {
            this.month = month;
            enrollments = new ArrayList<>();
        }

        public void addEnrollment(Enrollment enrollment) {
            LocalDate nextMonth = month.plusMonths(1);

            if (
                nextMonth.isAfter(toLocalDate(enrollment.getCreatedOn())) &&
                (
                    enrollment.getSubmissionDate() == null ||
                    nextMonth.minusDays(1).isBefore(toLocalDate(enrollment.getSubmissionDate()))
                )
            ) {
                enrollments.add(enrollment);
            }
        }

        public LocalDate getMonth() {
            return month;
        }

        public List<Enrollment> getEnrollments() {
            return enrollments;
        }
    }

    private static LocalDate toLocalDate(Date d) {
        return LocalDateTime.ofInstant(d.toInstant(), ZoneId.systemDefault()).toLocalDate();
    }
}
