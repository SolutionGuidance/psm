/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.screening.dao;

import gov.medicaid.entities.BBHTLicenseSearchCriteria;
import gov.medicaid.entities.License;
import gov.medicaid.entities.SearchResult;
import gov.medicaid.screening.services.ParsingException;
import gov.medicaid.screening.services.ServiceException;

/**
 * This defines the logic for searching for Board of Behavioral Health and Therapy Licenses.
 *
 * @author sampath01, j3_guile
 * @version 1.0
 */
public interface BBHTLicenseDAO {

    /**
     * Searches for providers with BBHT license using the given criteria.
     *
     * @param criteria the search criteria
     * @return the matched results
     * @throws ParsingException if any parsing errors are encountered
     * @throws ServiceException for any other exceptions encountered
     */
    SearchResult<License> search(BBHTLicenseSearchCriteria criteria) throws ParsingException, ServiceException;

    /**
     * Performs verification of the given license.
     *
     * @param license the license to verify
     * @return true if the license has been verified, false otherwise
     *
     * @throws ParsingException if any parsing errors are encountered
     * @throws ServiceException for any other exceptions encountered
     */
    boolean verifyLicense(License license) throws ParsingException, ServiceException;

    /**
     * Performs renewal of the given license. Currently unsupported.
     *
     * @param license the license to renew
     *
     * @throws ParsingException if any parsing errors are encountered
     * @throws ServiceException for any other exceptions encountered
     */
    void renew(License license) throws ParsingException, ServiceException;
}
