/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.screening.services;

import gov.medicaid.entities.NurseAnesthetistsSearchCriteria;
import gov.medicaid.entities.ProviderProfile;

/**
 * This defines the available services for searching for Nurse Anesthetists license.
 *
 * <p>
 * <code>Thread Safety</code> Implementations are expected to be thread safe.
 * </p>
 *
 * @author argolite, j3_guile
 * @version 1.0
 */
public interface NurseAnesthetistsLicenseService {

    /**
     * Searches for Nurse Anesthetists license.
     *
     * @param criteria the search criteria
     * @return the matched profile
     * @throws IllegalArgumentException if the criteria is null, or any argument needed by the concrete implementation
     *             is not valid
     * @throws ServiceException for any other exceptions encountered
     */
    ProviderProfile search(NurseAnesthetistsSearchCriteria criteria) throws ServiceException;
}