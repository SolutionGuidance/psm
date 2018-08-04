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
import gov.medicaid.entities.SearchResult;
import gov.medicaid.entities.SystemId;
import gov.medicaid.entities.UserSearchCriteria;

/**
 * This service defines the self service registration.
 */
public interface RegistrationService {

    /**
     * Retrieves the user with a linked account from the given system using the username provided.
     *
     * @param systemName the external system name to search the link for
     * @param username the username for the external system
     * @return the matching user, or null if not found
     */
    CMSUser findByExternalUsername(SystemId systemName, String username);

    /**
     * Retrieves the user with the given username.
     *
     * @param username the username to search for
     * @return the matching user, null if not found
     */
    CMSUser findByUsername(String username);

    /**
     * Registers the given user.
     *
     * Default role assigned will be Provider if not set (self service registration). Passwords will be generated and
     * sent via email so user email cannot be null
     *
     * @param registrant the user to be registered
     * @return the user id for the new user
     * @throws PortalServiceException for any errors encountered, or if any field is considered invalid by the
     *             underlying implementations
     */
    String register(CMSUser registrant) throws PortalServiceException;

    /**
     * Registers an external user. Default role assigned will be Provider (self service registration).
     *
     * @param systemId the system id for the user
     * @param username the external user id
     * @param registrant the user profile
     * @return the generated user id
     */
    String registerExternalUser(
            SystemId systemId,
            String username,
            CMSUser registrant
    );

    /**
     * Suspends the given user.
     *
     * @param principal the user performing the action
     * @param userId the user to be suspended
     */
    void suspend(CMSUser principal, String userId);

    /**
     * Reinstates the given user.
     *
     * @param principal the user performing the action
     * @param userId the user to be reinstated
     */
    void reinstate(CMSUser principal, String userId);

    /**
     * Creates the account link. Ignores duplicates.
     *
     * @param userId the user id to be linked
     * @param link the account link details
     */
    void addAccountLink(String userId, ExternalAccountLink link);

    /**
     * Retrieves the account link.
     *
     * @param userId the user id linked
     * @param system the system linked to
     * @param externalAccountId the external user
     * @return the matching account link or null if not found
     */
    ExternalAccountLink findAccountLink(String userId, SystemId system, String externalAccountId);

    /**
     * Replaces the password of the given user.
     *
     * @param user the user resetting the password
     * @param oldPassword the old password
     * @param password the new password
     * @return true if the password was reset
     * @throws PortalServiceException for any errors encountered
     */
    boolean resetPassword(CMSUser user, String oldPassword, String password) throws PortalServiceException;

    /**
     * Replaces the password of the given user and emails it to them.
     * @param username the user resetting the password
     * @param emailAddress the email address (should match one on file)
     * @return true if the password was reset
     * @throws PortalServiceException for any errors encountered
     */
    boolean resetPassword(String username, String emailAddress) throws PortalServiceException;

    /**
     * Retrieves the user with the given user id.
     *
     * @param userId the id to search for
     * @return the matching user, null if not found
     */
    CMSUser findByUserId(String userId);

    /**
     * Updates basic profile information for the given user.
     *
     * @param actorId the actor performing this operation
     * @param user the user to be updated.
     * @throws PortalServiceException for any errors encountered
     */
    void updateUserProfile(String actorId, CMSUser user) throws PortalServiceException;

    /**
     * Search for users given a criteria.
     * @param criteria the criteria to be used
     * @return the matching users
     * @throws PortalServiceException for any errors encountered
     */
    SearchResult<CMSUser> findUsersByCriteria(UserSearchCriteria criteria) throws PortalServiceException;

    /**
     * Deletes the given users.
     * @param actorId the actor performing this operation
     * @param userIds the user ids to be removed from the system.
     * @throws PortalServiceException for any errors encountered
     */
    void unregisterUsers(String actorId, String[] userIds) throws PortalServiceException;

    /**
     * Performs registration through administrator screens.
     * @param actor the administrator user
     * @param user the user to register
     * @param password the password to assign (if null, a new one is generated and emailed)
     * @return the user id
     * @throws PortalServiceException for any errors encountered
     */
    String registerByAdmin(CMSUser actor, CMSUser user, String password) throws PortalServiceException;

    /**
     * Performs registration updated administrator screens.
     * @param actor the administrator user
     * @param user the user to updated
     * @param password the password to assign (if null, no password change is made)
     * @return the user id
     * @throws PortalServiceException for any errors encountered
     */
    String updateByAdmin(CMSUser actor, CMSUser user, String password) throws PortalServiceException;

    /**
     * Authenticates the user.
     *
     * @param username the username
     * @param password the password
     * @return if a matching record is found
     * @throws PortalServiceException for any errors encountered
     */
    boolean authenticate(String username, String password) throws PortalServiceException;
}
