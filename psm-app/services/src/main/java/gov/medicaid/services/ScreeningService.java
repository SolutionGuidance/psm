/*
 * Copyright 2012, 2013 TopCoder, Inc.
 * Copyright 2018 The MITRE Corporation
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package gov.medicaid.services;

import gov.medicaid.entities.AutomaticScreening;
import gov.medicaid.entities.ScreeningSchedule;
import gov.medicaid.entities.ScreeningSearchCriteria;
import gov.medicaid.entities.SearchResult;

import javax.jws.WebService;

import java.util.Optional;

/**
 * This represents the service API to perform screenings.
 *
 * <p>
 * <b>Thread Safety</b> Implementations should be effectively thread-safe.
 * </p>
 */
@WebService
public interface ScreeningService {
    /**
     * This method gets the screening schedule.
     *
     * @return the screening schedule
     * @throws PortalServiceException - If there are any errors during the execution of this method
     */
    ScreeningSchedule getScreeningSchedule() throws PortalServiceException;

    /**
     * This method saves the screening schedule.
     *
     * @param screeningSchedule - the screening schedule
     *
     * @throws IllegalArgumentException - If screeningSchedule is null
     * @throws PortalServiceException - If there are any errors during the execution of this method
     */
    void saveScreeningSchedule(
            ScreeningSchedule screeningSchedule
    ) throws PortalServiceException;

    Optional<AutomaticScreening> findScreening(long screeningId);

    /**
     * @param criteria - screening search criteria
     * @return list of matched screenings or empty list
     * @throws PortalServiceRuntimeException
     */
    SearchResult<AutomaticScreening> getScreenings(
            ScreeningSearchCriteria criteria
    ) throws PortalServiceRuntimeException;

    void saveScreening(AutomaticScreening screening);
}
