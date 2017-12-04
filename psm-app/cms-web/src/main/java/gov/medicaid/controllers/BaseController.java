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

package gov.medicaid.controllers;

import com.topcoder.util.log.Log;
import gov.medicaid.controllers.validators.StrictCustomDateEditor;
import gov.medicaid.interceptors.HandlebarsInterceptor;
import gov.medicaid.services.PortalServiceConfigurationException;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Date;

/**
 * A base controller class that other classes will extend that provides logging.
 *
 * <p>
 * <b>Thread Safety</b> This class is mutable and not thread safe, but used in thread safe manner by framework.
 * </p>
 *
 * @author argolite, TCSASSEMBLER
 * @version 1.0
 */
@Controller
public abstract class BaseController {

    /**
     * It will be used to log all errors.
     *
     * It is injected by the container, may have any value, is fully mutable, but not expected to change after
     * dependency injection.
     */
    private Log log;

    /**
     * Empty constructor.
     */
    protected BaseController() {
    }

    /**
     * This method checks that all required injection fields are in fact provided.
     *
     * @throws PortalServiceConfigurationException - If there are required injection fields that are not injected
     */
    protected void init() {
        if (log == null) {
            throw new PortalServiceConfigurationException("log is not configured correctly.");
        }
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
     * Captures any exception that is thrown from the controllers and renders
     * the error page.
     *
     * @param request the request that resulted in an exception
     * @param ex      the exception thrown
     * @return the error view
     */
    @ExceptionHandler(Exception.class)
    public ModelAndView handleError(
            HttpServletRequest request,
            Exception ex
    ) {
        ModelAndView view = new ModelAndView("error");
        HandlebarsInterceptor.addCommonVariables(request, view);
        return view;
    }

    /**
     * Gets the value of the field <code>log</code>.
     *
     * @return the log
     */
    public Log getLog() {
        return log;
    }

    /**
     * Sets the value of the field <code>log</code>.
     *
     * @param log the log to set
     */
    public void setLog(Log log) {
        this.log = log;
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
