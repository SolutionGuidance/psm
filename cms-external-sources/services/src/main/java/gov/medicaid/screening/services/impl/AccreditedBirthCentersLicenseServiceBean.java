/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
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
import javax.ejb.EJB;
import javax.ejb.Remote;
import javax.ejb.Stateless;
import javax.ejb.TransactionAttribute;
import javax.ejb.TransactionAttributeType;
import javax.ejb.TransactionManagement;
import javax.ejb.TransactionManagementType;
import javax.jws.WebService;

/**
 * This class provides an implementation of the <code>AccreditedBirthCentersLicenseService</code> via its Local and
 * Remote interfaces.
 *
 * <p>
 * <strong>Thread Safety:</strong> This is a stateless EJB and is thread-safe.
 * </p>
 *
 * @author argolite, j3_guile
 * @version 1.0
 */
@WebService
@Stateless
@Remote(AccreditedBirthCentersLicenseService.class)
@TransactionManagement(TransactionManagementType.CONTAINER)
public class AccreditedBirthCentersLicenseServiceBean extends BaseService implements
    AccreditedBirthCentersLicenseService {

    /**
     * Accredited birth center data access.
     */
    @EJB
    private AccreditedBirthCentersLicenseDAO accreditedBirthCentersLicenseDAO;

    /**
     * Default empty constructor.
     */
    public AccreditedBirthCentersLicenseServiceBean() {
    }

    /**
     * This method gets the accredited birth centers.
     *
     * @return the search result with the accredited birth centers
     * @throws ParsingException if any parsing errors are encountered
     * @throws ServiceException for any other exceptions encountered
     */
    @TransactionAttribute(TransactionAttributeType.REQUIRED)
    public SearchResult<AccreditedBirthCenter> getAccreditedBirthCenters() throws ParsingException, ServiceException {
        String signature = "AccreditedBirthCentersLicenseServiceBean#getAccreditedBirthCenters";
        LogUtil.traceEntry(getLog(), signature, new String[]{}, new Object[]{});
        try {
            SearchResult<AccreditedBirthCenter> results = accreditedBirthCentersLicenseDAO.getAccreditedBirthCenters();
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
        if (accreditedBirthCentersLicenseDAO == null) {
            throw new ConfigurationException("The accreditedBirthCentersLicenseDAO must be configured.");
        }
    }
}
