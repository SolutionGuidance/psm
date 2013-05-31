/*
 * Copyright (C) 2013 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.screening.services.impl;

import gov.medicaid.entities.NurseAnesthetistsSearchCriteria;
import gov.medicaid.entities.ProviderProfile;
import gov.medicaid.screening.dao.NurseAnesthetistsLicenseDAO;
import gov.medicaid.screening.services.ConfigurationException;
import gov.medicaid.screening.services.NurseAnesthetistsLicenseService;
import gov.medicaid.screening.services.ServiceException;

import javax.annotation.PostConstruct;
import javax.jws.WebMethod;
import javax.jws.WebService;
import javax.naming.InitialContext;
import javax.naming.NamingException;

/**
 * This is the web service implementation of the <code>NurseAnesthetistsLicenseService</code>. It is exposed as a web
 * service by the container.
 * 
 * @author cyberjag
 * @version 1.0
 */
@WebService
public class NurseAnesthetistsLicenseServiceImpl extends AbstractBaseService implements NurseAnesthetistsLicenseService {

    /**
     * Nurse Anesthetists License data access.
     */
    private NurseAnesthetistsLicenseDAO nurseAnesthetistsLicenseDAO;

    /**
     * Default empty constructor.
     */
    public NurseAnesthetistsLicenseServiceImpl() {
    }

    /**
     * Searches for Nurse Anesthetists license.
     * 
     * @param criteria
     *            the search criteria
     * @return the matched profile, null if not matched
     * @throws IllegalArgumentException
     *             if the criteria is null
     * @throws IllegalArgumentException
     *             may be thrown if a parameter needed by the source site is invalid
     * @throws ServiceException
     *             for any other exceptions encountered
     */
    @WebMethod
    public ProviderProfile search(NurseAnesthetistsSearchCriteria criteria) throws ServiceException {
        String signature = "NurseAnesthetistsLicenseServiceBean#search";
        LogUtility.traceEntry(getLog(), signature, new String[] { "criteria" }, new Object[] { criteria });
        try {
            ProviderProfile result = nurseAnesthetistsLicenseDAO.search(criteria);
            return LogUtility.traceExit(getLog(), signature, result);
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
            nurseAnesthetistsLicenseDAO = (NurseAnesthetistsLicenseDAO) ctx
                    .lookup("ejblocal:gov.medicaid.screening.dao.NurseAnesthetistsLicenseDAO");
        } catch (NamingException e) {
            throw new ConfigurationException("Failed to create data access", e);
        }
    }
}