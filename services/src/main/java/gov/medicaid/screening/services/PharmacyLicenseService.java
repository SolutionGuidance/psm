/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.screening.services;

import gov.medicaid.entities.License;
import gov.medicaid.entities.PharmacyLicenseSearchCriteria;
import gov.medicaid.entities.SearchResult;

/**
 * This defines the available services for searching for Pharmacy Licenses.
 *
 * @author sampath01, j3_guile
 * @version 1.0
 */
public interface PharmacyLicenseService {

    /**
     * Searches for providers with Medical Practice license using the name filter.
     *
     * @param criteria the search criteria
     * @return the matched results
     * @throws ParsingException if any parsing errors are encountered
     * @throws ServiceException for any other
     */
    public SearchResult<License> searchByName(PharmacyLicenseSearchCriteria criteria) throws ParsingException,
        ServiceException;

}
