/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.screening.dao;

import gov.medicaid.entities.AccreditedBirthCenter;
import gov.medicaid.entities.SearchResult;
import gov.medicaid.screening.services.ServiceException;

/**
 * This represents the persistence API to search for accredited birth centers.
 *
 * <strong>Implementations should be effectively thread-safe.</strong>
 *
 * @author argolite, j3_guile
 * @version 1.0
 */
public interface AccreditedBirthCentersLicenseDAO {

    /**
     * This method gets the accredited birth centers.
     *
     * @return the search result with the accredited birth centers
     * @throws ServiceException for any other exceptions encountered
     */
    SearchResult<AccreditedBirthCenter> getAccreditedBirthCenters() throws ServiceException;
}
