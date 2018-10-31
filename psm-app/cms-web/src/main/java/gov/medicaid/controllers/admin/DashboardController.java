/*
 * Copyright 2012, 2013 TopCoder, Inc.
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

package gov.medicaid.controllers.admin;

import gov.medicaid.controllers.ControllerHelper;
import gov.medicaid.entities.ApplicationStatus;
import gov.medicaid.entities.CMSUser;
import gov.medicaid.entities.Event;
import gov.medicaid.entities.ProviderSearchCriteria;
import gov.medicaid.entities.SearchResult;
import gov.medicaid.entities.UserRequest;
import gov.medicaid.services.EventService;
import gov.medicaid.services.LookupService;
import gov.medicaid.services.PortalServiceException;
import gov.medicaid.services.ProviderApplicationService;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

@Controller
public class DashboardController {
    private final ProviderApplicationService providerProfileService;
    private final EventService eventService;
    private final LookupService lookupService;

    public DashboardController(
        ProviderApplicationService providerProfileService,
        EventService eventService,
        LookupService lookupService
    ) {
        this.providerProfileService = providerProfileService;
        this.eventService = eventService;
        this.lookupService = lookupService;
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
        // Package a ProviderSearchCriteria with first page of size 10 sorted by last update date column
        ProviderSearchCriteria criteria = new ProviderSearchCriteria();
        criteria.setPageNumber(1);
        criteria.setPageSize(10);
        criteria.setSortColumn("6");

        CMSUser currentUser = ControllerHelper.getCurrentUser();
        SearchResult<UserRequest> result = providerProfileService.searchApplications(currentUser, criteria);

        // Get latest notifications:
        List<Event> notifications = eventService.getLatest();
        List<ApplicationStatus> findAllLookups = lookupService.findAllLookups(ApplicationStatus.class);
        for (Event event : notifications) {
            for (ApplicationStatus applicationStatus : findAllLookups) {
                if (event.getStatus().equals(applicationStatus.getCode())) {
                    event.setStatus(applicationStatus.getDescription());
                }
            }
        }
        ModelAndView model = new ModelAndView("admin/dashboard");
        model.addObject("profiles", result.getItems());
        model.addObject("notifications", notifications);

        return model;
    }

    /**
     * This action will search for profile applications.
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
        SearchResult<UserRequest> result = providerProfileService.searchApplications(ControllerHelper.getCurrentUser(),
            criteria);

        // Get latest notifications:
        List<Event> notifications = eventService.getLatest();
        ModelAndView model = new ModelAndView("admin/dashboard");
        model.addObject("profiles", result.getItems());
        model.addObject("notifications", notifications);

        return model;
    }
}
