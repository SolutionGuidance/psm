/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.screening.services;

import gov.medicaid.entities.MedicaidCertifiedProviderSearchCriteria;
import gov.medicaid.entities.ResultLogEntry;
import gov.medicaid.entities.SourceStats;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;
import java.util.Properties;

import javax.naming.InitialContext;

import org.apache.http.HttpStatus;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.BlockJUnit4ClassRunner;

/**
 * Functional tests for <code>StatsTrackerService</code>.
 *
 * @author j3_guile
 * @version 1.0
 */
@RunWith(BlockJUnit4ClassRunner.class)
public class StatsTrackerServiceTest extends SOAPInvocationTestCase {

    /**
     * The service to be tested as a remote EJB.
     */
    private StatsTrackerService service;

    /**
     * Default empty constructor.
     */
    public StatsTrackerServiceTest() {
    }

    /**
     * Setup test class.
     *
     * @throws Exception to JUnit
     */
    @Before
    public void setUp() throws Exception {
        Properties props = new Properties();
        props.setProperty("java.naming.provider.url", getProperty("java.naming.provider.url"));
        props.setProperty("java.naming.factory.url.pkgs", getProperty("java.naming.factory.url.pkgs"));
        props.setProperty("java.naming.factory.initial", getProperty("java.naming.factory.initial"));

        InitialContext ctx = new InitialContext(props);
        service = (StatsTrackerService) ctx.lookup(getProperty("StatsTrackerServiceJNDI"));
        Class.forName("oracle.jdbc.driver.OracleDriver");
        clearStatsAndLogs();
    }

    /**
     * Clears the tables used by this test.
     *
     * @throws Exception to JUnit
     */
    private void clearStatsAndLogs() throws Exception {
        Connection conn = null;
        Statement stmt = null;
        try {
            conn = DriverManager.getConnection(getProperty("jdbc.url"), getProperty("jdbc.user"),
                getProperty("jdbc.pass"));
            stmt = conn.createStatement();
            stmt.execute("DELETE FROM SOURCE_STATS");
            stmt.execute("DELETE FROM MEDICAID_CERT_PROV_CRIT");
            stmt.execute("DELETE FROM RESULT_LOG_ENTRY");
            stmt.execute("DELETE FROM SEARCH_CRITERIA");
            conn.commit();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            if (stmt != null) {
                stmt.close();
            }

            if (conn != null) {
                conn.close();
            }
        }
    }

    /**
     * Destroy properties.
     *
     * @throws Exception to JUnit
     */
    @After
    public void tearDown() throws Exception {
        clearStatsAndLogs();
        service = null;
    }

    /**
     * Tests managing statistics via the remote service layer.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void testManageStats() throws Exception {
        SourceStats stats = service.getReliabilityStatistics("test");
        assertNull("stats should be null if not found", stats);

        // create
        service.updateSourceStats("test", HttpStatus.SC_OK);

        stats = service.getReliabilityStatistics("test");
        assertNotNull("stats should be created", stats);

        // reset
        stats.setReliability(0);
        stats.setPageChangedRequests(0);
        stats.setPageNotFoundRequests(0);
        stats.setServerErrorRequests(0);
        stats.setSuccessRequests(0);

        service.setReliabilityStatistics(stats);
        SourceStats updated = service.getReliabilityStatistics("test");

        assertEquals("stats should be updated", 0.0, updated.getReliability());
        assertEquals("stats should be updated", 0, updated.getPageChangedRequests());
        assertEquals("stats should be updated", 0, updated.getPageNotFoundRequests());
        assertEquals("stats should be updated", 0, updated.getServerErrorRequests());
        assertEquals("stats should be updated", 0, updated.getSuccessRequests());

        // add response
        service.updateSourceStats("test", HttpStatus.SC_OK);
        updated = service.getReliabilityStatistics("test");
        assertEquals("stats should be updated", 1.0, updated.getReliability());
        assertEquals("stats should be updated", 0, updated.getPageChangedRequests());
        assertEquals("stats should be updated", 0, updated.getPageNotFoundRequests());
        assertEquals("stats should be updated", 0, updated.getServerErrorRequests());
        assertEquals("stats should be updated", 1, updated.getSuccessRequests());

        // add response
        service.updateSourceStats("test", HttpStatus.SC_INTERNAL_SERVER_ERROR);
        updated = service.getReliabilityStatistics("test");
        assertEquals("stats should be updated", 0.5, updated.getReliability());
        assertEquals("stats should be updated", 0, updated.getPageChangedRequests());
        assertEquals("stats should be updated", 0, updated.getPageNotFoundRequests());
        assertEquals("stats should be updated", 1, updated.getServerErrorRequests());
        assertEquals("stats should be updated", 1, updated.getSuccessRequests());

        // add response
        service.updateSourceStats("test", HttpStatus.SC_MOVED_TEMPORARILY);
        service.updateSourceStats("test", HttpStatus.SC_MOVED_PERMANENTLY);
        updated = service.getReliabilityStatistics("test");
        assertEquals("stats should be updated", 0.25, updated.getReliability());
        assertEquals("stats should be updated", 2, updated.getPageChangedRequests());
        assertEquals("stats should be updated", 0, updated.getPageNotFoundRequests());
        assertEquals("stats should be updated", 1, updated.getServerErrorRequests());
        assertEquals("stats should be updated", 1, updated.getSuccessRequests());

        // add response
        service.updateSourceStats("test", HttpStatus.SC_NOT_FOUND);
        updated = service.getReliabilityStatistics("test");
        assertEquals("stats should be updated", 0.20, updated.getReliability());
        assertEquals("stats should be updated", 2, updated.getPageChangedRequests());
        assertEquals("stats should be updated", 1, updated.getPageNotFoundRequests());
        assertEquals("stats should be updated", 1, updated.getServerErrorRequests());
        assertEquals("stats should be updated", 1, updated.getSuccessRequests());

        List<SourceStats> allReliabilityStatistics = service.getAllReliabilityStatistics();
        assertFalse("There should be at least one", allReliabilityStatistics.isEmpty());

        boolean found = false;
        for (SourceStats sourceStats : allReliabilityStatistics) {
            if (sourceStats.getName().equals("test")) {
                found = true;
                break;
            }
        }
        assertTrue("The test data should be included", found);
    }

    /**
     * Tests managing log entries via the service layer.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void testManageLogEntries() throws Exception {
        List<ResultLogEntry> all = service.getLoggedEntries(0, 0);
        assertTrue("No entries expected", all.isEmpty());

        // create
        ResultLogEntry entry = new ResultLogEntry();
        entry.setCriteria(new MedicaidCertifiedProviderSearchCriteria());
        service.saveLoggedEntry(entry);

        all = service.getLoggedEntries(0, 0);
        assertEquals("1 entry expected", 1, all.size());
        assertEquals("same type expected", entry.getCriteria().getClass(), all.get(0).getCriteria().getClass());

        // create another
        service.saveLoggedEntry(entry);
        all = service.getLoggedEntries(0, 0);
        assertEquals("2 entries expected", 2, all.size());

        // test pagination
        service.saveLoggedEntry(entry);
        service.saveLoggedEntry(entry);

        all = service.getLoggedEntries(1, 1);
        assertEquals("1 entry expected", 1, all.size());
        all = service.getLoggedEntries(1, 2);
        assertEquals("2 entries expected", 2, all.size());
        all = service.getLoggedEntries(2, 1);
        assertEquals("1 entry expected", 1, all.size());
    }

}
