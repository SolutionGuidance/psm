/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.controllers.validators;

import gov.medicaid.controllers.forms.UpdatePasswordForm;

import org.springframework.validation.Errors;

/**
 * Validator for updating passwords.
 *
 * @author TCSASSEMBLER
 * @version 1.0
 */
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
