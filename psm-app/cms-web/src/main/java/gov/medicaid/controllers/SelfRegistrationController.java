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

import gov.medicaid.controllers.forms.RegistrationForm;
import gov.medicaid.controllers.validators.RegistrationFormValidator;
import gov.medicaid.entities.CMSUser;
import gov.medicaid.services.PortalServiceConfigurationException;
import gov.medicaid.services.PortalServiceException;
import gov.medicaid.services.RegistrationService;
import gov.medicaid.services.util.Util;

import java.io.UnsupportedEncodingException;

import javax.annotation.PostConstruct;

import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

/**
 * Handles self-registration flow.
 *
 * @author TCSASSEMBLER
 * @version 1.0
 * @endpoint "/accounts/*"
 */
@Controller
@RequestMapping("/accounts/*")
public class SelfRegistrationController extends BaseController {

    /**
     * Registration service.
     */
    private RegistrationService registrationService;

    /**
     * Validator.
     */
    private RegistrationFormValidator validator;

    /**
     * Empty constructor.
     */
    public SelfRegistrationController() {
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
            throw new PortalServiceConfigurationException("registrationService is not configured correctly.");
        }

        if (validator == null) {
            throw new PortalServiceConfigurationException("validator is not configured correctly.");
        }
    }

    /**
     * Loads the registration form.
     *
     * @return the view and model for the registration page.
     * @endpoint "/accounts/new"
     * @verb GET
     */
    @RequestMapping(value = "/accounts/new", method = RequestMethod.GET)
    public ModelAndView viewRegistrationForm() {
        ModelAndView mv = new ModelAndView("accounts/register");
        mv.addObject("registrant", new RegistrationForm());
        return mv;
    }

    /**
     * Processes the registration form.
     *
     * @param registrant the submitted form
     * @param errors the bidning results
     * @return the view and model for the registration result.
     * @throws PortalServiceException for non-recoverable errors encountered
     * @throws UnsupportedEncodingException if the system does not support UTF-8
     * @endpoint "/accounts/new"
     * @verb POST
     */
    @RequestMapping(value = "/accounts/new", method = RequestMethod.POST)
    public ModelAndView processRegistrationForm(@ModelAttribute("registrant") RegistrationForm registrant,
        BindingResult errors)
        throws PortalServiceException, UnsupportedEncodingException {

        validator.validate(registrant, errors);

        if (errors.hasErrors()) {
            // show input page
            ModelAndView mv = new ModelAndView("accounts/register");
            mv.addObject("registrant", registrant);
            return mv;
        } else {
            // register user
            CMSUser user = bindToModel(registrant);
            String userId = registrationService.register(user);

            String username = user.getUsername();
            String token = Util.hash(user.getUsername(), userId);
            ModelAndView mv = new ModelAndView("redirect:/accounts/confirm");
            mv.addObject("id", username);
            mv.addObject("token", token);
            return mv;
        }
    }

    /**
     * Loads the registration success page.
     *
     * @param username the registered name
     * @param token the result token
     * @return the view and model for the registration page.
     * @throws PortalServiceException for any errors encountered
     * @throws UnsupportedEncodingException if the system does not support UTF-8
     * @endpoint "/accounts/confirm"
     * @verb GET
     */
    @RequestMapping(value = "/accounts/confirm", method = RequestMethod.GET)
    public ModelAndView viewRegisterSuccess(@RequestParam("id") String username, @RequestParam("token") String token)
        throws PortalServiceException, UnsupportedEncodingException {

        CMSUser user = registrationService.findByUsername(username);
        if (user == null) {
            // should never reach this page if the user is not found
            throw new PortalServiceException("Invalid navigation path.");
        }

        String verify = Util.hash(user.getUsername(), user.getUserId());
        if (!verify.equals(token)) {
            throw new PortalServiceException("Invalid navigation path.");
        }

        ModelAndView mv = new ModelAndView("accounts/register_success");
        mv.addObject("account", user);
        return mv;
    }

    /**
     * Binds the given form to the persistent model.
     *
     * @param registrant the form to be bound
     * @return the bound data model
     */
    private CMSUser bindToModel(RegistrationForm registrant) {
        CMSUser user = new CMSUser();
        user.setFirstName(registrant.getFirstName());
        user.setLastName(registrant.getLastName());
        user.setMiddleName(registrant.getMiddleName());
        user.setUsername(registrant.getUsername());
        user.setEmail(registrant.getEmail());
        return user;
    }

    /**
     * Sets the value of the field <code>registrationService</code>.
     *
     * @param registrationService the registrationService to set
     */
    public void setRegistrationService(RegistrationService registrationService) {
        this.registrationService = registrationService;
    }

    /**
     * Sets the value of the field <code>validator</code>.
     *
     * @param validator the validator to set
     */
    public void setValidator(RegistrationFormValidator validator) {
        this.validator = validator;
    }
}
