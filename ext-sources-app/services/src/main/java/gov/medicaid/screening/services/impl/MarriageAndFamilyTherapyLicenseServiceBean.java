/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.screening.services.impl;

import gov.medicaid.entities.License;
import gov.medicaid.entities.MarriageAndFamilyTherapyLicenseCriteria;
import gov.medicaid.entities.SearchResult;
import gov.medicaid.screening.dao.MarriageAndFamilyTherapyLicenseDAO;
import gov.medicaid.screening.services.ErrorCode;
import gov.medicaid.screening.services.MarriageAndFamilyTherapyLicenseService;
import gov.medicaid.screening.services.ParsingException;
import gov.medicaid.screening.services.ServiceException;

import javax.ejb.EJB;
import javax.ejb.Remote;
import javax.ejb.Stateless;
import javax.ejb.TransactionAttribute;
import javax.ejb.TransactionAttributeType;
import javax.ejb.TransactionManagement;
import javax.ejb.TransactionManagementType;

/**
 * This is an EJB implementation of the <code>MarriageAndFamilyTherapyLicenseService</code>. It is exposed as a web
 * service by the container.
 *
 * @author sampath01, j3_guile
 * @version 1.0
 */
@Stateless
@Remote(MarriageAndFamilyTherapyLicenseService.class)
@TransactionManagement(value = TransactionManagementType.CONTAINER)
@TransactionAttribute(value = TransactionAttributeType.REQUIRED)
public class MarriageAndFamilyTherapyLicenseServiceBean extends BaseService implements
    MarriageAndFamilyTherapyLicenseService {

    /**
     * Marriage and Family Therapy License data access.
     */
    @EJB
    private MarriageAndFamilyTherapyLicenseDAO dataAccess;

    /**
     * Searches for providers with Marriage and Family therapy license using the name filter.
     *
     * @param criteria the search criteria
     * @return the matched results
     * @throws ParsingException if any parsing errors are encountered
     * @throws ServiceException for any other errors encountered
     */
    public SearchResult<License> searchByName(MarriageAndFamilyTherapyLicenseCriteria criteria)
        throws ServiceException {
        String signature = "MarriageAndFamilyTherapyLicenseServiceImpl#searchByName";
        LogUtil.traceEntry(getLog(), signature, new String[]{"criteria"}, new Object[]{criteria});

        try {
            SearchResult<License> results = dataAccess.searchByName(criteria);
            return LogUtil.traceExit(getLog(), signature, results);
        } catch (ServiceException e) {
            LogUtil.traceError(getLog(), signature, e);
            throw e;
        } catch (Throwable e) {
            ServiceException ex = new ServiceException(ErrorCode.MITA99999.getDesc(), e);
            LogUtil.traceError(getLog(), signature, ex);
            throw ex;
        }
    }

    /**
     * Searches for providers with Marriage and Family therapy license using the license number filter.
     *
     * @param criteria the search criteria
     * @return the matched results
     * @throws ParsingException if any parsing errors are encountered
     * @throws ServiceException for any other errors encountered
     */
    public SearchResult<License> searchByLicenseNumber(MarriageAndFamilyTherapyLicenseCriteria criteria)
        throws ServiceException {
        String signature = "MarriageAndFamilyTherapyLicenseServiceImpl#searchByLicenseNumber";
        LogUtil.traceEntry(getLog(), signature, new String[]{"criteria"}, new Object[]{criteria});

        try {
            SearchResult<License> results = dataAccess.searchByLicenseNumber(criteria);
            return LogUtil.traceExit(getLog(), signature, results);
        } catch (ServiceException e) {
            LogUtil.traceError(getLog(), signature, e);
            throw e;
        } catch (Throwable e) {
            ServiceException ex = new ServiceException(ErrorCode.MITA99999.getDesc(), e);
            LogUtil.traceError(getLog(), signature, ex);
            throw ex;
        }
    }
}