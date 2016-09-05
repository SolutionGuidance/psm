/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.controllers.validators;

import gov.medicaid.controllers.forms.UpdatePasswordForm;

import org.springframework.validation.Errors;

/**
 * Password reset request validator.
 *
 * @author TCSASSEMBLER
 * @version 1.0
 */
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
        rejectIfEmpty(errors, "username", "field.required", "User Name");
        rejectIfEmpty(errors, "email", "field.required", "Email");
    }

}
