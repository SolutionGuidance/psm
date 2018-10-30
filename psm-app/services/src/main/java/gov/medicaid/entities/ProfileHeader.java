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

import java.util.Date;

/**
 * Search result container for profiles.
 */
public class ProfileHeader {

    /**
     * The profile id.
     */
    private long profileId;

    /**
     * NPI.
     */
    private String npi;

    /**
     * Provider type.
     */
    private String providerType;

    /**
     * Effective date.
     */
    private Date effectiveDate;

    /**
     * Last modified date.
     */
    private Date lastModifiedDate;

    /**
     * Creates a new instance using the given values.
     *
     * @param profileId assigned to the field with the same name
     * @param npi assigned to the field with the same name
     * @param providerType assigned to the field with the same name
     * @param effectiveDate assigned to the field with the same name
     * @param lastModifiedDate assigned to the field with the same name
     */
    public ProfileHeader(long profileId, String npi, String providerType, Date effectiveDate, Date lastModifiedDate) {
        super();
        this.profileId = profileId;
        this.npi = npi;
        this.providerType = providerType;
        this.effectiveDate = effectiveDate;
        this.lastModifiedDate = lastModifiedDate;
    }

    /**
     * Gets the value of the field <code>profileId</code>.
     *
     * @return the profileId
     */
    public long getProfileId() {
        return profileId;
    }

    /**
     * Gets the value of the field <code>providerType</code>.
     *
     * @return the providerType
     */
    public String getProviderType() {
        return providerType;
    }

    /**
     * Gets the value of the field <code>effectiveDate</code>.
     *
     * @return the effectiveDate
     */
    public Date getEffectiveDate() {
        return effectiveDate;
    }

    /**
     * Gets the value of the field <code>lastModifiedDate</code>.
     *
     * @return the lastModifiedDate
     */
    public Date getLastModifiedDate() {
        return lastModifiedDate;
    }

    /**
     * Gets the value of the field <code>npi</code>.
     *
     * @return the npi
     */
    public String getNpi() {
        return npi;
    }

}
