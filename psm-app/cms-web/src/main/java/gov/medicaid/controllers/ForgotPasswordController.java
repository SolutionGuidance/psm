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

import gov.medicaid.controllers.forms.ForgotPasswordForm;
import gov.medicaid.controllers.validators.ForgotPasswordFormValidator;
import gov.medicaid.services.PortalServiceException;
import gov.medicaid.services.RegistrationService;

import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

/**
 * Handles requests to regenerated passwords.
 *
 * @endpoint "/forgotpassword"
 */
@Controller
@RequestMapping("/forgotpassword")
public class ForgotPasswordController extends BaseController {
    private final RegistrationService registrationService;
    private final ForgotPasswordFormValidator validator;

    public ForgotPasswordController(
        RegistrationService registrationService,
        ForgotPasswordFormValidator validator
    ) {
        this.registrationService = registrationService;
        this.validator = validator;
    }

    /**
     * Renders the form entry page.
     *
     * @return the form entry.
     * @throws PortalServiceException for any errors encountered
     * @verb GET
     */
    @RequestMapping(method = RequestMethod.GET)
    public ModelAndView viewPasswordChange() throws PortalServiceException {
        return renderForgotPassword(new ForgotPasswordForm());
    }

    /**
     * Renders the form entry page with the given form bound to controls..
     *
     * @param form the form to display
     * @return the form entry with the bound form
     */
    private ModelAndView renderForgotPassword(ForgotPasswordForm form) {
        ModelAndView mv = new ModelAndView("forgot_password");
        mv.addObject("passwordForm", form);
        return mv;
    }

    /**
     * Handles the form submission.
     *
     * @param form the submitted form
     * @param errors the binding results
     * @return the redirect to the login page if successful or back to the input if not.
     * @throws PortalServiceException for any errors encountered
     * @verb POST
     */
    @RequestMapping(method = RequestMethod.POST)
    public ModelAndView processPasswordChange(@ModelAttribute("passwordForm") ForgotPasswordForm form,
        BindingResult errors) throws PortalServiceException {
        validator.validate(form, errors);

        if (errors.hasErrors()) {
            return renderForgotPassword(form);
        } else {
            boolean reset = registrationService.resetPassword(form.getUsername(), form.getEmail());

            if (!reset) {
                ControllerHelper.flashError("We could not retrieve your account.");
                return renderForgotPassword(form);
            }

            ControllerHelper.flashInfo("Your password has been reset, "
                + "please check your email for the new login information.");
            return new ModelAndView("redirect:/login");
        }
    }
}
