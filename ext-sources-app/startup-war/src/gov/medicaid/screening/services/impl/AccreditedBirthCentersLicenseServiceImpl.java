/*
 * Copyright (C) 2013 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.screening.services.impl;

import gov.medicaid.entities.AccreditedBirthCenter;
import gov.medicaid.entities.SearchResult;
import gov.medicaid.screening.dao.AccreditedBirthCentersLicenseDAO;
import gov.medicaid.screening.services.AccreditedBirthCentersLicenseService;
import gov.medicaid.screening.services.ConfigurationException;
import gov.medicaid.screening.services.ParsingException;
import gov.medicaid.screening.services.ServiceException;

import javax.annotation.PostConstruct;
import javax.jws.WebMethod;
import javax.jws.WebService;
import javax.naming.InitialContext;
import javax.naming.NamingException;

/**
 * This class provides an implementation of the <code>AccreditedBirthCentersLicenseService</code> via webservice.
 * 
 * @author cyberjag
 * @version 1.0
 */
@WebService
public class AccreditedBirthCentersLicenseServiceImpl extends AbstractBaseService implements
        AccreditedBirthCentersLicenseService {

    /**
     * Accredited birth center data access.
     */
    private AccreditedBirthCentersLicenseDAO accreditedBirthCentersLicenseDAO;

    /**
     * Default empty constructor.
     */
    public AccreditedBirthCentersLicenseServiceImpl() {
    }

    /**
     * This method gets the accredited birth centers.
     * 
     * @return the search result with the accredited birth centers
     * @throws ParsingException
     *             if any parsing errors are encountered
     * @throws ServiceException
     *             for any other exceptions encountered
     */
    @WebMethod
    public SearchResult<AccreditedBirthCenter> getAccreditedBirthCenters() throws ParsingException, ServiceException {
        String signature = "AccreditedBirthCentersLicenseServiceBean#getAccreditedBirthCenters";
        LogUtility.traceEntry(getLog(), signature, new String[] {}, new Object[] {});
        try {
            SearchResult<AccreditedBirthCenter> results = accreditedBirthCentersLicenseDAO.getAccreditedBirthCenters();
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
            accreditedBirthCentersLicenseDAO = (AccreditedBirthCentersLicenseDAO) ctx
                    .lookup("ejblocal:gov.medicaid.screening.dao.AccreditedBirthCentersLicenseDAO");
        } catch (NamingException e) {
            throw new ConfigurationException("Failed to create data access", e);
        }
    }
}
