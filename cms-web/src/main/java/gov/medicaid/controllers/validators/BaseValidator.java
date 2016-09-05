/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.controllers.validators;

import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

/**
 * Base class for validators.
 *
 * @author TCSASSEMBLER
 * @version 1.0
 */
public abstract class BaseValidator implements Validator {

    /**
     * Empty constructor.
     */
    protected BaseValidator() {
    }

    /**
     * Rejects the field if the value is missing.
     * @param errors the current errors
     * @param fld the field path
     * @param code the error message code
     * @param args the message arguments
     */
    protected void rejectIfEmpty(Errors errors, String fld, String code, Object... args) {
        ValidationUtils.rejectIfEmptyOrWhitespace(errors, fld, code, args);
    }

    /**
     * Rejects the values with the given message.
     * @param errors the current errors
     * @param fld the field path
     * @param code the error message code
     * @param args the message arguments
     */
    protected void rejectValue(Errors errors, String fld, String code, Object... args) {
        errors.rejectValue(fld, code, args, code);
    }

}
