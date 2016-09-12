/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.screening.services.impl;

import gov.medicaid.entities.ExclusionType;
import gov.medicaid.entities.OIGSearchCriteria;
import gov.medicaid.entities.ProviderProfile;
import gov.medicaid.entities.SearchResult;
import gov.medicaid.screening.dao.OIGDAO;
import gov.medicaid.screening.services.ErrorCode;
import gov.medicaid.screening.services.OIGService;
import gov.medicaid.screening.services.ParsingException;
import gov.medicaid.screening.services.ServiceException;

import java.util.List;

import javax.ejb.EJB;
import javax.ejb.Remote;
import javax.ejb.Stateless;
import javax.ejb.TransactionAttribute;
import javax.ejb.TransactionAttributeType;

/**
 * This is an EJB implementation of the <code>OIGService</code>. It is exposed as a web service by the container.
 *
 * @author sampath01, j3_guile
 * @version 1.0
 */
@Stateless
@Remote(OIGService.class)
public class OIGServiceBean extends BaseService implements OIGService {

    /**
     * OIG exclusion data access.
     */
    @EJB
    private OIGDAO dataAccess;

    /**
     * Searches for excluded providers.
     *
     * @param criteria the search criteria
     * @return the matched results
     * @throws ParsingException if any parsing errors are encountered
     * @throws ServiceException for any other exceptions encountered
     */
    @TransactionAttribute(TransactionAttributeType.REQUIRED)
    public SearchResult<ProviderProfile> search(OIGSearchCriteria criteria) throws ParsingException, ServiceException {
        String signature = "OIGServiceImpl#search";
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

    /**
     * Verifies SSN if valid.
     *
     * @param entityId the entity id
     * @param ssn the ssn
     * @return true if valid, false if not
     * @throws ParsingException if any parsing errors are encountered
     * @throws ServiceException for any other exceptions encountered
     * @deprecated not updated in new site layout.
     */
    @TransactionAttribute(TransactionAttributeType.REQUIRED)
    @Deprecated
    public boolean verifySSN(String entityId, String ssn) throws ParsingException, ServiceException {
        String signature = "OIGServiceImpl#verifySSN";
        LogUtil.traceEntry(getLog(), signature, new String[]{"entityId", "ssn"}, new Object[]{entityId, ssn});
        try {
            return LogUtil.traceExit(getLog(), signature, dataAccess.verifySSN(entityId, ssn));
        } catch (ServiceException e) {
            LogUtil.traceError(getLog(), signature, e);
            throw e;
        } catch (Throwable e) {
            LogUtil.traceError(getLog(), signature, e);
            throw new ServiceException(ErrorCode.MITA99999.getDesc(), e);
        }
    }

    /**
     * Retrieves all available exclusion types.
     *
     * @return the exclusion types.
     * @throws ParsingException if any parsing errors are encountered
     * @throws ServiceException for any other exceptions encountered
     * @deprecated not updated in new site layout.
     */
    @TransactionAttribute(TransactionAttributeType.REQUIRED)
    @Deprecated
    public List<ExclusionType> getExclusionTypeList() throws ParsingException, ServiceException {
        String signature = "OIGServiceImpl#getExclusionTypeList";
        LogUtil.traceEntry(getLog(), signature, new String[]{}, new Object[]{});
        try {
            return LogUtil.traceExit(getLog(), signature, dataAccess.getExclusionTypeList());
        } catch (ServiceException e) {
            LogUtil.traceError(getLog(), signature, e);
            throw e;
        } catch (Throwable e) {
            LogUtil.traceError(getLog(), signature, e);
            throw new ServiceException(ErrorCode.MITA99999.getDesc(), e);
        }
    }
}