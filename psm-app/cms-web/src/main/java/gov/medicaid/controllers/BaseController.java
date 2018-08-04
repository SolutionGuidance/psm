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

package gov.medicaid.controllers;

import gov.medicaid.controllers.validators.StrictCustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;

import javax.servlet.http.HttpServletResponse;
import java.util.Date;
import java.util.logging.Logger;

/**
 * A base controller class that other classes will extend that provides logging.
 *
 * <p>
 * <b>Thread Safety</b> This class is mutable and not thread safe, but used in thread safe manner by framework.
 * </p>
 */
@Controller
public abstract class BaseController {

    /**
     * It will be used to log all errors.
     *
     * It is injected by the container, may have any value, is fully mutable, but not expected to change after
     * dependency injection.
     */
    private final Logger logger = Logger.getLogger(getClass().getName());

    /**
     * Empty constructor.
     */
    protected BaseController() {
    }

    /**
     * Sets up custom editors.
     *
     * @param binder the current binder registry
     */
    @InitBinder
    public void initBinder(final WebDataBinder binder) {
        binder.registerCustomEditor(Date.class, null, new StrictCustomDateEditor());
    }

    /**
     * Gets the value of the field <code>logger</code>.
     *
     * @return the logger
     */
    public Logger getLogger() {
        return logger;
    }

    /**
     * Disables caching for the given response.
     * @param response the response to add disable cache headers on
     */
    protected void nocache(HttpServletResponse response) {
        response.addHeader("Cache-Control", "no-cache,no-store,private,must-revalidate,max-stale=0,post-check=0,pre-check=0");
        response.addHeader("Pragma", "no-cache");
        response.addDateHeader("Expires", 0);
    }
}
