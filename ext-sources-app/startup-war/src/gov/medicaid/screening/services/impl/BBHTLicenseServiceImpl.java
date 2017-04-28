/*
 * Copyright (C) 2013 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.screening.services.impl;

import gov.medicaid.entities.BBHTLicenseSearchCriteria;
import gov.medicaid.entities.License;
import gov.medicaid.entities.SearchResult;
import gov.medicaid.screening.dao.BBHTLicenseDAO;
import gov.medicaid.screening.services.BBHTLicenseService;
import gov.medicaid.screening.services.ErrorCode;
import gov.medicaid.screening.services.ParsingException;
import gov.medicaid.screening.services.ServiceException;

import javax.annotation.PostConstruct;
import javax.jws.WebMethod;
import javax.jws.WebService;
import javax.naming.InitialContext;
import javax.naming.NamingException;

/**
 * This is the web service implementation of the <code>BBHTLicenseService</code>. It is exposed as a web service by the
 * container.
 * 
 * @author cyberjag
 * @version 1.0
 */
@WebService
public class BBHTLicenseServiceImpl extends AbstractBaseService implements BBHTLicenseService {

    /**
     * Board of Behavioral Health and Therapy License data access.
     */
    private BBHTLicenseDAO dataAccess;

    /**
     * Default empty constructor.
     */
    public BBHTLicenseServiceImpl() {
    }

    
    @PostConstruct
    protected void init() {
        super.init();
        try {
            InitialContext ctx = new InitialContext();
            dataAccess = (BBHTLicenseDAO) ctx.lookup("ejblocal:gov.medicaid.screening.dao.BBHTLicenseDAO");
        } catch (NamingException e) {
            throw new ConfigurationException("Failed to create data access", e);
        }
    }

    /**
     * Searches for providers with BBHT license using the given criteria.
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
    public SearchResult<License> search(BBHTLicenseSearchCriteria criteria) throws ParsingException, ServiceException {
        String signature = "BBHTLicenseServiceImpl#search";
        LogUtility.traceEntry(getLog(), signature, new String[] { "criteria" }, new Object[] { criteria });
        try {
            SearchResult<License> results = dataAccess.search(criteria);
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
     * Performs verification of the given license.
     * 
     * @param license
     *            the license to verify
     * @return true if the license has been verified, false otherwise
     * 
     * @throws ParsingException
     *             if any parsing errors are encountered
     * @throws ServiceException
     *             for any other exceptions encountered
     */
    @WebMethod
    public boolean verifyLicense(License license) throws ParsingException, ServiceException {
        String signature = "BBHTLicenseServiceImpl#verifyLicense";
        LogUtility.traceEntry(getLog(), signature, new String[] { "license" }, new Object[] { license });
        try {
            boolean result = dataAccess.verifyLicense(license);
            return LogUtility.traceExit(getLog(), signature, Boolean.valueOf(result));
        } catch (ServiceException e) {
            LogUtility.traceError(getLog(), signature, e);
            throw e;
        } catch (Throwable e) {
            LogUtility.traceError(getLog(), signature, e);
            throw new ServiceException(ErrorCode.MITA99999.getDesc());
        }
    }

    /**
     * Performs renewal of the given license. Currently unsupported.
     * 
     * @param license
     *            the license to renew
     * 
     * @throws ParsingException
     *             if any parsing errors are encountered
     * @throws ServiceException
     *             for any other exceptions encountered
     */
    public void renew(License license) throws ParsingException, ServiceException {
        throw new UnsupportedOperationException("Operation currently unsupported");
    }

}
