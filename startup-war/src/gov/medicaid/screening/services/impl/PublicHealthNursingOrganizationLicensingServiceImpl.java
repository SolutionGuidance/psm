/*
 * Copyright (C) 2013 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.screening.services.impl;

import gov.medicaid.entities.ProviderProfile;
import gov.medicaid.entities.PublicHealthNursingOrganizationSearchCriteria;
import gov.medicaid.entities.SearchResult;
import gov.medicaid.screening.dao.PublicHealthNursingOrganizationLicensingDAO;
import gov.medicaid.screening.services.ConfigurationException;
import gov.medicaid.screening.services.PublicHealthNursingOrganizationLicensingService;
import gov.medicaid.screening.services.ServiceException;

import javax.annotation.PostConstruct;
import javax.jws.WebMethod;
import javax.jws.WebService;
import javax.naming.InitialContext;
import javax.naming.NamingException;

/**
 * This class provides the webservice implementation of the PublicHealthNursingOrganizationLicensingService interface.
 * 
 * @author cyberjag
 * @version 1.0
 */
@WebService
public class PublicHealthNursingOrganizationLicensingServiceImpl extends AbstractBaseService implements
        PublicHealthNursingOrganizationLicensingService {
    /**
     * Represent the name of this class
     */
    private static final String CLASS_NAME = PublicHealthNursingOrganizationLicensingServiceImpl.class.getName();

    /**
     * Represents the DAO that will back this service. It may have any value. It is fully mutable, but not expected to
     * change after dependency injection.
     */
    private PublicHealthNursingOrganizationLicensingDAO publicHealthNursingOrganizationLicensingDAO;

    /**
     * Empty constructor
     */
    public PublicHealthNursingOrganizationLicensingServiceImpl() {
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
            publicHealthNursingOrganizationLicensingDAO = (PublicHealthNursingOrganizationLicensingDAO) ctx
                    .lookup("ejblocal:gov.medicaid.screening.dao.PublicHealthNursingOrganizationLicensingDAO");
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
    public SearchResult<ProviderProfile> search(PublicHealthNursingOrganizationSearchCriteria criteria)
            throws ServiceException {
        String signature = CLASS_NAME + "#search(PublicHealthNursingOrganizationSearchCriteria criteria)";
        LogUtility.traceEntry(getLog(), signature, new String[] { "criteria" }, new Object[] { criteria });
        try {
            SearchResult<ProviderProfile> results = publicHealthNursingOrganizationLicensingDAO.search(criteria);
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
