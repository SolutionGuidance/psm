/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.screening.dao;

import gov.medicaid.entities.License;
import gov.medicaid.entities.OptometryLicenseSearchCriteria;
import gov.medicaid.entities.SearchResult;
import gov.medicaid.screening.services.ParsingException;
import gov.medicaid.screening.services.ServiceException;

/**
 * This defines the logic for searching for Optometry Licenses.
 *
 * @author sampath01, j3_guile
 * @version 1.0
 */
public interface OptometryLicenseDAO {

    /**
     * Search optometry license by name.
     *
     * @param criteria The search criteria
     * @return optometry licenses
     * @throws ParsingException if any parsing errors are encountered
     * @throws ServiceException for any other
     */
    public SearchResult<License> searchByName(OptometryLicenseSearchCriteria criteria) throws ParsingException,
        ServiceException;

    /**
     * Search optometry license by license number.
     *
     * @param criteria The search criteria
     * @return optometry licenses
     * @throws ParsingException if any parsing errors are encountered
     * @throws ServiceException for any other
     */
    public SearchResult<License> searchByLicenseNumber(OptometryLicenseSearchCriteria criteria)
        throws ParsingException, ServiceException;
}
