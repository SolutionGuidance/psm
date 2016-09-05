/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.controllers.admin;

import gov.medicaid.services.LookupService;
import gov.medicaid.services.PortalServiceConfigurationException;
import gov.medicaid.services.RegistrationService;
import gov.medicaid.services.util.LogUtil;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.ModelAndView;

import com.topcoder.util.log.Log;

/**
 * A base controller class that other classes will extend that provides logging, auditing, and additional services.
 *
 * <p>
 * <b>Thread Safety</b> This class is mutable and not thread safe, but used in thread safe manner by framework.
 * </p>
 *
 * @author argolite, TCSASSEMBLER
 * @version 1.0
 */
@Controller
public abstract class BaseSystemAdminController {

    /**
     * It will be used to log all errors.
     *
     * It is injected by the container, may have any value, is fully mutable, but not expected to change after
     * dependency injection.
     */
    private Log log;

    /**
     * Registration service.
     */
    private RegistrationService registrationService;

    /**
     * Lookup service.
     */
    private LookupService lookupService;


    /**
     * Empty constructor.
     */
    protected BaseSystemAdminController() {
    }

    /**
     * Directs all exceptions encountered by subclasses to a generic error page.
     * @param ex the exception encountered
     * @return the error view name
     */
    @ExceptionHandler(Exception.class)
    public ModelAndView handleException(Exception ex) {
        LogUtil.traceError(getLog(), "BaseSystemAdminController#handleException(Exception ex)", ex);
        ModelAndView view = new ModelAndView("error");
        view.addObject("exception", ex);
        return view;
    }

    /**
     * This method checks that all required injection fields are in fact provided.
     *
     * @throws PortalServiceConfigurationException - If there are required injection fields that are not injected
     */
    protected void init() {
        if (log == null) {
            throw new PortalServiceConfigurationException("log must be configured.");
        }
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
     * Gets the value of the field <code>registrationService</code>.
     * @return the registrationService
     */
    public RegistrationService getRegistrationService() {
        return registrationService;
    }

    /**
     * Sets the value of the field <code>registrationService</code>.
     * @param registrationService the registrationService to set
     */
    public void setRegistrationService(RegistrationService registrationService) {
        this.registrationService = registrationService;
    }

    /**
     * Gets the value of the field <code>lookupService</code>.
     * @return the lookupService
     */
    public LookupService getLookupService() {
        return lookupService;
    }

    /**
     * Sets the value of the field <code>lookupService</code>.
     * @param lookupService the lookupService to set
     */
    public void setLookupService(LookupService lookupService) {
        this.lookupService = lookupService;
    }
}