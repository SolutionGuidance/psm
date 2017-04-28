/*
 * Copyright (C) 2013 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.screening.services.impl;

import gov.medicaid.entities.MedicaidCertifiedProviderSearchCriteria;
import gov.medicaid.entities.ProviderProfile;
import gov.medicaid.entities.SearchResult;
import gov.medicaid.screening.dao.MedicaidCertifiedProvidersDAO;
import gov.medicaid.screening.services.ConfigurationException;
import gov.medicaid.screening.services.MedicaidCertifiedProvidersService;
import gov.medicaid.screening.services.ServiceException;

import javax.annotation.PostConstruct;
import javax.jws.WebMethod;
import javax.jws.WebService;
import javax.naming.InitialContext;
import javax.naming.NamingException;

/**
 * This class provides an implementation of the <code>MedicaidCertifiedProvidersService</code> and exposed as web
 * service.
 * 
 * @author cyberjag
 * @version 1.0
 */
@WebService
public class MedicaidCertifiedProvidersServiceImpl extends AbstractBaseService implements MedicaidCertifiedProvidersService {

    /**
     * Medicaid provider data access.
     */
    private MedicaidCertifiedProvidersDAO medicaidCertifiedProvidersDAO;

    /**
     * Default empty constructor.
     */
    public MedicaidCertifiedProvidersServiceImpl() {
    }

    /**
     * This method gets the applicable providers that meet the search criteria. If none available, the search result
     * will be empty.
     * 
     * @param criteria
     *            the search criteria
     * @return the search result with the matched providers
     * @throws IllegalArgumentException
     *             if the criteria is null
     * @throws IllegalArgumentException
     *             if criteria.pageNumber < 0
     * @throws IllegalArgumentException
     *             - if criteria.pageSize < 1 unless criteria.pageNumber <= 0
     * @throws ServiceException
     *             for any other exceptions encountered
     */
    @WebMethod
    public SearchResult<ProviderProfile> search(MedicaidCertifiedProviderSearchCriteria criteria)
            throws ServiceException {
        String signature = "MedicaidCertifiedProvidersServiceBean#search";
        LogUtility.traceEntry(getLog(), signature, new String[] {}, new Object[] {});
        try {
            SearchResult<ProviderProfile> results = medicaidCertifiedProvidersDAO.search(criteria);
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
            medicaidCertifiedProvidersDAO = (MedicaidCertifiedProvidersDAO) ctx
                    .lookup("ejblocal:gov.medicaid.screening.dao.MedicaidCertifiedProvidersDAO");
        } catch (NamingException e) {
            throw new ConfigurationException("Failed to create data access", e);
        }
    }
}