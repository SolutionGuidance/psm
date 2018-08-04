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

package gov.medicaid.controllers.validators;

import gov.medicaid.controllers.forms.RegistrationForm;
import gov.medicaid.entities.CMSUser;
import gov.medicaid.services.RegistrationService;

import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;

/**
 * Registration request validator.
 */
@Component
public class RegistrationFormValidator extends BaseValidator {

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
     * The registration service used for data checks.
     */
    private final RegistrationService registrationService;

    public RegistrationFormValidator(RegistrationService registrationService) {
        this.registrationService = registrationService;
    }

    /**
     * Returns true for <code>RegistrationForm</code>.
     *
     * @param cls the class to test
     * @return true if the class is an RegistrationForm
     */
    public boolean supports(Class<?> cls) {
        return cls.isAssignableFrom(RegistrationForm.class);
    }

    /**
     * Performs the validations on the target object.
     *
     * @param target the object submitted
     * @param errors the binding results
     */
    public void validate(Object target, Errors errors) {
        // perform format validations
        rejectIfEmpty(errors, "username", "field.required", "Username");
        rejectIfEmpty(errors, "firstName", "field.required", "First Name");
        rejectIfEmpty(errors, "lastName", "field.required", "Last Name");
        rejectIfEmpty(errors, "email", "field.required", "Email");

        RegistrationForm user = (RegistrationForm) target;

        if (user.getUsername() != null && user.getUsername().length() > USERNAME_MAX_LENGTH) {
            rejectValue(errors, "username", "length.exceeded", "Username", USERNAME_MAX_LENGTH);
        }
        if (user.getFirstName() != null && user.getFirstName().length() > NAME_MAX_LENGTH) {
            rejectValue(errors, "firstName", "length.exceeded", "First Name", NAME_MAX_LENGTH);
        }

        if (user.getMiddleName() != null && user.getMiddleName().length() > NAME_MAX_LENGTH) {
            rejectValue(errors, "middleName", "length.exceeded", "Middle Name", NAME_MAX_LENGTH);
        }
        if (user.getLastName() != null && user.getLastName().length() > NAME_MAX_LENGTH) {
            rejectValue(errors, "lastName", "length.exceeded", "Last Name", NAME_MAX_LENGTH);
        }

        if (user.getEmail() != null && user.getEmail().length() > EMAIL_MAX_LENGTH) {
            rejectValue(errors, "email", "length.exceeded", "Email", NAME_MAX_LENGTH);
        }

        // perform logical validations
        if (!errors.hasFieldErrors("email")) {
            if (!user.getEmail().matches(EMAIL_REGEX)) {
                rejectValue(errors, "email", "email.invalid", "Email");
            }
        }

        // no two users should have the same login
        if (!errors.hasFieldErrors("username")) {
            CMSUser duplicate = registrationService.findByUsername(user.getUsername());
            if (duplicate != null) {
                errors.rejectValue("username", "duplicate.username");
            }
        }
    }
}
