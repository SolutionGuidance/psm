/*
 * Copyright 2012-2013 TopCoder, Inc.
 *
 * This code was developed under U.S. government contract NNH10CD71C. 
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * You may not use this file except in compliance with the License.
 * You may obtain a copy of the License at:
 *     http://www.apache.org/licenses/LICENSE-2.0
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package gov.medicaid.services;

import gov.medicaid.entities.HelpItem;
import gov.medicaid.entities.HelpSearchCriteria;
import gov.medicaid.entities.SearchResult;

import javax.jws.WebService;

/**
 * This represents the service API to manage help items.
 *
 * <p>
 * <b>Thread Safety</b> Implementations should be effectively thread-safe.
 * </p>
 *
 * @author argolite, TCSASSEMBLER
 * @version 1.0
 */
@WebService
public interface HelpService {

    /**
     * This method creates the help item and returns the new ID of the created entity.
     *
     * @param help - the help item to create
     * @return - the ID of the added help item
     * @throws IllegalArgumentException - If help is null
     * @throws PortalServiceException - If there are any errors during the execution of this method
     */
    long create(HelpItem help) throws PortalServiceException;

    /**
     * This method updates the help item.
     *
     * @param help - the help item to update
     * @throws IllegalArgumentException - If help is null
     * @throws PortalServiceException - If there are any errors during the execution of this method
     */
    void update(HelpItem help) throws PortalServiceException;

    /**
     * This method gets a help item by its ID. If not found, returns null.
     *
     * @param id - the ID of the help item to retrieve
     * @return - the requested help item
     * @throws PortalServiceException - If there are any errors during the execution of this method
     */
    HelpItem get(long id) throws PortalServiceException;

    /**
     * This method deletes the help item with the given ID.
     *
     * @param id - the ID of the help item to delete
     * @throws PortalServiceException - If there are any errors during the execution of this method
     */
    void delete(long id) throws PortalServiceException;

    /**
     * This method gets all the help items that meet the search criteria. If none available, the search result will be
     * empty.
     *
     * @param criteria - the search criteria
     * @return - the applicable help items
     * @throws IllegalArgumentException - If criteria.pageNumber < 0 or If criteria.pageSize < 1 unless
     *             criteria.pageNumber < 0
     * @throws PortalServiceException - If an error occurs while performing the operation
     */
    SearchResult<HelpItem> search(HelpSearchCriteria criteria) throws PortalServiceException;
}
