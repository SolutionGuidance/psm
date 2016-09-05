/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.screening.services;

import gov.medicaid.entities.License;
import gov.medicaid.entities.PodiatricMedicineLicenseSearchByLicenseNumberCriteria;
import gov.medicaid.entities.PodiatricMedicineLicenseSearchByNameCriteria;
import gov.medicaid.entities.SearchResult;

/**
 * This defines the available services for searching for Podiatric Medicine Licenses.
 *
 * @author argolite, j3_guile
 * @version 1.0
 */
public interface PodiatricMedicineLicenseService {

    /**
     * Searches for Podiatric Medicine Licenses by name.
     *
     * @param criteria the search criteria
     * @return the matched results
     * @throws ParsingException if any parsing errors are encountered
     * @throws IllegalArgumentException If criteria is null
     * @throws IllegalArgumentException If criteria.pageNumber < 0
     * @throws IllegalArgumentException If criteria.pageSize < 1 unless criteria.pageNumber <= 0
     * @throws ServiceException for any other exceptions encountered
     */
    SearchResult<License> searchByName(PodiatricMedicineLicenseSearchByNameCriteria criteria) throws ParsingException,
        ServiceException;

    /**
     * Searches for Podiatric Medicine Licenses by license number.
     *
     * @param criteria the search criteria
     * @return the matched results
     * @throws ParsingException if any parsing errors are encountered
     * @throws IllegalArgumentException If criteria is null
     * @throws IllegalArgumentException If criteria.pageNumber < 0
     * @throws IllegalArgumentException If criteria.pageSize < 1 unless criteria.pageNumber <= 0
     * @throws ServiceException for any other exceptions encountered
     */
    SearchResult<License> searchByLicenseNumber(PodiatricMedicineLicenseSearchByLicenseNumberCriteria criteria)
        throws ParsingException, ServiceException;

}
