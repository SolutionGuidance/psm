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

import gov.medicaid.domain.model.ApplicantType;
import gov.medicaid.entities.ProviderType;
import gov.medicaid.entities.ProviderTypeSearchCriteria;
import gov.medicaid.entities.SearchResult;

import javax.jws.WebService;

import java.util.List;

/**
 * This represents the service API to manage provider types.
 *
 * <p>
 * <b>Thread Safety</b> Implementations should be effectively thread-safe.
 * </p>
 */
@WebService
public interface ProviderTypeService {

    /**
     * This method creates the provider type and returns the new ID of the created entity.
     *
     * @param providerType - the provider type to create
     * @return - the ID of the added provider type
     * @throws IllegalArgumentException - If providerType is null
     * @throws PortalServiceException - If there are any errors during the execution of this method
     */
    String create(ProviderType providerType) throws PortalServiceException;

    /**
     * This method updates the provider type.
     *
     * @param providerType - the provider type to update
     * @throws IllegalArgumentException - If providerType is null
     * @throws PortalServiceException - If there are any errors during the execution of this method
     */
    void update(ProviderType providerType) throws PortalServiceException;

    /**
     * This method gets a provider type by its ID. If not found, returns null.
     *
     * @param string - the ID of the provider type to retrieve
     * @return - the requested provider type
     * @throws PortalServiceException - If there are any errors during the execution of this method
     */
    ProviderType get(String string) throws PortalServiceException;

    /**
     * This method gets a provider type by its description. If not found, returns null.
     *
     * @param description - the description of the provider type to retrieve
     * @return - the requested provider type
     */
    ProviderType getByDescription(String description);

    /**
     * This method deletes the provider type with the given ID.
     *
     * @param id - the ID of the provider type to delete
     * @throws PortalServiceException - If there are any errors during the execution of this method
     */
    void delete(String id) throws PortalServiceException;

    /**
     * This method gets all the provider types that meet the search criteria. If none available, the search result will
     * be empty.
     *
     * @param criteria - the search criteria
     * @return - the applicable provider types
     * @throws IllegalArgumentException - If criteria.pageNumber < 0 or If criteria.pageSize < 1 unless
     *             criteria.pageNumber < 0
     * @throws PortalServiceException - If an error occurs while performing the operation
     */
    SearchResult<ProviderType> search(ProviderTypeSearchCriteria criteria) throws PortalServiceException;

    /**
     * @return all provider types
     */
    List<ProviderType> getAllProviderTypes();

    /**
     * Retrieves the provider types filtered by applicant type.
     *
     * @param applicantType
     *            individual or organizations
     * @return the filtered provider types
     */
    List<ProviderType> getProviderTypes(ApplicantType applicantType);

    /**
     * Updates the ProviderTypeSettings for agreements.
     *
     * @param providerType providerType
     * @param agreementIds agreement ids
     */
    void updateProviderTypeAgreementSettings(
            ProviderType providerType,
            long[] agreementIds
    );

    /**
     * Updates the ProviderTypeSettings for licenses.
     *
     * @param providerType providerType
     * @param licenseIds license ids
     */
    void updateProviderTypeLicenseSettings(
            ProviderType providerType,
            String[] licenseIds
    );

    /**
     * Updates the ProviderType can delete setting.
     *
     * @param providerType providerType
     */
    void updateProviderTypeCanDelete(ProviderType providerType);
}
