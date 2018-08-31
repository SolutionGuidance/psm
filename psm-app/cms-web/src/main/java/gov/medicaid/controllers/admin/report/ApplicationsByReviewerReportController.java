package gov.medicaid.controllers.admin.report;

import gov.medicaid.entities.Enrollment;
import gov.medicaid.entities.EnrollmentSearchCriteria;
import gov.medicaid.services.PortalServiceException;
import gov.medicaid.services.ProviderEnrollmentService;

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
    private final ProviderEnrollmentService enrollmentService;

    public ApplicationsByReviewerReportController(ProviderEnrollmentService enrollmentService) {
        this.enrollmentService = enrollmentService;
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

        mv.addObject("enrollments", getEnrollmentsFromDB(startDate, endDate));
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

        List<Enrollment> enrollments = getEnrollmentsFromDB(startDate, endDate);

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
            for (Enrollment enrollment : enrollments) {
                csvPrinter.printRecord(
                    enrollment.getTicketId(),
                    enrollment.getDetails().getEntity().getName(),
                    enrollment.getDetails().getEntity().getProviderType().getDescription(),
                    enrollment.getCreatedOn(),
                    enrollment.getLastUpdatedBy().getUsername(),
                    enrollment.getStatusDate(),
                    enrollment.getStatus().getDescription()
                );
            }
            csvPrinter.close();
        } catch (IOException e) {
          throw new PortalServiceException("Couldn't generate CSV", e);
        }
    }

    private List<Enrollment> getEnrollmentsFromDB(
        Date startDate,
        Date endDate
    ) {
        EnrollmentSearchCriteria criteria = new EnrollmentSearchCriteria();
        criteria.setCreateDateStart(startDate);
        criteria.setCreateDateEnd(endDate);
        criteria.setAscending(true);
        criteria.setSortColumn("created_at");

        List<Enrollment> results = enrollmentService.searchEnrollments(criteria).getItems();

        results.stream()
            .forEach(e -> {
                e.setDetails(
                    enrollmentService.getProviderDetailsByTicket(e.getTicketId(), true)
                );
            });

        return results;
    }
}
