/*
 * Copyright (C) 2013 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.screening.services.impl;

import gov.medicaid.entities.License;
import gov.medicaid.entities.PhysicalTherapyLicenseSearchCriteria;
import gov.medicaid.entities.SearchResult;
import gov.medicaid.screening.dao.PhysicalTherapyLicenseDAO;
import gov.medicaid.screening.services.ConfigurationException;
import gov.medicaid.screening.services.ParsingException;
import gov.medicaid.screening.services.PhysicalTherapyLicenseService;
import gov.medicaid.screening.services.ServiceException;

import javax.annotation.PostConstruct;
import javax.jws.WebMethod;
import javax.jws.WebService;
import javax.naming.InitialContext;
import javax.naming.NamingException;

/**
 * This is the webservice implementation of the <code>PhysicalTherapyLicenseService</code>. It is exposed as a web
 * service by the container.
 * 
 * @author cyberjag
 * @version 1.0
 */
@WebService
public class PhysicalTherapyLicenseServiceImpl extends AbstractBaseService implements PhysicalTherapyLicenseService {

    /**
     * Physical Therapy License data access.
     */
    private PhysicalTherapyLicenseDAO dataAccess;

    /**
     * Searches for providers with physical therapy license using the name filter.
     * 
     * @param criteria
     *            the search criteria
     * @return the matched results
     * 
     * @throws ParsingException
     *             if any parsing errors are encountered
     * @throws ServiceException
     *             for any other errors encountered
     */
    @WebMethod
    public SearchResult<License> searchByName(PhysicalTherapyLicenseSearchCriteria criteria) throws ServiceException {
        String signature = "PhysicalTherapyLicenseServiceImpl#searchByName";
        LogUtility.traceEntry(getLog(), signature, new String[] { "criteria" }, new Object[] { criteria });

        SearchResult<License> results = dataAccess.searchByName(criteria);
        return LogUtility.traceExit(getLog(), signature, results);
    }

    /**
     * Searches for providers with physical therapy license using the license number filter.
     * 
     * @param criteria
     *            the search criteria
     * @return the matched results
     * 
     * @throws ParsingException
     *             if any parsing errors are encountered
     * @throws ServiceException
     *             for any other errors encountered
     */
    @WebMethod
    public SearchResult<License> searchByLicenseNumber(PhysicalTherapyLicenseSearchCriteria criteria)
            throws ServiceException {
        String signature = "PhysicalTherapyLicenseServiceImpl#searchByLicenseNumber";
        LogUtility.traceEntry(getLog(), signature, new String[] { "criteria" }, new Object[] { criteria });

        SearchResult<License> results = dataAccess.searchByLicenseNumber(criteria);
        return LogUtility.traceExit(getLog(), signature, results);
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
            dataAccess = (PhysicalTherapyLicenseDAO) ctx
                    .lookup("ejblocal:gov.medicaid.screening.dao.PhysicalTherapyLicenseDAO");
        } catch (NamingException e) {
            throw new ConfigurationException("Failed to create data access", e);
        }
    }

}