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
 * @author TCSASSEMBLER
 * @version 1.0
 */
public class ExternalAccountLink extends IdentifiableEntity {

    /**
     * The user id.
     */
    private String userId;

    /**
     * The external system id.
     */
    private SystemId systemId;

    /**
     * The external user id.
     */
    private String externalUserId;

    /**
     * Empty constructor.
     */
    public ExternalAccountLink() {

    }

    /**
     * Gets the value of the field <code>userId</code>.
     *
     * @return the userId
     */
    public String getUserId() {
        return userId;
    }

    /**
     * Sets the value of the field <code>userId</code>.
     *
     * @param userId the userId to set
     */
    public void setUserId(String userId) {
        this.userId = userId;
    }

    /**
     * Gets the value of the field <code>externalUserId</code>.
     *
     * @return the externalUserId
     */
    public String getExternalUserId() {
        return externalUserId;
    }

    /**
     * Sets the value of the field <code>externalUserId</code>.
     *
     * @param externalUserId the externalUserId to set
     */
    public void setExternalUserId(String externalUserId) {
        this.externalUserId = externalUserId;
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
}
