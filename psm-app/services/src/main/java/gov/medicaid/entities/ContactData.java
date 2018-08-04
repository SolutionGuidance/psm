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

package gov.medicaid.entities;


/**
 * Projection results from search of enrolled practices.
 */
public class ContactData {

    /**
     * Profile id.
     */
    private long profileId;

    /**
     * Contact name.
     */
    private String name;

    /**
     * Contact phone number.
     */
    private String phoneNumber;

    /**
     * Creates an instance using the values.
     * @param profileId assigned to the field with the same name
     * @param name assigned to the field with the same name
     */
    public ContactData(long profileId, String name) {
        super();
        this.profileId = profileId;
        this.name = name;
    }

    /**
     * Creates an instance using the values.
     * @param profileId assigned to the field with the same name
     * @param name assigned to the field with the same name
     */
    public ContactData(long profileId, String name, String phoneNumber) {
        super();
        this.profileId = profileId;
        this.name = name;
        this.phoneNumber = phoneNumber;
    }

    /**
     * Gets the value of the field <code>profileId</code>.
     * @return the profileId
     */
    public long getProfileId() {
        return profileId;
    }

    /**
     * Gets the value of the field <code>name</code>.
     * @return the name
     */
    public String getName() {
        return name;
    }

    /**
     * Gets the value of the field <code>phoneNumber</code>.
     * @return the phoneNumber
     */
    public String getPhoneNumber() {
        return phoneNumber;
    }
}
