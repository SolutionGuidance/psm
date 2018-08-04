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
import gov.medicaid.controllers.dto.StatusDTO;
import gov.medicaid.entities.CMSUser;
import gov.medicaid.entities.SearchResult;
import gov.medicaid.entities.UserSearchCriteria;
import gov.medicaid.services.PortalServiceException;

import gov.medicaid.services.RegistrationService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.Arrays;
import java.util.List;

/**
 * This controller class that provides for user search - simple and advanced.
 * Changes in 1.1: add private method getRolesStr
 *  and update search to use getRolesStr to get all the roles as an string.
 * <p>
 * <b>Thread Safety</b> This class is mutable and not thread safe, but used in thread safe manner by framework.
 * </p>
 *
 * @endpoint "/system/search/*"
 */
@Controller
@RequestMapping("/system/search/*")
public class SystemAdminUserSearchController {

    /**
     * The generic error message to be presented to the user.
     */
    private static final String USER_ERROR_MSG = "There was a problem processing your request, please contact support.";

    private final RegistrationService registrationService;

    public SystemAdminUserSearchController(RegistrationService registrationService) {
        this.registrationService = registrationService;
    }

    /**
     * This action will search for users.
     * Change in 1.1: use getRolesStr to get all the roles as an string.
     *
     * @param criteria - the search criteria
     * @return - the model and view instance that contains the name of view to be rendered and data to be used for
     *        rendering (not null)
     * @throws IllegalArgumentException - If the given criteria is null
     * @throws PortalServiceException - If there are any errors in the action
     * @endpoint "/system/search/list"
     */
    @RequestMapping("/list")
    public ModelAndView search(UserSearchCriteria criteria) throws PortalServiceException {

        if (criteria == null) { // never true if called by spring MVC
            throw new IllegalArgumentException("Argument 'criteria' cannot be null.");
        }

        SearchResult<CMSUser> results = registrationService.findUsersByCriteria(criteria);
        ModelAndView mv = new ModelAndView("admin/advanced-search-results-system-admin");
        mv.addObject("results", results);
        mv.addObject("criteria", criteria);
        mv.addObject("roles", getRolesStr(criteria.getRoles()));
        ControllerHelper.addPaginationDetails(results, mv);
        ControllerHelper.addPaginationLinks(results, mv);
        return mv;
    }

    /**
     * Gets all roles string.
     *
     * @param rolesList the roles list
     * @return the all roles string
     */
    private String getRolesStr(List<String> rolesList) {
        if (null == rolesList) {
            return "";
        }
        int rolesLen = rolesList.size();
        String[] roles = new String[rolesLen];
        for (int i = 0; i < rolesLen; i++) {
            roles[i] = rolesList.get(i);
        }
        return Arrays.toString(roles);
    }

    /**
     * This action will delete the entities with the given IDs.
     *
     * @param userIds - the entity IDs to be deleted
     * @return the status of the request, including a possible message
     * @throws IllegalArgumentException - If the list given is null
     * @endpoint "/system/search/delete"
     */
    @RequestMapping("/delete")
    @ResponseBody
    public StatusDTO delete(@RequestParam("userIds") String[] userIds) {

        if (userIds == null) { // never true if called by spring MVC
            throw new IllegalArgumentException("Argument 'userIds' cannot be null.");
        }

        StatusDTO statusDTO = new StatusDTO();
        try {
            CMSUser actor = ControllerHelper.getCurrentUser();
            registrationService.unregisterUsers(actor.getUserId(), userIds);
            statusDTO.setSuccess(true);
        } catch (PortalServiceException ex) {
            statusDTO.setMessage(USER_ERROR_MSG);
        }
        return statusDTO;
    }
}
