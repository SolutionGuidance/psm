/*
 * Copyright (C) 2013 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.screening.services.impl;

import gov.medicaid.entities.License;
import gov.medicaid.entities.MarriageAndFamilyTherapyLicenseCriteria;
import gov.medicaid.entities.SearchResult;
import gov.medicaid.screening.dao.MarriageAndFamilyTherapyLicenseDAO;
import gov.medicaid.screening.services.ConfigurationException;
import gov.medicaid.screening.services.ErrorCode;
import gov.medicaid.screening.services.MarriageAndFamilyTherapyLicenseService;
import gov.medicaid.screening.services.ParsingException;
import gov.medicaid.screening.services.ServiceException;

import javax.annotation.PostConstruct;
import javax.jws.WebMethod;
import javax.jws.WebService;
import javax.naming.InitialContext;
import javax.naming.NamingException;

/**
 * This is the web service implementation of the <code>MarriageAndFamilyTherapyLicenseService</code>. It is exposed as a
 * web service by the container.
 * 
 * @author cyberjag
 * @version 1.0
 */
@WebService
public class MarriageAndFamilyTherapyLicenseServiceImpl extends AbstractBaseService implements
        MarriageAndFamilyTherapyLicenseService {

    /**
     * Marriage and Family Therapy License data access.
     */
    private MarriageAndFamilyTherapyLicenseDAO dataAccess;

    /**
     * Searches for providers with Marriage and Family therapy license using the name filter.
     * 
     * @param criteria
     *            the search criteria
     * @return the matched results
     * @throws ParsingException
     *             if any parsing errors are encountered
     * @throws ServiceException
     *             for any other errors encountered
     */
    @WebMethod
    public SearchResult<License> searchByName(MarriageAndFamilyTherapyLicenseCriteria criteria) throws ServiceException {
        String signature = "MarriageAndFamilyTherapyLicenseServiceImpl#searchByName";
        LogUtility.traceEntry(getLog(), signature, new String[] { "criteria" }, new Object[] { criteria });

        try {
            SearchResult<License> results = dataAccess.searchByName(criteria);
            return LogUtility.traceExit(getLog(), signature, results);
        } catch (ServiceException e) {
            LogUtility.traceError(getLog(), signature, e);
            throw e;
        } catch (Throwable e) {
            ServiceException ex = new ServiceException(ErrorCode.MITA99999.getDesc(), e);
            LogUtility.traceError(getLog(), signature, ex);
            throw ex;
        }
    }

    /**
     * Searches for providers with Marriage and Family therapy license using the license number filter.
     * 
     * @param criteria
     *            the search criteria
     * @return the matched results
     * @throws ParsingException
     *             if any parsing errors are encountered
     * @throws ServiceException
     *             for any other errors encountered
     */
    @WebMethod
    public SearchResult<License> searchByLicenseNumber(MarriageAndFamilyTherapyLicenseCriteria criteria)
            throws ServiceException {
        String signature = "MarriageAndFamilyTherapyLicenseServiceImpl#searchByLicenseNumber";
        LogUtility.traceEntry(getLog(), signature, new String[] { "criteria" }, new Object[] { criteria });

        try {
            SearchResult<License> results = dataAccess.searchByLicenseNumber(criteria);
            return LogUtility.traceExit(getLog(), signature, results);
        } catch (ServiceException e) {
            LogUtility.traceError(getLog(), signature, e);
            throw e;
        } catch (Throwable e) {
            ServiceException ex = new ServiceException(ErrorCode.MITA99999.getDesc(), e);
            LogUtility.traceError(getLog(), signature, ex);
            throw ex;
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
            dataAccess = (MarriageAndFamilyTherapyLicenseDAO) ctx
                    .lookup("ejblocal:gov.medicaid.screening.dao.MarriageAndFamilyTherapyLicenseDAO");
        } catch (NamingException e) {
            throw new ConfigurationException("Failed to create data access", e);
        }
    }
}