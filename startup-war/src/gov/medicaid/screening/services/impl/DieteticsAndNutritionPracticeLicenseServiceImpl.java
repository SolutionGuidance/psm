/*
 * Copyright (C) 2013 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.screening.services.impl;

import gov.medicaid.entities.DieteticsAndNutritionPracticeLicenseSearchCriteria;
import gov.medicaid.entities.License;
import gov.medicaid.entities.SearchResult;
import gov.medicaid.screening.dao.DieteticsAndNutritionPracticeLicenseDAO;
import gov.medicaid.screening.services.ConfigurationException;
import gov.medicaid.screening.services.DieteticsAndNutritionPracticeLicenseService;
import gov.medicaid.screening.services.ErrorCode;
import gov.medicaid.screening.services.ParsingException;
import gov.medicaid.screening.services.ServiceException;

import javax.annotation.PostConstruct;
import javax.jws.WebMethod;
import javax.jws.WebService;
import javax.naming.InitialContext;
import javax.naming.NamingException;

/**
 * This is the webservice implementation of the <code>DieteticsAndNutritionPracticeLicenseService</code>.
 * 
 * @author cyberjag
 * @version 1.0
 */
@WebService
public class DieteticsAndNutritionPracticeLicenseServiceImpl extends AbstractBaseService implements
        DieteticsAndNutritionPracticeLicenseService {

    /**
     * Dietetics And Nutrition Practice License data access.
     */
    private DieteticsAndNutritionPracticeLicenseDAO dataAccess;

    /**
     * Searches for providers with Dietetics And Nutrition Practice license using the search filter.
     * 
     * @param criteria
     *            the search criteria
     * @return the matched results
     * @throws ParsingException
     *             if any parsing errors are encountered
     * @throws ServiceException
     *             for any other exceptions encountered
     */
    @WebMethod
    public SearchResult<License> search(DieteticsAndNutritionPracticeLicenseSearchCriteria criteria)
            throws ParsingException, ServiceException {
        String signature = "DieteticsAndNutritionPracticeLicenseServiceImpl#search";
        LogUtility.traceEntry(getLog(), signature, new String[] { "criteria" }, new Object[] { criteria });
        try {
            SearchResult<License> results = dataAccess.search(criteria);
            return LogUtility.traceExit(getLog(), signature, results);
        } catch (ServiceException e) {
            LogUtility.traceError(getLog(), signature, e);
            throw e;
        } catch (Throwable e) {
            LogUtility.traceError(getLog(), signature, e);
            throw new ServiceException(ErrorCode.MITA99999.getDesc());
        }
    }

    /**
     * This method checks that all required injection fields are in fact provided.
     * 
     * @throws ConfigurationException
     *             - If there are required injection fields that are not injected.
     */
    @PostConstruct
    protected void init() {
        super.init();
        try {
            InitialContext ctx = new InitialContext();
            dataAccess = (DieteticsAndNutritionPracticeLicenseDAO) ctx
                    .lookup("ejblocal:gov.medicaid.screening.dao.DieteticsAndNutritionPracticeLicenseDAO");
        } catch (NamingException e) {
            throw new ConfigurationException("Failed to create data access", e);
        }
    }
}
