/*
 * Copyright (C) 2013 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.screening.services.impl;

import gov.medicaid.entities.BusinessLienSearchCriteria;
import gov.medicaid.entities.ProviderProfile;
import gov.medicaid.entities.SearchResult;
import gov.medicaid.screening.dao.BusinessLienDAO;
import gov.medicaid.screening.services.BusinessLienSystemService;
import gov.medicaid.screening.services.ConfigurationException;
import gov.medicaid.screening.services.ErrorCode;
import gov.medicaid.screening.services.ParsingException;
import gov.medicaid.screening.services.ServiceException;

import javax.annotation.PostConstruct;
import javax.jws.WebMethod;
import javax.jws.WebService;
import javax.naming.InitialContext;
import javax.naming.NamingException;

/**
 * This is implementation of <code>BusinessLienSystemService</code>. It is exposed as a web service by the container.
 * 
 * @author cyberjag
 * @version 1.0
 */
@WebService
public class BusinessLienSystemServiceImpl extends AbstractBaseService implements BusinessLienSystemService {

    /**
     * Business Lien data access.
     */
    private BusinessLienDAO dataAccess;

    /**
     * Default empty constructor.
     */
    public BusinessLienSystemServiceImpl() {
    }

    /**
     * Searches for MN business and liens by name.
     * 
     * @param criteria
     *            the search criteria
     * @return the matched results
     * @throws ParsingException
     *             if any parsing errors are encountered
     * @throws ServiceException
     *             for any other exceptions encountered
     */
    @WebMethod
    public SearchResult<ProviderProfile> searchByName(BusinessLienSearchCriteria criteria) throws ParsingException,
            ServiceException {
        String signature = "BusinessLienSystemServiceImpl#searchByName";
        LogUtility.traceEntry(getLog(), signature, new String[] { "criteria" }, new Object[] { criteria });
        try {
            SearchResult<ProviderProfile> results = dataAccess.searchByName(criteria);
            return LogUtility.traceExit(getLog(), signature, results);
        } catch (ServiceException e) {
            LogUtility.traceError(getLog(), signature, e);
            throw e;
        } catch (Throwable e) {
            LogUtility.traceError(getLog(), signature, e);
            throw new ServiceException(ErrorCode.MITA99999.getDesc(), e);
        }
    }

    /**
     * Searches for MN business and liens by file number.
     * 
     * @param criteria
     *            the search criteria
     * @return the matched results
     * @throws ParsingException
     *             if any parsing errors are encountered
     * @throws ServiceException
     *             for any other exceptions encountered
     */
    @WebMethod
    public SearchResult<ProviderProfile> searchByFileNumber(BusinessLienSearchCriteria criteria)
            throws ParsingException, ServiceException {
        String signature = "BusinessLienSystemServiceImpl#searchByFileNumber";
        LogUtility.traceEntry(getLog(), signature, new String[] { "criteria" }, new Object[] { criteria });
        try {
            SearchResult<ProviderProfile> results = dataAccess.searchByFileNumber(criteria);
            return LogUtility.traceExit(getLog(), signature, results);
        } catch (ServiceException e) {
            LogUtility.traceError(getLog(), signature, e);
            throw e;
        } catch (Throwable e) {
            LogUtility.traceError(getLog(), signature, e);
            throw new ServiceException(ErrorCode.MITA99999.getDesc(), e);
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
            dataAccess = (BusinessLienDAO) ctx.lookup("ejblocal:gov.medicaid.screening.dao.BusinessLienDAO");
        } catch (NamingException e) {
            throw new ConfigurationException("Failed to create data access", e);
        }
    }
}