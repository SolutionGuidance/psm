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

package gov.medicaid.services;

import gov.medicaid.entities.ProviderProfile;

import java.util.List;

/**
 * Interface for external services related activities.
 */
public interface PartnerSystemService {

    /**
     * Retrieves the profiles of users from the given link.
     *
     * @param externalUserId the external account link user id
     * @return the list of matched profiles
     * @throws PortalServiceException for any errors encountered
     */
    List<ProviderProfile> findProfiles(String externalUserId) throws PortalServiceException;

    /**
     * Authenticates the given credentials.
     *
     * @param externalUserId the username
     * @param password the password
     * @param referrer
     * @param profileNPI
     * @return true if the credentials are valid
     */
    boolean authenticate(String externalUserId, String password, String profileNPI, String referrer);
}
