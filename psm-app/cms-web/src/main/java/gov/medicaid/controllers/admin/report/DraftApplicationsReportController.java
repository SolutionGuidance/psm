package gov.medicaid.controllers.admin.report;

import gov.medicaid.controllers.admin.report.ReportControllerUtils.EnrollmentMonth;
import gov.medicaid.entities.Enrollment;
import gov.medicaid.entities.EnrollmentSearchCriteria;
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
import java.util.List;

@Controller
public class DraftApplicationsReportController extends gov.medicaid.controllers.BaseController {
    private final ProviderEnrollmentService enrollmentService;

    public DraftApplicationsReportController(ProviderEnrollmentService enrollmentService) {
        this.enrollmentService = enrollmentService;
    }

    @RequestMapping(value = "/admin/reports/draft-applications", method = RequestMethod.GET)
    public ModelAndView getDraftApplications() {
        ModelAndView mv = new ModelAndView("admin/reports/draft_applications");
        List<Enrollment> enrollments = getEnrollmentsFromDB();
        List<EnrollmentMonth> months = groupEnrollments(enrollments);

        mv.addObject("enrollmentMonths", months);
        return mv;
    }

    @RequestMapping(value = "/admin/reports/draftapplications.csv", method = RequestMethod.GET)
    public void getDraftApplicationsCsv(HttpServletResponse response) throws PortalServiceException {
        String csvFileName = ReportControllerUtils.buildCsvName("draftapplications");
        response.setContentType("text/csv");
        response.setHeader("Content-Disposition", String.format("attachment; filename=\"%s\"", csvFileName));

        List<Enrollment> enrollments = getEnrollmentsFromDB();

        List<EnrollmentMonth> months = groupEnrollments(enrollments);

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
            for (EnrollmentMonth month : months) {
                for (Enrollment enrollment : month.getEnrollments()) {
                    csvPrinter.printRecord(
                        month.getMonth(),
                        enrollment.getTicketId(),
                        enrollment.getDetails().getEntity().getNpi(),
                        enrollment.getDetails().getEntity().getName(),
                        enrollment.getDetails().getEntity().getProviderType().getDescription(),
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

    private List<Enrollment> getEnrollmentsFromDB() {
        EnrollmentSearchCriteria criteria = new EnrollmentSearchCriteria();
        criteria.setAscending(true);
        criteria.setSortColumn("created_at");

        List<Enrollment> results = enrollmentService.getDraftAtEomEnrollments(criteria).getItems();

        results.stream()
            .forEach(e -> {
                e.setDetails(
                    enrollmentService.getProviderDetailsByTicket(e.getTicketId(), true)
                );
            });
        return results;
    }

    private List<EnrollmentMonth> groupEnrollments(List<Enrollment> enrollments) {
        return ReportControllerUtils.groupEnrollments(
            enrollments,
            Enrollment::getCreatedOn,
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
