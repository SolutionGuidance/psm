/*
 * Copyright (C) 2013 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.screening.services.impl;

import gov.medicaid.entities.SAMResponse;
import gov.medicaid.entities.SAMSearchCriteria;
import gov.medicaid.screening.dao.SAMSearchDAO;
import gov.medicaid.screening.services.ConfigurationException;
import gov.medicaid.screening.services.ErrorCode;
import gov.medicaid.screening.services.SAMSearchService;
import gov.medicaid.screening.services.ServiceException;

import java.util.List;

import javax.annotation.PostConstruct;
import javax.jws.WebMethod;
import javax.jws.WebService;
import javax.naming.InitialContext;
import javax.naming.NamingException;

/**
 * This defines the logic for searching for SAM records.
 * 
 * @author flexme
 * @version 1.0
 */
@WebService
public class SAMSearchServiceImpl extends AbstractBaseService implements SAMSearchService {
    /**
     * SAM records data access.
     */
    private SAMSearchDAO dataAccess;

    /**
     * Empty constructor.
     */
    public SAMSearchServiceImpl() {
    }

    /**
     * Search the SAM records.
     * 
     * @param criteria
     *            the searching criteria.
     * @return the records.
     * @throws ServiceException
     *             for any exceptions encountered
     */
    @WebMethod
    public List<SAMResponse> doSearch(SAMSearchCriteria criteria) throws ServiceException {
        String signature = "SAMSearchServiceBean#doSearch";
        LogUtility.traceEntry(getLog(), signature, new String[] { "criteria" }, new Object[] { criteria });

        try {
            List<SAMResponse> results = dataAccess.doSearch(criteria);
            return LogUtility.traceExit(getLog(), signature, results);
        } catch (ServiceException e) {
            LogUtility.traceError(getLog(), signature, e);
            throw e;
        } catch (Throwable e) {
            LogUtility.traceError(getLog(), signature, e);
            throw new ServiceException(ErrorCode.MITA99999.getDesc());
        }
    }

    /**
     * Verifies the provider using SSN.
     * 
     * @param ssn
     *            provider ssn
     * @param name
     *            provider name
     * @return return @return true if valid, false if not
     * @throws ServiceException
     *             if any error occur
     */
    @WebMethod
    public boolean verify(String ssn, String name) throws ServiceException {
        String signature = "SAMSearchServiceBean#verify";
        LogUtility.traceEntry(getLog(), signature, new String[] { "ssn", "name" }, new Object[] { ssn, name });
        try {
            return LogUtility.traceExit(getLog(), signature, dataAccess.verify(ssn, name));
        } catch (ServiceException e) {
            LogUtility.traceError(getLog(), signature, e);
            throw e;
        } catch (Throwable e) {
            LogUtility.traceError(getLog(), signature, e);
            throw new ServiceException(ErrorCode.MITA99999.getDesc());
        }
    }

    /**
     * Checks if the container properly initialized the injected fields.
     * 
     * @throws ConfigurationException
     *             if any injected field is null
     */
    @PostConstruct
    protected void init() {
        super.init();
        try {
            InitialContext ctx = new InitialContext();
            dataAccess = (SAMSearchDAO) ctx.lookup("ejblocal:gov.medicaid.screening.dao.SAMSearchDAO");
        } catch (NamingException e) {
            throw new ConfigurationException("Failed to create data access", e);
        }
    }

}
