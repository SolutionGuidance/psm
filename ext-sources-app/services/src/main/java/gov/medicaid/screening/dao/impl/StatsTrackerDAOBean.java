/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.screening.dao.impl;

import gov.medicaid.entities.ResultLogEntry;
import gov.medicaid.entities.SourceStats;
import gov.medicaid.screening.dao.StatsTrackerDAO;
import gov.medicaid.screening.services.ConfigurationException;
import gov.medicaid.screening.services.ErrorCode;
import gov.medicaid.screening.services.PersistenceException;
import gov.medicaid.screening.services.ServiceException;
import gov.medicaid.screening.services.impl.LogUtil;

import java.util.List;

import javax.annotation.PostConstruct;
import javax.ejb.Local;
import javax.ejb.Stateless;
import javax.ejb.TransactionAttribute;
import javax.ejb.TransactionAttributeType;
import javax.ejb.TransactionManagement;
import javax.ejb.TransactionManagementType;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import org.apache.http.HttpStatus;

import com.topcoder.util.log.Level;
import com.topcoder.util.log.Log;

/**
 * This class provides an EJB3 based implementation of the StatsTrackerDAO. Unlike the rest of the DAO, it cannot extend
 * the <code>BaseDAO</code> because it is a runtime dependency of the {@link BaseDAO}.
 *
 * <strong>This is an stateless EJB and is thread safe.</strong>
 *
 * @author argolite, j3_guile
 * @version 1.0
 */
@Stateless
@Local(StatsTrackerDAO.class)
@TransactionManagement(TransactionManagementType.CONTAINER)
@SuppressWarnings({ "rawtypes", "unchecked" })
public class StatsTrackerDAOBean implements StatsTrackerDAO {

    /**
     * Class logger.
     */
    private final Log log = LogUtil.getLog(getClass().getName());

    /**
     * Persistence context.
     */
    @PersistenceContext
    private EntityManager entityManager;

    /**
     * Default empty constructor.
     */
    public StatsTrackerDAOBean() {
    }

    /**
     * Retrieves the current statistics for the given host.
     *
     * @param hostId the external host to get the statistics for
     * @return the current statistics (may be null)
     * @throws IllegalArgumentException if the argument is null or an empty string
     * @throws ServiceException for any errors encountered
     */
    @TransactionAttribute(TransactionAttributeType.SUPPORTS)
    public SourceStats getReliabilityStatistics(String hostId) throws ServiceException {
        String signature = "StatsTrackerDAOBean#getReliabilityStatistics";
        LogUtil.traceEntry(log, signature, new String[]{"hostId"}, new Object[]{hostId});

        if (Util.isBlank(hostId)) {
            throw new IllegalArgumentException(ErrorCode.MITA10028.getDesc());
        }

        try {
            String findByHostId = "SELECT s FROM SourceStats s WHERE s.name = :hostId";
            List results = entityManager.createQuery(findByHostId).setParameter("hostId", hostId).getResultList();

            SourceStats stats;
            if (results.isEmpty()) {
                stats = null;
            } else {
                stats = (SourceStats) results.get(0); // unique result is expected
            }

            return LogUtil.traceExit(log, signature, stats);
        } catch (javax.persistence.PersistenceException e) {
            LogUtil.traceError(log, signature, e);
            throw new PersistenceException(ErrorCode.MITA50000.getDesc(), e);
        }
    }

    /**
     * Retrieves a paginated list of logged entries.
     *
     * @param startIndex the start index, ignored if 0
     * @param pageSize the page size, ignored if 0
     * @throws IllegalArgumentException if the start index is less than 0, or if page size < 0
     * @return all log entries filtered by the index and page size
     * @throws ServiceException for any errors encountered
     */
    @TransactionAttribute(TransactionAttributeType.SUPPORTS)
    public List<ResultLogEntry> getLoggedEntries(int startIndex, int pageSize) throws ServiceException {
        String signature = "StatsTrackerDAOBean#getLoggedEntries";
        LogUtil.traceEntry(log, signature, new String[]{"startIndex", "pageSize"}, new Object[]{startIndex, pageSize});

        if (startIndex < 0 || pageSize < 0) {
            throw new IllegalArgumentException(ErrorCode.MITA10027.getDesc());
        }

        try {
            String findAll = "SELECT r FROM ResultLogEntry r";
            Query query = entityManager.createQuery(findAll);

            if (startIndex > 0) {
                query.setFirstResult(startIndex);
            }

            if (pageSize > 0) {
                query.setMaxResults(pageSize);
            }

            List results = query.getResultList();
            return LogUtil.traceExit(log, signature, results);
        } catch (javax.persistence.PersistenceException e) {
            LogUtil.traceError(log, signature, e);
            throw new PersistenceException(ErrorCode.MITA50000.getDesc(), e);
        }
    }

    /**
     * Updates the source statistics.
     *
     * @param hostId the host id to update
     * @param statusCode the status code that was received
     * @throws IllegalArgumentException if the argument is null or an empty string
     * @throws ServiceException for any errors encountered
     */
    @TransactionAttribute(TransactionAttributeType.REQUIRES_NEW)
    public void updateSourceStats(String hostId, int statusCode) throws ServiceException {
        String signature = "StatsTrackerDAOBean#updateSourceStats";
        LogUtil.traceEntry(log, signature, new String[]{"hostId", "statusCode"}, new Object[]{hostId, statusCode});

        SourceStats stats = getReliabilityStatistics(hostId);

        if (stats == null) {
            stats = new SourceStats();
            stats.setName(hostId);
        }

        try {
            if (statusCode == HttpStatus.SC_OK) {
                // update the statistics
                stats.setSuccessRequests(stats.getSuccessRequests() + 1);
            } else if (statusCode == HttpStatus.SC_MOVED_PERMANENTLY || statusCode == HttpStatus.SC_MOVED_TEMPORARILY) {
                stats.setPageChangedRequests(stats.getPageChangedRequests() + 1);
            } else if (statusCode == HttpStatus.SC_NOT_FOUND) {
                stats.setPageNotFoundRequests(stats.getPageNotFoundRequests() + 1);
            } else if (statusCode == HttpStatus.SC_INTERNAL_SERVER_ERROR) {
                stats.setServerErrorRequests(stats.getServerErrorRequests() + 1);
            }

            // recalculate reliability
            double success = stats.getSuccessRequests();
            double total = stats.getSuccessRequests() + stats.getPageChangedRequests()
                + stats.getPageNotFoundRequests() + stats.getServerErrorRequests();
            stats.setReliability(success / total);

            setReliabilityStatistics(stats);
            LogUtil.traceExit(log, signature, null);
        } catch (javax.persistence.PersistenceException e) {
            LogUtil.traceError(log, signature, e);
        }
    }

    /**
     * Saves the logged entry.
     *
     * @param resultLogEntry the entry to save.
     * @throws IllegalArgumentException if the argument is null
     * @throws ServiceException If an error occurs while performing the operation
     */
    @TransactionAttribute(TransactionAttributeType.REQUIRED)
    public void saveLoggedEntry(ResultLogEntry resultLogEntry) throws ServiceException {
        String signature = "StatsTrackerDAOBean#saveLoggedEntry";
        LogUtil.traceEntry(log, signature, new String[]{"resultLogEntry"}, new Object[]{resultLogEntry});

        if (resultLogEntry == null) {
            throw new IllegalArgumentException(ErrorCode.MITA10029.getDesc());
        }

        try {
            entityManager.persist(resultLogEntry);
            LogUtil.traceExit(log, signature, null);
        } catch (javax.persistence.PersistenceException e) {
            LogUtil.traceError(log, signature, e);
        }
    }

    /**
     * Updates the source statistics provided.
     *
     * @param stats the statistics to merge.
     * @throws IllegalArgumentException if the argument is null
     * @throws ServiceException for any errors encountered
     */
    @TransactionAttribute(TransactionAttributeType.REQUIRED)
    public void setReliabilityStatistics(SourceStats stats) throws ServiceException {
        String signature = "StatsTrackerDAOBean#saveLoggedEntry";
        LogUtil.traceEntry(log, signature, new String[]{"stats"}, new Object[]{stats});

        if (stats == null) {
            throw new IllegalArgumentException(ErrorCode.MITA10030.getDesc());
        }

        try {
            entityManager.merge(stats);
            log.log(Level.INFO, "Successfully updated stats: " + stats.toJSONString());
            LogUtil.traceExit(log, signature, null);
        } catch (javax.persistence.PersistenceException e) {
            LogUtil.traceError(log, signature, e);
        }
    }

    /**
     * Retrieves reliability statistics for all hosts.
     *
     * @return the current statistics for all hosts, may be empty, but not null
     * @throws ServiceException for any errors encountered
     */
    @TransactionAttribute(TransactionAttributeType.SUPPORTS)
    public List<SourceStats> getAllReliabilityStatistics() throws ServiceException {
        String signature = "StatsTrackerDAOBean#getAllReliabilityStatistics";
        LogUtil.traceEntry(log, signature, null, null);
        try {
            String findAll = "SELECT s FROM SourceStats s";
            List results = entityManager.createQuery(findAll).getResultList();
            return LogUtil.traceExit(log, signature, results);
        } catch (javax.persistence.PersistenceException e) {
            LogUtil.traceError(log, signature, e);
            throw new PersistenceException(ErrorCode.MITA50000.getDesc(), e);
        }
    }

    /**
     * Checks if the container properly initialized the injected fields.
     *
     * @throws ConfigurationException if any injected field is null
     */
    @PostConstruct
    protected void init() {
        if (entityManager == null) {
            throw new ConfigurationException("The entityManager must be configured.");
        }
    }
}