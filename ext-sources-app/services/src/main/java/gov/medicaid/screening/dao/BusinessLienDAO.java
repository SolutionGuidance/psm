/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.screening.dao;

import gov.medicaid.entities.BusinessLienSearchCriteria;
import gov.medicaid.entities.ProviderProfile;
import gov.medicaid.entities.SearchResult;
import gov.medicaid.screening.services.ParsingException;
import gov.medicaid.screening.services.ServiceException;

/**
 * This defines the scraping interface for looking up MN business and liens.
 *
 * @author sampath01, j3_guile
 * @version 1.0
 */
public interface BusinessLienDAO {

    /**
     * Searches for MN business and liens by name.
     *
     * @param criteria the search criteria
     * @return the matched results
     * @throws ParsingException if any parsing errors are encountered
     * @throws ServiceException for any other exceptions encountered
     */
    SearchResult<ProviderProfile> searchByName(BusinessLienSearchCriteria criteria) throws ParsingException,
        ServiceException;

    /**
     * Searches for MN business and liens by file number.
     *
     * @param criteria the search criteria
     * @return the matched results
     * @throws ParsingException if any parsing errors are encountered
     * @throws ServiceException for any other exceptions encountered
     */
    SearchResult<ProviderProfile> searchByFileNumber(BusinessLienSearchCriteria criteria) throws ParsingException,
        ServiceException;
}
