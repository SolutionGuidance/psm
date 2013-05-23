/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.screening.dao;

import gov.medicaid.entities.ProviderProfile;
import gov.medicaid.entities.PublicHealthNursingOrganizationSearchCriteria;
import gov.medicaid.entities.SearchResult;
import gov.medicaid.screening.services.ParsingException;
import gov.medicaid.screening.services.ServiceException;

/**
 * This represents the persistence API to search for public health nursing organizations for the given search criteria.
 * 
 * @author argolite, TCSASSEMBLER
 * @version 1.0
 * @since Organizational Provider Screening External Datasources Services 1
 */
public interface PublicHealthNursingOrganizationLicensingDAO {
    /**
     * This method gets the applicable providers that meet the search criteria. If none available, the search
     * result will be empty.
     * 
     * @param criteria
     *            the search criteria
     * @return the search result with the matched providers
     * @throws IllegalArgumentException
     *             if the criteria is null, if criteria.pageNumber < 0; if criteria.pageSize < 1 unless
     *             criteria.pageNumber <= 0
     * @throws ParsingException
     *             if the parsing of the responses caused an error
     * @throws ServiceException
     *             for any other exceptions encountered
     */
    public SearchResult<ProviderProfile> search(PublicHealthNursingOrganizationSearchCriteria criteria) throws ParsingException,
            ServiceException;
}
