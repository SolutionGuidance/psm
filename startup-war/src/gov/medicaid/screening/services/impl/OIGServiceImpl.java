/*
 * Copyright (C) 2013 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.screening.services.impl;

import gov.medicaid.entities.ExclusionType;
import gov.medicaid.entities.OIGSearchCriteria;
import gov.medicaid.entities.ProviderProfile;
import gov.medicaid.entities.SearchResult;
import gov.medicaid.screening.dao.OIGDAO;
import gov.medicaid.screening.services.ConfigurationException;
import gov.medicaid.screening.services.ErrorCode;
import gov.medicaid.screening.services.OIGService;
import gov.medicaid.screening.services.ParsingException;
import gov.medicaid.screening.services.ServiceException;

import java.util.List;

import javax.annotation.PostConstruct;
import javax.jws.WebMethod;
import javax.jws.WebService;
import javax.naming.InitialContext;
import javax.naming.NamingException;

/**
 * This is the webservice implementation of the <code>OIGService</code>. It is exposed as a web service by the container.
 *
 * @author cyberjag
 * @version 1.0
 */
@WebService
public class OIGServiceImpl extends AbstractBaseService implements OIGService {

    /**
     * OIG exclusion data access.
     */
    private OIGDAO dataAccess;

    /**
     * Searches for excluded providers.
     *
     * @param criteria the search criteria
     * @return the matched results
     * @throws ParsingException if any parsing errors are encountered
     * @throws ServiceException for any other exceptions encountered
     */
    @WebMethod
    public SearchResult<ProviderProfile> search(OIGSearchCriteria criteria) throws ParsingException, ServiceException {
        String signature = "OIGServiceImpl#search";
        LogUtility.traceEntry(getLog(), signature, new String[]{"criteria"}, new Object[]{criteria});
        try {
            SearchResult<ProviderProfile> results = dataAccess.search(criteria);
            return LogUtility.traceExit(getLog(), signature, results);
        } catch (ServiceException e) {
            LogUtility.traceError(getLog(), signature, e);
            throw e;
        } catch (Throwable e) {
            LogUtility.traceError(getLog(), signature, e);
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
     */
    @WebMethod
    public boolean verifySSN(String entityId, String ssn) throws ParsingException, ServiceException {
        String signature = "OIGServiceImpl#verifySSN";
        LogUtility.traceEntry(getLog(), signature, new String[]{"entityId", "ssn"}, new Object[]{entityId, ssn});
        try {
            return LogUtility.traceExit(getLog(), signature, dataAccess.verifySSN(entityId, ssn));
        } catch (ServiceException e) {
            LogUtility.traceError(getLog(), signature, e);
            throw e;
        } catch (Throwable e) {
            LogUtility.traceError(getLog(), signature, e);
            throw new ServiceException(ErrorCode.MITA99999.getDesc(), e);
        }
    }

    /**
     * Retrieves all available exclusion types.
     *
     * @return the exclusion types.
     * @throws ParsingException if any parsing errors are encountered
     * @throws ServiceException for any other exceptions encountered
     */
    @WebMethod
    public List<ExclusionType> getExclusionTypeList() throws ParsingException, ServiceException {
        String signature = "OIGServiceImpl#getExclusionTypeList";
        LogUtility.traceEntry(getLog(), signature, new String[]{}, new Object[]{});
        try {
            return LogUtility.traceExit(getLog(), signature, dataAccess.getExclusionTypeList());
        } catch (ServiceException e) {
            LogUtility.traceError(getLog(), signature, e);
            throw e;
        } catch (Throwable e) {
            LogUtility.traceError(getLog(), signature, e);
            throw new ServiceException(ErrorCode.MITA99999.getDesc(), e);
        }
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
            dataAccess = (OIGDAO) ctx.lookup("ejblocal:gov.medicaid.screening.dao.OIGDAO");
        } catch (NamingException e) {
            throw new ConfigurationException("Failed to create data access", e);
        }
    }
}