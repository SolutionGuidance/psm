/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.screening.services.impl;

import gov.medicaid.entities.License;
import gov.medicaid.entities.SearchResult;
import gov.medicaid.entities.SocialWorkLicenseSearchByLicenseNumberCriteria;
import gov.medicaid.entities.SocialWorkLicenseSearchByNameCriteria;
import gov.medicaid.screening.dao.SocialWorkLicenseDAO;
import gov.medicaid.screening.services.ConfigurationException;
import gov.medicaid.screening.services.ServiceException;
import gov.medicaid.screening.services.SocialWorkLicenseService;

import javax.annotation.PostConstruct;
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
 * This is an EJB implementation of the <code>SocialWorkLicenseService</code>. It is exposed as a web service by the
 * container.
 *
 * @author argolite, j3_guile
 * @version 1.0
 */
@WebService
@Stateless
@Remote(SocialWorkLicenseService.class)
@TransactionManagement(TransactionManagementType.CONTAINER)
public class SocialWorkLicenseServiceBean extends BaseService implements SocialWorkLicenseService {

    /**
     * Social work license data access.
     */
    @EJB
    private SocialWorkLicenseDAO socialWorkLicenseDAO;

    /**
     * Default empty constructor.
     */
    public SocialWorkLicenseServiceBean() {
    }

    /**
     * This method gets the applicable licenses that meet the search criteria, which only focuses on the name of the
     * licensee. If none available, the search result will be empty..
     *
     * @param criteria the search criteria
     * @return the search result with the applicable providers
     * @throws IllegalArgumentException if criteria is null
     * @throws IllegalArgumentException if criteria.pageNumber < 0
     * @throws IllegalArgumentException if criteria.pageSize < 1 unless criteria.pageNumber <= 0
     * @throws ServiceException If an error occurs while performing the operation
     */
    @WebMethod
    @TransactionAttribute(TransactionAttributeType.REQUIRED)
    public SearchResult<License> searchByName(SocialWorkLicenseSearchByNameCriteria criteria) throws ServiceException {
        String signature = "SocialWorkLicenseServiceBean#searchByName";
        LogUtil.traceEntry(getLog(), signature, new String[]{"criteria"}, new Object[]{criteria});
        try {
            SearchResult<License> results = socialWorkLicenseDAO.searchByName(criteria);
            return LogUtil.traceExit(getLog(), signature, results);
        } catch (IllegalArgumentException e) {
            LogUtil.traceError(getLog(), signature, e);
            throw e;
        } catch (ServiceException e) {
            LogUtil.traceError(getLog(), signature, e);
            throw e;
        }
    }

    /**
     * This method gets the applicable licenses that meet the search criteria, which only focuses on the license number
     * of the licensee. If none available, the search result will be empty.
     *
     * @param criteria the search criteria
     * @return the search result with the applicable providers
     * @throws IllegalArgumentException if criteria is null
     * @throws IllegalArgumentException if criteria.pageNumber < 0
     * @throws IllegalArgumentException if criteria.pageSize < 1 unless criteria.pageNumber <= 0
     * @throws ServiceException If an error occurs while performing the operation
     */
    @WebMethod
    @TransactionAttribute(TransactionAttributeType.REQUIRED)
    public SearchResult<License> searchByLicenseNumber(SocialWorkLicenseSearchByLicenseNumberCriteria criteria)
        throws ServiceException {
        String signature = "SocialWorkLicenseServiceBean#searchByLicenseNumber";
        LogUtil.traceEntry(getLog(), signature, new String[]{"criteria"}, new Object[]{criteria});
        try {
            SearchResult<License> results = socialWorkLicenseDAO.searchByLicenseNumber(criteria);
            return LogUtil.traceExit(getLog(), signature, results);
        } catch (IllegalArgumentException e) {
            LogUtil.traceError(getLog(), signature, e);
            throw e;
        } catch (ServiceException e) {
            LogUtil.traceError(getLog(), signature, e);
            throw e;
        }
    }

    /**
     * Checks if the container properly initialized the injected fields.
     *
     * @throws ConfigurationException if any injected field is null
     */
    @PostConstruct
    protected void init() {
        if (socialWorkLicenseDAO == null) {
            throw new ConfigurationException("The socialWorkLicenseDAO must be configured.");
        }
    }
}
