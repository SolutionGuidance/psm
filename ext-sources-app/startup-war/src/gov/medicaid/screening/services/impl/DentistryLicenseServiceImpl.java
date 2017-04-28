/*
 * Copyright (C) 2013 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.screening.services.impl;

import gov.medicaid.entities.DentistryLicenseSearchCriteria;
import gov.medicaid.entities.License;
import gov.medicaid.entities.SearchResult;
import gov.medicaid.screening.dao.DentistryLicenseDAO;
import gov.medicaid.screening.services.ConfigurationException;
import gov.medicaid.screening.services.DentistryLicenseService;
import gov.medicaid.screening.services.ErrorCode;
import gov.medicaid.screening.services.ParsingException;
import gov.medicaid.screening.services.ServiceException;

import javax.annotation.PostConstruct;
import javax.jws.WebMethod;
import javax.jws.WebService;
import javax.naming.InitialContext;
import javax.naming.NamingException;

/**
 * This is the web service implementation of the <code>DentistryLicenseServiceImpl</code>. It is exposed as a web
 * service by the container.
 * 
 * @author cyberjag
 * @version 1.0
 */
@WebService
public class DentistryLicenseServiceImpl extends AbstractBaseService implements DentistryLicenseService {

    /**
     * Dietetics And Nutrition Practice License data access.
     */
    private DentistryLicenseDAO dataAccess;

    /**
     * Searches for providers with Dentistry license using the search filter.
     * 
     * @param criteria
     *            the search criteria
     * @return the matched results
     * @throws ParsingException
     *             if any parsing errors are encountered
     * @throws ServiceException
     *             for any other exceptions encountered
     */
    @Override
    @WebMethod
    public SearchResult<License> search(DentistryLicenseSearchCriteria criteria) throws ParsingException,
            ServiceException {
        String signature = "DentistryLicenseServiceImpl#search";
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
     * This method checks that all required injection fields are in fact provided.
     * 
     * @throws ConfigurationException
     *             - If there are required injection fields that are not injected.
     */
    @PostConstruct
    protected void init() {
        super.init();
        try {
            InitialContext ctx = new InitialContext();
            dataAccess = (DentistryLicenseDAO) ctx.lookup("ejblocal:gov.medicaid.screening.dao.DentistryLicenseDAO");
        } catch (NamingException e) {
            throw new ConfigurationException("Failed to create data access", e);
        }
    }
}
