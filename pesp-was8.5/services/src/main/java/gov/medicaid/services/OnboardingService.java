/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.services;

import gov.medicaid.entities.CMSUser;
import gov.medicaid.entities.ExternalAccountLink;
import gov.medicaid.entities.ProviderProfile;

import java.util.List;

/**
 * This service defines the interface for importing external data.
 *
 * @author TCSASSEMBLER
 * @version 1.0
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
     * @throws PortalServiceException for any errors encountered
     */
    boolean verifyCredentials(ExternalAccountLink link, String password) throws PortalServiceException;
}
