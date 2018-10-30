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

import gov.medicaid.entities.Event;

import java.util.List;


/**
 * <p>
 * This represents the service API to manage events.
 * </p>
 * <p>
 * Implementations should be effectively thread-safe.
 * </p>
 */
public interface EventService {

    /**
     * This method creates the event and returns the new ID of the created entity.
     *
     * @param event the event to create
     *
     * @return the ID of the added event
     *
     * @throws IllegalArgumentException If event is null
     * @throws PortalServiceException If there are any errors during the execution of this method
     */
    long create(Event event) throws PortalServiceException;

    /**
     * This method gets the latest events.
     *
     * @return the latest events
     *
     * @throws PortalServiceException If there are any errors during the execution of this method
     */
    List<Event> getLatest() throws PortalServiceException;
}
