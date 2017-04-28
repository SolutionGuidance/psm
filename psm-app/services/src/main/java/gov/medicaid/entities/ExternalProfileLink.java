/*
 * Copyright 2012-2013 TopCoder, Inc.
 *
 * This code was developed under U.S. government contract NNH10CD71C. 
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * You may not use this file except in compliance with the License.
 * You may obtain a copy of the License at:
 *     http://www.apache.org/licenses/LICENSE-2.0
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package gov.medicaid.entities;

/**
 * Represents a link to an external user.
 *
 * @author TCSASSEMBLER
 * @version 1.0
 */
public class ExternalProfileLink extends IdentifiableEntity {

    /**
     * The user id.
     */
    private long profileId;

    /**
     * The external system id.
     */
    private SystemId systemId;

    /**
     * The external user id.
     */
    private String externalProfileId;

    /**
     * Empty constructor.
     */
    public ExternalProfileLink() {

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
     * Sets the value of the field <code>profileId</code>.
     *
     * @param profileId the profileId to set
     */
    public void setProfileId(long profileId) {
        this.profileId = profileId;
    }

    /**
     * Gets the value of the field <code>systemId</code>.
     *
     * @return the systemId
     */
    public SystemId getSystemId() {
        return systemId;
    }

    /**
     * Sets the value of the field <code>systemId</code>.
     *
     * @param systemId the systemId to set
     */
    public void setSystemId(SystemId systemId) {
        this.systemId = systemId;
    }

    /**
     * Gets the value of the field <code>externalProfileId</code>.
     *
     * @return the externalProfileId
     */
    public String getExternalProfileId() {
        return externalProfileId;
    }

    /**
     * Sets the value of the field <code>externalProfileId</code>.
     *
     * @param externalProfileId the externalProfileId to set
     */
    public void setExternalProfileId(String externalProfileId) {
        this.externalProfileId = externalProfileId;
    }
}
