/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.screening.services.impl;

import gov.medicaid.screening.services.ConfigurationException;

import javax.annotation.PostConstruct;

import com.topcoder.util.log.Log;

/**
 * This is the base class for license services, it contains definitions for common properties and functions.
 *
 * <strong>This is an abstract class, but defines no mutable properties and is therefore thread-safe, however subclasses
 * may behave differently.</strong>
 *
 * @author argolite, j3_guile
 * @version 1.0
 */
public abstract class BaseService {

    /**
     * Class logger.
     */
    private Log log = LogUtil.getLog(getClass().getName());

    /**
     * Default empty constructor.
     */
    protected BaseService() {
    }

    /**
     * Checks if the container properly initialized the injected fields.
     *
     * @throws ConfigurationException if any injected field is null
     */
    @PostConstruct
    protected void init() {
        // currently empty, for future use.
    }

    /**
     * Gets the value of the field <code>log</code>.
     *
     * @return the log
     */
    public Log getLog() {
        return log;
    }
}