/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.screening.services;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.BlockJUnit4ClassRunner;

/**
 * Functional tests for <code>OptometryLicenseService</code>.
 *
 * @author j3_guile
 * @version 1.0
 */
@RunWith(BlockJUnit4ClassRunner.class)
public class OptometryLicenseServiceTest extends SOAPInvocationTestCase {

    /**
     * Service end point.
     */
    private String serviceURL;

    /**
     * Default empty constructor.
     */
    public OptometryLicenseServiceTest() {
    }

    /**
     * Setup test class.
     *
     * @throws Exception to JUnit
     */
    @Before
    public void setUp() throws Exception {
        serviceURL = getProperty("OptometryLicenseServiceEndPoint");
    }

    /**
     * Destroy properties.
     */
    @After
    public void tearDown() {
        serviceURL = null;
    }

    /**
     * Tests search by name functionality. Only last name is provided.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void testSearchByName() throws Exception {
        matchInvoke(serviceURL, "OPT_testSearchByName_req.xml", "OPT_testSearchByName_res.xml");
    }

    /**
     * Tests search by name functionality. Page 2 is requested and is sorted by first name.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void testSearchByName_PaginatedAndSorted() throws Exception {
        matchInvoke(serviceURL, "OPT_testSearchByName_PaginatedAndSorted_req.xml",
            "OPT_testSearchByName_PaginatedAndSorted_res.xml");
    }

    /**
     * Tests search by name functionality. Invalid request should show fault.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void testSearchByName_invalid() throws Exception {
        matchInvoke(serviceURL, "OPT_testSearchByName_invalid_req.xml", "OPT_testSearchByName_invalid_res.xml");
    }

    /**
     * Tests search by license number functionality. Only identifier is provided (1 exact match).
     *
     * @throws Exception to JUnit
     */
    @Test
    public void testSearchByLicenseNumber() throws Exception {
        matchInvoke(serviceURL, "OPT_testSearchByLicenseNumber_req.xml", "OPT_testSearchByLicenseNumber_res.xml");
    }

    /**
     * Tests search by license number functionality. No matches are expected.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void testSearchByLicenseNumber_nomatch() throws Exception {
        matchInvoke(serviceURL, "OPT_testSearchByLicenseNumber_nomatch_req.xml",
            "OPT_testSearchByLicenseNumber_nomatch_res.xml");
    }

    /**
     * Tests search by license number functionality. Fault is expected for invalid criteria.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void testSearchByLicenseNumber_invalid() throws Exception {
        matchInvoke(serviceURL, "OPT_testSearchByLicenseNumber_invalid_req.xml",
            "OPT_testSearchByLicenseNumber_invalid_res.xml");
    }
}
