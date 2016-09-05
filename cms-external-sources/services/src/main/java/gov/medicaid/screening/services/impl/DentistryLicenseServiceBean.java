/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.screening.services.impl;

import gov.medicaid.entities.DentistryLicenseSearchCriteria;
import gov.medicaid.entities.License;
import gov.medicaid.entities.SearchResult;
import gov.medicaid.screening.dao.DentistryLicenseDAO;
import gov.medicaid.screening.services.DentistryLicenseService;
import gov.medicaid.screening.services.ErrorCode;
import gov.medicaid.screening.services.ParsingException;
import gov.medicaid.screening.services.ServiceException;

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
 * This is an EJB implementation of the <code>DentistryLicenseServiceImpl</code>. It is exposed as a web service by the
 * container.
 *
 * @author sampath01, j3_guile
 * @version 1.0
 */
@WebService
@Stateless
@Remote(DentistryLicenseService.class)
@TransactionManagement(TransactionManagementType.CONTAINER)
@TransactionAttribute(TransactionAttributeType.REQUIRED)
public class DentistryLicenseServiceBean extends BaseService implements DentistryLicenseService {

    /**
     * Dietetics And Nutrition Practice License data access.
     */
    @EJB
    private DentistryLicenseDAO dataAccess;

    /**
     * Searches for providers with Dentistry license using the search filter.
     *
     * @param criteria the search criteria
     * @return the matched results
     * @throws ParsingException if any parsing errors are encountered
     * @throws ServiceException for any other exceptions encountered
     */
    @Override
    @WebMethod
    public SearchResult<License> search(DentistryLicenseSearchCriteria criteria) throws ParsingException,
        ServiceException {
        String signature = "DentistryLicenseServiceImpl#search";
        LogUtil.traceEntry(getLog(), signature, new String[]{"criteria"}, new Object[]{criteria});
        try {
            SearchResult<License> results = dataAccess.search(criteria);
            return LogUtil.traceExit(getLog(), signature, results);
        } catch (ServiceException e) {
            LogUtil.traceError(getLog(), signature, e);
            throw e;
        } catch (Throwable e) {
            LogUtil.traceError(getLog(), signature, e);
            throw new ServiceException(ErrorCode.MITA99999.getDesc());
        }
    }

}
