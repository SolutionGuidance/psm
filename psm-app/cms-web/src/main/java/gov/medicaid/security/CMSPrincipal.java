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

package gov.medicaid.security;

import gov.medicaid.entities.CMSUser;
import gov.medicaid.entities.SystemId;

import java.security.Principal;
import java.util.Date;

/**
 * Defines an extension to the security principal supporting linked user accounts.
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
