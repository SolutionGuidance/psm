/*
 * Copyright (C) 2013 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.screening.dao;

import gov.medicaid.entities.SAMResponse;
import gov.medicaid.entities.SAMSearchCriteria;
import gov.medicaid.screening.services.ServiceException;

import java.util.List;

/**
 * This defines the logic for searching for SAM records.
 * 
 * @author flexme
 * @version 1.0
 */
public interface SAMSearchDAO {
    /**
     * Search the SAM records.
     * 
     * @param criteria
     *            the searching criteria.
     * @return the records.
     * @throws ServiceException
     *             for any exceptions encountered
     */
    public List<SAMResponse> doSearch(SAMSearchCriteria criteria) throws ServiceException;

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
    public boolean verify(String ssn, String name) throws ServiceException;
}
