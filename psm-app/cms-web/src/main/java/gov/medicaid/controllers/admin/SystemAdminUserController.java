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
import gov.medicaid.entities.Role;
import gov.medicaid.entities.SearchResult;
import gov.medicaid.entities.UserSearchCriteria;
import gov.medicaid.entities.dto.ViewStatics;
import gov.medicaid.services.LookupService;
import gov.medicaid.services.PortalServiceException;
import gov.medicaid.services.RegistrationService;
import gov.medicaid.services.util.Util;

import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.Arrays;

/**
 * This controller class that manages users, all 4 types of them. Changes in 1.1: update search to add initSearchBox
 * parameter.
 * <p>
 * <b>Thread Safety</b> This class is mutable and not thread safe, but used in thread safe manner by framework.
 * </p>
 *
 * @endpoint "/system/user/*"
 */
@Controller
@RequestMapping("/system/user/*")
public class SystemAdminUserController {

    /**
     * Maximum password length.
     */
    private static final int PASSWD_MAX_LENGTH = 100;

    /**
     * Default page size displayed.
     */
    private static final int DEFAULT_PAGE_SIZE = 10;

    private final LookupService lookupService;

    private final RegistrationService registrationService;

    /**
     * The validator for user parameters.
     */
    private final UserValidator userValidator;

    public SystemAdminUserController(
        LookupService lookupService,
        RegistrationService registrationService,
        UserValidator userValidator
    ) {
        this.lookupService = lookupService;
        this.registrationService = registrationService;
        this.userValidator = userValidator;
    }

    /**
     * This action will load the providers' page.
     *
     * @return the model and view instance that contains the name of view to be rendered and data to be used for
     *         rendering (not null)
     * @throws PortalServiceException - If there are any errors in the action
     * @endpoint "/system/user/list"
     */
    @RequestMapping("/list")
    public ModelAndView view() throws PortalServiceException {
        ModelAndView mv = loadUserManagement(ViewStatics.ROLE_PROVIDER, null);
        return mv;
    }

    /**
     * This action will search for users. Changes in 1.1: add initSearchBox parameter.
     *
     * @param role - the role being managed
     * @param initSearchBox - the initialize search box flag
     * @param criteria - the search criteria
     * @return - the model and view instance that contains the name of view to be rendered and data to be used for
     *         rendering (not null)
     *
     * @throws IllegalArgumentException - if role is not one of the four configured roles, or if the criteria is null
     * @throws PortalServiceException - If there are any errors in the action
     * @endpoint "/system/user/search"
     */
    @RequestMapping("/search")
    public ModelAndView search(@RequestParam("role") String role,
        @RequestParam(value = "initSearchBox", required = false, defaultValue = "false") boolean initSearchBox,
        UserSearchCriteria criteria) throws PortalServiceException {

        checkRoleParameter(role);
        if (criteria == null) {
            throw new IllegalArgumentException("Argument 'criteria' cannot be null.");
        }

        ModelAndView mv = loadUserManagement(role, criteria);
        if (initSearchBox) { // if it's search from search box
            mv.addObject("searchFirstName", criteria.getFirstName());
            criteria.setLastName("");
            criteria.setFirstName("");
            mv.addObject("searchedResult", true);
        }
        return mv;
    }

    /**
     * This action will get the entity with the given ID.
     *
     * @param role - the role being managed
     * @param userId - the entity ID
     *
     * @return - the model and view instance that contains the name of view to be rendered and data to be used for
     *         rendering (not null)
     *
     * @throws IllegalArgumentException - if role is not one of the four configured roles
     * @throws PortalServiceException - If there are any errors in the action
     * @endpoint "/system/user/details"
     */
    @RequestMapping("/details")
    public ModelAndView get(@RequestParam("role") String role, @RequestParam("userId") String userId)
        throws PortalServiceException {
        checkRoleParameter(role);

        String viewName = "admin/user-account-details-system-admin";
        ModelAndView mv = loadUser(viewName, role, userId);

        return mv;
    }

    /**
     * This action will begin the edit process by getting the entity with the given ID.
     *
     * @param role - the role being managed
     * @param userId - the entity ID
     * @return - the model and view instance that contains the name of view to be rendered and data to be used for
     *         rendering (not null)
     *
     * @throws IllegalArgumentException - if role is not one of the four configured roles
     * @throws PortalServiceException - If there are any errors in the action
     * @endpoint "/system/user/edit"
     * @endpoint "/system/user/new"
     * @verb GET
     */
    @RequestMapping(value = { "/edit", "/new" }, method = RequestMethod.GET)
    public ModelAndView beginEdit(@RequestParam("role") String role,
        @RequestParam(value = "userId", required = false) String userId) throws PortalServiceException {
        checkRoleParameter(role);

        String viewName = "admin/user-account-edit-system-admin";
        ModelAndView mv = loadUser(viewName, role, userId);

        return mv;
    }

    /**
     * This action will create the entity.
     *
     * @param role - the role being managed
     * @param password - the password for the new user
     * @param password2 - the confirmed password for the new user
     * @param user - the user
     * @param errors - the framework binding results
     * @return - the model and view instance that contains the name of view to be rendered and data to be used for
     *         rendering (not null)
     *
     *
     * @throws IllegalArgumentException - if role is not one of the four configured roles, if user is null/empty
     * @throws PortalServiceException - If there are any errors in the action
     * @endpoint "/system/user/new"
     * @verb POST
     */
    @RequestMapping(value = "/new", method = RequestMethod.POST)
    public ModelAndView create(
            @RequestParam(value = "roleName") String role,
            @RequestParam(value = "password", required = false) String password,
            @RequestParam(value = "password2", required = false) String password2,
            @ModelAttribute("user") CMSUser user,
            BindingResult errors
    ) throws PortalServiceException {

        checkRoleParameter(role);
        if (user == null) {
            throw new IllegalArgumentException("Argument 'user' cannot be null.");
        }

        ModelAndView mv = null;
        userValidator.validate(user, errors);
        if (password == null || password.trim().length() == 0) {
            errors.rejectValue("userId", "field.required", new Object[]{"Password"}, "Enter a valid password.");
        } else if (!password.equals(password2)) {
            // if first and second password don't match, throw an error
            errors.rejectValue("userId", "password.mismatch");
        } else {
            if (password.length() > PASSWD_MAX_LENGTH) {
                // password is not stored in the domain model so just mark the id
                errors.rejectValue("userId", "lengthexceeded", "Password length cannot exceed " + PASSWD_MAX_LENGTH
                    + " characters.");
            }
        }

        CMSUser actor = ControllerHelper.getCurrentUser();
        if (errors.hasErrors()) {
            mv = new ModelAndView("admin/user-account-edit-system-admin");
            mv.addObject("user", user);
            mv.addObject("role", role);
            mv.addObject("availableRoles", lookupService.findAllLookups(Role.class));
        } else {
            String userId = registrationService.registerByAdmin(actor, user, password);
            String viewName = "admin/user-account-details-system-admin";
            mv = loadUser(viewName, role, userId);
        }

        return mv;
    }

    /**
     * This action will save the entity.
     *
     * @param role - the role being managed
     * @param user - the user
     * @param password - the new password (if any)
     * @param errors - the framework binding results
     * @return - the model and view instance that contains the name of view to be rendered and data to be used for
     *         rendering (not null)
     *
     * @throws IllegalArgumentException - if role is not one of the four configured roles, if user is null
     * @throws PortalServiceException - If there are any errors in the action
     * @endpoint "/system/user/edit"
     * @verb POST
     */
    @RequestMapping(value = "/edit", method = RequestMethod.POST)
    public ModelAndView edit(@RequestParam("roleName") String role,
        @RequestParam(value = "password", required = false) String password, @ModelAttribute("user") CMSUser user,
        BindingResult errors) throws PortalServiceException {

        checkRoleParameter(role);
        if (user == null) {
            throw new IllegalArgumentException("Argument 'user' cannot be null.");
        }

        ModelAndView mv = null;
        userValidator.validate(user, errors);
        if (Util.isNotBlank(password)) {
            if (password.length() > PASSWD_MAX_LENGTH) {
                // password is not stored in the domain model so just mark the id
                errors.rejectValue("userId", "lengthexceeded", "Password length cannot exceed " + PASSWD_MAX_LENGTH
                    + " characters.");
            }
        }
        if (errors.hasErrors()) {
            mv = new ModelAndView("admin/user-account-edit-system-admin");
            mv.addObject("role", role);
            mv.addObject("user", user);
            mv.addObject("availableRoles", lookupService.findAllLookups(Role.class));
        } else {
            CMSUser actor = ControllerHelper.getCurrentUser();
            String userId = registrationService.updateByAdmin(actor, user, password);
            String viewName = "admin/user-account-details-system-admin";
            mv = loadUser(viewName, role, userId);
        }

        return mv;
    }

    /**
     * This action will delete the entities with the given IDs.
     *
     * @param role - the role being managed
     * @param userIds - the entity IDs
     *
     * @throws IllegalArgumentException - if role is not one of the four configured roles
     * @throws PortalServiceException - If there are any errors in the action
     * @endpoint "/system/user/delete"
     */
    @RequestMapping(value = "/delete", method = RequestMethod.POST)
    @ResponseBody
    public void delete(@RequestParam("role") String role, @RequestParam("userIds") String[] userIds)
        throws PortalServiceException {
        checkRoleParameter(role);
        if (userIds == null) {
            throw new IllegalArgumentException("Argument 'userIds' cannot be null.");
        }

        CMSUser actor = ControllerHelper.getCurrentUser();
        registrationService.unregisterUsers(actor.getUserId(), userIds);
    }

    /**
     * This action will disable the user with the given ID.
     *
     * @param userId - the user Id
     * @return the model and view instance that contains the name of view to be rendered and data to be used for
     *         rendering (not null)
     */
    @RequestMapping(value = "/suspend", method = RequestMethod.POST)
    @ResponseBody
    public void disable(@RequestParam("userId") String userId) {
        CMSUser actor = ControllerHelper.getCurrentUser();
        registrationService.suspend(actor, userId);
    }

    /**
     * This action will enable the user with the given ID.
     *
     * @param userId - the user Id
     * @return the model and view instance that contains the name of view to be rendered and data to be used for
     *         rendering (not null)
     */
    @RequestMapping(value = "/reinstate", method = RequestMethod.POST)
    @ResponseBody
    public void reinstate(@RequestParam("userId") String userId) {
        CMSUser actor = ControllerHelper.getCurrentUser();
        registrationService.reinstate(actor, userId);
    }

    /**
     * Loads the user with the given id into a ModelAndView.
     *
     * @param viewName the name of the view
     * @param role the role being managed
     * @param userId the user to be loaded
     * @return the model and view with the role and user in the context
     * @throws PortalServiceException for any errors encountered
     * @throws IllegalArgumentException if the role is not one of the configured types
     */
    private ModelAndView loadUser(String viewName, String role, String userId) throws PortalServiceException {
        CMSUser user;
        if (!Util.isBlank(userId)) {
            user = registrationService.findByUserId(userId);
        } else {
            user = new CMSUser();
            user.setRole(new Role());
            user.getRole().setDescription(role);
        }
        ModelAndView mv = new ModelAndView(viewName);
        mv.addObject("user", user);
        mv.addObject("role", role);
        mv.addObject("availableRoles", lookupService.findAllLookups(Role.class));
        return mv;
    }

    /**
     * Prepares the model and view for the user management page.
     *
     * @param role the role currently active in the screen
     * @param criteria the current criteria
     * @return the model and view for the manage users screen
     * @throws PortalServiceException for any errors encountered
     */
    private ModelAndView loadUserManagement(String role, UserSearchCriteria criteria) throws PortalServiceException {
        if (criteria == null) {
            criteria = new UserSearchCriteria();
            criteria.setRoles(Arrays.asList(role));
            criteria.setPageNumber(1);
            criteria.setPageSize(DEFAULT_PAGE_SIZE);
        } else if (criteria.getPageNumber() == 0) {
            // To detect if pageNumber and pageSize were not set, we check for
            // pageNumber == 0 (the Java default for int). (pageSize is set to
            // 0 when 'show all' option is selected.)
            criteria.setPageNumber(1);
            criteria.setPageSize(DEFAULT_PAGE_SIZE);
            if (null == criteria.getRoles() || criteria.getRoles().isEmpty()) {
                criteria.setRoles(Arrays.asList(role));
            }
        }
        SearchResult<CMSUser> results = registrationService.findUsersByCriteria(criteria);
        ModelAndView mv = new ModelAndView("admin/user-account-system-admin");
        if (criteria.isSearchBox()) {
            mv.setViewName("admin/search-result-system-admin");
        }
        mv.addObject("results", results);
        mv.addObject("role", role);
        mv.addObject("criteria", criteria);
        ControllerHelper.addPaginationDetails(results, mv);
        ControllerHelper.addPaginationLinks(results, mv);
        return mv;
    }

    /**
     * Asserts that the given role is one of the supported types.
     *
     * @param role - the role to be checked
     * @throws IllegalArgumentException if the role is not one of the configured types
     */
    private void checkRoleParameter(String role) {
        if (!ViewStatics.ROLE_PROVIDER.equals(role)
                && !ViewStatics.ROLE_SERVICE_AGENT.equals(role)
                && !ViewStatics.ROLE_SERVICE_ADMINISTRATOR.equals(role)
                && !ViewStatics.ROLE_SYSTEM_ADMINISTRATOR.equals(role)) {
            throw new IllegalArgumentException("Unrecognized 'role' argument was provided.");
        }
    }
}
