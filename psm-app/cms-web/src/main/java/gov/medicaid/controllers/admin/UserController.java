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
import gov.medicaid.entities.CMSUser;
import gov.medicaid.services.PortalServiceException;
import gov.medicaid.services.RegistrationService;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;

/**
 * <p>
 * This controller class that manages a user's profile.
 * </p>
 * <p>
 * This class is mutable and not thread safe, but used in thread safe manner by framework.
 * </p>
 */
@Controller
public class UserController {
    private final RegistrationService registrationService;

    public UserController(RegistrationService registrationService) {
        this.registrationService = registrationService;
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
        String userId = ControllerHelper.getCurrentUser().getUserId();
        CMSUser user = registrationService.findByUserId(userId);
        ModelAndView model = new ModelAndView("admin/service_admin_view_user_profile");
        model.addObject("user", user);

        return model;
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
        String userId = ControllerHelper.getCurrentUser().getUserId();
        CMSUser user = registrationService.findByUserId(userId);
        ModelAndView model = new ModelAndView("admin/service_admin_edit_user_profile");
        model.addObject("user", user);

        return model;
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
        CMSUser currentUser = ControllerHelper.getCurrentUser();
        if (!currentUser.getUserId().equals(user.getUserId())) {
            throw new PortalServiceException("Invalid navigation path.");
        }
        user.concatPhone();
        registrationService.updateUserProfile(currentUser.getUserId(), user);
        ModelAndView model = new ModelAndView("admin/service_admin_view_user_profile");
        model.addObject("user", user);

        return model;
    }
}
