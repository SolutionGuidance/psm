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

import gov.medicaid.controllers.forms.UpdatePasswordForm;
import gov.medicaid.controllers.validators.UpdatePasswordFormValidator;
import gov.medicaid.entities.CMSUser;
import gov.medicaid.entities.ProviderSearchCriteria;
import gov.medicaid.entities.SearchResult;
import gov.medicaid.entities.UserRequest;
import gov.medicaid.entities.Validity;
import gov.medicaid.entities.dto.ViewStatics;
import gov.medicaid.services.PortalServiceException;
import gov.medicaid.services.ProviderApplicationService;
import gov.medicaid.services.RegistrationService;

import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import java.util.Arrays;
import java.util.List;

/**
 * Handles account maintenance.
 *
 * @endpoint "/provider/profile/*"
 */
@Controller
@RequestMapping("/provider/profile/*")
public class MyProfileController extends BaseController {
    private final ProviderApplicationService applicationService;
    private final RegistrationService registrationService;
    private final UpdatePasswordFormValidator validator;

    public MyProfileController(
        ProviderApplicationService applicationService,
        RegistrationService registrationService,
        UpdatePasswordFormValidator validator
    ) {
        this.applicationService = applicationService;
        this.registrationService = registrationService;
        this.validator = validator;
    }

    /**
     * Displays the update password page.
     *
     * @return the update password page.
     * @throws PortalServiceException for any errors encountered
     * @endpoint "/provider/profile/reset"
     * @verb GET
     */
    @RequestMapping(value = "/reset", method = RequestMethod.GET)
    public ModelAndView viewPasswordChange() throws PortalServiceException {
        return renderPasswordResetPage(new UpdatePasswordForm());
    }

    /**
     * Displays the update password page.
     *
     * @param form the form to bind to the view
     * @return the update password page.
     */
    private ModelAndView renderPasswordResetPage(UpdatePasswordForm form) {
        ModelAndView mv = new ModelAndView("provider/profile/password");
        mv.addObject("passwordForm", form);
        return mv;
    }

    /**
     * Performs password update.
     *
     * @param form the submitted form
     * @param errors the binding results
     * @return the redirect to the profiles page, or back to the input page request is not valid
     * @throws PortalServiceException for any errors encountered
     * @endpoint "/provider/profile/reset"
     * @verb POST
     */
    @RequestMapping(value = "/reset", method = RequestMethod.POST)
    public ModelAndView processPasswordChange(@ModelAttribute("passwordForm") UpdatePasswordForm form,
        BindingResult errors) throws PortalServiceException {
        validator.validate(form, errors);

        if (errors.hasErrors()) {
            return renderPasswordResetPage(form);
        } else {
            CMSUser user = ControllerHelper.getCurrentUser();
            boolean reset = registrationService.resetPassword(user, form.getOldPassword(), form.getPassword());
            if (!reset) {
                ControllerHelper.flashError("Incorrect password.");
                return renderPasswordResetPage(form);
            }

            ControllerHelper.flashInfo("Password has been updated.");
            return new ModelAndView("redirect:/provider/profile/");
        }
    }

    /**
     * Displays the my profile page.
     *
     * @return the my profile model and view
     * @endpoint "/provider/profile/"
     * @verb GET
     */
    @RequestMapping(value = "/", method = RequestMethod.GET)
    public ModelAndView viewDashboard() {
        ModelAndView mv = new ModelAndView("provider/profile/profile");
        return mv;
    }

    /**
     * Starts the renewal process.
     *
     * @param profileId the profile to renew
     * @return the application start page.
     * @throws PortalServiceException for any errors encountered
     * @endpoint "/provider/profile/renew"
     * @verb GET
     */
    @RequestMapping(value = "/renew", method = RequestMethod.GET)
    public ModelAndView startRenewal(
        @RequestParam(value = "profileId", required = false, defaultValue = "0") long profileId)
        throws PortalServiceException {
        if (profileId == 0) {
            ControllerHelper.flashError("Please select the profile to be renewed.");
            return new ModelAndView("redirect:/provider/profile/");
        } else {

            // check if there is an existing draft and reuse it
            ProviderSearchCriteria criteria = new ProviderSearchCriteria();
            criteria.setProfileId(profileId);
            criteria.setRequestTypes(Arrays.asList(ViewStatics.RENEWAL_REQUEST));
            criteria.setStatuses(Arrays.asList(ViewStatics.DRAFT_STATUS));
            SearchResult<UserRequest> results = applicationService.searchApplications(ControllerHelper.getCurrentUser(),
                criteria);
            List<UserRequest> drafts = results.getItems();
            if (drafts != null) {
                for (UserRequest userRequest : drafts) {
                    Validity validity = applicationService.getSubmissionValidity(userRequest.getApplicationId(), profileId);
                    if (validity != Validity.STALE) {
                        ModelAndView mv = new ModelAndView("provider/profile/confirm_edit");
                        mv.addObject("requestType", ViewStatics.RENEWAL_REQUEST);
                        mv.addObject("profileId", profileId);
                        mv.addObject("applicationId", userRequest.getApplicationId());
                        return mv;
                    }
                }
            }

            ModelAndView mv = new ModelAndView("redirect:/provider/application/renew");
            mv.addObject("profileId", profileId);
            return mv;
        }
    }

    /**
     * Starts the update process.
     *
     * @param profileId the profile to be edited
     * @return the application start page.
     * @throws PortalServiceException for any errors encountered
     * @endpoint "/provider/profile/edit"
     * @verb GET
     */
    @RequestMapping(value = "/edit", method = RequestMethod.GET)
    public ModelAndView startEdit(
        @RequestParam(value = "profileId", required = false, defaultValue = "0") long profileId)
        throws PortalServiceException {
        if (profileId == 0) {
            ControllerHelper.flashError("Please select the profile to be updated.");
            return new ModelAndView("redirect:/provider/profile/");
        } else {

            // check if there is an existing draft and reuse it
            ProviderSearchCriteria criteria = new ProviderSearchCriteria();
            criteria.setProfileId(profileId);
            criteria.setRequestTypes(Arrays.asList(ViewStatics.UPDATE_REQUEST));
            criteria.setStatuses(Arrays.asList(ViewStatics.DRAFT_STATUS));
            SearchResult<UserRequest> results = applicationService.searchApplications(ControllerHelper.getCurrentUser(),
                criteria);
            List<UserRequest> drafts = results.getItems();
            if (drafts != null) {
                for (UserRequest userRequest : drafts) {
                    Validity validity = applicationService.getSubmissionValidity(userRequest.getApplicationId(), profileId);
                    if (validity != Validity.STALE) {
                        ModelAndView mv = new ModelAndView("provider/profile/confirm_edit");
                        mv.addObject("requestType", ViewStatics.UPDATE_REQUEST);
                        mv.addObject("profileId", profileId);
                        mv.addObject("applicationId", userRequest.getApplicationId());
                        return mv;
                    }
                }
            }

            ModelAndView mv = new ModelAndView("redirect:/provider/application/edit");
            mv.addObject("profileId", profileId);
            return mv;
        }
    }
}
