/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.screening.services.impl;

import gov.medicaid.entities.License;
import gov.medicaid.entities.PodiatricMedicineLicenseSearchByLicenseNumberCriteria;
import gov.medicaid.entities.PodiatricMedicineLicenseSearchByNameCriteria;
import gov.medicaid.entities.SearchResult;
import gov.medicaid.screening.dao.PodiatricMedicineLicenseDAO;
import gov.medicaid.screening.services.ConfigurationException;
import gov.medicaid.screening.services.PodiatricMedicineLicenseService;
import gov.medicaid.screening.services.ServiceException;

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
 * This is an EJB implementation of the <code>PodiatricMedicineLicenseService</code>. It is exposed as a web service by
 * the container.
 *
 * @author argolite, j3_guile
 * @version 1.0
 */
@WebService
@Stateless
@Remote(PodiatricMedicineLicenseService.class)
@TransactionManagement(TransactionManagementType.CONTAINER)
public class PodiatricMedicineLicenseServiceBean extends BaseService implements PodiatricMedicineLicenseService {

    /**
     * Podiatric Medicine License data access.
     */
    @EJB
    private PodiatricMedicineLicenseDAO podiatricMedicineLicenseDAO;

    /**
     * Default empty constructor.
     */
    public PodiatricMedicineLicenseServiceBean() {
    }

    /**
     * Searches for Podiatric Medicine Licenses by name.
     *
     * @param criteria the search criteria
     * @return the matched results
     * @throws IllegalArgumentException if any parameters are invalid
     * @throws ServiceException for any other exceptions encountered
     */
    @WebMethod
    @TransactionAttribute(TransactionAttributeType.REQUIRED)
    public SearchResult<License> searchByName(PodiatricMedicineLicenseSearchByNameCriteria criteria)
        throws ServiceException {
        String signature = "PodiatricMedicineLicenseServiceBean#searchByName";
        LogUtil.traceEntry(getLog(), signature, new String[]{"criteria"}, new Object[]{criteria});
        try {
            SearchResult<License> results = podiatricMedicineLicenseDAO.searchByName(criteria);
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
     * Searches for Podiatric Medicine Licenses by license number.
     *
     * @param criteria the search criteria
     * @return the matched results
     * @throws IllegalArgumentException if any parameters are invalid
     * @throws ServiceException for any other exceptions encountered
     */
    @WebMethod
    @TransactionAttribute(TransactionAttributeType.REQUIRED)
    public SearchResult<License> searchByLicenseNumber(PodiatricMedicineLicenseSearchByLicenseNumberCriteria criteria)
        throws ServiceException {
        String signature = "PodiatricMedicineLicenseServiceBean#searchByLicenseNumber";
        LogUtil.traceEntry(getLog(), signature, new String[]{"criteria"}, new Object[]{criteria});
        try {
            SearchResult<License> results = podiatricMedicineLicenseDAO.searchByLicenseNumber(criteria);
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
        if (podiatricMedicineLicenseDAO == null) {
            throw new ConfigurationException("The podiatricMedicineLicenseDAO must be configured.");
        }
    }
}
