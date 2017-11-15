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

package gov.medicaid.services.impl;

import gov.medicaid.dao.IdentityProviderDAO;
import gov.medicaid.entities.Authentication;
import gov.medicaid.entities.CMSUser;
import gov.medicaid.services.PortalServiceConfigurationException;
import gov.medicaid.services.PortalServiceException;
import org.apache.commons.codec.binary.Base64;

import javax.ejb.Local;
import javax.ejb.Stateless;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.List;

/**
 * This is an EJB implementation for the {@link IdentityProviderDAO} which connects directly to the database
 * servers.
 *
 * @author TCSASSEMBLER
 * @version 1.0
 */
@Stateless
@Local(IdentityProviderDAO.class)
public class DBIdentityProviderDAOBean extends BaseService implements IdentityProviderDAO {

    /**
     * Empty constructor.
     */
    public DBIdentityProviderDAOBean() {
    }

    /**
     * Asks the identity provider to provision a new user with the given profile and password.
     *
     * @param user the user to be provisioned
     * @param password the password for the user
     * @throws PortalServiceException for any errors encountered
     */
    public void provisionUser(CMSUser user, String password) throws PortalServiceException {
        Authentication authentication = new Authentication();
        authentication.setUsername(user.getUsername());
        authentication.setPassword(hash(password));
        getEm().persist(authentication);
    }

    /**
     * Updates the profile of the user on the external provider.
     *
     * @param user the profile to be updated (it is assumed username is never changed)
     * @throws PortalServiceException for any errors encountered
     */
    public void updateUser(CMSUser user) throws PortalServiceException {
        // no user attributes for this provider
    }

    /**
     * Resets the password for the given user.
     *
     * @param username the username
     * @param password the new password
     * @throws PortalServiceException for any errors encountered
     */
    public void resetPassword(String username, String password) throws PortalServiceException {
        Authentication auth = getEm().find(Authentication.class, username);
        auth.setPassword(hash(password));
        getEm().merge(auth);
    }

    /**
     * Removes the user from the underlying identity provider.
     *
     * @param username this is the user that will be permanently removed
     * @throws PortalServiceException for any errors encountered
     */
    public void removeUser(String username) throws PortalServiceException {
        Authentication auth = getEm().find(Authentication.class, username);
        getEm().remove(auth);
    }

    /**
     * Retrieves the roles for the from the identity provider.
     *
     * @param username the user to get the roles for
     * @return the list of roles for the user
     * @throws PortalServiceException for any errors encountered
     */
    public List<String> findRoles(String username) throws PortalServiceException {
        return new ArrayList<String>();
    }

    /**
     * Hashes the given password so it is not stored as plain text on LDAP.
     *
     * @param password the plain text password to hash
     * @return the hashed password
     */
    private String hash(String password) {
        if (password == null) {
            return hash("");
        }
        try {
            MessageDigest sha = MessageDigest.getInstance("SHA");
            sha.update(password.getBytes());
            byte[] hash = sha.digest();
            return "{SHA}" + new String(Base64.encodeBase64(hash));
        } catch (NoSuchAlgorithmException e) {
            throw new PortalServiceConfigurationException("No valid encryption algorithm was found.", e);
        }
    }

    /**
     * Password authenticate.
     *
     * @param username the user to be used
     * @param password the password to be used
     * @return true if the user was authenticated
     * @throws PortalServiceException for any errors encountered
     */
    public boolean authenticate(String username, String password) throws PortalServiceException {
        Authentication auth = getEm().find(Authentication.class, username);
        if (auth == null) {
            return false;
        }
        
        return auth.getPassword().equals(hash(password));
    }
}