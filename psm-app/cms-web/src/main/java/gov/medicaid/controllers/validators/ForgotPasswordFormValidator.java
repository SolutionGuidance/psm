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

import gov.medicaid.controllers.forms.UpdatePasswordForm;

import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;

/**
 * Password reset request validator.
 */
@Component
public class ForgotPasswordFormValidator extends BaseValidator {

    /**
     * Empty constructor.
     */
    public ForgotPasswordFormValidator() {
    }

    /**
     * Returns true for <code>ForgotPasswordForm</code>.
     *
     * @param cls the class to test
     * @return true if the class is an RegistrationForm
     */
    public boolean supports(Class<?> cls) {
        return cls.isAssignableFrom(UpdatePasswordForm.class);
    }

    /**
     * Performs the validations on the target object.
     *
     * @param target the object submitted
     * @param errors the binding results
     */
    public void validate(Object target, Errors errors) {
        rejectIfEmpty(errors, "username", "field.required", "Username");
        rejectIfEmpty(errors, "email", "field.required", "Email");
    }

}
