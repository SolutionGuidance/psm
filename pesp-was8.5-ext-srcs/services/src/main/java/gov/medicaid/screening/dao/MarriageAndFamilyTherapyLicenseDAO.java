/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.screening.dao;

import gov.medicaid.entities.License;
import gov.medicaid.entities.MarriageAndFamilyTherapyLicenseCriteria;
import gov.medicaid.entities.SearchResult;
import gov.medicaid.screening.services.ParsingException;
import gov.medicaid.screening.services.ServiceException;

/**
 * This defines the actual logic of searching for Marriage and Family Therapy Licenses.
 *
 * @author sampath01, j3_guile
 * @version 1.0
 */
public interface MarriageAndFamilyTherapyLicenseDAO {

    /**
     * Searches for providers with Marriage and Family therapy license using the name filter.
     *
     * @param criteria the search criteria
     * @return the matched results
     * @throws ParsingException if any parsing errors are encountered
     * @throws ServiceException for any other
     */
    public SearchResult<License> searchByName(MarriageAndFamilyTherapyLicenseCriteria criteria) throws ServiceException;

    /**
     * Searches for providers with Marriage and Family therapy license using the license number filter.
     *
     * @param criteria the search criteria
     * @return the matched results
     * @throws ParsingException if any parsing errors are encountered
     * @throws ServiceException for any other
     */
    public SearchResult<License> searchByLicenseNumber(MarriageAndFamilyTherapyLicenseCriteria criteria)
        throws ServiceException;
}
