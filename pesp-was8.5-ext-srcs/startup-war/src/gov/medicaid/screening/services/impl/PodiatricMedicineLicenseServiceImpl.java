/*
 * Copyright (C) 2013 TopCoder Inc., All Rights Reserved.
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
import javax.jws.WebMethod;
import javax.jws.WebService;
import javax.naming.InitialContext;
import javax.naming.NamingException;

/**
 * This is the webservice implementation of the <code>PodiatricMedicineLicenseService</code>. It is exposed as a web
 * service by the container.
 * 
 * @author cyberjag
 * @version 1.0
 */
@WebService
public class PodiatricMedicineLicenseServiceImpl extends AbstractBaseService implements PodiatricMedicineLicenseService {

    /**
     * Podiatric Medicine License data access.
     */
    private PodiatricMedicineLicenseDAO podiatricMedicineLicenseDAO;

    /**
     * Default empty constructor.
     */
    public PodiatricMedicineLicenseServiceImpl() {
    }

    /**
     * Searches for Podiatric Medicine Licenses by name.
     * 
     * @param criteria
     *            the search criteria
     * @return the matched results
     * @throws IllegalArgumentException
     *             if any parameters are invalid
     * @throws ServiceException
     *             for any other exceptions encountered
     */
    @WebMethod
    public SearchResult<License> searchByName(PodiatricMedicineLicenseSearchByNameCriteria criteria)
            throws ServiceException {
        String signature = "PodiatricMedicineLicenseServiceBean#searchByName";
        LogUtility.traceEntry(getLog(), signature, new String[] { "criteria" }, new Object[] { criteria });
        try {
            SearchResult<License> results = podiatricMedicineLicenseDAO.searchByName(criteria);
            return LogUtility.traceExit(getLog(), signature, results);
        } catch (IllegalArgumentException e) {
            LogUtility.traceError(getLog(), signature, e);
            throw e;
        } catch (ServiceException e) {
            LogUtility.traceError(getLog(), signature, e);
            throw e;
        }
    }

    /**
     * Searches for Podiatric Medicine Licenses by license number.
     * 
     * @param criteria
     *            the search criteria
     * @return the matched results
     * @throws IllegalArgumentException
     *             if any parameters are invalid
     * @throws ServiceException
     *             for any other exceptions encountered
     */
    @WebMethod
    public SearchResult<License> searchByLicenseNumber(PodiatricMedicineLicenseSearchByLicenseNumberCriteria criteria)
            throws ServiceException {
        String signature = "PodiatricMedicineLicenseServiceBean#searchByLicenseNumber";
        LogUtility.traceEntry(getLog(), signature, new String[] { "criteria" }, new Object[] { criteria });
        try {
            SearchResult<License> results = podiatricMedicineLicenseDAO.searchByLicenseNumber(criteria);
            return LogUtility.traceExit(getLog(), signature, results);
        } catch (IllegalArgumentException e) {
            LogUtility.traceError(getLog(), signature, e);
            throw e;
        } catch (ServiceException e) {
            LogUtility.traceError(getLog(), signature, e);
            throw e;
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
            podiatricMedicineLicenseDAO = (PodiatricMedicineLicenseDAO) ctx
                    .lookup("ejblocal:gov.medicaid.screening.dao.PodiatricMedicineLicenseDAO");
        } catch (NamingException e) {
            throw new ConfigurationException("Failed to create data access", e);
        }
    }
}
