/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.screening.services.impl;

import gov.medicaid.entities.NETStudyResponse;
import gov.medicaid.screening.dao.NETStudyDAO;
import gov.medicaid.screening.services.ConfigurationException;
import gov.medicaid.screening.services.NETStudyService;
import gov.medicaid.screening.services.ServiceException;

import javax.annotation.PostConstruct;
import javax.jws.WebMethod;
import javax.jws.WebService;
import javax.naming.InitialContext;
import javax.naming.NamingException;

/**
 * This service defines a method to get NETStudy web service response by LISStudyID.
 * 
 * @author cyberjag
 * @version 1.0
 */
@WebService
public class NETStudyServiceImpl extends AbstractBaseService implements NETStudyService {
    /**
     * Represent the name of this class
     */
    private static final String CLASS_NAME = NETStudyServiceImpl.class.getName();

    /**
     * This is NETStudy DAO.
     */
    private NETStudyDAO netStudyDAO;

    /**
     * Empty constructor, it does nothing.
     */
    public NETStudyServiceImpl() {
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
            netStudyDAO = (NETStudyDAO) ctx.lookup("ejblocal:gov.medicaid.screening.dao.NETStudyDAO");
        } catch (NamingException e) {
            throw new ConfigurationException("Failed to create data access", e);
        }
    }

    /**
     * Get NETStudy web service response by LISStudyID.
     * 
     * @param lisStudyID
     *            the list study id to get the response.
     * @throws ServiceException
     *             If an error occurs while performing the operation.
     * @return the net study response.
     */
    @WebMethod
    public NETStudyResponse getNETStudyResponse(int lisStudyID) throws ServiceException {
        String signature = CLASS_NAME + "#getNETStudyResponse(int lisStudyID)";
        LogUtility.traceEntry(getLog(), signature, new String[] { "lisStudyID" }, new Object[] { lisStudyID });
        try {
            NETStudyResponse result = netStudyDAO.getNETStudyResponse(lisStudyID);
            return LogUtility.traceExit(getLog(), signature, result);
        } catch (ServiceException e) {
            LogUtility.traceError(getLog(), signature, e);
            throw e;
        }
    }
}
