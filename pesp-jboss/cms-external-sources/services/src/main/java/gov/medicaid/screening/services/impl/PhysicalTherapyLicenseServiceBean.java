/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.screening.services.impl;

import gov.medicaid.entities.License;
import gov.medicaid.entities.PhysicalTherapyLicenseSearchCriteria;
import gov.medicaid.entities.SearchResult;
import gov.medicaid.screening.dao.PhysicalTherapyLicenseDAO;
import gov.medicaid.screening.services.ParsingException;
import gov.medicaid.screening.services.PhysicalTherapyLicenseService;
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
 * This is an EJB implementation of the <code>PhysicalTherapyLicenseService</code>. It is exposed as a web service by
 * the container.
 *
 * @author sampath01, j3_guile
 * @version 1.0
 */
@WebService
@Stateless
@Remote(PhysicalTherapyLicenseService.class)
@TransactionManagement(value = TransactionManagementType.CONTAINER)
@TransactionAttribute(value = TransactionAttributeType.REQUIRED)
public class PhysicalTherapyLicenseServiceBean extends BaseService implements PhysicalTherapyLicenseService {

    /**
     * Physical Therapy License data access.
     */
    @EJB
    private PhysicalTherapyLicenseDAO dataAccess;

    /**
     * Searches for providers with physical therapy license using the name filter.
     *
     * @param criteria the search criteria
     * @return the matched results
     *
     * @throws ParsingException if any parsing errors are encountered
     * @throws ServiceException for any other errors encountered
     */
    @WebMethod
    public SearchResult<License> searchByName(PhysicalTherapyLicenseSearchCriteria criteria) throws ServiceException {
        String signature = "PhysicalTherapyLicenseServiceImpl#searchByName";
        LogUtil.traceEntry(getLog(), signature, new String[]{"criteria"}, new Object[]{criteria});

        SearchResult<License> results = dataAccess.searchByName(criteria);
        return LogUtil.traceExit(getLog(), signature, results);
    }

    /**
     * Searches for providers with physical therapy license using the license number filter.
     *
     * @param criteria the search criteria
     * @return the matched results
     *
     * @throws ParsingException if any parsing errors are encountered
     * @throws ServiceException for any other errors encountered
     */
    @WebMethod
    public SearchResult<License> searchByLicenseNumber(PhysicalTherapyLicenseSearchCriteria criteria)
        throws ServiceException {
        String signature = "PhysicalTherapyLicenseServiceImpl#searchByLicenseNumber";
        LogUtil.traceEntry(getLog(), signature, new String[]{"criteria"}, new Object[]{criteria});

        SearchResult<License> results = dataAccess.searchByLicenseNumber(criteria);
        return LogUtil.traceExit(getLog(), signature, results);
    }
}