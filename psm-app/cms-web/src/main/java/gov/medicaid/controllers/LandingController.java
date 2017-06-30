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
import gov.medicaid.entities.Role;
import gov.medicaid.entities.dto.ViewStatics;
import gov.medicaid.services.PortalServiceException;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * Handles display of the default page for the users.
 *
 * @author TCSASSEMBLER
 * @version 1.0
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
        Role role = user.getRole();

        if (ViewStatics.ROLE_PROVIDER.equals(role.getDescription())) {
            return "redirect:/provider/dashboard/";
        } else if (ViewStatics.ROLE_SVC_AGENT.equals(role.getDescription())) {
            return "redirect:/ops/viewDashboard";
        } else if (ViewStatics.ROLE_SVC_ADMIN.equals(role.getDescription())) {
            return "redirect:/ops/viewDashboard";
        } else if (ViewStatics.ROLE_SYS_ADMIN.equals(role.getDescription())) {
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
