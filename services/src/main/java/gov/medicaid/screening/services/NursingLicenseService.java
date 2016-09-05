/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.screening.services;

import gov.medicaid.entities.License;
import gov.medicaid.entities.NursingLicenseSearchCriteria;
import gov.medicaid.entities.SearchResult;

/**
 * This defines the available services for searching for Nursing Licenses.
 *
 * @author sampath01, j3_guile
 * @version 1.0
 */
public interface NursingLicenseService {

    /**
     * Searches for providers with Nursing license using the name filter.
     *
     * @param criteria the search criteria
     * @return the matched results
     * @throws ParsingException if any parsing errors are encountered
     * @throws ServiceException for any other exceptions encountered
     */
    SearchResult<License> searchByName(NursingLicenseSearchCriteria criteria) throws ParsingException, ServiceException;

    /**
     * Searches for providers with Nursing license using the identifier filter.
     *
     * @param criteria the search criteria
     * @return the matched results
     * @throws ParsingException if any parsing errors are encountered
     * @throws ServiceException for any other exceptions encountered
     */
    SearchResult<License> searchByLicenseNumber(NursingLicenseSearchCriteria criteria) throws ParsingException,
        ServiceException;
}
