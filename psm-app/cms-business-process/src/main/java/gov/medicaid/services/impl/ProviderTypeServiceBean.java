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

package gov.medicaid.services.impl;

import gov.medicaid.domain.model.ApplicantType;
import gov.medicaid.entities.AgreementDocument;
import gov.medicaid.entities.LicenseType;
import gov.medicaid.entities.ProviderType;
import gov.medicaid.entities.ProviderTypeSearchCriteria;
import gov.medicaid.entities.SearchResult;
import gov.medicaid.services.EntityNotFoundException;
import gov.medicaid.services.PortalServiceException;
import gov.medicaid.services.ProviderTypeService;
import gov.medicaid.services.util.Util;

import javax.ejb.Local;
import javax.ejb.Stateless;
import javax.ejb.TransactionAttribute;
import javax.ejb.TransactionAttributeType;
import javax.ejb.TransactionManagement;
import javax.ejb.TransactionManagementType;
import javax.persistence.EntityGraph;
import javax.persistence.PersistenceException;
import javax.persistence.Query;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashSet;
import java.util.List;
import java.util.stream.Collectors;

/**
 * This class provides an implementation of the <code>ProviderTypeDAO</code> as a local EJB.
 *
 * <p>
 * <b>Thread Safety</b> This bean is mutable and not thread-safe as it deals with non-thread-safe entities. However, in
 * the context of being used in a container, it is thread-safe.
 * </p>
 */
@Stateless
@TransactionManagement(TransactionManagementType.CONTAINER)
@Local(ProviderTypeService.class)
public class ProviderTypeServiceBean extends BaseService implements ProviderTypeService {

    /**
     * Default empty constructor.
     */
    public ProviderTypeServiceBean() {
    }

    /**
     * This method creates the provider type and returns the new ID of the created entity.
     *
     * @param providerType - the provider type to create
     * @return - the ID of the added provider type
     * @throws IllegalArgumentException - If providerType is null
     * @throws PortalServiceException - If there are any errors during the execution of this method
     */
    @TransactionAttribute(TransactionAttributeType.REQUIRED)
    public String create(ProviderType providerType) throws PortalServiceException {
        if (providerType == null) {
            throw new IllegalArgumentException("Argument 'providerType' cannot be null.");
        }

        try {
            if (Util.isBlank(providerType.getCode())) {
                providerType.setCode(generateCode(getLookupService().findAllLookups(ProviderType.class)));
            }
            getEm().persist(providerType);
            return providerType.getCode();
        } catch (PersistenceException e) {
            throw new PortalServiceException("Could not complete database operation.", e);
        }
    }

    /**
     * Generates a unique provider type code.
     *
     * @param findAllLookups all existing provider types
     * @return a unique provider type
     * @throws PortalServiceException if there are no more codes to be used (36*36 provider types supported) (highly
     *             unlikely)
     */
    private String generateCode(List<ProviderType> findAllLookups) throws PortalServiceException {
        HashSet<String> taken = new HashSet<String>();
        for (ProviderType providerType : findAllLookups) {
            taken.add(providerType.getCode());
        }

        char[] charsToUse = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789".toCharArray();
        for (char c1 : charsToUse) {
            String start = "" + c1 + "A";
            String end = "" + c1 + "9";
            if (taken.contains(start) && taken.contains(end)) {
                continue;
            }
            for (char c2 : charsToUse) {
                String test = c1 + "" + c2;
                if (!taken.contains(test)) {
                    return test;
                }
            }
        }

        throw new PortalServiceException("No Provider type code available for use.");
    }

    /**
     * This method updates the provider type.
     *
     * @param providerType - the provider type to update
     * @throws IllegalArgumentException - If providerType is null
     * @throws PortalServiceException - If there are any errors during the execution of this method
     */
    @TransactionAttribute(TransactionAttributeType.REQUIRED)
    public void update(ProviderType providerType) throws PortalServiceException {
        if (providerType == null) {
            throw new IllegalArgumentException("Argument 'providerType' cannot be null.");
        }

        try {
            ProviderType obj = getEm().find(ProviderType.class, providerType.getCode());
            if (obj == null) {
                throw new EntityNotFoundException("No such entity in the database.");
            }
            getEm().merge(providerType);
        } catch (PersistenceException e) {
            throw new PortalServiceException("Could not complete database operation.", e);
        }
    }

    /**
     * This method gets a provider type by its ID. If not found, returns null.
     *
     * @param id - the ID of the provider type to retrieve
     * @return - the requested provider type
     *
     * @throws PortalServiceException - If there are any errors during the execution of this method
     */
    @TransactionAttribute(TransactionAttributeType.SUPPORTS)
    public ProviderType get(String id) throws PortalServiceException {
        try {
            return getEm().find(
                    ProviderType.class,
                    id,
                    hintEntityGraph("ProviderType with AgreementDocuments and LicenseTypes")
            );
        } catch (PersistenceException e) {
            throw new PortalServiceException("Could not complete database operation.", e);
        }
    }

    /**
     * This method gets a provider type by its description. If not found, returns null.
     *
     * @param description - the description of the provider type to retrieve
     * @return - the requested provider type, null if not found
     *
     * @throws PortalServiceException - If there are any errors during the execution of this method
     */
    @TransactionAttribute(TransactionAttributeType.SUPPORTS)
    public ProviderType getByDescription(String description) {
        EntityGraph graph = getEm().getEntityGraph(
            "ProviderType with AgreementDocuments and LicenseTypes"
        );
        return getEm().createQuery(
            "FROM ProviderType WHERE description = :description",
            ProviderType.class
        ).setParameter("description", description)
        .setHint("javax.persistence.loadgraph", graph)
        .getSingleResult();
    }

    /**
     * This method deletes the provider type with the given ID.
     *
     * @param id - the ID of the provider type to delete
     * @throws PortalServiceException - If there are any errors during the execution of this method
     */
    @TransactionAttribute(TransactionAttributeType.REQUIRED)
    @Override
    public void delete(String id) throws PortalServiceException {
        try {
            ProviderType obj = getEm().find(ProviderType.class, id);
            if (obj == null) {
                throw new EntityNotFoundException("No such entity in the database.");
            }
            getEm().remove(obj);
        } catch (PersistenceException e) {
            throw new PortalServiceException("Could not complete database operation.", e);
        }
    }

    /**
     * This method gets all the provider types that meet the search criteria. If none available, the search result will
     * be empty.
     *
     * @param criteria - the search criteria
     * @return - the applicable provider types
     *
     * @throws IllegalArgumentException - If criteria.pageNumber < 0 or If criteria.pageSize < 1 unless
     *             criteria.pageNumber < 0
     * @throws PortalServiceException - If an error occurs while performing the operation
     */
    @SuppressWarnings("unchecked")
    @TransactionAttribute(TransactionAttributeType.SUPPORTS)
    public SearchResult<ProviderType> search(ProviderTypeSearchCriteria criteria) throws PortalServiceException {
        if (criteria == null) {
            throw new IllegalArgumentException("criteria cannot be null.");
        }
        if (criteria.getPageNumber() <= 0 || (criteria.getPageNumber() > 1 && criteria.getPageSize() <= 0)) {
            throw new IllegalArgumentException("Invalid page combination.");
        }

        SearchResult<ProviderType> results = new SearchResult<ProviderType>();
        results.setPageNumber(criteria.getPageNumber());
        results.setPageSize(criteria.getPageSize());

        StringBuilder countQuery = new StringBuilder("SELECT count(entity) FROM ProviderType entity WHERE 1 = 1 ");
        appendCriteria(countQuery, criteria);

        Query count = getEm().createQuery(countQuery.toString());
        bindParameters(count, criteria);
        results.setTotal(((Number) count.getSingleResult()).intValue());

        StringBuilder fetchQuery = new StringBuilder("SELECT entity FROM ProviderType entity WHERE 1 = 1 ");
        appendCriteria(fetchQuery, criteria);
        appendSorting(fetchQuery, criteria);

        Query items = getEm().createQuery(fetchQuery.toString());
        bindParameters(items, criteria);
        if (criteria.getPageSize() > 0) {
            int offset = (criteria.getPageNumber() - 1) * criteria.getPageSize();
            items.setFirstResult(offset);
            items.setMaxResults(criteria.getPageSize());
        }

        results.setItems(items.getResultList());
        return results;
    }

    public List<ProviderType> getAllProviderTypes() {
        return getEm().createQuery(
                "FROM ProviderType",
                ProviderType.class
        ).getResultList();
    }

    /**
     * Retrieves the provider types filtered by applicant type.
     *
     * @param applicantType
     *            individual or organizations
     * @return the filtered provider types
     */
    public List<ProviderType> getProviderTypes(ApplicantType applicantType) {
        return getEm().createQuery(
                "FROM ProviderType WHERE applicantType = :type",
                ProviderType.class
        ).setParameter(
                "type",
                applicantType
        ).getResultList();
    }

    @Override
    public void updateProviderTypeAgreementSettings(
            ProviderType providerType,
            long[] agreementIds
    ) {
        providerType.setAgreementDocuments(
                new HashSet<>(getAgreementDocuments(agreementIds))
        );
        getEm().merge(providerType);
    }

    @Override
    public void updateProviderTypeLicenseSettings(
            ProviderType providerType,
            String[] licenseCodes
    ) {
        providerType.setLicenseTypes(
                new HashSet<>(getLicenseTypes(licenseCodes))
        );
        getEm().merge(providerType);
    }

    @Override
    public void updateProviderTypeCanDelete(ProviderType providerType) {
        providerType.setCanDelete(
            0 == ((Number) (getEm().createQuery("SELECT count(*) FROM Entity WHERE providerType = :providerType")
                     .setParameter("providerType", providerType)
                     .getSingleResult()))
                 .intValue() &&
            0 == ((Number) (getEm().createQuery("SELECT count(*) FROM ProviderTypeSetting WHERE providerTypeCode = :providerTypeCode")
                     .setParameter("providerTypeCode", providerType.getCode())
                     .getSingleResult()))
                 .intValue()
        );
    }

    private List<AgreementDocument> getAgreementDocuments(long[] agreementIds) {
        if (agreementIds.length == 0) {
            return new ArrayList<>();
        } else {
            return getEm().createQuery(
                    "FROM AgreementDocument WHERE id IN :ids",
                    AgreementDocument.class
            ).setParameter(
                    "ids",
                    Arrays.stream(agreementIds)
                            .boxed()
                            .collect(Collectors.toList())
            ).getResultList();
        }
    }

    private List<LicenseType> getLicenseTypes(String[] licenseCodes) {
        if (licenseCodes.length == 0) {
            return new ArrayList<>();
        } else {
            return getEm().createQuery(
                    "FROM LicenseType WHERE code IN :codes",
                    LicenseType.class
            ).setParameter(
                    "codes",
                    Arrays.asList(licenseCodes)
            ).getResultList();
        }
    }

    /**
     * Appends the provider type search criteria to the current buffer.
     *
     * @param buffer the query buffer
     * @param criteria the search criteria
     */
    private void appendCriteria(StringBuilder buffer, ProviderTypeSearchCriteria criteria) {
        if (Util.isNotBlank(criteria.getTypeName())) {
            buffer.append("AND entity.description LIKE :name ");
        }
    }

    /**
     * Binds the provider type search criteria to the query.
     *
     * @param query the query to bind to
     * @param criteria the search criteria
     */
    private void bindParameters(Query query, ProviderTypeSearchCriteria criteria) {
        if (Util.isNotBlank(criteria.getTypeName())) {
            query.setParameter("name", criteria.getTypeName() + "%");
        }
    }

    /**
     * Appends the sorting criteria.
     * @param fetchQuery the fetch query
     * @param criteria the criteria to append
     */
    private void appendSorting(StringBuilder fetchQuery, ProviderTypeSearchCriteria criteria) {
        if (Util.isNotBlank(criteria.getSortColumn())) {
            fetchQuery.append(" ORDER BY entity.").append(criteria.getSortColumn())
                .append(!criteria.isAscending() ? " DESC" : " ASC");
        }
    }
}
