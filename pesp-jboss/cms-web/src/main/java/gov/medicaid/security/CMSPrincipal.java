/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.security;

import java.security.Principal;
import java.util.Date;

import gov.medicaid.entities.CMSUser;
import gov.medicaid.entities.SystemId;

/**
 * Defines an extension to the security principal supporting linked user accounts.
 *
 * @author TCSASSEMBLER
 * @version 1.0
 */
public interface CMSPrincipal extends Principal {

    /**
     * The system that performed authentication.
     * @return the authehtication system
     */
    SystemId getAuthenticatedBySystem();

    /**
     * The internal user.
     * @return the cms user
     */
    CMSUser getUser();

    /**
     * The login date.
     * @return the login date
     */
    Date getLoginDate();

    /**
     * The username.
     * @return the login name
     */
    String getUsername();
}
