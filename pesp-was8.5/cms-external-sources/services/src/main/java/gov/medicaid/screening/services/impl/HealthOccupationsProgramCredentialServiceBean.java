/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
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
import javax.ejb.EJB;
import javax.ejb.Remote;
import javax.ejb.Stateless;
import javax.ejb.TransactionAttribute;
import javax.ejb.TransactionAttributeType;
import javax.ejb.TransactionManagementType;
import javax.ejb.TransactionManagement;
import javax.jws.WebService;

/**
 * This is an EJB implementation of the <code>HealthOccupationsProgramCredentialService</code>. It is exposed as a web
 * service by the container.
 *
 * <p>
 * <code>Thread Safety</code> This is stateless EJB and is thread safe.
 * </p>
 *
 * @author argolite, j3_guile
 * @version 1.0
 */
@WebService
@Stateless
@Remote(HealthOccupationsProgramCredentialService.class)
@TransactionManagement(TransactionManagementType.CONTAINER)
public class HealthOccupationsProgramCredentialServiceBean extends BaseService implements
    HealthOccupationsProgramCredentialService {

    /**
     * Health Occupations Program Credential data access.
     */
    @EJB
    private HealthOccupationsProgramCredentialDAO healthOccupationsProgramCredentialDAO;

    /**
     * Default empty constructor.
     */
    public HealthOccupationsProgramCredentialServiceBean() {
    }

    /**
     * Searches for health occupations program credentials.
     *
     * @param criteria the search criteria
     * @return the matched results
     * @throws IllegalArgumentException if the criteria is null, it may be thrown if a parameter needed by the source
     *             site is invalid
     * @throws ServiceException for any other exceptions encountered
     */
    @TransactionAttribute(TransactionAttributeType.REQUIRED)
    public SearchResult<ProviderProfile> search(HealthOccupationsProgramCredentialSearchCriteria criteria)
        throws ServiceException {
        String signature = "HealthOccupationsProgramCredentialServiceBean#search";
        LogUtil.traceEntry(getLog(), signature, new String[]{"criteria"}, new Object[]{criteria});
        try {
            SearchResult<ProviderProfile> results = healthOccupationsProgramCredentialDAO.search(criteria);
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
        if (healthOccupationsProgramCredentialDAO == null) {
            throw new ConfigurationException("The healthOccupationsProgramCredentialDAO must be configured.");
        }
    }
}