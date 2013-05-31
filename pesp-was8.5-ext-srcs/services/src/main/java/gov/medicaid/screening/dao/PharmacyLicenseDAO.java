/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.screening.dao;

import gov.medicaid.entities.License;
import gov.medicaid.entities.PharmacyLicenseSearchCriteria;
import gov.medicaid.entities.SearchResult;
import gov.medicaid.screening.services.ParsingException;
import gov.medicaid.screening.services.ServiceException;

/**
 * This defines the logic for searching for Pharmacy Licenses.
 *
 * @author sampath01, j3_guile
 * @version 1.0
 */
public interface PharmacyLicenseDAO {

    /**
     * Searches for Pharmacy licenses using the first name, business name, last name or license number.
     *
     * @param criteria The search criteria
     * @return the pharmacy licenses.
     * @throws ParsingException if any parsing errors are encountered
     * @throws ServiceException for any other
     */
    public SearchResult<License> search(PharmacyLicenseSearchCriteria criteria) throws ParsingException,
        ServiceException;
}
