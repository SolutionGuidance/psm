/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.screening.services;

import gov.medicaid.entities.MedicaidCertifiedProviderSearchCriteria;
import gov.medicaid.entities.ProviderProfile;
import gov.medicaid.entities.SearchResult;

/**
 * This represents the service API to search for providers for the given search criteria.
 *
 * <strong>Implementations should be effectively thread-safe.</strong>
 *
 * @author argolite, j3_guile
 * @version 1.0
 */
public interface MedicaidCertifiedProvidersService {

    /**
     * This method gets the applicable providers that meet the search criteria. If none available, the search result
     * will be empty.
     *
     * @param criteria the search criteria
     * @return the search result with the matched providers
     * @throws IllegalArgumentException if the criteria is null
     * @throws IllegalArgumentException if criteria.pageNumber < 0
     * @throws IllegalArgumentException - if criteria.pageSize < 1 unless criteria.pageNumber <= 0
     * @throws ServiceException for any other exceptions encountered
     */
    SearchResult<ProviderProfile> search(MedicaidCertifiedProviderSearchCriteria criteria) throws ServiceException;
}
