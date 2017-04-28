/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
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

import javax.ejb.EJB;
import javax.ejb.Remote;
import javax.ejb.Stateless;
import javax.ejb.TransactionAttribute;
import javax.ejb.TransactionAttributeType;
import javax.ejb.TransactionManagement;
import javax.ejb.TransactionManagementType;
import javax.jws.WebMethod;

/**
 * This is an EJB implementation of the <code>BaseLicenseServiceImpl</code>. It is exposed as a web service by the
 * container.
 *
 * @author sampath01, j3_guile
 * @version 1.0
 */
@Stateless
@Remote(BBHTLicenseService.class)
@TransactionManagement(TransactionManagementType.CONTAINER)
public class BBHTLicenseServiceBean extends BaseService implements BBHTLicenseService {

    /**
     * Board of Behavioral Health and Therapy License data access.
     */
    @EJB
    private BBHTLicenseDAO dataAccess;

    /**
     * Default empty constructor.
     */
    public BBHTLicenseServiceBean() {
    }

    /**
     * Searches for providers with BBHT license using the given criteria.
     *
     * @param criteria the search criteria
     * @return the matched results
     * @throws ParsingException if any parsing errors are encountered
     * @throws ServiceException for any other exceptions encountered
     */
    @WebMethod
    @TransactionAttribute(TransactionAttributeType.REQUIRED)
    public SearchResult<License> search(BBHTLicenseSearchCriteria criteria) throws ParsingException, ServiceException {
        String signature = "BBHTLicenseServiceImpl#search";
        LogUtil.traceEntry(getLog(), signature, new String[]{"criteria"}, new Object[]{criteria});
        try {
            SearchResult<License> results = dataAccess.search(criteria);
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
     * Performs verification of the given license.
     *
     * @param license the license to verify
     * @return true if the license has been verified, false otherwise
     *
     * @throws ParsingException if any parsing errors are encountered
     * @throws ServiceException for any other exceptions encountered
     */
    @WebMethod
    @TransactionAttribute(TransactionAttributeType.REQUIRED)
    public boolean verifyLicense(License license) throws ParsingException, ServiceException {
        String signature = "BBHTLicenseServiceImpl#verifyLicense";
        LogUtil.traceEntry(getLog(), signature, new String[]{"license"}, new Object[]{license});
        try {
            boolean result = dataAccess.verifyLicense(license);
            return LogUtil.traceExit(getLog(), signature, Boolean.valueOf(result));
        } catch (ServiceException e) {
            LogUtil.traceError(getLog(), signature, e);
            throw e;
        } catch (Throwable e) {
            LogUtil.traceError(getLog(), signature, e);
            throw new ServiceException(ErrorCode.MITA99999.getDesc());
        }
    }

    /**
     * Performs renewal of the given license. Currently unsupported.
     *
     * @param license the license to renew
     *
     * @throws ParsingException if any parsing errors are encountered
     * @throws ServiceException for any other exceptions encountered
     */
    public void renew(License license) throws ParsingException, ServiceException {
        throw new UnsupportedOperationException("Operation currently unsupported");
    }

}
