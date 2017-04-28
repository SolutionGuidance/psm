/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.screening.services;

import gov.medicaid.entities.License;
import gov.medicaid.entities.OptometryLicenseSearchCriteria;
import gov.medicaid.entities.SearchResult;

/**
 * This defines the available services for searching for Optometry Licenses.
 *
 * @author sampath01, j3_guile
 * @version 1.0
 */
public interface OptometryLicenseService {

    /**
     * Searches for providers with Optometry license using the name filter.
     *
     * @param criteria the search criteria
     * @return the matched results
     * @throws ParsingException if any parsing errors are encountered
     * @throws ServiceException for any other
     */
    public SearchResult<License> searchByName(OptometryLicenseSearchCriteria criteria) throws ParsingException,
        ServiceException;

    /**
     * Searches for providers with Optometry license using the license number filter.
     *
     * @param criteria the search criteria
     * @return the matched results
     * @throws ParsingException if any parsing errors are encountered
     * @throws ServiceException for any other
     */
    public SearchResult<License> searchByLicenseNumber(OptometryLicenseSearchCriteria criteria)
        throws ParsingException, ServiceException;
}
