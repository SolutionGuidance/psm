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

package gov.medicaid.binders;

/**
 * Exception for invalid data formats.
 */
public class BinderException extends Exception {

    /**
     * Cause of the bind exception.
     */
    private String parameterKey;

    /**
     * Cause of the bind exception.
     */
    private String parameterValue;

    /**
     * Creates an exception with the given message.
     * @param message the error message
     */
    public BinderException(String message) {
        super(message);
    }

    /**
     * Creates an exception with the given message and cause.
     * @param message the error message
     * @param cause the underlying cause
     */
    public BinderException(String message, Throwable cause) {
        super(message, cause);
    }

    public void setAttribute(String parameterKey, String parameterValue) {
        this.parameterKey = parameterKey;
        this.parameterValue = parameterValue;
    }

    /**
     * Gets the value of the field <code>parameterKey</code>.
     * @return the parameterKey
     */
    public String getParameterKey() {
        return parameterKey;
    }

    /**
     * Sets the value of the field <code>parameterKey</code>.
     * @param parameterKey the parameterKey to set
     */
    public void setParameterKey(String parameterKey) {
        this.parameterKey = parameterKey;
    }

    /**
     * Gets the value of the field <code>parameterValue</code>.
     * @return the parameterValue
     */
    public String getParameterValue() {
        return parameterValue;
    }

    /**
     * Sets the value of the field <code>parameterValue</code>.
     * @param parameterValue the parameterValue to set
     */
    public void setParameterValue(String parameterValue) {
        this.parameterValue = parameterValue;
    }
}
