/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.screening.dao;

import gov.medicaid.entities.HealthOccupationsProgramCredentialSearchCriteria;
import gov.medicaid.entities.ProviderProfile;
import gov.medicaid.entities.SearchResult;
import gov.medicaid.screening.services.ServiceException;

/**
 * This defines the scraping interface for looking up health occupations program credentials.
 *
 * <p>
 * <code>Thread Safety</code> Implementations are expected to be thread safe.
 * </p>
 *
 * @author argolite, j3_guile
 * @version 1.0
 */
public interface HealthOccupationsProgramCredentialDAO {

    /**
     * Searches for health occupations program credentials.
     *
     * @param criteria the search criteria
     * @return the matched results
     * @throws IllegalArgumentException if the criteria is null, or any argument needed by the concrete implementation
     *             is not valid
     * @throws ServiceException for any other exceptions encountered
     */
    SearchResult<ProviderProfile> search(HealthOccupationsProgramCredentialSearchCriteria criteria)
        throws ServiceException;
}
