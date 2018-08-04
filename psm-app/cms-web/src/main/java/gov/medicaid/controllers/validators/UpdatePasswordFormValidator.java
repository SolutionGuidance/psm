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
 * Validator for updating passwords.
 */
@Component
public class UpdatePasswordFormValidator extends BaseValidator {

    /**
     * Empty constructor.
     */
    public UpdatePasswordFormValidator() {
    }

    /**
     * Returns true for <code>UpdatePasswordForm</code>.
     *
     * @param cls the class to test
     * @return true if the class is an UpdatePasswordForm
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
        rejectIfEmpty(errors, "oldPassword", "field.required", "Old Password");
        rejectIfEmpty(errors, "password", "field.required", "Password");

        UpdatePasswordForm form = (UpdatePasswordForm) target;
        if (!errors.hasFieldErrors("password")) {
            if (!form.getPassword().equals(form.getConfirmPassword())) {
                rejectValue(errors, "password", "password.mismatch");
            }
        }
    }

}
