/*
 * Copyright (C) 2013 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.screening.services.impl;

import gov.medicaid.entities.ChiropracticLicenseSearchCriteria;
import gov.medicaid.entities.License;
import gov.medicaid.entities.SearchResult;
import gov.medicaid.screening.dao.ChiropracticLicenseDAO;
import gov.medicaid.screening.services.ChiropracticLicenseService;
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
 * This is the webservice implementation of the <code>ChiropracticLicenseService</code>. It is exposed as a web service
 * by the container.
 * 
 * @author cyberjag
 * @version 1.0
 */
@WebService
public class ChiropracticLicenseServiceImpl extends AbstractBaseService implements ChiropracticLicenseService {

    /**
     * Chiropractic Practice License data access.
     */
    private ChiropracticLicenseDAO dataAccess;

    /**
     * Searches for providers with Chiropractic license using the name filter.
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
    public SearchResult<License> searchByLastName(ChiropracticLicenseSearchCriteria criteria) throws ParsingException,
            ServiceException {
        String signature = "ChiropracticLicenseServiceImpl#searchByLastName";
        LogUtility.traceEntry(getLog(), signature, new String[] { "criteria" }, new Object[] { criteria });
        try {
            SearchResult<License> results = dataAccess.searchByLastName(criteria);
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
     * Searches for providers with Chiropractic license using the city filter.
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
    public SearchResult<License> searchByCity(ChiropracticLicenseSearchCriteria criteria) throws ParsingException,
            ServiceException {
        String signature = "ChiropracticLicenseServiceImpl#searchByCity";
        LogUtility.traceEntry(getLog(), signature, new String[] { "criteria" }, new Object[] { criteria });
        try {
            SearchResult<License> results = dataAccess.searchByCity(criteria);
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
     * Searches for providers with Chiropractic license using the zipcode filter.
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
    public SearchResult<License> searchByZipCode(ChiropracticLicenseSearchCriteria criteria) throws ParsingException,
            ServiceException {
        String signature = "ChiropracticLicenseServiceImpl#searchByZipCode";
        LogUtility.traceEntry(getLog(), signature, new String[] { "criteria" }, new Object[] { criteria });
        try {
            SearchResult<License> results = dataAccess.searchByZipCode(criteria);
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
     * Searches for providers with Chiropractic license using the sounds like name filter.
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
    public SearchResult<License> searchBySoundingLikeLastName(ChiropracticLicenseSearchCriteria criteria)
            throws ParsingException, ServiceException {
        String signature = "ChiropracticLicenseServiceImpl#searchBySoundingLikeLastName";
        LogUtility.traceEntry(getLog(), signature, new String[] { "criteria" }, new Object[] { criteria });
        try {
            SearchResult<License> results = dataAccess.searchBySoundingLikeLastName(criteria);
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
     * Retrieves all licensees that have disciplinary action record from the source site.
     * 
     * @param criteria
     *            the pagination criteria
     * @return the matched results
     * @throws ParsingException
     *             if any parsing errors are encountered
     * @throws ServiceException
     *             for any other exceptions encountered
     */
    @WebMethod
    public SearchResult<License> getDeniedList(ChiropracticLicenseSearchCriteria criteria) throws ParsingException,
            ServiceException {
        String signature = "ChiropracticLicenseServiceImpl#getDeniedList";
        LogUtility.traceEntry(getLog(), signature, null, null);
        try {
            SearchResult<License> results = dataAccess.getDeniedList(criteria);
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
            dataAccess = (ChiropracticLicenseDAO) ctx
                    .lookup("ejblocal:gov.medicaid.screening.dao.ChiropracticLicenseDAO");
        } catch (NamingException e) {
            throw new ConfigurationException("Failed to create data access", e);
        }
    }
}