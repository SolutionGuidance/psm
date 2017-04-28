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
 * Functional tests for <code>HospitalLicensingService</code>.
 *
 * @author TCSASSEMBLER
 * @version 1.0
 * @since Organizational Provider Screening External Datasources Services 1
 */
@RunWith(BlockJUnit4ClassRunner.class)
public class HospitalLicensingServiceTest extends SOAPInvocationTestCase {

    /**
     * Service end point.
     */
    private String serviceURL;

    /**
     * Default empty constructor.
     */
    public HospitalLicensingServiceTest() {
    }

    /**
     * Setup test class.
     *
     * @throws Exception to JUnit
     */
    @Before
    public void setUp() throws Exception {
        serviceURL = getProperty("HospitalLicensingServiceEndPoint");
    }

    /**
     * Destroy properties.
     */
    @After
    public void tearDown() {
        serviceURL = null;
    }

    /**
     * Tests HospitalLicensingService#search, invalid criteria.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void test_invalid() throws Exception {
        matchInvoke(serviceURL, "Hospital_testSearch_invalid_req.xml",
            "Hospital_testSearch_invalid_res.xml");
    }
    
    /**
     * Tests HospitalLicensingService#search, county name is '08'.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void test_county() throws Exception {
        matchInvoke(serviceURL, "Hospital_testSearch_county_req.xml",
            "Hospital_testSearch_county_res.xml");
    }
    
    /**
     * Tests HospitalLicensingService#search, city name is 'MINNEAPOLIS'.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void test_city() throws Exception {
        matchInvoke(serviceURL, "Hospital_testSearch_city_req.xml",
            "Hospital_testSearch_city_res.xml");
    }
    
    /**
     * Tests HospitalLicensingService#search, provider name is 'a'.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void test_provider() throws Exception {
        matchInvoke(serviceURL, "Hospital_testSearch_provider_req.xml",
            "Hospital_testSearch_provider_res.xml");
    }
    
    /**
     *  Tests HospitalLicensingService#search, test pagination.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void test_paginated() throws Exception {
        matchInvoke(serviceURL, "Hospital_testSearch_paginated_req.xml",
            "Hospital_testSearch_paginated_res.xml");
    }
}
