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

import gov.medicaid.entities.AutomaticScreening;
import gov.medicaid.entities.AutomaticScreening.Result;
import gov.medicaid.entities.ScreeningSchedule;
import gov.medicaid.services.PortalServiceException;
import gov.medicaid.services.ScreeningService;
import gov.medicaid.services.util.Util;
import org.apache.commons.collections.MapUtils;
import org.apache.commons.lang3.EnumUtils;
import javax.ejb.Local;
import javax.ejb.Stateless;
import javax.ejb.TransactionAttribute;
import javax.ejb.TransactionAttributeType;
import javax.ejb.TransactionManagement;
import javax.ejb.TransactionManagementType;
import javax.persistence.PersistenceException;
import javax.persistence.TypedQuery;
import java.text.ParseException;
import java.text.SimpleDateFormat;
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
 *
 * @author argolite, TCSASSEMBLER
 * @version 1.0
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
     * Constant for date format used in queries
     */
    private static final String DATE_PATTERN = "MM/dd/yyyy";

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
    public Optional<AutomaticScreening> findScreening(long screeningId) {
        return Optional.ofNullable(
                getEm().find(AutomaticScreening.class, screeningId, hintEntityGraph("Screening with matches")));
    }

    /*
     * This method is for getting all screenings.
     * @param params - Filter condition based on date or status or both
     * @return list of screenings matching filter condition
     */

    @Override
    public List<AutomaticScreening> getAllScreenings(Map<String, String> params)
            throws PortalServiceException {
        List<String> clauseList = new ArrayList<>();
        String start = MapUtils.getString(params, "startDate");
        String end = MapUtils.getString(params, "endDate");
        String status = MapUtils.getString(params, "status");
        Map<String, Object> bindParams = new HashMap<>();

        // Clause for Status filter
        if (Util.isNotBlank(status) && EnumUtils.isValidEnum(Result.class, status.toUpperCase())) {
            clauseList.add("result in (:status)");
            bindParams.put("status", Result.valueOf(status.toUpperCase()));
        }

        // Clause for Date Range filter
        if (Util.isNotBlank(start) && Util.isNotBlank(end)) {
            SimpleDateFormat format = new SimpleDateFormat(DATE_PATTERN);
            try {
                Date frmDate = format.parse(start);
                Date enDate = format.parse(end);
                clauseList.add("created_at BETWEEN :stDate AND :edDate");
                bindParams.put("stDate", frmDate);
                bindParams.put("edDate", enDate);
            } catch (ParseException e) {
                throw new PortalServiceException("Could not complete database operation.", e);
            }
        }

        // TODO: Add page parameters here

        // Build Clause dynamically from inputs
        String clause = clauseList.stream().map(i -> i.toString()).collect(Collectors.joining(" And "));
        StringBuilder sql = new StringBuilder("FROM AutomaticScreening");
        if (clause.length() > 0) {
            sql.append(" WHERE ");
            sql.append(clause);
        }

        // Query
        TypedQuery<AutomaticScreening> query = getEm().createQuery(sql.toString(), AutomaticScreening.class);
        bindParams.forEach((k, v) -> query.setParameter(k, v));

        return query.getResultList();
    }

}
