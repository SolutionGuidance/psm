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
import gov.medicaid.entities.ProviderType;
import gov.medicaid.entities.ProviderTypeSearchCriteria;
import gov.medicaid.services.PortalServiceException;
import gov.medicaid.services.ProviderApplicationService;
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
    private final ProviderApplicationService applicationService;
    private final ProviderTypeService providerTypeService;

    public ProviderTypesReportController(
        ProviderApplicationService applicationService,
        ProviderTypeService providerTypeService
    ) {
        this.applicationService = applicationService;
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

        List<Application> applications = getApplicationsFromDB(providerTypeCodes);
        List<ApplicationMonth> ems = groupApplications(applications);
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

        List<Application> applications = getApplicationsFromDB(providerTypeCodes);
        List<ApplicationMonth> ems = groupApplications(applications);
        List<Month> months = buildMonths(ems);

        try {
            CSVPrinter csvPrinter = new CSVPrinter(response.getWriter(), CSVFormat.DEFAULT);

            csvPrinter.printRecord("Month Reviewed", "Provider Type", "Applications Reviewed");

            for (Month month : months) {
                for (ProviderType providerType : month.getProviderTypes()) {
                    csvPrinter.printRecord(
                        month.getMonth(),
                        providerType.getDescription(),
                        month.getApplications(providerType).size()
                    );
                }
            }

            csvPrinter.close();
        } catch (IOException e) {
            throw new PortalServiceException("Couldn't generate CSV", e);
        }
    }

    private List<Application> getApplicationsFromDB(
        List<String> providerTypeCodes
    ) {
        ApplicationSearchCriteria criteria = new ApplicationSearchCriteria();
        criteria.setProviderTypes(providerTypeCodes);
        return applicationService.searchApplications(criteria).getItems();
    }

    private List<ApplicationMonth> groupApplications(List<Application> applications) {
        return ReportControllerUtils.groupApplications(
            applications,
            Application::getStatusDate,
            (e, monthStart, monthEnd) -> {
                LocalDate statusDate = ReportControllerUtils.toLocalDate(e.getStatusDate());
                return !(monthStart.isAfter(statusDate) || monthEnd.isBefore(statusDate));
            });
    }

    private List<Month> buildMonths(List<ApplicationMonth> ems) {
        List<Month> months = new ArrayList<>();

        for (ApplicationMonth em : ems) {
            months.add(new Month(em, applicationService));
        }

        return months;
    }

    public static class Month {
        Map<ProviderType, List<Application>> typeApplications;
        LocalDate month;

        public Month(ApplicationMonth em, ProviderApplicationService applicationService) {
            typeApplications = new HashMap<>();
            month = em.getMonth();

            for (Application e : em.getApplications()) {
                ProviderType providerType =
                    applicationService.findEntityByProviderKey(e.getProfileReferenceId()).getProviderType();

                if (providerType != null) {
                    if (!typeApplications.containsKey(providerType)) {
                        typeApplications.put(providerType, new ArrayList<>());
                    }
                    typeApplications.get(providerType).add(e);
                }
            }
        }

        public List<ProviderType> getProviderTypes() {
            return typeApplications.keySet().stream()
                .sorted((pt1, pt2) -> pt1.getDescription().compareTo(pt2.getDescription()))
                .collect(Collectors.toList());
        }

        public List<Application> getApplications(ProviderType tp) {
            return typeApplications.get(tp);
        }

        public boolean containsApplications(ProviderType tp) {
            return typeApplications.containsKey(tp);
        }

        public LocalDate getMonth() {
            return month;
        }
    }
}
