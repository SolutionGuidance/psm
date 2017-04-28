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
 * Functional tests for <code>PublicHealthNursingOrganizationLicensingService</code>.
 *
 * @author TCSASSEMBLER
 * @version 1.0
 * @since Organizational Provider Screening External Datasources Services 1
 */
@RunWith(BlockJUnit4ClassRunner.class)
public class PublicHealthNursingOrganizationLicensingServiceTest extends SOAPInvocationTestCase {

    /**
     * Service end point.
     */
    private String serviceURL;

    /**
     * Default empty constructor.
     */
    public PublicHealthNursingOrganizationLicensingServiceTest() {
    }

    /**
     * Setup test class.
     *
     * @throws Exception to JUnit
     */
    @Before
    public void setUp() throws Exception {
        serviceURL = getProperty("PublicHealthNursingOrganizationLicensingServiceEndPoint");
    }

    /**
     * Destroy properties.
     */
    @After
    public void tearDown() {
        serviceURL = null;
    }

    /**
     * Tests PublicHealthNursingOrganizationLicensingService#search, invalid criteria.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void test_invalid() throws Exception {
        matchInvoke(serviceURL, "PHNO_testSearch_invalid_req.xml",
            "PHNO_testSearch_invalid_res.xml");
    }
    
    /**
     * Tests PublicHealthNursingOrganizationLicensingService#search, county name is '08'.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void test_county() throws Exception {
        matchInvoke(serviceURL, "PHNO_testSearch_county_req.xml",
            "PHNO_testSearch_county_res.xml");
    }
    
    /**
     * Tests PublicHealthNursingOrganizationLicensingService#search, city name is 'MINNEAPOLIS'.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void test_city() throws Exception {
        matchInvoke(serviceURL, "PHNO_testSearch_city_req.xml",
            "PHNO_testSearch_city_res.xml");
    }
    
    /**
     * Tests PublicHealthNursingOrganizationLicensingService#search, provider name is 'a'.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void test_provider() throws Exception {
        matchInvoke(serviceURL, "PHNO_testSearch_provider_req.xml",
            "PHNO_testSearch_provider_res.xml");
    }
    
    /**
     *  Tests PublicHealthNursingOrganizationLicensingService#search, test pagination.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void test_paginated() throws Exception {
        matchInvoke(serviceURL, "PHNO_testSearch_paginated_req.xml",
            "PHNO_testSearch_paginated_res.xml");
    }
}
