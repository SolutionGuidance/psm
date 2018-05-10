package gov.medicaid.controllers.admin.report;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.annotation.PostConstruct;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.csv.CSVFormat;
import org.apache.commons.csv.CSVPrinter;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import gov.medicaid.entities.Enrollment;
import gov.medicaid.entities.EnrollmentSearchCriteria;
import gov.medicaid.entities.SearchResult;
import gov.medicaid.services.PortalServiceConfigurationException;
import gov.medicaid.services.PortalServiceException;
import gov.medicaid.services.ProviderEnrollmentService;

@Controller
public class ApplicationsApprovedReportController extends gov.medicaid.controllers.BaseController {

    private ProviderEnrollmentService enrollmentService;
    private SimpleDateFormat csvDf = new SimpleDateFormat("yyyyMMdd-hhmm");

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

    @RequestMapping(value = "/admin/reports/enrollmentapproval.csv", method = RequestMethod.GET)
    public void getEnrollments(
        @RequestParam(value = "startDate", required = false) Date startDate,
        @RequestParam(value = "endDate", required = false) Date endDate,
        HttpServletResponse response
    ) throws PortalServiceException {
        String csvFileName = "applicationreviewers_" + csvDf.format(new Date()) + ".csv";
        response.setContentType("text/csv");
        response.setHeader("Content-Disposition", String.format("attachment; filename=\"%s\"", csvFileName));

        EnrollmentSearchCriteria criteria = new EnrollmentSearchCriteria();
        criteria.setCreateDateStart(startDate);
        criteria.setCreateDateEnd(endDate);
        criteria.setAscending(true);
        criteria.setSortColumn("created_at");
        SearchResult<Enrollment> result = enrollmentService.searchEnrollments(criteria);

        try {
            CSVPrinter csvPrinter = new CSVPrinter(response.getWriter(), CSVFormat.DEFAULT);

            csvPrinter.printRecord(
                "Application ID",
                "Submission Date",
                "Reviewed By",
                "Review Date",
                "Status");
            for (Enrollment enrollment : result.getItems()) {
                csvPrinter.printRecord(
                    enrollment.getTicketId(),
                    enrollment.getCreatedOn(),
                    enrollment.getLastUpdatedBy(),
                    enrollment.getStatusDate(),
                    enrollment.getStatus().getDescription()
                    );
            }
            csvPrinter.close();
        } catch (IOException e) {
          throw new PortalServiceException("Couldn't generate CSV", e);
        }
    }
}
