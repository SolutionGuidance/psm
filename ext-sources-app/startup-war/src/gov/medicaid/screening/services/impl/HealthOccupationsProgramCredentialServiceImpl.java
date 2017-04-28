/*
 * Copyright (C) 2013 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.screening.services.impl;

import gov.medicaid.entities.HealthOccupationsProgramCredentialSearchCriteria;
import gov.medicaid.entities.ProviderProfile;
import gov.medicaid.entities.SearchResult;
import gov.medicaid.screening.dao.HealthOccupationsProgramCredentialDAO;
import gov.medicaid.screening.services.ConfigurationException;
import gov.medicaid.screening.services.HealthOccupationsProgramCredentialService;
import gov.medicaid.screening.services.ServiceException;

import javax.annotation.PostConstruct;
import javax.ejb.TransactionAttribute;
import javax.ejb.TransactionAttributeType;
import javax.jws.WebService;
import javax.naming.InitialContext;
import javax.naming.NamingException;

/**
 * This is the web service implementation of the <code>HealthOccupationsProgramCredentialService</code>.
 * 
 * @author cyberjag
 * @version 1.0
 */
@WebService
public class HealthOccupationsProgramCredentialServiceImpl extends AbstractBaseService implements
        HealthOccupationsProgramCredentialService {

    /**
     * Health Occupations Program Credential data access.
     */
    private HealthOccupationsProgramCredentialDAO healthOccupationsProgramCredentialDAO;

    /**
     * Default empty constructor.
     */
    public HealthOccupationsProgramCredentialServiceImpl() {
    }

    /**
     * Searches for health occupations program credentials.
     * 
     * @param criteria
     *            the search criteria
     * @return the matched results
     * @throws IllegalArgumentException
     *             if the criteria is null, it may be thrown if a parameter needed by the source site is invalid
     * @throws ServiceException
     *             for any other exceptions encountered
     */
    @TransactionAttribute(TransactionAttributeType.REQUIRED)
    public SearchResult<ProviderProfile> search(HealthOccupationsProgramCredentialSearchCriteria criteria)
            throws ServiceException {
        String signature = "HealthOccupationsProgramCredentialServiceBean#search";
        LogUtility.traceEntry(getLog(), signature, new String[] { "criteria" }, new Object[] { criteria });
        try {
            SearchResult<ProviderProfile> results = healthOccupationsProgramCredentialDAO.search(criteria);
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
            healthOccupationsProgramCredentialDAO = (HealthOccupationsProgramCredentialDAO) ctx
                    .lookup("ejblocal:gov.medicaid.screening.dao.HealthOccupationsProgramCredentialDAO");
        } catch (NamingException e) {
            throw new ConfigurationException("Failed to create data access", e);
        }
    }
}