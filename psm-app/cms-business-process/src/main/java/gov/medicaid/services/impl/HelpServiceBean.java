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
package gov.medicaid.services.impl;

import gov.medicaid.entities.HelpItem;
import gov.medicaid.entities.HelpSearchCriteria;
import gov.medicaid.entities.SearchResult;
import gov.medicaid.services.EntityNotFoundException;
import gov.medicaid.services.HelpService;
import gov.medicaid.services.PortalServiceException;
import gov.medicaid.services.util.LogUtil;
import gov.medicaid.services.util.Sequences;
import gov.medicaid.services.util.Util;

import javax.ejb.Local;
import javax.ejb.Stateless;
import javax.ejb.TransactionAttribute;
import javax.ejb.TransactionAttributeType;
import javax.ejb.TransactionManagement;
import javax.ejb.TransactionManagementType;
import javax.persistence.PersistenceException;
import javax.persistence.Query;

/**
 * This class provides an implementation of the <code>HelpService</code> as a local EJB.
 *
 * <p>
 * <b>Thread Safety</b> This bean is mutable and not thread-safe as it deals with non-thread-safe entities. However, in
 * the context of being used in a container, it is thread-safe.
 * </p>
 *
 * @author argolite, TCSASSEMBLER
 * @version 1.0
 */
@Stateless
@TransactionManagement(TransactionManagementType.CONTAINER)
@Local(HelpService.class)
public class HelpServiceBean extends BaseService implements HelpService {

    /**
     * Default empty constructor.
     */
    public HelpServiceBean() {
    }

    /**
     * This method creates the help item and returns the new ID of the created entity.
     *
     * @param help - the help item to create
     * @return - the ID of the added help item
     *
     * @throws IllegalArgumentException - If help is null
     * @throws PortalServiceException - If there are any errors during the execution of this method
     */
    @TransactionAttribute(TransactionAttributeType.REQUIRED)
    public long create(HelpItem help) throws PortalServiceException {
        String signature = "HelpDAOBean#create(HelpItem help)";
        LogUtil.traceEntry(getLog(), signature, new String[]{"help"}, new Object[]{help});

        if (help == null) {
            throw new IllegalArgumentException("argument 'help' cannot be null.");
        }

        try {
            help.setId(0);
            getEm().persist(help);
            return LogUtil.traceExit(getLog(), signature, help.getId());
        } catch (PersistenceException e) {
            throw new PortalServiceException("Could not database complete operation.", e);
        }
    }

    /**
     * This method updates the help item.
     *
     * @param help - the help item to update
     *
     * @throws IllegalArgumentException - If help is null
     * @throws PortalServiceException - If there are any errors during the execution of this method
     */
    @TransactionAttribute(TransactionAttributeType.REQUIRED)
    public void update(HelpItem help) throws PortalServiceException {
        String signature = "HelpDAOBean#update(HelpItem help)";
        LogUtil.traceEntry(getLog(), signature, new String[]{"help"}, new Object[]{help});

        if (help == null) {
            throw new IllegalArgumentException("Argument 'help' cannot be null.");
        }

        try {
            HelpItem item = getEm().find(HelpItem.class, help.getId());
            if (item == null) {
                throw new EntityNotFoundException("No such entity in the database.");
            }
            getEm().merge(help);
            LogUtil.traceExit(getLog(), signature, null);
        } catch (PersistenceException e) {
            throw new PortalServiceException("Could not database complete operation.", e);
        }
    }

    /**
     * This method gets a help item by its ID. If not found, returns null.
     *
     * @param id - the ID of the help item to retrieve
     * @return - the requested help item
     *
     * @throws PortalServiceException - If there are any errors during the execution of this method
     */
    @TransactionAttribute(TransactionAttributeType.SUPPORTS)
    public HelpItem get(long id) throws PortalServiceException {
        String signature = "HelpDAOBean#get(long id)";
        LogUtil.traceEntry(getLog(), signature, new String[]{"id"}, new Object[]{id});

        try {
            return LogUtil.traceExit(getLog(), signature, getEm().find(HelpItem.class, id));
        } catch (PersistenceException e) {
            throw new PortalServiceException("Could not database complete operation.", e);
        }
    }

    /**
     * This method deletes the help item with the given ID.
     *
     * @param id - the ID of the help item to delete
     *
     * @throws PortalServiceException - If there are any errors during the execution of this method
     */
    @TransactionAttribute(TransactionAttributeType.REQUIRED)
    public void delete(long id) throws PortalServiceException {
        String signature = "HelpDAOBean#delete(long id)";
        LogUtil.traceEntry(getLog(), signature, new String[]{"id"}, new Object[]{id});

        try {
            HelpItem item = getEm().find(HelpItem.class, id);
            if (item == null) {
                throw new EntityNotFoundException("No such entity in the database.");
            }
            getEm().remove(item);
            LogUtil.traceExit(getLog(), signature, null);
        } catch (PersistenceException e) {
            throw new PortalServiceException("Could not database complete operation.", e);
        }
    }

    /**
     * This method gets all the help items that meet the search criteria. If none available, the search result will be
     * empty.
     *
     * @param criteria - the search criteria
     * @return - the applicable help items
     *
     * @throws IllegalArgumentException - If criteria.pageNumber < 0 or If criteria.pageSize < 1 unless
     *             criteria.pageNumber < 0
     * @throws PortalServiceException - If an error occurs while performing the operation
     */
    @SuppressWarnings("unchecked")
    @TransactionAttribute(TransactionAttributeType.SUPPORTS)
    public SearchResult<HelpItem> search(HelpSearchCriteria criteria) throws PortalServiceException {
        String signature = "HelpDAOBean#search(HelpSearchCriteria criteria)";
        LogUtil.traceEntry(getLog(), signature, new String[]{"criteria"}, new Object[]{criteria});

        if (criteria == null) {
            throw new IllegalArgumentException("criteria cannot be null.");
        }
        if (criteria.getPageNumber() <= 0 || (criteria.getPageNumber() > 1 && criteria.getPageSize() <= 0)) {
            throw new IllegalArgumentException("invalid page combination");
        }

        SearchResult<HelpItem> results = new SearchResult<HelpItem>();
        results.setPageNumber(criteria.getPageNumber());
        results.setPageSize(criteria.getPageSize());

        StringBuilder countQuery = new StringBuilder("SELECT count(entity) FROM HelpItem entity WHERE 1 = 1 ");
        appendCriteria(countQuery, criteria);

        Query count = getEm().createQuery(countQuery.toString());
        bindParameters(count, criteria);
        results.setTotal(((Number) count.getSingleResult()).intValue());

        StringBuilder fetchQuery = new StringBuilder("SELECT entity FROM HelpItem entity WHERE 1 = 1 ");
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
        return LogUtil.traceExit(getLog(), signature, results);
    }


    /**
     * Appends the provider search criteria to the current buffer.
     *
     * @param buffer the query buffer
     * @param criteria the search criteria
     */
    private void appendCriteria(StringBuilder buffer, HelpSearchCriteria criteria) {
        if (Util.isNotBlank(criteria.getTerm())) {
            buffer.append("AND entity.title LIKE :title ");
        }
    }

    /**
     * Binds the provider search criteria to the query.
     *
     * @param query the query to bind to
     * @param criteria the search criteria
     */
    private void bindParameters(Query query, HelpSearchCriteria criteria) {
        if (Util.isNotBlank(criteria.getTerm())) {
            query.setParameter("title", "%" + criteria.getTerm() + "%");
        }
    }

    /**
     * Appends the sorting criteria.
     * @param fetchQuery the fetch query
     * @param criteria the criteria to append
     */
    private void appendSorting(StringBuilder fetchQuery, HelpSearchCriteria criteria) {
        if (Util.isNotBlank(criteria.getSortColumn())) {
            fetchQuery.append(" ORDER BY entity.").append(criteria.getSortColumn())
                .append(!criteria.isAscending() ? " DESC" : " ASC");
        }
    }
}
