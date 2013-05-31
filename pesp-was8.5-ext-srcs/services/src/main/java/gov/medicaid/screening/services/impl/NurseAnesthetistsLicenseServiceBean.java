/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.screening.services.impl;

import gov.medicaid.entities.NurseAnesthetistsSearchCriteria;
import gov.medicaid.entities.ProviderProfile;
import gov.medicaid.screening.dao.NurseAnesthetistsLicenseDAO;
import gov.medicaid.screening.services.ConfigurationException;
import gov.medicaid.screening.services.NurseAnesthetistsLicenseService;
import gov.medicaid.screening.services.ServiceException;

import javax.annotation.PostConstruct;
import javax.ejb.EJB;
import javax.ejb.Remote;
import javax.ejb.Stateless;
import javax.ejb.TransactionAttribute;
import javax.ejb.TransactionAttributeType;
import javax.ejb.TransactionManagement;
import javax.ejb.TransactionManagementType;

/**
 * This is an EJB implementation of the <code>NurseAnesthetistsLicenseService</code>. It is exposed as a web service by
 * the container.
 *
 * <p>
 * <code>Thread Safety</code> This is stateless EJB and is thread safe.
 * </p>
 *
 * @author argolite, j3_guile
 * @version 1.0
 */
@Stateless
@Remote(NurseAnesthetistsLicenseService.class)
@TransactionManagement(TransactionManagementType.CONTAINER)
public class NurseAnesthetistsLicenseServiceBean extends BaseService implements NurseAnesthetistsLicenseService {

    /**
     * Nurse Anesthetists License data access.
     */
    @EJB
    private NurseAnesthetistsLicenseDAO nurseAnesthetistsLicenseDAO;

    /**
     * Default empty constructor.
     */
    public NurseAnesthetistsLicenseServiceBean() {
    }

    /**
     * Searches for Nurse Anesthetists license.
     *
     * @param criteria the search criteria
     * @return the matched profile, null if not matched
     * @throws IllegalArgumentException if the criteria is null
     * @throws IllegalArgumentException may be thrown if a parameter needed by the source site is invalid
     * @throws ServiceException for any other exceptions encountered
     */
    @TransactionAttribute(TransactionAttributeType.REQUIRED)
    public ProviderProfile search(NurseAnesthetistsSearchCriteria criteria) throws ServiceException {
        String signature = "NurseAnesthetistsLicenseServiceBean#search";
        LogUtil.traceEntry(getLog(), signature, new String[]{"criteria"}, new Object[]{criteria});
        try {
            ProviderProfile result = nurseAnesthetistsLicenseDAO.search(criteria);
            return LogUtil.traceExit(getLog(), signature, result);
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
        if (nurseAnesthetistsLicenseDAO == null) {
            throw new ConfigurationException("The nurseAnesthetistsLicenseDAO must be configured.");
        }
    }
}