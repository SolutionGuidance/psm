/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.screening.dao;

import gov.medicaid.entities.ResultLogEntry;
import gov.medicaid.entities.SourceStats;
import gov.medicaid.screening.services.ServiceException;

import java.util.List;

/**
 * This represents the persistence API to manage statistics and log entries.
 *
 * @author argolite, j3_guile
 * @version 1.0
 */
public interface StatsTrackerDAO {

    /**
     * Retrieves the current statistics for the given host.
     *
     * @param hostId the external host to get the statistics for
     * @return the current statistics (may be null)
     * @throws IllegalArgumentException if the argument is null or an empty string
     * @throws ServiceException for any errors encountered
     */
    SourceStats getReliabilityStatistics(String hostId) throws ServiceException;

    /**
     * Retrieves reliability statistics for all hosts.
     *
     * @return the current statistics for all hosts, may be empty, but not null
     * @throws ServiceException for any errors encountered
     */
    List<SourceStats> getAllReliabilityStatistics() throws ServiceException;

    /**
     * Retrieves a paginated list of logged entries.
     *
     * @param startIndex the start index
     * @param pageSize the page size
     * @throws IllegalArgumentException if the start index is less than 0, or if page size < 0
     * @return all log entries filtered by the index and page size
     * @throws ServiceException for any errors encountered
     */
    List<ResultLogEntry> getLoggedEntries(int startIndex, int pageSize) throws ServiceException;

    /**
     * Updates the source statistics provided.
     *
     * @param stats the statistics to merge.
     * @throws IllegalArgumentException if the argument is null
     * @throws ServiceException for any errors encountered
     */
    void setReliabilityStatistics(SourceStats stats) throws ServiceException;

    /**
     * Updates the source statistics.
     *
     * @param hostId the host id to update
     * @param statusCode the status code that was received
     * @throws IllegalArgumentException if the argument is null or an empty string
     * @throws ServiceException for any errors encountered
     */
    void updateSourceStats(String hostId, int statusCode) throws ServiceException;

    /**
     * Saves the logged entry.
     *
     * @param resultLogEntry the entry to save.
     * @throws IllegalArgumentException if the argument is null
     * @throws ServiceException If an error occurs while performing the operation
     */
    void saveLoggedEntry(ResultLogEntry resultLogEntry) throws ServiceException;
}
