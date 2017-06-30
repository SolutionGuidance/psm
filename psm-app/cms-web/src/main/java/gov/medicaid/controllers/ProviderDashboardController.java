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
import gov.medicaid.services.PortalServiceConfigurationException;
import gov.medicaid.services.PortalServiceException;
import gov.medicaid.services.ProviderEnrollmentService;
import gov.medicaid.services.util.Util;

import java.io.IOException;
import java.util.Arrays;
import java.util.UUID;

import javax.annotation.PostConstruct;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

/**
 * Handles dashboard functions.
 *
 * @author TCSASSEMBLER
 * @version 1.0
 * @endpoint "/provider/dashboard/*"
 */
@Controller
@RequestMapping("/provider/dashboard/*")
public class ProviderDashboardController extends BaseController {

    /**
     * Default display size.
     */
    private static final int DEFAULT_PAGE_SIZE = 10;

    /**
     * Service used to perform operations.
     */
    private ProviderEnrollmentService enrollmentService;

    /**
     * Used to export results to PDF.
     */
    private ExportService exportService;

    /**
     * Empty constructor.
     */
    public ProviderDashboardController() {
    }

    /**
     * This method checks that all required injection fields are in fact provided.
     *
     * @throws PortalServiceConfigurationException - If there are required injection fields that are not injected
     */
    @PostConstruct
    protected void init() {
        super.init();
        if (enrollmentService == null) {
            throw new PortalServiceConfigurationException("enrollmentService is not configured correctly.");
        }
    }

    /**
     * Opens the dashboard.
     *
     * @return the dashboard page and the needed models
     * @throws PortalServiceException for any errors encountered
     * @endpoint "/provider/dashboard/"
     * @verb GET
     */
    @RequestMapping(value = "/", method = RequestMethod.GET)
    public ModelAndView viewDashboard() throws PortalServiceException {
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
     * @return true if the user is an agent or admin
     */
    private boolean isOperations() {
        CMSUser user = ControllerHelper.getCurrentUser();
        String role = user.getRole().getDescription();
        return !ViewStatics.ROLE_PROVIDER.equals(role);
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
     * @throws PortalServiceException for any errors encountered
     * @endpoint "/provider/dashboard/list"
     * @verb GET
     */
    @RequestMapping(value = "/list", method = RequestMethod.GET)
    public ModelAndView viewTicketList() throws PortalServiceException {
        return filterTicketList(createDefaultFilter());
    }

    /**
     * Shows the drafts page.
     *
     * @return the drafts page
     * @throws PortalServiceException for any errors encountered
     * @endpoint "/provider/dashboard/drafts"
     * @verb GET
     */
    @RequestMapping(value = "/drafts", method = RequestMethod.GET)
    public ModelAndView viewDrafts() throws PortalServiceException {
        if (isOperations()) {
            return new ModelAndView("redirect:/agent/enrollment/search/draft?statuses=Draft&showFilterPanel=true");
        }
        return filterTicketsByStatus(ViewStatics.DRAFT_STATUS, createDefaultFilter());
    }

    /**
     * Shows the pending page.
     *
     * @return the pending page
     * @throws PortalServiceException for any errors encountered
     * @endpoint "/provider/dashboard/pending"
     * @verb GET
     */
    @RequestMapping(value = "/pending", method = RequestMethod.GET)
    public ModelAndView viewPending() throws PortalServiceException {
        if (isOperations()) {
            return new ModelAndView("redirect:/agent/enrollment/search/draft?statuses=Pending&showFilterPanel=true");
        }
        return filterTicketsByStatus(ViewStatics.PENDING_STATUS, createDefaultFilter());
    }

    /**
     * Shows the approved page.
     *
     * @return the approved page
     * @throws PortalServiceException for any errors encountered
     * @endpoint "/provider/dashboard/approved"
     * @verb GET
     */
    @RequestMapping(value = "/approved", method = RequestMethod.GET)
    public ModelAndView viewApproved() throws PortalServiceException {
        if (isOperations()) {
            return new ModelAndView("redirect:/agent/enrollment/search/draft?statuses=Approved&showFilterPanel=true");
        }
        return filterTicketsByStatus(ViewStatics.APPROVED_STATUS, createDefaultFilter());
    }

    /**
     * Shows the rejected page.
     *
     * @return the rejected page
     * @throws PortalServiceException for any errors encountered
     * @endpoint "/provider/dashboard/rejected"
     * @verb GET
     */
    @RequestMapping(value = "/rejected", method = RequestMethod.GET)
    public ModelAndView viewRejected() throws PortalServiceException {
        if (isOperations()) {
            return new ModelAndView("redirect:/agent/enrollment/search/draft?statuses=Rejected&showFilterPanel=true");
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
     * @throws PortalServiceException for any errors encountered
     * @endpoint "/provider/dashboard/filter"
     * @verb GET
     */
    @RequestMapping(value = "/filter", method = RequestMethod.GET)
    public ModelAndView filterTicketsByStatus(@RequestParam("status") String status, ProviderSearchCriteria criteria)
        throws PortalServiceException {

        String view = "provider/dashboard/list_by_status";
        criteria.setStatuses(Arrays.asList(status));
        ModelAndView mv = searchTickets(criteria, view);
        mv.addObject("statusFilter", status);
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
    public void exportTicketsByStatus(@RequestParam("status") String status, ProviderSearchCriteria criteria,
        HttpServletResponse response) throws PortalServiceException, IOException {
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
     * @throws PortalServiceException for any errors encountered
     * @endpoint "/provider/dashboard/list/filter"
     * @verb GET
     */
    @RequestMapping(value = "/list/filter", method = RequestMethod.GET)
    public ModelAndView filterTicketList(ProviderSearchCriteria criteria) throws PortalServiceException {
        return searchTickets(criteria, "provider/dashboard/list");
    }

    /**
     * Performs search.
     *
     * @param criteria the search criteria
     * @param view the view to render the results
     * @return the results and the view provided
     * @throws PortalServiceException for any errors encountered
     */
    private ModelAndView searchTickets(ProviderSearchCriteria criteria, String view) throws PortalServiceException {
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

        // revert changes to input
        criteria.setEnrollmentNumber(enrollmentNumber);
        mv.addObject("criteria", criteria);
        return mv;
    }

    /**
     * Sets the value of the field <code>enrollmentService</code>.
     *
     * @param enrollmentService the enrollmentService to set
     */
    public void setEnrollmentService(ProviderEnrollmentService enrollmentService) {
        this.enrollmentService = enrollmentService;
    }

    /**
     * Sets the value of the field <code>exportService</code>.
     * @param exportService the exportService to set
     */
    public void setExportService(ExportService exportService) {
        this.exportService = exportService;
    }

}
