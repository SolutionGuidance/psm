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

import gov.medicaid.domain.rules.GlobalLookups;
import gov.medicaid.entities.AgreementDocument;
import gov.medicaid.entities.AgreementDocumentSearchCriteria;
import gov.medicaid.entities.SearchResult;
import gov.medicaid.services.AgreementDocumentService;
import gov.medicaid.services.EntityNotFoundException;
import gov.medicaid.services.PortalServiceException;
import gov.medicaid.services.util.Util;

import javax.ejb.Local;
import javax.ejb.Stateless;
import javax.ejb.TransactionAttribute;
import javax.ejb.TransactionAttributeType;
import javax.ejb.TransactionManagement;
import javax.ejb.TransactionManagementType;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceException;
import javax.persistence.Query;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * <p>
 * This class provides an implementation of the AgreementDocumentDAO.
 * </p>
 * <p>
 * This bean is mutable and not thread-safe as it deals with non-thread-safe entities. However, in the context of being
 * used in a container, it is thread-safe.
 * </p>
 */
@Stateless
@TransactionManagement(TransactionManagementType.CONTAINER)
@Local(AgreementDocumentService.class)
public class HibernateAgreementDocumentBean extends BaseService implements AgreementDocumentService {
    /**
     * Empty constructor.
     */
    public HibernateAgreementDocumentBean() {
    }

    /**
     * This method creates the agreement document and returns the new ID of the created entity.
     *
     * @param agreementDocument the agreement document to create
     *
     * @return the ID of the added agreement document
     *
     * @throws IllegalArgumentException If agreement document is null
     * @throws PortalServiceException If there are any errors during the execution of this method
     */
    @TransactionAttribute(TransactionAttributeType.REQUIRED)
    public long create(AgreementDocument agreementDocument) throws PortalServiceException {
        try {
            if (agreementDocument == null) {
                throw new IllegalArgumentException("Argument 'agreementDocument' cannot be null.");
            }

            agreementDocument.setId(0);
            agreementDocument.setCreatedOn(new Date());
            getEm().persist(agreementDocument);

            return agreementDocument.getId();
        } catch (PersistenceException e) {
            throw new PortalServiceException("Could not complete database operation.", e);
        }
    }

    /**
     * This method updates the agreement document.
     *
     * @param agreementDocument the agreement document to update
     *
     * @throws IllegalArgumentException If agreement document is null
     * @throws PortalServiceException If there are any errors during the execution of this method
     */
    @TransactionAttribute(TransactionAttributeType.REQUIRED)
    public void update(AgreementDocument agreementDocument) throws PortalServiceException {
        if (agreementDocument == null) {
            throw new IllegalArgumentException("Argument 'agreementDocument' cannot be null.");
        }

        try {
            AgreementDocument entity = getEm().find(AgreementDocument.class, agreementDocument.getId());

            if (entity == null) {
                throw new EntityNotFoundException("No such entity in the database.");
            }
            agreementDocument.setVersion(agreementDocument.getVersion() + 1);
            getEm().merge(agreementDocument);

            GlobalLookups.refresh();
        } catch (PersistenceException e) {
            throw new PortalServiceException("Could not complete database operation.", e);
        }
    }

    /**
     * This method gets a agreement document by its ID. If not found, returns null.
     *
     * @param agreementDocumentId the ID of the agreement document to retrieve
     *
     * @return the requested agreement document
     * @throws PortalServiceException If there are any errors during the execution of this method
     */
    @TransactionAttribute(TransactionAttributeType.SUPPORTS)
    public AgreementDocument get(long agreementDocumentId) throws PortalServiceException {
        try {
            return getEm().find(AgreementDocument.class, agreementDocumentId);
        } catch (PersistenceException e) {
            throw new PortalServiceException("Could not complete database operation.", e);
        }
    }

    /**
     * This method deletes the agreement document with the given ID.
     *
     * @param agreementDocumentId the ID of the agreement document to delete
     *
     * @throws PortalServiceException If there are any errors during the execution of this method
     */
    @TransactionAttribute(TransactionAttributeType.REQUIRED)
    public void delete(long agreementDocumentId) throws PortalServiceException {
        try {
            AgreementDocument item = getEm().find(AgreementDocument.class, agreementDocumentId);

            if (item == null) {
                throw new EntityNotFoundException("No such entity in the database.");
            }

            getEm().remove(item);
        } catch (PersistenceException e) {
            throw new PortalServiceException("Could not complete database operation.", e);
        }
    }

    /**
     * This method gets all the agreement documents that meet the search criteria. If none available, the search result
     * will be empty.
     *
     * @param criteria the search criteria
     *
     * @return the applicable agreement documents
     *
     * @throws IllegalArgumentException If criteria.pageNumber is less than 0 or if criteria.pageSize is less than 1
     *             unless criteria.pageNumber is less than 0
     * @throws PortalServiceException If an error occurs while performing the operation
     */
    @TransactionAttribute(TransactionAttributeType.SUPPORTS)
    public SearchResult<AgreementDocument> search(AgreementDocumentSearchCriteria criteria)
        throws PortalServiceException {
        try {
            if (criteria == null) {
                throw new IllegalArgumentException("criteria cannot be null.");
            }
            if (criteria.getPageNumber() <= 0 || (criteria.getPageNumber() > 1 && criteria.getPageSize() <= 0)) {
                throw new IllegalArgumentException("invalid page combination");
            }
            // Create result object:
            SearchResult<AgreementDocument> searchResults = new SearchResult<AgreementDocument>();
            // Set page number:
            searchResults.setPageNumber(criteria.getPageNumber());
            // Set page size:
            searchResults.setPageSize(criteria.getPageSize());

            // Query for count of all entities for the provided filters
            // (here there is no paging applied, and sorting is not relevant)
            // Create query string:
            StringBuilder entityCountQueryString = new StringBuilder("FROM AgreementDocument entity WHERE 1=1 ");
            Map<String, Object> parameters = new HashMap<String, Object>();

            if (Util.isNotBlank(criteria.getTitle())) {
                entityCountQueryString.append("AND title LIKE :title ");
                parameters.put("title", criteria.getTitle());
            }

            if (criteria.getType() != null) {
                entityCountQueryString.append("AND type = :type ");
                parameters.put("type", criteria.getType().name());
            }

            // Get count
            List<Long> results = queryResultList(getEm(), "SELECT count(entity) " + entityCountQueryString.toString(),
                parameters, 0, 0);
            int totalRecordCount = results.get(0).intValue();

            if (Util.isNotBlank(criteria.getSortColumn())) {
                entityCountQueryString.append("ORDER BY entity." + criteria.getSortColumn()
                    + (criteria.isAscending() ? " ASC" : " DESC"));
            }
            // Create query string to get the requested paged entries for the
            // applicable filters
            List<AgreementDocument> items = queryResultList(getEm(),
                "SELECT entity " + entityCountQueryString.toString(), parameters, criteria.getPageNumber(),
                criteria.getPageSize());
            searchResults.setItems(items);
            searchResults = assembleResult(searchResults, criteria.getPageNumber(), criteria.getPageSize(),
                totalRecordCount);

            return searchResults;
        } catch (PersistenceException e) {
            throw new PortalServiceException("Could not complete database operation.", e);
        }
    }

    /**
     * <p>
     * Run the hql with the given manager which returns a list.
     * </p>
     *
     * @param <T> the list type
     * @param manager the entity manager.
     * @param hql the hql to run
     * @param parameters the parameters
     * @param pageNo the page number
     * @param pageSize the page size
     *
     * @return the query results list
     */
    @SuppressWarnings("unchecked")
    private static <T> List<T> queryResultList(EntityManager manager, String hql, Map<String, Object> parameters,
        int pageNo, int pageSize) {
        Query query = manager.createQuery(hql);

        for (Map.Entry<String, Object> entry : parameters.entrySet()) {
            query.setParameter(entry.getKey(), entry.getValue());
        }

        // Set result page:
        if (pageSize > 0) {
            query.setFirstResult((pageNo - 1) * pageSize).setMaxResults(pageSize);
        }

        return query.getResultList();
    }

    /**
     * <p>
     * Assemble the searching results.
     * </p>
     *
     * @param searchResults the SearchResult instance
     * @param pageNo the page number
     * @param pageSize the page size
     * @param totalRecordCount total records
     *
     * @return the paged result.
     */
    private SearchResult<AgreementDocument> assembleResult(SearchResult<AgreementDocument> searchResults, int pageNo,
        int pageSize, int totalRecordCount) {
        // Set current page:
        searchResults.setPageNumber(pageNo);
        // Set total records:
        searchResults.setTotal(totalRecordCount);
        // Set page size:
        searchResults.setPageSize(pageSize);
        return searchResults;
    }
}
