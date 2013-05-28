/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.screening.dao;

import gov.medicaid.entities.DentistryLicenseSearchCriteria;
import gov.medicaid.entities.License;
import gov.medicaid.entities.SearchResult;
import gov.medicaid.screening.services.ParsingException;
import gov.medicaid.screening.services.ServiceException;

/**
 * This defines the scraping interface for looking up Dentistry Licenses.
 *
 * @author sampath01, j3_guile
 * @version 1.0
 */
public interface DentistryLicenseDAO {

    /**
     * Searches for providers with Dentistry license using the search filter.
     *
     * @param criteria the search criteria
     * @return the matched results
     * @throws ParsingException if any parsing errors are encountered
     * @throws ServiceException for any other exceptions encountered
     */
    SearchResult<License> search(DentistryLicenseSearchCriteria criteria) throws ParsingException, ServiceException;
}
