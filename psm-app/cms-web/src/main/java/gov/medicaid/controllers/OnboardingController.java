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

import gov.medicaid.controllers.forms.AccountLinkForm;
import gov.medicaid.controllers.validators.AccountLinkFormValidator;
import gov.medicaid.entities.CMSUser;
import gov.medicaid.entities.ExternalAccountLink;
import gov.medicaid.entities.ProviderProfile;
import gov.medicaid.entities.SystemId;
import gov.medicaid.security.CMSPrincipal;
import gov.medicaid.services.OnboardingService;
import gov.medicaid.services.PortalServiceConfigurationException;
import gov.medicaid.services.PortalServiceException;
import gov.medicaid.services.RegistrationService;
import gov.medicaid.services.util.Util;

import java.util.List;

import javax.annotation.PostConstruct;

import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

/**
 * Handles data import flows.
 *
 * @author TCSASSEMBLER
 * @version 1.0
 * @endpoint "/provider/onboarding/*"
 */
@Controller
@RequestMapping("/provider/onboarding/*")
public class OnboardingController extends BaseController {

    /**
     * Onboarding data service.
     */
    private OnboardingService onboardingService;

    /**
     * Registration service.
     */
    private RegistrationService registrationService;

    /**
     * Account link validator.
     */
    private AccountLinkFormValidator validator;

    /**
     * Empty constructor.
     */
    public OnboardingController() {
    }

    /**
     * This method checks that all required injection fields are in fact provided.
     *
     * @throws PortalServiceConfigurationException - If there are required injection fields that are not injected
     */
    @PostConstruct
    protected void init() {
        super.init();
        if (onboardingService == null) {
            throw new PortalServiceConfigurationException("onboardingService is not configured correctly.");
        }
        if (registrationService == null) {
            throw new PortalServiceConfigurationException("registrationService is not configured correctly.");
        }
        if (validator == null) {
            throw new PortalServiceConfigurationException("validator is not configured correctly.");
        }
    }

    /**
     * Shows the external profiles found.
     *
     * @param systemId the system to search on
     * @param accountId the account id to use
     * @return the external profiles listing
     * @throws PortalServiceException for any errors encountered
     * @endpoint "/provider/onboarding/list"
     * @verb GET
     */
    @RequestMapping(value = "/list", method = RequestMethod.GET)
    public ModelAndView listExternalProfiles(@RequestParam(value = "systemId", required = false) String systemId,
        @RequestParam(value = "accountId", required = false) String accountId) throws PortalServiceException {

        CMSPrincipal principal = ControllerHelper.getPrincipal();
        SystemId sourceSystem = principal.getAuthenticatedBySystem();

        // for externally authenticated users, only current system id can be used
        if (sourceSystem != SystemId.CMS_ONLINE) {
            systemId = sourceSystem.name();
            accountId = principal.getUsername();
        }

        if (Util.isBlank(systemId) || Util.isBlank(accountId)) { // JSP should never generate invalid links
            throw new PortalServiceException("Invalid navigation path.");
        }

        ExternalAccountLink link = retrieveAccountLink(principal.getUser().getUserId(), systemId, accountId);
        List<ProviderProfile> profiles = onboardingService.findProfiles(link);
        ModelAndView mv = new ModelAndView("provider/onboarding/profiles");
        mv.addObject("systemId", link.getSystemId().name());
        mv.addObject("accountId", link.getExternalUserId());
        mv.addObject("hash", Util.hash(systemId + accountId, principal.getLoginDate().toString()));
        mv.addObject("profiles", profiles);
        return mv;
    }

    /**
     * Imports the user selection.
     *
     * @param systemId the system to search on
     * @param accountId the account id to use
     * @param hash hash verification
     * @param externalProfileIds the selection
     * @return back to the listing page
     * @throws PortalServiceException for any errors encountered
     * @endpoint "/provider/onboarding/list"
     * @verb POST
     */
    @RequestMapping(value = "/list", method = RequestMethod.POST)
    public ModelAndView importExternalProfiles(@RequestParam("systemId") String systemId,
        @RequestParam("accountId") String accountId, @RequestParam("hash") String hash,
        @RequestParam(value = "profileIds", required = false) String[] externalProfileIds)
        throws PortalServiceException {

        CMSPrincipal principal = ControllerHelper.getPrincipal();
        String expected = Util.hash(systemId + accountId, principal.getLoginDate().toString());
        if (!expected.equals(hash)) {
            throw new PortalServiceException("Rejecting expired/tampered request.");
        }

        CMSUser user = principal.getUser();
        ExternalAccountLink link = retrieveAccountLink(user.getUserId(), systemId, accountId);
        if (externalProfileIds != null && externalProfileIds.length > 0) {
            int count = onboardingService.importProfiles(user, link, externalProfileIds);
            ControllerHelper.flashInfo("Sucessfully imported " + count + " profile(s).");
        } else {
            ControllerHelper.flashError("Please select profiles to be imported.");
        }
        ModelAndView mv = new ModelAndView("redirect:/provider/onboarding/list");
        if (principal.getAuthenticatedBySystem() == SystemId.CMS_ONLINE) {
            mv.addObject("systemId", link.getSystemId().name());
            mv.addObject("accountId", link.getExternalUserId());
        }
        return mv;
    }

    /**
     * Finds the account link with the given values.
     * @param userId the user id
     * @param systemId the external system
     * @param externalAccountId the external account id
     * @return the matching record
     * @throws PortalServiceException if the record is not found or cannot be retrieved
     */
    private ExternalAccountLink retrieveAccountLink(String userId, String systemId, String externalAccountId)
        throws PortalServiceException {
        SystemId system = SystemId.valueOf(systemId);
        ExternalAccountLink extAcct = registrationService.findAccountLink(userId, system, externalAccountId);
        if (extAcct == null) {
            throw new PortalServiceException("User does not have an account link to specified system.");
        }

        ExternalAccountLink link = new ExternalAccountLink();
        link.setSystemId(system);
        link.setUserId(extAcct.getUserId());
        link.setExternalUserId(externalAccountId);
        return link;
    }

    /**
     * Shows the external account link page.
     *
     * @return the page to get the account details.
     * @throws PortalServiceException for any errors encountered
     * @endpoint "/provider/onboarding/link"
     * @verb GET
     */
    @RequestMapping(value = "/link", method = RequestMethod.GET)
    public ModelAndView viewLinkCreation() throws PortalServiceException {
        if (ControllerHelper.getPrincipal().getAuthenticatedBySystem() != SystemId.CMS_ONLINE) {
            throw new PortalServiceException("Cannot link accounts to an external user.");
        }
        return renderAccountLinkForm(new AccountLinkForm());
    }

    /**
     * Processes the submitted account information.
     *
     * @param accountLinkForm the account link
     * @param errors the binding results
     * @return the view to list the profiles for the account, or back to the input if request is not valid
     * @throws PortalServiceException for any errors encountered
     * @endpoint "/provider/onboarding/link"
     * @verb POST
     */
    @RequestMapping(value = "/link", method = RequestMethod.POST)
    public ModelAndView processLinkCreation(@ModelAttribute("accountLink") AccountLinkForm accountLinkForm,
        BindingResult errors) throws PortalServiceException {
        if (ControllerHelper.getPrincipal().getAuthenticatedBySystem() != SystemId.CMS_ONLINE) {
            throw new PortalServiceException("Cannot link accounts to an external user.");
        }

        validator.validate(accountLinkForm, errors);

        if (errors.hasErrors()) {
            return renderAccountLinkForm(accountLinkForm);
        }

        ExternalAccountLink link = bindToModel(accountLinkForm);

        // check permission to link
        boolean valid = onboardingService.verifyCredentials(link, accountLinkForm.getPassword());
        if (!valid) {
            errors.rejectValue("accountId", "invalid.credentials");
            return renderAccountLinkForm(accountLinkForm);
        }

        CMSUser user = ControllerHelper.getCurrentUser();
        registrationService.addAccountLink(user.getUserId(), link);
        ModelAndView mv = new ModelAndView("redirect:/provider/onboarding/list");
        mv.addObject("systemId", link.getSystemId().name());
        mv.addObject("accountId", link.getExternalUserId());
        return mv;
    }

    /**
     * Renders the account link form with the given model.
     * @param accountLinkForm the form to bind
     * @return the model and view for account linking
     */
    private ModelAndView renderAccountLinkForm(AccountLinkForm accountLinkForm) {
        ModelAndView mv = new ModelAndView("provider/onboarding/create_link");
        mv.addObject("accountLink", accountLinkForm);
        return mv;
    }

    /**
     * Binds the given form into the persistent model.
     * @param accountLinkForm the form to bind
     * @return the bound model
     */
    private ExternalAccountLink bindToModel(AccountLinkForm accountLinkForm) {
        ExternalAccountLink link = new ExternalAccountLink();
        link.setExternalUserId(accountLinkForm.getAccountId());
        link.setSystemId(SystemId.valueOf(accountLinkForm.getSystemId()));
        return link;
    }

    /**
     * Sets the value of the field <code>onboardingService</code>.
     *
     * @param onboardingService the onboardingService to set
     */
    public void setOnboardingService(OnboardingService onboardingService) {
        this.onboardingService = onboardingService;
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
    public void setValidator(AccountLinkFormValidator validator) {
        this.validator = validator;
    }
}
