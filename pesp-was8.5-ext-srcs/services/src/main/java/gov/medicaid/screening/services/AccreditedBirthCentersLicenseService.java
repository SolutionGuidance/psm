/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.screening.services;

import gov.medicaid.entities.AccreditedBirthCenter;
import gov.medicaid.entities.SearchResult;

/**
 * This represents the service API to search for accredited birth centers.
 *
 * <strong>Implementations should be effectively thread-safe.</strong>
 *
 * @author argolite, j3_guile
 * @version 1.0
 */
public interface AccreditedBirthCentersLicenseService {

    /**
     * This method gets the accredited birth centers.
     *
     * @return the search result with the accredited birth centers
     * @throws ParsingException if any parsing errors are encountered
     * @throws ServiceException for any other exceptions encountered
     */
    SearchResult<AccreditedBirthCenter> getAccreditedBirthCenters() throws ParsingException, ServiceException;
}
