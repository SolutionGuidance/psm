/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
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
 * This class provides an implementation of the <code>MedicaidCertifiedProvidersService</code> via its Remote interface.
 *
 * <strong>This bean is mutable and not thread-safe as it deals with non-thread-safe entities. However, in the context
 * of being used in a container, it is thread-safe.</strong>
 *
 * @author argolite, j3_guile
 * @version 1.0
 */
@WebService
@Stateless
@Remote(MedicaidCertifiedProvidersService.class)
@TransactionManagement(TransactionManagementType.CONTAINER)
public class MedicaidCertifiedProvidersServiceBean extends BaseService implements MedicaidCertifiedProvidersService {

    /**
     * Medicaid provider data access.
     */
    @EJB
    private MedicaidCertifiedProvidersDAO medicaidCertifiedProvidersDAO;

    /**
     * Default empty constructor.
     */
    public MedicaidCertifiedProvidersServiceBean() {
    }

    /**
     * This method gets the applicable providers that meet the search criteria. If none available, the search result
     * will be empty.
     *
     * @param criteria the search criteria
     * @return the search result with the matched providers
     * @throws IllegalArgumentException if the criteria is null
     * @throws IllegalArgumentException if criteria.pageNumber < 0
     * @throws IllegalArgumentException - if criteria.pageSize < 1 unless criteria.pageNumber <= 0
     * @throws ServiceException for any other exceptions encountered
     */
    @WebMethod
    @TransactionAttribute(TransactionAttributeType.REQUIRED)
    public SearchResult<ProviderProfile> search(MedicaidCertifiedProviderSearchCriteria criteria)
        throws ServiceException {
        String signature = "MedicaidCertifiedProvidersServiceBean#search";
        LogUtil.traceEntry(getLog(), signature, new String[]{}, new Object[]{});
        try {
            SearchResult<ProviderProfile> results = medicaidCertifiedProvidersDAO.search(criteria);
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
        if (medicaidCertifiedProvidersDAO == null) {
            throw new ConfigurationException("The medicaidCertifiedProvidersDAO must be configured.");
        }
    }
}