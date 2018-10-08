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

import gov.medicaid.domain.model.ApplicationType;
import gov.medicaid.domain.model.SubmitApplicationRequest;
import gov.medicaid.domain.model.SubmitApplicationResponse;

/**
 * Web service facade for application requests.
 */
public interface ApplicationWebService {
    /**
     * Retrieves the application details.
     *
     * @param username     the username of the requesting user
     * @param systemId     the system that authenticated the requesting user
     * @param npi          the NPI for which this user is a proxy, if any
     * @param applicationId the ID of the application
     * @return the application
     * @throws PortalServiceException for any errors encountered
     */
    ApplicationType getApplicationDetails(
            String username,
            String systemId,
            String npi,
            long applicationId
    ) throws PortalServiceException;

    /**
     * Saves the application details.
     *
     * @param username   the username of the requesting user
     * @param systemId   the system that authenticated the requesting user
     * @param npi        the NPI for which this user is a proxy, if any
     * @param application the application to save
     * @return the application ID
     * @throws PortalServiceException for any errors encountered
     */
    long saveApplication(
            String username,
            String systemId,
            String npi,
            ApplicationType applicationType
    ) throws PortalServiceException;

    /**
     * Submits the given application request.
     *
     * @param request the service request
     * @return the service response
     * @throws PortalServiceException for any errors encountered
     */
    SubmitApplicationResponse submitApplication(
            SubmitApplicationRequest request
    ) throws PortalServiceException;

    /**
     * Retrieves the profile details.
     *
     * @param username  the username of the requesting user
     * @param systemId  the system that authenticated the requesting user
     * @param npi       the NPI for which this user is a proxy, if any
     * @param profileId the ID of the application (profile) to look up
     * @return the application (profile) found
     * @throws PortalServiceException for any errors encountered
     */
    ApplicationType getProfile(
            String username,
            String systemId,
            String npi,
            long profileId
    ) throws PortalServiceException;

    /**
     * Resubmits the given application request.
     *
     * @param username   the username of the requesting user
     * @param systemId   the system that authenticated the requesting user
     * @param npi        the NPI for which this user is a proxy, if any
     * @param application the application to resubmit
     * @return the status of the resubmission
     * @throws PortalServiceException for any errors encountered
     */
    String resubmitApplication(
            String username,
            String systemId,
            String npi,
            ApplicationType applicationType
    ) throws PortalServiceException;
}
