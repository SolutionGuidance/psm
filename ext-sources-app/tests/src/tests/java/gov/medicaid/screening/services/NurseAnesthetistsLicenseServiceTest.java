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
 * Functional tests for <code>NurseAnesthetistsLicenseService</code>.
 *
 * @author j3_guile
 * @version 1.0
 */
@RunWith(BlockJUnit4ClassRunner.class)
public class NurseAnesthetistsLicenseServiceTest extends SOAPInvocationTestCase {

    /**
     * Service end point.
     */
    private String serviceURL;

    /**
     * Default empty constructor.
     */
    public NurseAnesthetistsLicenseServiceTest() {
    }

    /**
     * Setup test class.
     *
     * @throws Exception to JUnit
     */
    @Before
    public void setUp() throws Exception {
        serviceURL = getProperty("NurseAnesthetistsLicenseServiceEndPoint");
    }

    /**
     * Destroy properties.
     */
    @After
    public void tearDown() {
        serviceURL = null;
    }

    /**
     * Tests search functionality. A matching SSN and AANA number is provided.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void testSearch_match() throws Exception {
        matchInvoke(serviceURL, "AANA_testSearch_match_req.xml", "AANA_testSearch_match_res.xml");
    }

    /**
     * Tests search functionality. A matching SSN and AANA number is provided, recertification is true.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void testSearch_recertify() throws Exception {
        matchInvoke(serviceURL, "AANA_testSearch_recertify_req.xml", "AANA_testSearch_recertify_res.xml");
    }

    /**
     * Tests search functionality. A non-matching SSN and AANA number is provided.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void testSearch_nomatch() throws Exception {
        matchInvoke(serviceURL, "AANA_testSearch_nomatch_req.xml", "AANA_testSearch_nomatch_res.xml");
    }

    /**
     * Tests search functionality. Incomplete parameters are provided.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void testSearch_invalid() throws Exception {
        matchInvoke(serviceURL, "AANA_testSearch_invalid_req.xml", "AANA_testSearch_invalid_res.xml");
    }
}