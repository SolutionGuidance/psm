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

import gov.medicaid.entities.CMSUser;
import gov.medicaid.entities.ExternalAccountLink;
import gov.medicaid.entities.ProviderProfile;

import java.util.List;

/**
 * This service defines the interface for importing external data.
 */
public interface OnboardingService {

    /**
     * Retrieves the profiles of users from the given link.
     *
     * @param link the external account link
     * @return the list of matched profiles
     * @throws PortalServiceException for any errors encountered
     */
    List<ProviderProfile> findProfiles(ExternalAccountLink link) throws PortalServiceException;

    /**
     * Imports the selected profiles from the external data source.
     *
     * @param user the user performing the action
     * @param link the external account link
     * @param externalProfileIds the selected profile IDs
     * @return the number of profiles successfully imported
     * @throws PortalServiceException for any errors encountered
     */
    int importProfiles(CMSUser user, ExternalAccountLink link, String[] externalProfileIds)
        throws PortalServiceException;

    /**
     * Verifies the credentials of the user.
     *
     * @param link the external account link to verify credentials for
     * @param password the credentials
     * @return true if the credentials provided are valid
     */
    boolean verifyCredentials(ExternalAccountLink link, String password);
}
