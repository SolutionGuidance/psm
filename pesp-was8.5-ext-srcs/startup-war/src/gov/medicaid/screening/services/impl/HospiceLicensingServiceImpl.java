/*
 * Copyright (C) 2013 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.screening.services.impl;

import gov.medicaid.entities.HospiceSearchCriteria;
import gov.medicaid.entities.ProviderProfile;
import gov.medicaid.entities.SearchResult;
import gov.medicaid.screening.dao.HospiceLicensingDAO;
import gov.medicaid.screening.services.ConfigurationException;
import gov.medicaid.screening.services.HospiceLicensingService;
import gov.medicaid.screening.services.ServiceException;

import javax.annotation.PostConstruct;
import javax.jws.WebMethod;
import javax.jws.WebService;
import javax.naming.InitialContext;
import javax.naming.NamingException;

/**
 * This class provides the web service implementation of the HospiceLicensingService interface. It is a stateless, remote
 * web service bean.
 * 
 * @author cyberjag
 * @version 1.0
 */
@WebService
public class HospiceLicensingServiceImpl extends AbstractBaseService implements HospiceLicensingService {
    /**
     * Represent the name of this class
     */
    private static final String CLASS_NAME = HospiceLicensingServiceImpl.class.getName();

    /**
     * Represents the DAO that will back this service. It may have any value. It is fully mutable, but not expected to
     * change after dependency injection.
     */
    private HospiceLicensingDAO hospiceLicensingDAO;

    /**
     * Empty constructor
     */
    public HospiceLicensingServiceImpl() {
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
            hospiceLicensingDAO = (HospiceLicensingDAO) ctx
                    .lookup("ejblocal:gov.medicaid.screening.dao.HospiceLicensingDAO");
        } catch (NamingException e) {
            throw new ConfigurationException("Failed to create data access", e);
        }
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
    public SearchResult<ProviderProfile> search(HospiceSearchCriteria criteria) throws ServiceException {
        String signature = CLASS_NAME + "#search(HospiceSearchCriteria criteria)";
        LogUtility.traceEntry(getLog(), signature, new String[] { "criteria" }, new Object[] { criteria });
        try {
            SearchResult<ProviderProfile> results = hospiceLicensingDAO.search(criteria);
            return LogUtility.traceExit(getLog(), signature, results);
        } catch (IllegalArgumentException e) {
            LogUtility.traceError(getLog(), signature, e);
            throw e;
        } catch (ServiceException e) {
            LogUtility.traceError(getLog(), signature, e);
            throw e;
        }
    }
}
