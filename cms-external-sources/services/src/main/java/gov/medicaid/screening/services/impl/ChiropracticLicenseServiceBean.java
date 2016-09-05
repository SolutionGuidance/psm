/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.screening.services.impl;

import gov.medicaid.entities.ChiropracticLicenseSearchCriteria;
import gov.medicaid.entities.License;
import gov.medicaid.entities.SearchResult;
import gov.medicaid.screening.dao.ChiropracticLicenseDAO;
import gov.medicaid.screening.services.ChiropracticLicenseService;
import gov.medicaid.screening.services.ErrorCode;
import gov.medicaid.screening.services.ParsingException;
import gov.medicaid.screening.services.ServiceException;

import javax.ejb.EJB;
import javax.ejb.Remote;
import javax.ejb.Stateless;
import javax.ejb.TransactionAttribute;
import javax.ejb.TransactionAttributeType;
import javax.ejb.TransactionManagement;
import javax.ejb.TransactionManagementType;
import javax.jws.WebMethod;
import javax.jws.WebService;

/**
 * This is an EJB implementation of the <code>ChiropracticLicenseService</code>. It is exposed as a web service by the
 * container.
 *
 * @author sampath01, j3_guile
 * @version 1.0
 */
@WebService
@Stateless
@Remote(ChiropracticLicenseService.class)
@TransactionManagement(TransactionManagementType.CONTAINER)
@TransactionAttribute(TransactionAttributeType.REQUIRED)
public class ChiropracticLicenseServiceBean extends BaseService implements ChiropracticLicenseService {

    /**
     * Chiropractic Practice License data access.
     */
    @EJB
    private ChiropracticLicenseDAO dataAccess;

    /**
     * Searches for providers with Chiropractic license using the name filter.
     *
     * @param criteria the search criteria
     * @return the matched results
     * @throws ParsingException if any parsing errors are encountered
     * @throws ServiceException for any other exceptions encountered
     */
    @WebMethod
    public SearchResult<License> searchByLastName(ChiropracticLicenseSearchCriteria criteria) throws ParsingException,
        ServiceException {
        String signature = "ChiropracticLicenseServiceImpl#searchByLastName";
        LogUtil.traceEntry(getLog(), signature, new String[]{"criteria"}, new Object[]{criteria});
        try {
            SearchResult<License> results = dataAccess.searchByLastName(criteria);
            return LogUtil.traceExit(getLog(), signature, results);
        } catch (ServiceException e) {
            LogUtil.traceError(getLog(), signature, e);
            throw e;
        } catch (Throwable e) {
            LogUtil.traceError(getLog(), signature, e);
            throw new ServiceException(ErrorCode.MITA99999.getDesc());
        }
    }

    /**
     * Searches for providers with Chiropractic license using the city filter.
     *
     * @param criteria the search criteria
     * @return the matched results
     * @throws ParsingException if any parsing errors are encountered
     * @throws ServiceException for any other exceptions encountered
     */
    @WebMethod
    public SearchResult<License> searchByCity(ChiropracticLicenseSearchCriteria criteria) throws ParsingException,
        ServiceException {
        String signature = "ChiropracticLicenseServiceImpl#searchByCity";
        LogUtil.traceEntry(getLog(), signature, new String[]{"criteria"}, new Object[]{criteria});
        try {
            SearchResult<License> results = dataAccess.searchByCity(criteria);
            return LogUtil.traceExit(getLog(), signature, results);
        } catch (ServiceException e) {
            LogUtil.traceError(getLog(), signature, e);
            throw e;
        } catch (Throwable e) {
            LogUtil.traceError(getLog(), signature, e);
            throw new ServiceException(ErrorCode.MITA99999.getDesc());
        }
    }

    /**
     * Searches for providers with Chiropractic license using the zipcode filter.
     *
     * @param criteria the search criteria
     * @return the matched results
     * @throws ParsingException if any parsing errors are encountered
     * @throws ServiceException for any other exceptions encountered
     */
    @WebMethod
    public SearchResult<License> searchByZipCode(ChiropracticLicenseSearchCriteria criteria) throws ParsingException,
        ServiceException {
        String signature = "ChiropracticLicenseServiceImpl#searchByZipCode";
        LogUtil.traceEntry(getLog(), signature, new String[]{"criteria"}, new Object[]{criteria});
        try {
            SearchResult<License> results = dataAccess.searchByZipCode(criteria);
            return LogUtil.traceExit(getLog(), signature, results);
        } catch (ServiceException e) {
            LogUtil.traceError(getLog(), signature, e);
            throw e;
        } catch (Throwable e) {
            LogUtil.traceError(getLog(), signature, e);
            throw new ServiceException(ErrorCode.MITA99999.getDesc());
        }
    }

    /**
     * Searches for providers with Chiropractic license using the sounds like name filter.
     *
     * @param criteria the search criteria
     * @return the matched results
     * @throws ParsingException if any parsing errors are encountered
     * @throws ServiceException for any other exceptions encountered
     */
    @WebMethod
    public SearchResult<License> searchBySoundingLikeLastName(ChiropracticLicenseSearchCriteria criteria)
        throws ParsingException, ServiceException {
        String signature = "ChiropracticLicenseServiceImpl#searchBySoundingLikeLastName";
        LogUtil.traceEntry(getLog(), signature, new String[]{"criteria"}, new Object[]{criteria});
        try {
            SearchResult<License> results = dataAccess.searchBySoundingLikeLastName(criteria);
            return LogUtil.traceExit(getLog(), signature, results);
        } catch (ServiceException e) {
            LogUtil.traceError(getLog(), signature, e);
            throw e;
        } catch (Throwable e) {
            LogUtil.traceError(getLog(), signature, e);
            throw new ServiceException(ErrorCode.MITA99999.getDesc());
        }
    }

    /**
     * Retrieves all licensees that have disciplinary action record from the source site.
     *
     * @param criteria the pagination criteria
     * @return the matched results
     * @throws ParsingException if any parsing errors are encountered
     * @throws ServiceException for any other exceptions encountered
     */
    @WebMethod
    public SearchResult<License> getDeniedList(ChiropracticLicenseSearchCriteria criteria) throws ParsingException,
        ServiceException {
        String signature = "ChiropracticLicenseServiceImpl#getDeniedList";
        LogUtil.traceEntry(getLog(), signature, null, null);
        try {
            SearchResult<License> results = dataAccess.getDeniedList(criteria);
            return LogUtil.traceExit(getLog(), signature, results);
        } catch (ServiceException e) {
            LogUtil.traceError(getLog(), signature, e);
            throw e;
        } catch (Throwable e) {
            LogUtil.traceError(getLog(), signature, e);
            throw new ServiceException(ErrorCode.MITA99999.getDesc());
        }
    }
}