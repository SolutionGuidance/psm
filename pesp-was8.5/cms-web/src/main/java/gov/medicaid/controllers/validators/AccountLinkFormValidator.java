/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.controllers.validators;

import gov.medicaid.controllers.forms.AccountLinkForm;

import org.springframework.validation.Errors;

/**
 * Account link validator.
 *
 * @author TCSASSEMBLER
 * @version 1.0
 */
public class AccountLinkFormValidator extends BaseValidator {

    /**
     * Empty constructor.
     */
    public AccountLinkFormValidator() {
    }

    /**
     * Returns true for <code>AccountLinkForm</code>.
     *
     * @param cls the class to test
     * @return true if the class is an AccountLinkForm
     */
    public boolean supports(Class<?> cls) {
        return cls.isAssignableFrom(AccountLinkForm.class);
    }

    /**
     * Performs the validations on the target object.
     *
     * @param target the object submitted
     * @param errors the binding results
     */
    public void validate(Object target, Errors errors) {
        rejectIfEmpty(errors, "systemId", "field.required", "System");
        rejectIfEmpty(errors, "accountId", "field.required", "Account Id");
        rejectIfEmpty(errors, "password", "field.required", "Password");
    }
}
