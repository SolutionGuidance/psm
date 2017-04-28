/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.screening.dao.impl;

import gov.medicaid.screening.services.ConfigurationException;
import gov.medicaid.screening.services.impl.LogUtil;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import com.topcoder.util.log.Log;

/**
 * A base DAO class provides logging and JPA access.
 * 
 * @author zsudraco, hanshuai
 * @version 1.0
 */
public abstract class PersistenceBaseDAO {
    /**
     * This is used for logging. It is initialized as
     * gov.medicaid.screening.services.impl.LogUtil.getLog(getClass().getName());
     */
    private final Log log = LogUtil.getLog(getClass().getName());

    /**
     * The entity manager to access database.
     */
    @PersistenceContext(unitName = "punit")
    private EntityManager entityManager;

    /**
     * Empty constructor, it does nothing.
     */
    protected PersistenceBaseDAO() {
    }

    /**
     * This method checks that all required injection fields are in fact provided.
     * 
     * @throws ConfigurationException
     *             If there are required injection fields that are not injected
     */
    protected void init() {
        if (entityManager == null) {
            throw new ConfigurationException("The entityManager must be not be null.");
        }
    }

    /**
     * Getter method for namesake field, simply return the namesake field.
     * 
     * @return the log.
     */
    protected Log getLog() {
        return log;
    }

    /**
     * Getter method for namesake field, simply return the namesake field.
     * 
     * @return the entity manager.
     */
    protected EntityManager getEntityManager() {
        return entityManager;
    }
}
