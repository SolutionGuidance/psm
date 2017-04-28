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
 * Functional tests for <code>BBHTLicenseService</code>.
 *
 * @author j3_guile
 * @version 1.0
 */
@RunWith(BlockJUnit4ClassRunner.class)
public class BBHTLicenseServiceTest extends SOAPInvocationTestCase {

    /**
     * Service end point.
     */
    private String serviceURL;

    /**
     * Default empty constructor.
     */
    public BBHTLicenseServiceTest() {
    }

    /**
     * Setup test class.
     * @throws Exception to JUnit
     */
    @Before
    public void setUp() throws Exception {
        serviceURL = getProperty("BBHTLicenseServiceEndPoint");
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
    public void testSearchByLastName() throws Exception {
        matchInvoke(serviceURL, "BBHT_testSearchByLastName_req.xml", "BBHT_testSearchByLastName_res.xml");
    }

    /**
     * Tests search by name functionality. Only first name is provided.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void testSearchByNameByFirstName() throws Exception {
        matchInvoke(serviceURL, "BBHT_testSearchByFirstName_req.xml", "BBHT_testSearchByFirstName_res.xml");
    }

    /**
     * Tests search by name functionality. First and last name are provided.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void testSearchByNameByFirstLastName() throws Exception {
        matchInvoke(serviceURL, "BBHT_testSearchByFirstLastName_req.xml", "BBHT_testSearchByFirstLastName_res.xml");
    }

    /**
     * Tests search by name functionality. Only license number is provided.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void testSearchByLicenseNumber() throws Exception {
        matchInvoke(serviceURL, "BBHT_testSearchByLicenseNumber_req.xml", "BBHT_testSearchByLicenseNumber_res.xml");
    }

    /**
     * Tests search by name functionality. License number is provided. No license type. Invalid.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void testSearchByLicenseNumberWihtoutType() throws Exception {
        matchInvoke(serviceURL, "BBHT_testSearchByLicenseNumberWithoutType_req.xml",
            "BBHT_testSearchByLicenseNumberWithoutType_res.xml");
    }

    /**
     * Tests search by name functionality. Invalid request.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void testSearchInvalidRequest() throws Exception {
        matchInvoke(serviceURL, "BBHT_testSearch_invalid_req.xml", "BBHT_testSearch_invalid_res.xml");
    }

    /**
     * Tests search by name functionality. Paginated.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void testSearchPaginated() throws Exception {
        matchInvoke(serviceURL, "BBHT_testSearch_paginated_req.xml", "BBHT_testSearch_paginated_res.xml");
    }

    /**
     * Tests verify license functionality. Active result.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void testVerifyLicenseActive() throws Exception {
        matchInvoke(serviceURL, "BBHT_testVerifyLicense_active_req.xml", "BBHT_testVerifyLicense_active_res.xml");
    }


    /**
     * Tests verify license functionality. Inactive result.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void testVerifyLicenseInactive() throws Exception {
        matchInvoke(serviceURL, "BBHT_testVerifyLicense_inactive_req.xml", "BBHT_testVerifyLicense_inactive_res.xml");
    }
}
