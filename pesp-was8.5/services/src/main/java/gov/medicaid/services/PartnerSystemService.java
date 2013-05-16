/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.services;

import gov.medicaid.entities.CMSUser;
import gov.medicaid.entities.ProviderProfile;

import java.util.List;

/**
 * Interface for external services related activities.
 *
 * @author TCSASSEMBLER
 * @version 1.0
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
     * @return true if the credentials are valid
     * @throws PortalServiceException for any errors encountered
     */
    boolean authenticate(String externalUserId, String password) throws PortalServiceException;

    /**
     * Retrieves the basic profile from the external service.
     * @param username the user name
     * @return the basic profile mapped to an internal user
     */
    CMSUser getUserInformation(String username);

}