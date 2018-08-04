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

import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

/**
 * Base class for validators.
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
