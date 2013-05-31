/*
 * Copyright (C) 2013 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.screening.services.impl;

import gov.medicaid.entities.PECOSRecord;
import gov.medicaid.screening.dao.PECOSDAO;
import gov.medicaid.screening.services.ConfigurationException;
import gov.medicaid.screening.services.PECOSService;
import gov.medicaid.screening.services.ServiceException;

import javax.annotation.PostConstruct;
import javax.jws.WebMethod;
import javax.jws.WebService;
import javax.naming.InitialContext;
import javax.naming.NamingException;

/**
 * This service defines a method to get PECOS record by National Provider Identifier (NPI).
 * 
 * @author cyberjag
 * @version 1.0
 */
@WebService
public class PECOSServiceImpl extends AbstractBaseService implements PECOSService {
    /**
     * Represent the name of this class
     */
    private static final String CLASS_NAME = PECOSServiceImpl.class.getName();

    /**
     * This is PECOS DAO.
     */
    private PECOSDAO pecosDAO;

    /**
     * Empty constructor, it does nothing.
     */
    public PECOSServiceImpl() {
    }

    /**
     * This method checks that all required injection fields are in fact provided.
     * 
     * @throws ConfigurationException
     *             - If there are required injection fields that are not injected
     */
    @PostConstruct
    protected void init() {
        super.init();
        try {
            InitialContext ctx = new InitialContext();
            pecosDAO = (PECOSDAO) ctx.lookup("ejblocal:gov.medicaid.screening.dao.PECOSDAO");
        } catch (NamingException e) {
            throw new ConfigurationException("Failed to create data access", e);
        }
    }

    /**
     * Get PECOS record by National Provider Identifier (NPI). Return null if none is found.
     * 
     * @throws IllegalArgumentException
     *             if the argument is null or empty string
     * @throws ServiceException
     *             If an error occurs while performing the operation
     * 
     * @param npi
     *            the national provider identifier
     * @return the PECOS record
     */
    @WebMethod
    public PECOSRecord getPECOSRecord(String npi) throws ServiceException {
        String signature = CLASS_NAME + "#getPECOSRecord(String npi)";
        LogUtility.traceEntry(getLog(), signature, new String[] { "npi" }, new Object[] { npi });
        try {
            PECOSRecord record = pecosDAO.getPECOSRecord(npi);
            return LogUtility.traceExit(getLog(), signature, record);
        } catch (ServiceException e) {
            LogUtility.traceError(getLog(), signature, e);
            throw e;
        } catch (IllegalArgumentException e) {
            LogUtility.traceError(getLog(), signature, e);
            throw e;
        }
    }
}
