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

import java.util.Arrays;

import gov.medicaid.controllers.ControllerHelper;
import gov.medicaid.entities.CMSUser;
import gov.medicaid.entities.Role;
import gov.medicaid.entities.SearchResult;
import gov.medicaid.entities.UserSearchCriteria;
import gov.medicaid.entities.dto.ViewStatics;
import gov.medicaid.services.PortalServiceConfigurationException;
import gov.medicaid.services.PortalServiceException;
import gov.medicaid.services.RegistrationService;
import gov.medicaid.services.util.LogUtil;
import gov.medicaid.services.util.Util;

import javax.annotation.PostConstruct;
import javax.servlet.http.HttpServletRequest;

import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

/**
 * <p>
 * This controller class that manages service agents.
 * </p>
 * <p>
 * This class is mutable and not thread safe, but used in thread safe manner by framework.
 * </p>
 *
 * @author argolite, TCSASSEMBLER
 * @version 1.0
 */
public class ServiceAgentController extends BaseServiceAdminController {
    /**
     * Represents the user service. It is managed with a getter and setter. It may have any value, but is expected to be
     * set to a non-null/empty value by dependency injection. It is fully mutable, but not expected to change after
     * dependency injection.
     */
    private RegistrationService registrationService;

    /**
     * Empty constructor.
     */
    public ServiceAgentController() {
    }

    /**
     * This method checks that all required injection fields are in fact provided.
     *
     * @throws PortalServiceConfigurationException If there are required injection fields that are not injected
     */
    @Override
    @PostConstruct
    protected void init() {
        super.init();

        if (registrationService == null) {
            throw new PortalServiceConfigurationException("registrationService must be configured.");
        }
    }

    /**
     * This action will load the users page.
     *
     * @return the model and view instance that contains the name of view to be rendered and data to be used for
     *         rendering (not null)
     *
     * @throws PortalServiceException If there are any errors in the action
     * @endpoint "/admin/viewAgents"
     * @verb GET
     */
    @RequestMapping(value = "/admin/viewAgents", method = RequestMethod.GET)
    public ModelAndView view() throws PortalServiceException {
        String signature = "ServiceAgentController#view()";
        LogUtil.traceEntry(getLog(), signature, null, null);

        try {
            UserSearchCriteria criteria = new UserSearchCriteria();
            criteria.setPageNumber(1);
            criteria.setPageSize(10);
            criteria.setSortColumn("lastName");
            criteria.setAscending(true);
            criteria.setRoles(Arrays.asList(ViewStatics.ROLE_SERVICE_AGENT));
            SearchResult<CMSUser> result = registrationService.findUsersByCriteria(criteria);
            ModelAndView model = new ModelAndView("admin/service_admin_service_agents");

            model.addObject("usersSearchResult", result);
            model.addObject("searchCriteria", criteria);
            return LogUtil.traceExit(getLog(), signature, model);
        } catch (PortalServiceException e) {
            LogUtil.traceError(getLog(), signature, e);
            throw e;
        }
    }

    /**
     * This action will search for users.
     *
     * @param criteria the search criteria
     *
     * @return the model and view instance that contains the name of view to be rendered and data to be used for
     *         rendering (not null)
     *
     * @throws PortalServiceException If there are any errors in the action
     * @endpoint "/admin/viewAgents"
     * @verb POST
     */
    @RequestMapping(value = "/admin/viewAgents", method = RequestMethod.POST)
    public ModelAndView search(@ModelAttribute("criteria") UserSearchCriteria criteria) throws PortalServiceException {
        String signature = "ServiceAgentController#search(UserSearchCriteria criteria)";
        LogUtil.traceEntry(getLog(), signature, new String[] {"criteria"}, new Object[] {criteria});

        try {
            SearchResult<CMSUser> result = registrationService.findUsersByCriteria(criteria);
            criteria.setRoles(Arrays.asList(ViewStatics.ROLE_SERVICE_AGENT));
            ModelAndView model = new ModelAndView("admin/service_admin_service_agents");

            model.addObject("usersSearchResult", result);
            model.addObject("searchCriteria", criteria);
            return LogUtil.traceExit(getLog(), signature, model);
        } catch (PortalServiceException e) {
            LogUtil.traceError(getLog(), signature, e);
            throw e;
        }
    }

    /**
     * This action will get the entity with the given ID.
     *
     * @param userId the user id
     *
     * @return the model and view instance that contains the name of view to be rendered and data to be used for
     *         rendering (not null)
     *
     * @throws PortalServiceException If there are any errors in the action
     * @endpoint "/admin/getAgent"
     * @verb GET
     */
    @RequestMapping(value = "/admin/getAgent", method = RequestMethod.GET)
    public ModelAndView get(@RequestParam("userId") String userId) throws PortalServiceException {
        String signature = "ServiceAgentController#get(long userId)";
        LogUtil.traceEntry(getLog(), signature, new String[] {"userId"}, new Object[] {userId});

        try {
            CMSUser user = registrationService.findByUserId(userId);
            ModelAndView model = new ModelAndView("admin/service_admin_view_service_agent_details");
            model.addObject("user", user);

            return LogUtil.traceExit(getLog(), signature, model);
        } catch (PortalServiceException e) {
            LogUtil.traceError(getLog(), signature, e);
            throw e;
        }
    }

    /**
     * This action will get the entity with the given ID.
     *
     * @param userId the entity ID
     *
     * @return the model and view instance that contains the name of view to be rendered and data to be used for
     *         rendering (not null)
     *
     * @throws PortalServiceException If there are any errors in the action
     * @endpoint "/admin/beginEditAgent"
     * @verb GET
     */
    @RequestMapping(value = "/admin/beginEditAgent", method = RequestMethod.GET)
    public ModelAndView beginEdit(@RequestParam("userId") String userId) throws PortalServiceException {
        String signature = "ServiceAgentController#beginEdit(long userId)";
        LogUtil.traceEntry(getLog(), signature, new String[] {"userId"}, new Object[] {userId});

        try {

            ModelAndView model = new ModelAndView("admin/service_admin_edit_service_agent");

            if (Util.isBlank(userId)) {
                model.addObject("user", new CMSUser());
            } else {
                CMSUser user = registrationService.findByUserId(userId);
                model.addObject("user", user);
            }
            return LogUtil.traceExit(getLog(), signature, model);
        } catch (PortalServiceException e) {
            LogUtil.traceError(getLog(), signature, e);
            throw e;
        }
    }

    /**
     * This action will create the entity.
     *
     * @param user the user
     * @param request the http servlet request
     *
     * @return the model and view for creation result
     *
     * @throws IllegalArgumentException if user is null/empty
     * @throws PortalServiceException If there are any errors in the action
     * @endpoint "/admin/createAgent"
     * @verb POST
     */
    @RequestMapping(value = "/admin/createAgent", method = RequestMethod.POST)
    public ModelAndView create(@ModelAttribute("user") CMSUser user, HttpServletRequest request)
        throws PortalServiceException {
        String signature = "ServiceAgentController#create(User user)";
        LogUtil.traceEntry(getLog(), signature, new String[] {"user"}, new Object[] {user});

        try {
            user.concatPhone();
            Role role = new Role();
            role.setDescription(ViewStatics.ROLE_SERVICE_AGENT);
            user.setRole(role);
            CMSUser actor = ControllerHelper.getCurrentUser();
            registrationService.registerByAdmin(actor, user, null);

            ModelAndView model = new ModelAndView("admin/service_admin_view_service_agent");
            model.addObject("user", user);

            return LogUtil.traceExit(getLog(), signature, model);
        } catch (PortalServiceException e) {
            LogUtil.traceError(getLog(), signature, e);
            throw e;
        }
    }

    /**
     * This action will save the entity.
     *
     * @param user the user
     * @param request the http servlet request
     *
     * @return the model and view for update result
     *
     * @throws IllegalArgumentException if user is null/empty
     * @throws PortalServiceException If there are any errors in the action
     * @endpoint "/admin/updateAgent"
     * @verb POST
     */
    @RequestMapping(value = "/admin/updateAgent", method = RequestMethod.POST)
    public ModelAndView edit(@ModelAttribute("user") CMSUser user, HttpServletRequest request)
        throws PortalServiceException {
        String signature = "ServiceAgentController#edit(User user)";
        LogUtil.traceEntry(getLog(), signature, new String[] {"user"}, new Object[] {user});

        try {
            CMSUser currentUser = ControllerHelper.getCurrentUser();
            user.concatPhone();
            registrationService.updateByAdmin(currentUser, user, null);
            ModelAndView model = new ModelAndView("admin/service_admin_view_service_agent");
            model.addObject("user", user);
            return LogUtil.traceExit(getLog(), signature, model);
        } catch (PortalServiceException e) {
            LogUtil.traceError(getLog(), signature, e);
            throw e;
        }
    }

    /**
     * This action will delete the entities with the given IDs.
     *
     * @param userIds the entity IDs
     * @param request the http servlet request
     * @return the successful text
     *
     * @throws PortalServiceException If there are any errors in the action
     * @endpoint "/admin/deleteAgents"
     * @verb GET
     */
    @RequestMapping(value = "/admin/deleteAgents", method = RequestMethod.GET)
    @ResponseBody
    public String delete(@RequestParam("userIds") String[] userIds, HttpServletRequest request)
        throws PortalServiceException {
        String signature = "ServiceAgentController#delete(long[] userIds)";
        LogUtil.traceEntry(getLog(), signature, new String[] {"userIds"}, new Object[] {userIds});

        try {
            CMSUser currentUser = ControllerHelper.getCurrentUser();
            registrationService.unregisterUsers(currentUser.getUserId(), userIds);
            return LogUtil.traceExit(getLog(), signature, "success");
        } catch (PortalServiceException e) {
            LogUtil.traceError(getLog(), signature, e);
            throw e;
        }
    }

    /**
     * Gets the value of the field <code>registrationService</code>.
     *
     * @return the registrationService
     */
    public RegistrationService getRegistrationService() {
        return registrationService;
    }

    /**
     * Sets the value of the field <code>registrationService</code>.
     *
     * @param registrationService the registrationService to set
     */
    public void setRegistrationService(RegistrationService registrationService) {
        this.registrationService = registrationService;
    }
}
