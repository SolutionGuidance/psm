/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.screening.services;

import gov.medicaid.entities.ChiropracticLicenseSearchCriteria;
import gov.medicaid.entities.License;
import gov.medicaid.entities.SearchResult;

/**
 * This defines the available services for searching for Chiropractic Licenses.
 *
 * @author sampath01, j3_guile
 * @version 1.0
 */
public interface ChiropracticLicenseService {

    /**
     * Searches for providers with Chiropractic license using the name filter.
     *
     * @param criteria the search criteria
     * @return the matched results
     * @throws ParsingException if any parsing errors are encountered
     * @throws ServiceException for any other exceptions encountered
     */
    SearchResult<License> searchByLastName(ChiropracticLicenseSearchCriteria criteria) throws ParsingException,
        ServiceException;

    /**
     * Searches for providers with Chiropractic license using the city filter.
     *
     * @param criteria the search criteria
     * @return the matched results
     * @throws ParsingException if any parsing errors are encountered
     * @throws ServiceException for any other exceptions encountered
     */
    SearchResult<License> searchByCity(ChiropracticLicenseSearchCriteria criteria) throws ParsingException,
        ServiceException;

    /**
     * Searches for providers with Chiropractic license using the zipcode filter.
     *
     * @param criteria the search criteria
     * @return the matched results
     * @throws ParsingException if any parsing errors are encountered
     * @throws ServiceException for any other exceptions encountered
     */
    SearchResult<License> searchByZipCode(ChiropracticLicenseSearchCriteria criteria) throws ParsingException,
        ServiceException;

    /**
     * Searches for providers with Chiropractic license using the sounds like name filter.
     *
     * @param criteria the search criteria
     * @return the matched results
     * @throws ParsingException if any parsing errors are encountered
     * @throws ServiceException for any other exceptions encountered
     */
    SearchResult<License> searchBySoundingLikeLastName(ChiropracticLicenseSearchCriteria criteria)
        throws ParsingException, ServiceException;

    /**
     * Retrieves all licensees that have disciplinary action record from the source site.
     *
     * @param criteria the pagination criteria
     * @return the matched results
     * @throws ParsingException if any parsing errors are encountered
     * @throws ServiceException for any other exceptions encountered
     */
    SearchResult<License> getDeniedList(ChiropracticLicenseSearchCriteria criteria) throws ParsingException,
        ServiceException;
}
