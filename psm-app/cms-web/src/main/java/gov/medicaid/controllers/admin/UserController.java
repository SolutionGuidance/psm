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
import gov.medicaid.services.PortalServiceConfigurationException;
import gov.medicaid.services.PortalServiceException;
import gov.medicaid.services.RegistrationService;
import gov.medicaid.services.util.LogUtil;

import javax.annotation.PostConstruct;
import javax.servlet.http.HttpServletRequest;

import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

/**
 * <p>
 * This controller class that manages a user's profile.
 * </p>
 * <p>
 * This class is mutable and not thread safe, but used in thread safe manner by framework.
 * </p>
 *
 * @author argolite, TCSASSEMBLER
 * @version 1.0
 */
public class UserController extends BaseServiceAdminController {
    /**
     * Represents the user service. it is managed with a getter and setter. It may have any value, but is expected to be
     * set to a non-null/empty value by dependency injection. It is fully mutable, but not expected to change after
     * dependency injection.
     */
    private RegistrationService registrationService;

    /**
     * Empty constructor.
     */
    public UserController() {
    }

    /**
     * This method checks that all required injection fields are in fact provided.
     *
     * @throws PortalServiceConfigurationException - If there are required injection fields that are not injected
     */
    @PostConstruct
    protected void init() {
        super.init();

        if (registrationService == null) {
            throw new PortalServiceConfigurationException("userService must be configured.");
        }
    }

    /**
     * This action will get the entity with the given ID.
     *
     * @return the model and view instance that contains the name of view to be rendered and data to be used for
     *         rendering (not null)
     *
     * @throws PortalServiceException If there are any errors in the action
     * @endpoint "/ops/getUser"
     * @verb GET
     */
    @RequestMapping(value = "/ops/getUser", method = RequestMethod.GET)
    public ModelAndView get() throws PortalServiceException {
        String signature = "UserController#get(long userId)";
        LogUtil.traceEntry(getLog(), signature, null, null);

        try {
            String userId = ControllerHelper.getCurrentUser().getUserId();
            CMSUser user = registrationService.findByUserId(userId);
            ModelAndView model = new ModelAndView("admin/service_admin_view_user_profile");
            model.addObject("user", user);
            ControllerHelper.addContextInfoToModel(model);

            return LogUtil.traceExit(getLog(), signature, model);
        } catch (PortalServiceException e) {
            LogUtil.traceError(getLog(), signature, e);
            throw e;
        }
    }

    /**
     * This action will get the entity with the given ID.
     *
     * @return the model and view instance that contains the name of view to be rendered and data to be used for
     *         rendering (not null)
     *
     * @throws PortalServiceException If there are any errors in the action
     * @endpoint "/ops/beginEditUser"
     * @verb GET
     */
    @RequestMapping(value = "/ops/beginEditUser", method = RequestMethod.GET)
    public ModelAndView beginEdit() throws PortalServiceException {
        String signature = "UserController#beginEdit(long userId)";
        LogUtil.traceEntry(getLog(), signature, null, null);

        try {
            String userId = ControllerHelper.getCurrentUser().getUserId();
            CMSUser user = registrationService.findByUserId(userId);
            ModelAndView model = new ModelAndView("admin/service_admin_edit_user_profile");
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
     * @throws IllegalArgumentException if user is null
     * @throws PortalServiceException If there are any errors in the action
     * @endpoint "/ops/updateUser"
     * @verb POST
     */
    @RequestMapping(value = "/ops/updateUser", method = RequestMethod.POST)
    public ModelAndView edit(@ModelAttribute("user") CMSUser user, HttpServletRequest request)
        throws PortalServiceException {
        String signature = "UserController#edit(User user)";
        LogUtil.traceEntry(getLog(), signature, new String[] {"user"}, new Object[] {user});

        try {
            CMSUser currentUser = ControllerHelper.getCurrentUser();
            if (!currentUser.getUserId().equals(user.getUserId())) {
                throw new PortalServiceException("Invalid navigation path.");
            }
            user.concatPhone();
            registrationService.updateUserProfile(currentUser.getUserId(), user);
            ModelAndView model = new ModelAndView("admin/service_admin_view_user_profile");
            model.addObject("user", user);
            ControllerHelper.addContextInfoToModel(model);

            return LogUtil.traceExit(getLog(), signature, model);
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
