/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.screening.services.impl;

import gov.medicaid.entities.EPLSSearchCriteria;
import gov.medicaid.entities.ProviderProfile;
import gov.medicaid.entities.SearchResult;
import gov.medicaid.screening.dao.EPLSDAO;
import gov.medicaid.screening.services.EPLSService;
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
 * This is an EJB implementation of the <code>EPLSService</code>. It is exposed as a web service by the container.
 *
 * @author sampath01, j3_guile
 * @version 1.0
 */
@Stateless
@Remote(EPLSService.class)
@TransactionManagement(TransactionManagementType.CONTAINER)
public class EPLSServiceBean extends BaseService implements EPLSService {

    /**
     * EPLS exclusion data access.
     */
    @EJB
    private EPLSDAO dataAccess;

    /**
     * Searches for excluded providers.
     *
     * @param criteria the search criteria
     * @return the matched results
     * @throws ParsingException if any parsing errors are encountered
     * @throws ServiceException for any other exceptions encountered
     */
    @TransactionAttribute(TransactionAttributeType.REQUIRED)
    public SearchResult<ProviderProfile> search(EPLSSearchCriteria criteria) throws ParsingException, ServiceException {
        String signature = "EPLSServiceImpl#search";
        LogUtil.traceEntry(getLog(), signature, new String[]{"criteria"}, new Object[]{criteria});
        try {
            SearchResult<ProviderProfile> results = dataAccess.search(criteria);
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