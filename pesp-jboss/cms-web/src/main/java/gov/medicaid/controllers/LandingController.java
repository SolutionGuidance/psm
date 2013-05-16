/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
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
