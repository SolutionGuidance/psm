/*
 * Copyright (C) 2013 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.screening.services.impl;

import gov.medicaid.entities.License;
import gov.medicaid.entities.MedicalPracticeLicenseSearchCriteria;
import gov.medicaid.entities.SearchResult;
import gov.medicaid.screening.dao.MedicalPracticeLicenseDAO;
import gov.medicaid.screening.services.ConfigurationException;
import gov.medicaid.screening.services.ErrorCode;
import gov.medicaid.screening.services.MedicalPracticeLicenseService;
import gov.medicaid.screening.services.ParsingException;
import gov.medicaid.screening.services.ServiceException;

import javax.annotation.PostConstruct;
import javax.jws.WebMethod;
import javax.jws.WebService;
import javax.naming.InitialContext;
import javax.naming.NamingException;

/**
 * This is the web service implementation of the <code>PharmacyLicenseService</code>. It is exposed as a web service by
 * the container.
 * 
 * @author cyberjag
 * @version 1.0
 */
@WebService
public class MedicalPracticeLicenseServiceImpl extends AbstractBaseService implements MedicalPracticeLicenseService {

    /**
     * Medical Practice License data access.
     */
    private MedicalPracticeLicenseDAO dataAccess;

    /**
     * Searches for providers with Medical Practice license using the name filter.
     * 
     * @param criteria
     *            the search criteria
     * @return the matched results
     * @throws ParsingException
     *             if any parsing errors are encountered
     * @throws ServiceException
     *             for any other errors encountered
     */
    @WebMethod
    public SearchResult<License> searchByName(MedicalPracticeLicenseSearchCriteria criteria) throws ParsingException,
            ServiceException {
        String signature = "MedicalPracticeLicenseServiceImpl#searchByName";
        LogUtility.traceEntry(getLog(), signature, new String[] { "criteria" }, new Object[] { criteria });
        try {
            SearchResult<License> results = dataAccess.searchByName(criteria);
            return LogUtility.traceExit(getLog(), signature, results);
        } catch (ServiceException e) {
            LogUtility.traceError(getLog(), signature, e);
            throw e;
        } catch (Throwable e) {
            LogUtility.traceError(getLog(), signature, e);
            throw new ServiceException(ErrorCode.MITA99999.getDesc(), e);
        }
    }

    /**
     * Searches for providers with Medical Practice license using the specialty filter.
     * 
     * @param criteria
     *            the search criteria
     * @return the matched results
     * @throws ParsingException
     *             if any parsing errors are encountered
     * @throws ServiceException
     *             for any other errors encountered
     */
    @WebMethod
    public SearchResult<License> searchBySpecialty(MedicalPracticeLicenseSearchCriteria criteria)
            throws ParsingException, ServiceException {
        String signature = "MedicalPracticeLicenseServiceImpl#searchBySpecialty";
        LogUtility.traceEntry(getLog(), signature, new String[] { "criteria" }, new Object[] { criteria });
        try {
            SearchResult<License> results = dataAccess.searchBySpecialty(criteria);
            return LogUtility.traceExit(getLog(), signature, results);
        } catch (ServiceException e) {
            LogUtility.traceError(getLog(), signature, e);
            throw e;
        } catch (Throwable e) {
            LogUtility.traceError(getLog(), signature, e);
            throw new ServiceException(ErrorCode.MITA99999.getDesc(), e);
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
            dataAccess = (MedicalPracticeLicenseDAO) ctx
                    .lookup("ejblocal:gov.medicaid.screening.dao.MedicalPracticeLicenseDAO");
        } catch (NamingException e) {
            throw new ConfigurationException("Failed to create data access", e);
        }
    }
}