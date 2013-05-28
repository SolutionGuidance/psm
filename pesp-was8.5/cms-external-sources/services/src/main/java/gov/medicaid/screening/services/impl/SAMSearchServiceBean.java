/*
 * Copyright (C) 2013 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.screening.services.impl;

import gov.medicaid.entities.SAMResponse;
import gov.medicaid.entities.SAMSearchCriteria;
import gov.medicaid.screening.dao.SAMSearchDAO;
import gov.medicaid.screening.services.ErrorCode;
import gov.medicaid.screening.services.SAMSearchService;
import gov.medicaid.screening.services.ServiceException;

import javax.ejb.EJB;
import javax.ejb.Remote;
import javax.ejb.Stateless;
import javax.jws.WebMethod;
import javax.jws.WebService;
import java.util.List;

/**
 * This defines the logic for searching for SAM records.
 * 
 * @author flexme
 * @version 1.0
 */
@WebService
@Stateless
@Remote(SAMSearchService.class)
public class SAMSearchServiceBean extends BaseService implements SAMSearchService {
    /**
     * SAM records data access.
     */
    @EJB
    private SAMSearchDAO dataAccess;

    /**
     * Empty constructor.
     */
    public SAMSearchServiceBean() {
    }

    /**
     * Search the SAM records.
     * 
     * @param criteria
     *            the searching criteria.
     * @return the records.
     * @throws ServiceException
     *             for any exceptions encountered
     */
    @WebMethod
    public List<SAMResponse> doSearch(SAMSearchCriteria criteria) throws ServiceException {
        String signature = "SAMSearchServiceBean#doSearch";
        LogUtil.traceEntry(getLog(), signature, new String[] { "criteria" }, new Object[] { criteria });

        try {
            List<SAMResponse> results = dataAccess.doSearch(criteria);
            return LogUtil.traceExit(getLog(), signature, results);
        } catch (ServiceException e) {
            LogUtil.traceError(getLog(), signature, e);
            throw e;
        } catch (Throwable e) {
            LogUtil.traceError(getLog(), signature, e);
            throw new ServiceException(ErrorCode.MITA99999.getDesc());
        }
    }

    /**
     * Verifies the provider using SSN.
     * 
     * @param ssn
     *            provider ssn
     * @param name
     *            provider name
     * @return return @return true if valid, false if not
     * @throws ServiceException
     *             if any error occur
     */
    @WebMethod
    public boolean verify(String ssn, String name) throws ServiceException {
        String signature = "SAMSearchServiceBean#verify";
        LogUtil.traceEntry(getLog(), signature, new String[] { "ssn", "name" }, new Object[] { ssn, name });
        try {
            return LogUtil.traceExit(getLog(), signature, dataAccess.verify(ssn, name));
        } catch (ServiceException e) {
            LogUtil.traceError(getLog(), signature, e);
            throw e;
        } catch (Throwable e) {
            LogUtil.traceError(getLog(), signature, e);
            throw new ServiceException(ErrorCode.MITA99999.getDesc());
        }
    }
}
