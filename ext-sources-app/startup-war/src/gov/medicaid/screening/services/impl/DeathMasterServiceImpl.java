/*
 * Copyright (C) 2013 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.screening.services.impl;

import gov.medicaid.entities.DeathMasterRecord;
import gov.medicaid.screening.dao.DeathMasterDAO;
import gov.medicaid.screening.services.ConfigurationException;
import gov.medicaid.screening.services.DeathMasterService;
import gov.medicaid.screening.services.ServiceException;

import javax.annotation.PostConstruct;
import javax.jws.WebMethod;
import javax.jws.WebService;
import javax.naming.InitialContext;
import javax.naming.NamingException;

/**
 * This service defines a method to get death master record by social security number.
 * 
 * @author cyberjag
 * @version 1.0
 */
@WebService
public class DeathMasterServiceImpl extends AbstractBaseService implements DeathMasterService {
    /**
     * Represent the name of this class
     */
    private static final String CLASS_NAME = DeathMasterServiceImpl.class.getName();

    /**
     * This is death master DAO.
     */
    private DeathMasterDAO deathMasterDAO;

    /**
     * Empty constructor, it does nothing.
     */
    public DeathMasterServiceImpl() {
    }

    /**
     * This method checks that all required injection fields are in fact provided.
     * 
     * @throws ConfigurationException
     *             - If there are required injection fields that are not injected.
     */
    @PostConstruct
    protected void init() {
        super.init();
        try {
            InitialContext ctx = new InitialContext();
            deathMasterDAO = (DeathMasterDAO) ctx.lookup("ejblocal:gov.medicaid.screening.dao.DeathMasterDAO");
        } catch (NamingException e) {
            throw new ConfigurationException("Failed to create data access", e);
        }
    }

    /**
     * Get death master record by social security number. Return null if none is found.
     * 
     * @throws IllegalArgumentException
     *             if the argument is null or empty string
     * @throws ServiceException
     *             If an error occurs while performing the operation
     * 
     * @param ssn
     *            the social security number
     * @return the death master record
     */
    @WebMethod
    public DeathMasterRecord getDeathMasterRecord(String ssn) throws ServiceException {
        String signature = CLASS_NAME + "#getDeathMasterRecord(String ssn)";
        LogUtility.traceEntry(getLog(), signature, new String[] { "ssn" }, new Object[] { ssn });
        try {
            DeathMasterRecord record = deathMasterDAO.getDeathMasterRecord(ssn);
            return LogUtility.traceExit(getLog(), signature, record);
        } catch (IllegalArgumentException e) {
            LogUtility.traceError(getLog(), signature, e);
            throw e;
        } catch (ServiceException e) {
            LogUtility.traceError(getLog(), signature, e);
            throw e;
        }
    }
}
