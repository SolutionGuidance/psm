/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.screening.services;

import gov.medicaid.entities.HealthOccupationsProgramCredentialSearchCriteria;
import gov.medicaid.entities.ProviderProfile;
import gov.medicaid.entities.SearchResult;

/**
 * This defines the available services for searching for health occupations program credentials.
 *
 * <p>
 * <code>Thread Safety</code> Implementations are expected to be thread safe.
 * </p>
 *
 * @author argolite, j3_guile
 * @version 1.0
 */
public interface HealthOccupationsProgramCredentialService {

    /**
     * Searches for health occupations program credentials.
     *
     * @param criteria the search criteria
     * @return the matched results
     * @throws IllegalArgumentException if the criteria is null, it may be thrown if a parameter needed by the source
     *             site is invalid
     * @throws ServiceException for any other exceptions encountered
     */
    SearchResult<ProviderProfile> search(HealthOccupationsProgramCredentialSearchCriteria criteria)
        throws ServiceException;
}