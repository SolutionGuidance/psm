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

import gov.medicaid.controllers.validators.BaseValidator;
import gov.medicaid.entities.CMSUser;
import gov.medicaid.entities.dto.ViewStatics;
import gov.medicaid.services.PortalServiceConfigurationException;
import gov.medicaid.services.PortalServiceException;
import gov.medicaid.services.RegistrationService;

import java.util.Arrays;
import java.util.List;

import javax.annotation.PostConstruct;

import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

/**
 * This is the validator for User instances.
 *
 * <p>
 * <b>Thread Safety</b> This class is mutable and not thread safe, but used in thread safe manner by framework.
 * </p>
 *
 * @author argolite, TCSASSEMBLER
 * @version 1.0
 */
public class UserValidator extends BaseValidator implements Validator {

    /**
     * Regular expression pattern for email format.
     */
    private static final String EMAIL_REGEX = "(?i)[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,4}";

    /**
     * Maximum length for name fields.
     */
    private static final int NAME_MAX_LENGTH = 50;

    /**
     * Maximum length for email fields.
     */
    private static final int EMAIL_MAX_LENGTH = 100;

    /**
     * Maximum length for username fields.
     */
    private static final int USERNAME_MAX_LENGTH = 100;

    /**
     * Represents the list of valid roles (each should have the ID and name provided).
     *
     * It is injected by the container, may have any value, is fully mutable, but not expected to change after
     * dependency injection.
     */
    private static final List<String> ROLES = Arrays.asList(ViewStatics.ROLE_PROVIDER, ViewStatics.ROLE_SVC_AGENT,
        ViewStatics.ROLE_SVC_ADMIN, ViewStatics.ROLE_SYS_ADMIN);

    /**
     * Represents the user service used for validation.
     */
    private RegistrationService registrationService;

    /**
     * Empty constructor.
     */
    public UserValidator() {
    }

    /**
     * This method checks that all required injection fields are in fact provided.
     *
     * @throws PortalServiceConfigurationException - If there are required injection fields that are not injected
     */
    @PostConstruct
    protected void init() {
        if (registrationService == null) {
            throw new PortalServiceConfigurationException("registrationService must be configured.");
        }
    }

    /**
     * Can this Validator validate instances of the supplied class.
     *
     * @param clazz - the Class that this Validator is being asked if it can validate
     * @return - true if this Validator can indeed validate instances of the supplied clazz
     */
    public boolean supports(Class<?> clazz) {
        return CMSUser.class.isAssignableFrom(clazz);
    }

    /**
     * Validate the supplied target object, which must be of a Class for which the supports(Class) method typically has
     * (or would) return true. The supplied errors instance can be used to report any resulting validation errors.
     *
     * @param target - the object that is to be validated (can be null)
     * @param errors - contextual state about the validation process (never null)
     */
    public void validate(Object target, Errors errors) {
        // perform format validations
        rejectIfEmpty(errors, "firstName", "field.required", "First Name");
        rejectIfEmpty(errors, "lastName", "field.required", "Last Name");
        rejectIfEmpty(errors, "username", "field.required", "Username");
        rejectIfEmpty(errors, "email", "field.required", "Email");
        rejectIfEmpty(errors, "role.description", "field.required", "Role");

        CMSUser user = (CMSUser) target;
        if (user.getFirstName() != null && user.getFirstName().length() > NAME_MAX_LENGTH) {
            rejectValue(errors, "firstName", "length.exceeded", "First Name ", NAME_MAX_LENGTH);
        }

        if (user.getLastName() != null && user.getLastName().length() > NAME_MAX_LENGTH) {
            rejectValue(errors, "lastName", "length.exceeded", "Last Name", NAME_MAX_LENGTH);
        }

        if (user.getMiddleName() != null && user.getMiddleName().length() > NAME_MAX_LENGTH) {
            rejectValue(errors, "middleName", "length.exceeded", "Middle Name", NAME_MAX_LENGTH);
        }

        if (user.getEmail() != null && user.getEmail().length() > EMAIL_MAX_LENGTH) {
            rejectValue(errors, "email", "length.exceeded", "Email", EMAIL_MAX_LENGTH);
        }

        if (user.getUsername() != null && user.getUsername().length() > USERNAME_MAX_LENGTH) {
            rejectValue(errors, "username", "length.exceeded", "Username", USERNAME_MAX_LENGTH);
        }

        // perform logical validations
        if (!errors.hasFieldErrors("email")) {
            if (!user.getEmail().matches(EMAIL_REGEX)) {
                errors.rejectValue("email", "email.invalid", "Email must be in the format user@host.ext");
            }
        }

        if (!errors.hasFieldErrors("role.description")) {
            if (!ROLES.contains(user.getRole().getDescription())) {
                errors.rejectValue("role.description", "role.invalid", "Unrecognized role was specified.");
            }
        }

        try {
            // no two users should have the same login
            if (!errors.hasFieldErrors("username")) {
                CMSUser duplicate = registrationService.findByUsername(user.getUsername());
                if (duplicate != null && !duplicate.getUserId().equals(user.getUserId())) {
                    errors.rejectValue("username", "duplicate.username", "The requested username is already in use.");
                }
            }
        } catch (PortalServiceException e) {
            errors.rejectValue("userId", "generic.error", "Unable to process request, please try again later.");
        }
    }

    /**
     * Gets the value of the field <code>registrationService</code>.
     * @return the registrationService
     */
    public RegistrationService getRegistrationService() {
        return registrationService;
    }

    /**
     * Sets the value of the field <code>registrationService</code>.
     * @param registrationService the registrationService to set
     */
    public void setRegistrationService(RegistrationService registrationService) {
        this.registrationService = registrationService;
    }
}
