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
 * Functional tests for <code>PharmacyLicenseService</code>.
 *
 * @author j3_guile
 * @version 1.0
 */
@RunWith(BlockJUnit4ClassRunner.class)
public class PharmacyLicenseServiceTest extends SOAPInvocationTestCase {

    /**
     * Service end point.
     */
    private String serviceURL;

    /**
     * Default empty constructor.
     */
    public PharmacyLicenseServiceTest() {
    }

    /**
     * Setup test class.
     *
     * @throws Exception to JUnit
     */
    @Before
    public void setUp() throws Exception {
        serviceURL = getProperty("PharmacyLicenseServiceEndPoint");
    }

    /**
     * Destroy properties.
     */
    @After
    public void tearDown() {
        serviceURL = null;
    }

    /**
     * Tests search by name functionality. Invalid request should show fault.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void testSearchByName_invalid() throws Exception {
        matchInvoke(serviceURL, "PHRM_testSearchByName_invalid_req.xml", "PHRM_testSearchByName_invalid_res.xml");
    }

    /**
     * Tests search by name functionality. Only last name is provided.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void testSearchByName_lastName_used() throws Exception {
        matchInvoke(serviceURL, "PHRM_testSearchByName_lastName_req.xml", "PHRM_testSearchByName_lastName_res.xml");
    }

    /**
     * Tests search by name functionality. Only identifier is provided (1 exact match).
     *
     * @throws Exception to JUnit
     */
    @Test
    public void testSearchByName_identifier_used() throws Exception {
        matchInvoke(serviceURL, "PHRM_testSearchByName_identifier_req.xml", "PHRM_testSearchByName_identifier_res.xml");
    }

    /**
     * Tests search by last name functionality. Page 2 is requested and is sorted by license number.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void testSearchByName_PaginatedAndSorted() throws Exception {
        matchInvoke(serviceURL, "PHRM_testSearchByName_PaginatedAndSorted_req.xml",
            "PHRM_testSearchByName_PaginatedAndSorted_res.xml");
    }

    /**
     * Tests search by name functionality. No matches are expected.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void testSearchByName_nomatch() throws Exception {
        matchInvoke(serviceURL, "PHRM_testSearchByName_nomatch_req.xml", "PHRM_testSearchByName_nomatch_res.xml");
    }

}
