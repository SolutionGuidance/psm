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

package gov.medicaid.controllers.admin;

import gov.medicaid.controllers.ControllerHelper;
import gov.medicaid.entities.CMSUser;
import gov.medicaid.services.PortalServiceConfigurationException;

import javax.annotation.PostConstruct;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;

import java.util.logging.Logger;


/**
 * <p>A base controller class that other classes will extend that provides logging.</p>
 *  <p>This class is mutable and not thread safe, but used in thread safe manner by framework.</p>
 *
 * @author argolite, TCSASSEMBLER
 * @version 1.0
 */
@Controller
public abstract class BaseServiceAdminController {

    /**
     * It will be used to log all errors.   It is set in the setter. It can be retrieved in the getter.  It may
     * have any value, but is expected to be set to a non-null value.  It is fully mutable, but not expected to change
     * after dependency injection.
     */
    private final Logger logger = Logger.getLogger(getClass().getName());

    /**
     * Empty constructor.
     */
    protected BaseServiceAdminController() {
    }

    /**
     * Get username from the session.
     * @param request the http request
     * @return the username
     */
    protected String getUserName(HttpServletRequest request) {
        CMSUser user = ControllerHelper.getCurrentUser();
        return user == null ? null : user.getUsername();
    }

    /**
     * Ensure the object is properly initialized
     */
    protected void init() {}

    /**
     * Getter of the logger.
     *
     * @return the logger
     */
    public Logger getLogger() {
        return logger;
    }
}
