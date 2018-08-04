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

import gov.medicaid.entities.AutomaticScreening;
import gov.medicaid.entities.AutomaticScreening.Result;
import gov.medicaid.entities.ScreeningSchedule;
import gov.medicaid.entities.ScreeningSearchCriteria;
import gov.medicaid.entities.SearchResult;
import gov.medicaid.services.PortalServiceException;
import gov.medicaid.services.ScreeningService;
import gov.medicaid.services.util.Util;

import org.apache.commons.lang3.EnumUtils;

import javax.ejb.Local;
import javax.ejb.Stateless;
import javax.ejb.TransactionAttribute;
import javax.ejb.TransactionAttributeType;
import javax.ejb.TransactionManagement;
import javax.ejb.TransactionManagementType;
import javax.persistence.PersistenceException;
import javax.persistence.TypedQuery;

import java.time.ZoneId;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.stream.Collectors;

/**
 * This class provides an implementation of the ScreeningDAO as a local EJB.
 *
 * <p>
 * <b>Thread Safety</b> This bean is mutable and not thread-safe as it deals with non-thread-safe entities. However, in
 * the context of being used in a container, it is thread-safe.
 * </p>
 */
@Stateless
@TransactionManagement(TransactionManagementType.CONTAINER)
@Local(ScreeningService.class)
public class ScreeningServiceBean extends BaseService implements ScreeningService {

    /**
     * Constant id for the screening schedule.
     */
    private static final long SCREENING_SCHEDULE_ID = 1;

    /**
     * Default empty constructor.
     */
    public ScreeningServiceBean() {
    }

    /**
     * This method gets the screening schedule.
     *
     * @return the screening schedule
     * @throws PortalServiceException - If there are any errors during the execution of this method
     */
    @TransactionAttribute(TransactionAttributeType.SUPPORTS)
    public ScreeningSchedule getScreeningSchedule() throws PortalServiceException {
        try {
            ScreeningSchedule schedule = getEm().find(ScreeningSchedule.class, SCREENING_SCHEDULE_ID);
            return schedule;
        } catch (PersistenceException e) {
            throw new PortalServiceException("Could not complete database operation.", e);
        }
    }

    /**
     * This method saves the screening schedule.
     *
     * @param screeningSchedule - the screening schedule
     * @throws IllegalArgumentException - If screeningSchedule is null
     * @throws PortalServiceException - If there are any errors during the execution of this method
     */
    @TransactionAttribute(TransactionAttributeType.REQUIRED)
    public void saveScreeningSchedule(ScreeningSchedule screeningSchedule) throws PortalServiceException {
        if (screeningSchedule == null) {
            throw new IllegalArgumentException("Argument 'screeningSchedule' cannot be null.");
        }

        screeningSchedule.setId(SCREENING_SCHEDULE_ID);

        try {
            getEm().merge(screeningSchedule);
        } catch (PersistenceException e) {
            throw new PortalServiceException("Could not complete database operation.", e);
        }
    }

    @Override
    public Optional<AutomaticScreening> findScreening(
            long screeningId
    ) {
        return Optional.ofNullable(
                getEm().find(
                        AutomaticScreening.class,
                        screeningId
                )
        );
    }

    /**
     * Get all screenings or just some of them, filtered by date, status, etc.
     *
     * @param params - Filter condition based on date or status or both
     * @return list of screenings matching filter condition
     */
    @Override
    public SearchResult<AutomaticScreening> getScreenings(
            ScreeningSearchCriteria criteria
    ) {
        List<String> clauseList = new ArrayList<>();
        Map<String, Object> bindParams = new HashMap<>();

        addStatus(clauseList, bindParams, criteria);
        addDateRange(clauseList, bindParams, criteria);

        String queryString = buildQueryString(clauseList);
        String countQueryString = "SELECT count(*) " + queryString;

        TypedQuery<AutomaticScreening> query = getEm()
                .createQuery(queryString, AutomaticScreening.class);
        bindParams.forEach((k, v) -> query.setParameter(k, v));
        if (criteria.getPageSize() > 0) {
            int offset = (criteria.getPageNumber() - 1) * criteria.getPageSize();
            query.setFirstResult(offset);
            query.setMaxResults(criteria.getPageSize());
        }

        TypedQuery<Long> countQuery = getEm()
                .createQuery(countQueryString, Long.class);
        bindParams.forEach((k, v) -> countQuery.setParameter(k, v));

        SearchResult<AutomaticScreening> results = new SearchResult<>();
        results.setPageNumber(criteria.getPageNumber());
        results.setPageSize(criteria.getPageSize());

        results.setTotal(((Number) countQuery.getSingleResult()).intValue());
        results.setItems(query.getResultList());
        return results;
    }

    private void addStatus(
            List<String> clauseList,
            Map<String, Object> bindParams,
            ScreeningSearchCriteria criteria
    ) {
        if (Util.isNotBlank(criteria.getStatus()) &&
                EnumUtils.isValidEnum(Result.class, criteria.getStatus().toUpperCase())
        ) {
            clauseList.add("result in (:status)");
            bindParams.put("status", Result.valueOf(criteria.getStatus().toUpperCase()));
        }
    }

    private void addDateRange(
            List<String> clauseList,
            Map<String, Object> bindParams,
            ScreeningSearchCriteria criteria
    ) {
        if (criteria.getStartDate() != null && criteria.getEndDate() != null) {
            clauseList.add("created_at >= :startDate AND created_at < :endDate");
            bindParams.put("startDate", criteria.getStartDate());
            bindParams.put("endDate",
                    Date.from(
                            criteria.getEndDate()
                                    .toInstant()
                                    .atZone(ZoneId.systemDefault())
                                    .toLocalDate()
                                    .plusDays(1)
                                    .atStartOfDay(ZoneId.systemDefault()).toInstant()
                    )
            );
        }
    }

    private String buildQueryString(
            List<String> clauseList
    ) {
        String clause = clauseList.stream()
                .map(i -> i.toString())
                .collect(Collectors.joining(" And "));

        StringBuilder sql = new StringBuilder("FROM AutomaticScreening");
        if (clause.length() > 0) {
            sql.append(" WHERE ");
            sql.append(clause);
        }
        return sql.toString();
    }

    @Override
    public void saveScreening(AutomaticScreening screening) {
        getEm().merge(screening);
    }
}
