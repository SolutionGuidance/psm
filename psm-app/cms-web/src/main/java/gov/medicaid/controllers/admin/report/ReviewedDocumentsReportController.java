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
import java.time.LocalDate;
import java.util.List;
import java.util.stream.Collectors;

@Controller
public class ReviewedDocumentsReportController extends gov.medicaid.controllers.BaseController {
    private final ProviderEnrollmentService enrollmentService;

    public ReviewedDocumentsReportController(ProviderEnrollmentService enrollmentService) {
        this.enrollmentService = enrollmentService;
    }

    @RequestMapping(value = "/admin/reports/reviewed-documents", method = RequestMethod.GET)
    public ModelAndView getReviewedDocuments() {
        ModelAndView mv = new ModelAndView("admin/reports/reviewed_documents");

        List<Enrollment> enrollments = getEnrollmentsFromDB();
        List<EnrollmentMonth> ems = groupEnrollments(enrollments);
        mv.addObject("months", ems.stream().map(e -> new DocumentsMonth(e, enrollmentService)).collect(Collectors.toList()));

        return mv;
    }

    @RequestMapping(value = "/admin/reports/revieweddocuments.csv", method = RequestMethod.GET)
    public void getReviewedDocumentsCsv(HttpServletResponse response) throws PortalServiceException {
        String csvFileName = ReportControllerUtils.buildCsvName("revieweddocuments");
        response.setContentType("text/csv");
        response.setHeader("Content-Disposition", String.format("attachment; filename=\"%s\"", csvFileName));

        List<Enrollment> enrollments = getEnrollmentsFromDB();
        List<EnrollmentMonth> ems = groupEnrollments(enrollments);
        List<DocumentsMonth> dms = ems.stream().map(e -> new DocumentsMonth(e, enrollmentService)).collect(Collectors.toList());

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

    private List<Enrollment> getEnrollmentsFromDB() {
        EnrollmentSearchCriteria criteria = new EnrollmentSearchCriteria();
        criteria.setAscending(true);
        criteria.setSortColumn("created_at");
        return enrollmentService.searchEnrollments(criteria).getItems();
    }

    private List<EnrollmentMonth> groupEnrollments(List<Enrollment> enrollments) {
        return ReportControllerUtils.groupEnrollments(
            enrollments,
            Enrollment::getStatusDate,
            (e, monthStart, monthEnd) -> {
                LocalDate statusDate = ReportControllerUtils.toLocalDate(e.getStatusDate());
                return !(monthStart.isAfter(statusDate) || monthEnd.isBefore(statusDate));
            });
    }

    public static class DocumentsMonth {
        private int numDocuments;
        private LocalDate month;

        public DocumentsMonth(EnrollmentMonth em, ProviderEnrollmentService enrollmentService) {
            numDocuments = 0;
            month = em.getMonth();

            for (Enrollment e : em.getEnrollments()) {
                numDocuments += enrollmentService.findAttachments(e.getProfileReferenceId()).size();
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
