/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.screening.services;

import gov.medicaid.entities.EPLSSearchCriteria;
import gov.medicaid.entities.ProviderProfile;
import gov.medicaid.entities.SearchResult;

/**
 * This defines the available services for searching for EPLS.
 *
 * @author sampath01, j3_guile
 * @version 1.0
 */
public interface EPLSService {

    /**
     * Searches for excluded providers.
     *
     * @param criteria the search criteria
     * @return the matched results
     * @throws ParsingException if any parsing errors are encountered
     * @throws ServiceException for any other exceptions encountered
     */
    SearchResult<ProviderProfile> search(EPLSSearchCriteria criteria) throws ParsingException, ServiceException;
}
