/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.screening.services.impl;

import gov.medicaid.entities.ResultLogEntry;
import gov.medicaid.entities.SourceStats;
import gov.medicaid.screening.dao.StatsTrackerDAO;
import gov.medicaid.screening.services.ConfigurationException;
import gov.medicaid.screening.services.ServiceException;
import gov.medicaid.screening.services.StatsTrackerService;

import java.util.List;

import javax.annotation.PostConstruct;
import javax.ejb.EJB;
import javax.ejb.Remote;
import javax.ejb.Stateless;
import javax.ejb.TransactionAttribute;
import javax.ejb.TransactionAttributeType;
import javax.ejb.TransactionManagement;
import javax.ejb.TransactionManagementType;

/**
 * This is an EJB3 implementation of the <code>StatsTrackerService</code>.
 *
 * <strong>This is a stateless EJB and is thread-safe.</strong>
 *
 * @author argolite, j3_guile
 * @version 1.0
 */
@Stateless
@Remote(StatsTrackerService.class)
@TransactionManagement(TransactionManagementType.CONTAINER)
public class StatsTrackerServiceBean extends BaseService implements StatsTrackerService {

    /**
     * DAO implementation.
     */
    @EJB
    private StatsTrackerDAO statsTrackerDAO;

    /**
     * Default empty constructor.
     */
    public StatsTrackerServiceBean() {
    }

    /**
     * Retrieves the current statistics for the given host.
     *
     * @param hostId the external host to get the statistics for
     * @return the current statistics (may be null)
     * @throws IllegalArgumentException if the argument is null or an empty string
     * @throws ServiceException for any errors encountered
     */
    @TransactionAttribute(TransactionAttributeType.REQUIRED)
    public SourceStats getReliabilityStatistics(String hostId) throws ServiceException {
        String signature = "StatsTrackerServiceBean#getReliabilityStatistics";
        LogUtil.traceEntry(getLog(), signature, new String[]{"hostId"}, new Object[]{hostId});
        try {
            SourceStats results = statsTrackerDAO.getReliabilityStatistics(hostId);
            return LogUtil.traceExit(getLog(), signature, results);
        } catch (IllegalArgumentException e) {
            LogUtil.traceError(getLog(), signature, e);
            throw e;
        } catch (ServiceException e) {
            LogUtil.traceError(getLog(), signature, e);
            throw e;
        }
    }

    /**
     * Retrieves reliability statistics for all hosts.
     *
     * @return the current statistics for all hosts, may be empty, but not null
     * @throws ServiceException for any errors encountered
     */
    @TransactionAttribute(TransactionAttributeType.REQUIRED)
    public List<SourceStats> getAllReliabilityStatistics() throws ServiceException {
        String signature = "StatsTrackerServiceBean#getAllReliabilityStatistics";
        LogUtil.traceEntry(getLog(), signature, null, null);
        try {
            List<SourceStats> results = statsTrackerDAO.getAllReliabilityStatistics();
            return LogUtil.traceExit(getLog(), signature, results);
        } catch (ServiceException e) {
            LogUtil.traceError(getLog(), signature, e);
            throw e;
        }
    }

    /**
     * Retrieves a paginated list of logged entries.
     *
     * @param startIndex the start index
     * @param pageSize the page size
     * @throws IllegalArgumentException if the start index is less than 0, or if page size < 0
     * @return all log entries filtered by the index and page size
     * @throws ServiceException for any errors encountered
     */
    @TransactionAttribute(TransactionAttributeType.REQUIRED)
    public List<ResultLogEntry> getLoggedEntries(int startIndex, int pageSize) throws ServiceException {
        String signature = "StatsTrackerServiceBean#getLoggedEntries";
        LogUtil.traceEntry(getLog(), signature, new String[]{"startIndex", "pageSize"}, new Object[]{startIndex,
            pageSize});
        try {
            List<ResultLogEntry> results = statsTrackerDAO.getLoggedEntries(startIndex, pageSize);
            return LogUtil.traceExit(getLog(), signature, results);
        } catch (IllegalArgumentException e) {
            LogUtil.traceError(getLog(), signature, e);
            throw e;
        } catch (ServiceException e) {
            LogUtil.traceError(getLog(), signature, e);
            throw e;
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
    @TransactionAttribute(TransactionAttributeType.REQUIRED)
    public void updateSourceStats(String hostId, int statusCode) throws ServiceException {
        String signature = "StatsTrackerServiceBean#updateSourceStats";
        LogUtil.traceEntry(getLog(), signature, new String[]{"hostId", "statusCode"}, new Object[]{hostId, statusCode});
        try {
            statsTrackerDAO.updateSourceStats(hostId, statusCode);
            LogUtil.traceExit(getLog(), signature, null);
        } catch (IllegalArgumentException e) {
            LogUtil.traceError(getLog(), signature, e);
            throw e;
        } catch (ServiceException e) {
            LogUtil.traceError(getLog(), signature, e);
            throw e;
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
        String signature = "StatsTrackerServiceBean#saveLoggedEntry";
        LogUtil.traceEntry(getLog(), signature, new String[]{"resultLogEntry"}, new Object[]{resultLogEntry});

        try {
            statsTrackerDAO.saveLoggedEntry(resultLogEntry);
            LogUtil.traceExit(getLog(), signature, null);
        } catch (IllegalArgumentException e) {
            LogUtil.traceError(getLog(), signature, e);
            throw e;
        } catch (ServiceException e) {
            LogUtil.traceError(getLog(), signature, e);
            throw e;
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
        String signature = "StatsTrackerServiceBean#setReliabilityStatistics";
        LogUtil.traceEntry(getLog(), signature, new String[]{"stats"}, new Object[]{stats});

        try {
            statsTrackerDAO.setReliabilityStatistics(stats);
            LogUtil.traceExit(getLog(), signature, null);
        } catch (IllegalArgumentException e) {
            LogUtil.traceError(getLog(), signature, e);
            throw e;
        } catch (ServiceException e) {
            LogUtil.traceError(getLog(), signature, e);
            throw e;
        }
    }

    /**
     * Checks if the container properly initialized the injected fields.
     *
     * @throws ConfigurationException if any injected field is null
     */
    @PostConstruct
    protected void init() {
        super.init();
        if (statsTrackerDAO == null) {
            throw new ConfigurationException("The statsTrackerDAO must be configured.");
        }
    }
}