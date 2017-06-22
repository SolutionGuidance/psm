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
package gov.medicaid.controllers.admin;

import gov.medicaid.controllers.ControllerHelper;
import gov.medicaid.entities.CMSUser;
import gov.medicaid.entities.EnrollmentStatus;
import gov.medicaid.entities.Event;
import gov.medicaid.entities.HelpItem;
import gov.medicaid.entities.HelpSearchCriteria;
import gov.medicaid.entities.ProviderSearchCriteria;
import gov.medicaid.entities.SearchResult;
import gov.medicaid.entities.UserRequest;
import gov.medicaid.services.CMSConfigurator;
import gov.medicaid.services.EventService;
import gov.medicaid.services.HelpService;
import gov.medicaid.services.LookupService;
import gov.medicaid.services.PortalServiceConfigurationException;
import gov.medicaid.services.PortalServiceException;
import gov.medicaid.services.ProviderEnrollmentService;
import gov.medicaid.services.util.LogUtil;

import java.util.List;

import javax.annotation.PostConstruct;

import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

/**
 * <p>
 * This controller class displays the dashboard and help page.
 * </p>
 * <p>
 * This class is mutable and not thread safe, but used in thread safe manner by framework.
 * </p>
 *
 * @author argolite, TCSASSEMBLER
 * @version 1.0
 */
public class DashboardController extends BaseServiceAdminController {
    /**
     * Represents the provoder profile service. it is managed with a getter and setter. It may have any value, but is
     * expected to be set to a non-null/empty value by dependency injection. It is fully mutable, but not expected to
     * change after dependency injection.
     */
    private ProviderEnrollmentService providerProfileService;

    /**
     * Represents the help service. it is managed with a getter and setter. It may have any value, but is expected to be
     * set to a non-null/empty value by dependency injection. It is fully mutable, but not expected to change after
     * dependency injection.
     */
    private HelpService helpService;

    /**
     * Represents the event service. it is managed with a getter and setter. It may have any value, but is expected to
     * be set to a non-null/empty value by dependency injection. It is fully mutable, but not expected to change after
     * dependency injection.
     */
    private EventService eventService;

    /**
     * For lookup values.
     */
    private LookupService lookupService;

    /**
     * Empty constructor.
     */
    public DashboardController() {
    }

    /**
     * This method checks that all required injection fields are in fact provided.
     *
     * @throws PortalServiceConfigurationException If there are required injection fields that are not injected
     */
    @PostConstruct
    protected void init() {
        super.init();

        if (providerProfileService == null) {
            throw new PortalServiceConfigurationException("providerProfileService must be configured.");
        }

        if (helpService == null) {
            throw new PortalServiceConfigurationException("helpService must be configured.");
        }

        if (eventService == null) {
            throw new PortalServiceConfigurationException("eventService must be configured.");
        }
        lookupService = new CMSConfigurator().getLookupService();
    }

    /**
     * This action will load the dashboard page.
     *
     * @return the model and view instance that contains the name of view to be rendered and data to be used for
     *         rendering (not null)
     *
     * @throws PortalServiceException If there are any errors in the action
     * @endpoint "/ops/viewDashboard"
     * @verb GET
     */
    @RequestMapping(value = { "/ops/viewDashboard" }, method = RequestMethod.GET)
    public ModelAndView view() throws PortalServiceException {
        String signature = "DashboardController#view()";
        LogUtil.traceEntry(getLog(), signature, null, null);

        try {
            // Package a ProviderSearchCriteria with first page of size 10 sorted by last update date column
            ProviderSearchCriteria criteria = new ProviderSearchCriteria();
            criteria.setPageNumber(1);
            criteria.setPageSize(10);
            criteria.setSortColumn("6");

            CMSUser currentUser = ControllerHelper.getCurrentUser();
            SearchResult<UserRequest> result = providerProfileService.searchTickets(currentUser, criteria);

            // Get latest notifications:
            List<Event> notifications = eventService.getLatest();
            List<EnrollmentStatus> findAllLookups = lookupService.findAllLookups(EnrollmentStatus.class);
            for (Event event : notifications) {
                for (EnrollmentStatus enrollmentStatus : findAllLookups) {
                    if (event.getStatus().equals(enrollmentStatus.getCode())) {
                        event.setStatus(enrollmentStatus.getDescription());
                    }
                }
            }
            ModelAndView model = new ModelAndView("admin/dashboard");
            model.addObject("profiles", result.getItems());
            model.addObject("notifications", notifications);

            return LogUtil.traceExit(getLog(), signature, model);
        } catch (PortalServiceException e) {
            LogUtil.traceError(getLog(), signature, e);
            throw e;
        }
    }

    /**
     * This action will search for profile enrollments.
     *
     * @param criteria the search criteria
     *
     * @return the model and view instance that contains the name of view to be rendered and data to be used for
     *         rendering (not null)
     *
     * @throws PortalServiceException If there are any errors in the action
     * @endpoint "/ops/viewDashboard"
     * @verb POST
     */
    @RequestMapping(value = { "/ops/viewDashboard" }, method = RequestMethod.POST)
    public ModelAndView search(@ModelAttribute("criteria") ProviderSearchCriteria criteria)
        throws PortalServiceException {
        String signature = "DashboardController#search(ProviderSearchCriteria criteria)";
        LogUtil.traceEntry(getLog(), signature, new String[] {"criteria"}, new Object[] {criteria});

        try {
            SearchResult<UserRequest> result = providerProfileService.searchTickets(ControllerHelper.getCurrentUser(),
                criteria);

            // Get latest notifications:
            List<Event> notifications = eventService.getLatest();
            ModelAndView model = new ModelAndView("admin/dashboard");
            model.addObject("profiles", result.getItems());
            model.addObject("notifications", notifications);

            return LogUtil.traceExit(getLog(), signature, model);
        } catch (PortalServiceException e) {
            LogUtil.traceError(getLog(), signature, e);
            throw e;
        }
    }

    /**
     * This action will load the help page.
     *
     * @return the model and view instance that contains the name of view to be rendered and data to be used for
     *         rendering (not null)
     *
     * @throws PortalServiceException If there are any errors in the action
     * @endpoint "/viewHelp"
     * @verb GET
     */
    @RequestMapping(value = "/viewHelp", method = RequestMethod.GET)
    public ModelAndView getHelp() throws PortalServiceException {
        String signature = "DashboardController#getHelp()";
        LogUtil.traceEntry(getLog(), signature, null, null);

        try {
            // Get all help topics with help service
            SearchResult<HelpItem> result = helpService.search(new HelpSearchCriteria());
            ModelAndView model = new ModelAndView("admin/help");
            model.addObject("helpItems", result.getItems());

            return LogUtil.traceExit(getLog(), signature, model);
        } catch (PortalServiceException e) {
            LogUtil.traceError(getLog(), signature, e);
            throw e;
        }
    }

    /**
     * This action will get the entity with the given ID.
     *
     * @param id the entity ID
     *
     * @return the model and view instance that contains the name of view to be rendered and data to be used for
     *         rendering (not null)
     *
     * @throws PortalServiceException If there are any errors in the action
     * @endpoint "/viewHelpItem"
     * @verb GET
     */
    @RequestMapping(value = "/viewHelpItem", method = RequestMethod.GET)
    public ModelAndView getHelpItem(@RequestParam("helpItemId") long id) throws PortalServiceException {
        String signature = "DashboardController#getHelpItem(long id)";
        LogUtil.traceEntry(getLog(), signature, new String[] {"id"}, new Object[] {id});

        try {
            HelpItem helpItem = helpService.get(id);
            ModelAndView model = new ModelAndView("admin/help_detail");
            model.addObject("helpItem", helpItem);

            return LogUtil.traceExit(getLog(), signature, model);
        } catch (PortalServiceException e) {
            LogUtil.traceError(getLog(), signature, e);
            throw e;
        }
    }

    /**
     * This action will search for help items.
     *
     * @param criteria the search criteria
     *
     * @return the model and view instance that contains the name of view to be rendered and data to be used for
     *         rendering (not null)
     *
     * @throws PortalServiceException If there are any errors in the action
     * @endpoint "/viewHelp"
     * @verb POST
     */
    @RequestMapping(value = "/viewHelp", method = RequestMethod.POST)
    public ModelAndView searchHelp(@ModelAttribute("criteria") HelpSearchCriteria criteria)
        throws PortalServiceException {
        String signature = "DashboardController#searchHelp(HelpSearchCriteria criteria)";
        LogUtil.traceEntry(getLog(), signature, new String[] {"criteria"}, new Object[] {criteria});

        try {
            List<HelpItem> helpItems = helpService.search(criteria).getItems();
            ModelAndView model = new ModelAndView("admin/help");
            model.addObject("helpItems", helpItems);

            return LogUtil.traceExit(getLog(), signature, model);
        } catch (PortalServiceException e) {
            LogUtil.traceError(getLog(), signature, e);
            throw e;
        }
    }

    /**
     * Getter of helpService.
     *
     * @return the helpService
     */
    public HelpService getHelpService() {
        return helpService;
    }

    /**
     * Set the helpService.
     *
     * @param helpService the helpService to set
     */
    public void setHelpService(HelpService helpService) {
        this.helpService = helpService;
    }

    /**
     * Getter of eventService.
     *
     * @return the eventService
     */
    public EventService getEventService() {
        return eventService;
    }

    /**
     * Set the eventService.
     *
     * @param eventService the eventService to set
     */
    public void setEventService(EventService eventService) {
        this.eventService = eventService;
    }

    /**
     * Gets the value of the field <code>providerProfileService</code>.
     * @return the providerProfileService
     */
    public ProviderEnrollmentService getProviderProfileService() {
        return providerProfileService;
    }

    /**
     * Sets the value of the field <code>providerProfileService</code>.
     * @param providerProfileService the providerProfileService to set
     */
    public void setProviderProfileService(ProviderEnrollmentService providerProfileService) {
        this.providerProfileService = providerProfileService;
    }
}
