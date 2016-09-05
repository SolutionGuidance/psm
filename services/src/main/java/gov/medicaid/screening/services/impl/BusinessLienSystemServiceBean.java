/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.screening.services.impl;

import gov.medicaid.entities.BusinessLienSearchCriteria;
import gov.medicaid.entities.ProviderProfile;
import gov.medicaid.entities.SearchResult;
import gov.medicaid.screening.dao.BusinessLienDAO;
import gov.medicaid.screening.services.BusinessLienSystemService;
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

/**
 * This is an EJB implementation of the <code>BaseLicenseServiceImpl</code>. It is exposed as a web service by the
 * container.
 *
 * @author sampath01, j3_guile
 * @version 1.0
 */
@Stateless
@Remote(BusinessLienSystemService.class)
@TransactionManagement(TransactionManagementType.CONTAINER)
public class BusinessLienSystemServiceBean extends BaseService implements BusinessLienSystemService {

    /**
     * Business Lien data access.
     */
    @EJB
    private BusinessLienDAO dataAccess;

    /**
     * Default empty constructor.
     */
    public BusinessLienSystemServiceBean() {
    }

    /**
     * Searches for MN business and liens by name.
     *
     * @param criteria the search criteria
     * @return the matched results
     * @throws ParsingException if any parsing errors are encountered
     * @throws ServiceException for any other exceptions encountered
     */
    @TransactionAttribute(TransactionAttributeType.REQUIRED)
    public SearchResult<ProviderProfile> searchByName(BusinessLienSearchCriteria criteria) throws ParsingException,
        ServiceException {
        String signature = "BusinessLienSystemServiceImpl#searchByName";
        LogUtil.traceEntry(getLog(), signature, new String[]{"criteria"}, new Object[]{criteria});
        try {
            SearchResult<ProviderProfile> results = dataAccess.searchByName(criteria);
            return LogUtil.traceExit(getLog(), signature, results);
        } catch (ServiceException e) {
            LogUtil.traceError(getLog(), signature, e);
            throw e;
        } catch (Throwable e) {
            LogUtil.traceError(getLog(), signature, e);
            throw new ServiceException(ErrorCode.MITA99999.getDesc(), e);
        }
    }

    /**
     * Searches for MN business and liens by file number.
     *
     * @param criteria the search criteria
     * @return the matched results
     * @throws ParsingException if any parsing errors are encountered
     * @throws ServiceException for any other exceptions encountered
     */
    @TransactionAttribute(TransactionAttributeType.REQUIRED)
    public SearchResult<ProviderProfile> searchByFileNumber(BusinessLienSearchCriteria criteria)
        throws ParsingException, ServiceException {
        String signature = "BusinessLienSystemServiceImpl#searchByFileNumber";
        LogUtil.traceEntry(getLog(), signature, new String[]{"criteria"}, new Object[]{criteria});
        try {
            SearchResult<ProviderProfile> results = dataAccess.searchByFileNumber(criteria);
            return LogUtil.traceExit(getLog(), signature, results);
        } catch (ServiceException e) {
            LogUtil.traceError(getLog(), signature, e);
            throw e;
        } catch (Throwable e) {
            LogUtil.traceError(getLog(), signature, e);
            throw new ServiceException(ErrorCode.MITA99999.getDesc(), e);
        }
    }
}