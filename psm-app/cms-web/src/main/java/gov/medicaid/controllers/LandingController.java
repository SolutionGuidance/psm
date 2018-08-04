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

package gov.medicaid.controllers;

import gov.medicaid.entities.CMSUser;
import gov.medicaid.entities.Role;
import gov.medicaid.entities.dto.ViewStatics;
import gov.medicaid.services.PortalServiceException;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * Handles display of the default page for the users.
 */
@Controller
public class LandingController extends BaseController {

    /**
     * Empty constructor.
     */
    public LandingController() {
    }

    /**
     * Determines the appropriate initial page for the user.
     *
     * @return the redirect to the appropriate initial page.
     * @throws PortalServiceException for any errors encountered
     * @endpoint "/landing"
     * @verb GET
     */
    @RequestMapping(value = "/landing", method = RequestMethod.GET)
    public String viewLandingPage() throws PortalServiceException {
        CMSUser user = ControllerHelper.getCurrentUser();
        String role = user.getRole().getDescription();

        if (ViewStatics.ROLE_PROVIDER.equals(role)) {
            return "redirect:/provider/dashboard/";
        } else if (ViewStatics.ROLE_SERVICE_AGENT.equals(role)) {
            return "redirect:/provider/dashboard/";
        } else if (ViewStatics.ROLE_SERVICE_ADMINISTRATOR.equals(role)) {
            return "redirect:/ops/viewDashboard";
        } else if (ViewStatics.ROLE_SYSTEM_ADMINISTRATOR.equals(role)) {
            return "redirect:/system/user/list";
        }

        throw new PortalServiceException("User has no valid role for this system.");
    }

    /**
     * Determines the appropriate initial page for the user.
     *
     * @return the redirect to the appropriate initial page.
     * @throws PortalServiceException for any errors encountered
     * @endpoint "/myprofile"
     * @verb GET
     */
    @RequestMapping(value = "/myprofile", method = RequestMethod.GET)
    public String viewProfilePage() throws PortalServiceException {
        CMSUser user = ControllerHelper.getCurrentUser();
        Role role = user.getRole();

        if (ViewStatics.ROLE_PROVIDER.equals(role.getDescription())) {
            return "redirect:/provider/profile/";
        } else {
            return "redirect:/ops/getUser";
        }
    }
}
