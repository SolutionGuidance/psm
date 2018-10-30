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

package gov.medicaid.domain.rules.inference;

/**
 * This class is used by the rules to perform validation on a phone number within a context, since a phone number may
 * appear in different levels of a profile.
 */
public class PhoneNumberEntry {

    /**
     * The phone number to be checked.
     */
    private final String phoneNumber;

    /**
     * FAX number, Contact Number, etc.
     */
    private String type;

    /**
     * The path to this phone number.
     */
    private String path;

    /**
     * Prevents loops when multiple phones are present.
     */
    private String validated;

    /**
     * Creates a new instance using the given entity.
     *
     * @param type the phone number type
     * @param path the path to the field
     * @param phoneNumber the value
     */
    public PhoneNumberEntry(String type, String path, String phoneNumber) {
        this.type = type;
        this.path = path;
        this.phoneNumber = phoneNumber;
        this.validated = "N";
    }

    /**
     * Gets the value of the field <code>type</code>.
     *
     * @return the type
     */
    public String getType() {
        return type;
    }

    /**
     * Sets the value of the field <code>type</code>.
     *
     * @param type the type to set
     */
    public void setType(String type) {
        this.type = type;
    }

    /**
     * Gets the value of the field <code>path</code>.
     *
     * @return the path
     */
    public String getPath() {
        return path;
    }

    /**
     * Sets the value of the field <code>path</code>.
     *
     * @param path the path to set
     */
    public void setPath(String path) {
        this.path = path;
    }

    /**
     * Gets the value of the field <code>validated</code>.
     *
     * @return the validated
     */
    public String getValidated() {
        return validated;
    }

    /**
     * Sets the value of the field <code>validated</code>.
     *
     * @param validated the validated to set
     */
    public void setValidated(String validated) {
        this.validated = validated;
    }

    /**
     * Gets the value of the field <code>phoneNumber</code>.
     *
     * @return the phoneNumber
     */
    public String getPhoneNumber() {
        return phoneNumber;
    }
}
