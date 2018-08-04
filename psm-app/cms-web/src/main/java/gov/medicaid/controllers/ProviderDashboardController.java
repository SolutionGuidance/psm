/*
 * Copyright 2012-2013 TopCoder, Inc.
 *
 * This code was developed under U.S. government contract NNH10CD71C.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * You may not use this file except in compliance with the License.
 * You may obtain a copy of the License at:
 *     http://www.apache.org/licenses/LICENSE-2.0
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package gov.medicaid.controllers;

import gov.medicaid.entities.CMSUser;
import gov.medicaid.entities.ProviderSearchCriteria;
import gov.medicaid.entities.SearchResult;
import gov.medicaid.entities.SystemId;
import gov.medicaid.entities.UserRequest;
import gov.medicaid.entities.dto.ViewStatics;
import gov.medicaid.security.CMSPrincipal;
import gov.medicaid.services.ExportService;
import gov.medicaid.services.PortalServiceException;
import gov.medicaid.services.ProviderEnrollmentService;
import gov.medicaid.services.util.Util;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Arrays;
import java.util.Collection;
import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

/**
 * Handles dashboard functions.
 *
 * @endpoint "/provider/dashboard/*"
 */
@Controller
@RequestMapping("/provider/dashboard/*")
public class ProviderDashboardController extends BaseController {

    /**
     * Default display size.
     */
    private static final int DEFAULT_PAGE_SIZE = 10;

    private final ProviderEnrollmentService enrollmentService;
    private final ExportService exportService;

    public ProviderDashboardController(
        ProviderEnrollmentService enrollmentService,
        ExportService exportService
    ) {
        this.enrollmentService = enrollmentService;
        this.exportService = exportService;
    }

    /**
     * Opens the dashboard.
     *
     * @return the dashboard page and the needed models
     * @endpoint "/provider/dashboard/"
     * @verb GET
     */
    @RequestMapping(value = "/", method = RequestMethod.GET)
    public ModelAndView viewDashboard() {
        if (isOperations()) {
            return new ModelAndView("redirect:/landing");
        }

        CMSPrincipal principal = ControllerHelper.getPrincipal();
        // check if this user has any activities recorded
        ProviderSearchCriteria criteria = new ProviderSearchCriteria();
        criteria.setPageNumber(1);
        criteria.setPageSize(1);

        SearchResult<UserRequest> tickets = enrollmentService.searchTickets(principal.getUser(), criteria);
        if (tickets.getTotal() > 0) {
            return viewTicketList();
        }

        return viewAccountSetup();
    }

    /**
     * Is operations user.
     *
     * @return true if the user is an admin
     */
    private boolean isOperations() {
        final Collection<String> operationsRoles = Arrays.asList(
                ViewStatics.ROLE_SERVICE_ADMINISTRATOR,
                ViewStatics.ROLE_SYSTEM_ADMINISTRATOR
        );
        CMSUser user = ControllerHelper.getCurrentUser();
        String role = user.getRole().getDescription();
        return operationsRoles.contains(role);
    }

    /**
     * Shows the account setup page.
     *
     * @return the account setup page (varies depending on user type)
     * @endpoint "/provider/dashboard/setup"
     * @verb GET
     */
    @RequestMapping(value = "/setup", method = RequestMethod.GET)
    private ModelAndView viewAccountSetup() {
        CMSPrincipal principal = ControllerHelper.getPrincipal();
        if (principal.getAuthenticatedBySystem() != SystemId.CMS_ONLINE) {
            return new ModelAndView("provider/dashboard/external_home");
        } else {
            return new ModelAndView("provider/dashboard/internal_home");
        }
    }

    /**
     * Shows the default dashboard page.
     *
     * @return the dashboard page
     * @endpoint "/provider/dashboard/list"
     * @verb GET
     */
    @RequestMapping(value = "/list", method = RequestMethod.GET)
    public ModelAndView viewTicketList() {
        return filterTicketList(createDefaultFilter());
    }

    /**
     * Shows the drafts page.
     *
     * @return the drafts page
     * @endpoint "/provider/dashboard/drafts"
     * @verb GET
     */
    @RequestMapping(value = "/drafts", method = RequestMethod.GET)
    public ModelAndView viewDrafts() {
        if (isOperations()) {
            return new ModelAndView("redirect:/agent/enrollment/list/draft?statuses=Draft&showFilterPanel=true");
        }
        return filterTicketsByStatus(ViewStatics.DRAFT_STATUS, createDefaultFilter());
    }

    /**
     * Shows the pending page.
     *
     * @return the pending page
     * @endpoint "/provider/dashboard/pending"
     * @verb GET
     */
    @RequestMapping(value = "/pending", method = RequestMethod.GET)
    public ModelAndView viewPending() {
        if (isOperations()) {
            return new ModelAndView("redirect:/agent/enrollment/list/draft?statuses=Pending&showFilterPanel=true");
        }
        return filterTicketsByStatus(ViewStatics.PENDING_STATUS, createDefaultFilter());
    }

    /**
     * Shows the approved page.
     *
     * @return the approved page
     * @endpoint "/provider/dashboard/approved"
     * @verb GET
     */
    @RequestMapping(value = "/approved", method = RequestMethod.GET)
    public ModelAndView viewApproved() {
        if (isOperations()) {
            return new ModelAndView("redirect:/agent/enrollment/list/draft?statuses=Approved&showFilterPanel=true");
        }
        return filterTicketsByStatus(ViewStatics.APPROVED_STATUS, createDefaultFilter());
    }

    /**
     * Shows the rejected page.
     *
     * @return the rejected page
     * @endpoint "/provider/dashboard/rejected"
     * @verb GET
     */
    @RequestMapping(value = "/rejected", method = RequestMethod.GET)
    public ModelAndView viewRejected() {
        if (isOperations()) {
            return new ModelAndView("redirect:/agent/enrollment/list/draft?statuses=Rejected&showFilterPanel=true");
        }
        return filterTicketsByStatus(ViewStatics.REJECTED_STATUS, createDefaultFilter());
    }

    /**
     * Creates a default filter.
     *
     * @return the default filter settings
     */
    private ProviderSearchCriteria createDefaultFilter() {
        ProviderSearchCriteria criteria = new ProviderSearchCriteria();
        criteria.setSortColumn("6");
        criteria.setAscending(false);
        criteria.setPageNumber(1);
        criteria.setPageSize(DEFAULT_PAGE_SIZE);
        return criteria;
    }

    /**
     * Filters the tickets using the provided criteria.
     *
     * @param status only status of this type will be returned
     * @param criteria the search criteria
     * @return the view to show the results by status
     * @endpoint "/provider/dashboard/filter"
     * @verb GET
     */
    @RequestMapping(value = "/filter", method = RequestMethod.GET)
    public ModelAndView filterTicketsByStatus(
        @RequestParam("status") String status,
        ProviderSearchCriteria criteria
    ) {
        String view = "provider/dashboard/list_by_status";
        criteria.setStatuses(Arrays.asList(status));
        ModelAndView mv = searchTickets(criteria, view);
        mv.addObject("statusFilter", status);
        if (ViewStatics.REJECTED_STATUS.equals(status)) {
            mv.addObject("listType", "Denied Enrollments");
        } else {
            mv.addObject("listType", status + " Enrollments");
        }

        return mv;
    }

    /**
     * Filters the tickets using the provided criteria.
     *
     * @param status only status of this type will be returned
     * @param criteria the search criteria
     * @param response the response to write to
     * @throws PortalServiceException for any errors encountered
     * @throws IOException for read/write errors
     * @endpoint "/provider/dashboard/export"
     * @verb GET
     */
    @SuppressWarnings("unchecked")
    @RequestMapping(value = "/export", method = RequestMethod.GET)
    public void exportTicketsByStatus(
        @RequestParam("status") String status, ProviderSearchCriteria criteria,
        HttpServletResponse response
    ) throws PortalServiceException, IOException {
        criteria.setStatuses(Arrays.asList(status));

        // export all
        criteria.setPageNumber(0);
        criteria.setPageSize(0);

        ModelAndView mv = searchTickets(criteria, "provider/dashboard/list_by_status");

        SearchResult<UserRequest> results = (SearchResult<UserRequest>) mv.getModelMap().get("results");
        response.reset();
        response.setContentType("application/pdf");
        String id = UUID.randomUUID().toString();
        response.setHeader("Content-Disposition", "attachment; filename=export_" + id + ".pdf");
        exportService.export(results.getItems(), status, response.getOutputStream());
    }

    /**
     * Performs navigation and filtering of dashboard search.
     *
     * @param criteria the filter
     * @return the dashboard page
     * @endpoint "/provider/dashboard/list/filter"
     * @verb GET
     */
    @RequestMapping(value = "/list/filter", method = RequestMethod.GET)
    public ModelAndView filterTicketList(ProviderSearchCriteria criteria) {
        ModelAndView mv = searchTickets(criteria, "provider/dashboard/list_by_status");
        mv.addObject("statusFilter", "All");
        mv.addObject("listType", "All Enrollments");
        return mv;
    }

    /**
     * Performs search.
     *
     * @param criteria the search criteria
     * @param view the view to render the results
     * @return the results and the view provided
     */
    private ModelAndView searchTickets(
        ProviderSearchCriteria criteria,
        String view
    ) {
        String enrollmentNumber = criteria.getEnrollmentNumber();
        // enrollment number must be a valid long since ids are of that type.
        if (Util.isNotBlank(enrollmentNumber)) {
            try {
                Long.parseLong(enrollmentNumber);
            } catch (NumberFormatException e) {
                // if not, set to a dummy value that will NEVER match any record
                criteria.setEnrollmentNumber("999999999999999999");
            }
        }

        CMSUser principal = ControllerHelper.getCurrentUser();
        SearchResult<UserRequest> results = enrollmentService.searchTickets(principal, criteria);
        ModelAndView mv = new ModelAndView(view);
        mv.addObject("results", results);

        List<Long> profileIds = enrollmentService.findMyProfiles(principal)
                .stream()
                .map(profileHeader -> profileHeader.getProfileId())
                .collect(Collectors.toList());
        mv.addObject("profileIds", profileIds);

        ControllerHelper.addPaginationDetails(results, mv);
        ControllerHelper.addPaginationLinks(results, mv);

        // revert changes to input
        criteria.setEnrollmentNumber(enrollmentNumber);
        mv.addObject("criteria", criteria);
        return mv;
    }
}
