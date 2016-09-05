/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.screening.dao;

import gov.medicaid.entities.NurseAnesthetistsSearchCriteria;
import gov.medicaid.entities.ProviderProfile;
import gov.medicaid.screening.services.ServiceException;

/**
 * This defines the scraping interface for looking up Nurse Anesthetists license.
 *
 * <p>
 * <code>Thread Safety</code> Implementations are expected to be thread safe.
 * </p>
 *
 * @author argolite, j3_guile
 * @version 1.0
 */
public interface NurseAnesthetistsLicenseDAO {

    /**
     * Searches for Nurse Anesthetists license.
     *
     * @param criteria the search criteria
     * @return the matched profile, null if not matched
     * @throws IllegalArgumentException if the criteria is null, or any argument needed by the concrete implementation
     *             is not valid
     * @throws ServiceException for any other exceptions encountered
     */
    ProviderProfile search(NurseAnesthetistsSearchCriteria criteria) throws ServiceException;
}
