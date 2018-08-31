package gov.medicaid.controllers.admin.report;

import gov.medicaid.controllers.admin.report.ReportControllerUtils.EnrollmentMonth;
import gov.medicaid.entities.Enrollment;
import gov.medicaid.entities.EnrollmentSearchCriteria;
import gov.medicaid.entities.ProviderType;
import gov.medicaid.entities.ProviderTypeSearchCriteria;
import gov.medicaid.services.PortalServiceException;
import gov.medicaid.services.ProviderEnrollmentService;
import gov.medicaid.services.ProviderTypeService;

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
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Controller
public class ProviderTypesReportController extends gov.medicaid.controllers.BaseController {
    private final ProviderEnrollmentService enrollmentService;
    private final ProviderTypeService providerTypeService;

    public ProviderTypesReportController(
        ProviderEnrollmentService enrollmentService,
        ProviderTypeService providerTypeService
    ) {
        this.enrollmentService = enrollmentService;
        this.providerTypeService = providerTypeService;
    }

    @RequestMapping(value = "/admin/reports/provider-types", method = RequestMethod.GET)
    public ModelAndView getProviderTypes(
        @RequestParam(value = "providerType", required = false) List<String> providerTypeCodes
    ) throws PortalServiceException {
        ModelAndView mv = new ModelAndView("admin/reports/provider_types");

        ProviderTypeSearchCriteria criteria = new ProviderTypeSearchCriteria();
        criteria.setPageNumber(1);
        criteria.setPageSize(0);
        criteria.setSortColumn("description");
        criteria.setAscending(true);
        List<ProviderType> providerTypes = providerTypeService.search(criteria).getItems();

        List<Enrollment> enrollments = getEnrollmentsFromDB(providerTypeCodes);
        List<EnrollmentMonth> ems = groupEnrollments(enrollments);
        List<Month> months = buildMonths(ems);

        mv.addObject("providerTypes", providerTypes);
        mv.addObject("months", months);
        mv.addObject("enteredProviderTypeCodes", providerTypeCodes == null ? new ArrayList<String>() : providerTypeCodes);
        if (providerTypeCodes != null) {
           mv.addObject("providerTypeCodesQueryString",
               providerTypeCodes.stream()
                   .map(code -> "providerType=" + code)
                   .collect(Collectors.joining("&")));
        }
        return mv;
    }

    @RequestMapping(value = "/admin/reports/providertypes.csv", method = RequestMethod.GET)
    public void getProviderTypesCsv(
        @RequestParam(value = "providerType", required = false) List<String> providerTypeCodes,
        HttpServletResponse response
    ) throws PortalServiceException {
        String csvFileName = ReportControllerUtils.buildCsvName("providertypes");
        response.setContentType("text/csv");
        response.setHeader("Content-Disposition", String.format("attachment; filename=\"%s\"", csvFileName));

        List<Enrollment> enrollments = getEnrollmentsFromDB(providerTypeCodes);
        List<EnrollmentMonth> ems = groupEnrollments(enrollments);
        List<Month> months = buildMonths(ems);

        try {
            CSVPrinter csvPrinter = new CSVPrinter(response.getWriter(), CSVFormat.DEFAULT);

            csvPrinter.printRecord("Month Reviewed", "Provider Type", "Applications Reviewed");

            for (Month month : months) {
                for (ProviderType providerType : month.getProviderTypes()) {
                    csvPrinter.printRecord(
                        month.getMonth(),
                        providerType.getDescription(),
                        month.getEnrollments(providerType).size()
                    );
                }
            }

            csvPrinter.close();
        } catch (IOException e) {
            throw new PortalServiceException("Couldn't generate CSV", e);
        }
    }

    private List<Enrollment> getEnrollmentsFromDB(
        List<String> providerTypeCodes
    ) {
        EnrollmentSearchCriteria criteria = new EnrollmentSearchCriteria();
        criteria.setProviderTypes(providerTypeCodes);
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

    private List<Month> buildMonths(List<EnrollmentMonth> ems) {
        List<Month> months = new ArrayList<>();

        for (EnrollmentMonth em : ems) {
            months.add(new Month(em, enrollmentService));
        }

        return months;
    }

    public static class Month {
        Map<ProviderType, List<Enrollment>> typeEnrollments;
        LocalDate month;

        public Month(EnrollmentMonth em, ProviderEnrollmentService enrollmentService) {
            typeEnrollments = new HashMap<>();
            month = em.getMonth();

            for (Enrollment e : em.getEnrollments()) {
                ProviderType providerType =
                    enrollmentService.findEntityByProviderKey(null, e.getTicketId()).getProviderType();

                if (providerType != null) {
                    if (!typeEnrollments.containsKey(providerType)) {
                        typeEnrollments.put(providerType, new ArrayList<>());
                    }
                    typeEnrollments.get(providerType).add(e);
                }
            }
        }

        public List<ProviderType> getProviderTypes() {
            return typeEnrollments.keySet().stream()
                .sorted((pt1, pt2) -> pt1.getDescription().compareTo(pt2.getDescription()))
                .collect(Collectors.toList());
        }

        public List<Enrollment> getEnrollments(ProviderType tp) {
            return typeEnrollments.get(tp);
        }

        public boolean containsEnrollments(ProviderType tp) {
            return typeEnrollments.containsKey(tp);
        }

        public LocalDate getMonth() {
            return month;
        }
    }
}
