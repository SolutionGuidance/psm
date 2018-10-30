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

import gov.medicaid.entities.BeneficialOwnerType;
import gov.medicaid.entities.LookupEntity;

import java.util.List;

/**
 * Defines the lookup related services.
 */
public interface LookupService {
    /**
     * Retrieves the lookup with the given description.
     *
     * @param cls
     *            the class to lookup
     * @param description
     *            the filter
     * @param <T>
     *            the return type
     * @return the matched lookup
     */
    <T extends LookupEntity> T findLookupByDescription(Class<T> cls, String description);

    /**
     * Retrieves the lookup with the given description.
     *
     * @param cls
     *            the class to lookup
     * @param description
     *            the filter
     * @param <T>
     *            the return type
     * @return the matched lookup
     */
    <T extends LookupEntity> T findLookupByCode(Class<T> cls, String code);

    /**
     * Find the related lookups to the given provider.
     *
     * @param cls          the class to search for
     * @param providerType the provider type to filter on
     * @param relType      the relationship mapping
     * @param <T>          the return type
     * @return the related types
     * @see gov.medicaid.entities.ProviderTypeSetting
     * @deprecated These should be replaced with Hibernate relationships.
     */
    @Deprecated
    <T extends LookupEntity> List<T> findRelatedLookup(
            Class<T> cls,
            String providerType,
            String relType
    );

    /**
     * Retrieves all the lookups of the given class.
     *
     * @param cls
     *            the class to search for
     * @param <T>
     *            the return type
     * @return the matched lookups
     */
    <T extends LookupEntity> List<T> findAllLookups(Class<T> cls);

    /**
     * Retrieves all the owner types allowed for the given structure.
     *
     * @param entityType
     *            the corporate structure types
     * @return the matched lookups
     */
    List<BeneficialOwnerType> findBeneficialOwnerTypes(String entityType);
}
