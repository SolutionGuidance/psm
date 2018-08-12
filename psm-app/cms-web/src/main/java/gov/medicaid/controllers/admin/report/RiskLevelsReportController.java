package gov.medicaid.controllers.admin.report;

import com.google.common.collect.ImmutableList;
import gov.medicaid.controllers.admin.report.ReportControllerUtils.EnrollmentMonth;
import gov.medicaid.entities.Enrollment;
import gov.medicaid.entities.EnrollmentSearchCriteria;
import gov.medicaid.entities.ProviderProfile;
import gov.medicaid.entities.RiskLevel;
import gov.medicaid.entities.dto.ViewStatics;
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
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.function.Function;
import java.util.stream.Collectors;

@Controller
public class RiskLevelsReportController extends gov.medicaid.controllers.BaseController {
    private static final List<String> RISK_LEVELS = ImmutableList.of(
        ViewStatics.LIMITED_RISK,
        ViewStatics.MODERATE_RISK,
        ViewStatics.HIGH_RISK
    );

    private final ProviderEnrollmentService enrollmentService;

    public RiskLevelsReportController(ProviderEnrollmentService enrollmentService) {
        this.enrollmentService = enrollmentService;
    }

    @RequestMapping(value = "/admin/reports/risk-levels", method = RequestMethod.GET)
    public ModelAndView getRiskLevels() {
        ModelAndView mv = new ModelAndView("admin/reports/risk_levels");

        List<Enrollment> enrollments = getEnrollmentsFromDB();
        List<EnrollmentMonth> ems = groupEnrollments(enrollments);
        mv.addObject("riskLevels", RISK_LEVELS);
        mv.addObject(
            "months",
            ems.stream()
                .map(e -> new RiskLevelsMonth(e, enrollmentService))
                .collect(Collectors.toList()));

        return mv;
    }

    @RequestMapping(value = "/admin/reports/risklevels.csv", method = RequestMethod.GET)
    public void getRiskLevelsCsv(HttpServletResponse response) throws PortalServiceException {
        String csvFileName = ReportControllerUtils.buildCsvName("risklevels");
        response.setContentType("text/csv");
        response.setHeader("Content-Disposition", String.format("attachment; filename=\"%s\"", csvFileName));

        List<Enrollment> enrollments = getEnrollmentsFromDB();
        List<EnrollmentMonth> ems = groupEnrollments(enrollments);
        List<RiskLevelsMonth> rlms =
            ems.stream()
            .map(e -> new RiskLevelsMonth(e, enrollmentService))
            .collect(Collectors.toList());

        try {
            CSVPrinter csvPrinter = new CSVPrinter(response.getWriter(), CSVFormat.DEFAULT);
            List<String> header = new ArrayList<>();
            header.add("Month");
            header.addAll(RISK_LEVELS);
            csvPrinter.printRecord(header);

            for (RiskLevelsMonth rlm : rlms) {
                List<String> row = new ArrayList<>();
                row.add(rlm.getMonth().toString());
                row.addAll(
                    RISK_LEVELS.stream()
                    .map(rl -> "" + rlm.getNum(rl))
                    .collect(Collectors.toList()));
                csvPrinter.printRecord(row);
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

    public static class RiskLevelsMonth {
        private Map<String, Long> numByRiskLevel;
        private LocalDate month;

        public RiskLevelsMonth(EnrollmentMonth em, ProviderEnrollmentService enrollmentService2) {
            numByRiskLevel = RISK_LEVELS.stream().collect(Collectors.toMap(
                Function.identity(),
                x -> 0L
            ));
            month = em.getMonth();

            numByRiskLevel.putAll(em.getEnrollments().stream()
                .map(Enrollment::getTicketId)
                .map(id -> enrollmentService2.getProviderDetailsByTicket(id, false))
                .map(ProviderProfile::getRiskLevel)
                .filter(Objects::nonNull)
                .map(RiskLevel::getDescription)
                .collect(Collectors.groupingBy(
                    Function.identity(),
                    Collectors.counting()
                ))
            );
        }

        public long getNum(String riskLevel) {
            return numByRiskLevel.get(riskLevel);
        }

        public LocalDate getMonth() {
            return month;
        }
    }
}
