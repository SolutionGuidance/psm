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
 * Functional tests for <code>SocialWorkLicenseService</code>.
 *
 * @author j3_guile
 * @version 1.0
 */
@RunWith(BlockJUnit4ClassRunner.class)
public class SocialWorkLicenseServiceTest extends SOAPInvocationTestCase {

    /**
     * Service end point.
     */
    private String serviceURL;

    /**
     * Default empty constructor.
     */
    public SocialWorkLicenseServiceTest() {
    }

    /**
     * Setup test class.
     *
     * @throws Exception to JUnit
     */
    @Before
    public void setUp() throws Exception {
        serviceURL = getProperty("SocialWorkLicenseServiceEndPoint");
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
        matchInvoke(serviceURL, "SOC_testSearchByName_req.xml", "SOC_testSearchByName_res.xml");
    }

    /**
     * Tests search by name functionality. Full name is provided.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void testSearchByName_full() throws Exception {
        matchInvoke(serviceURL, "SOC_testSearchByName_full_req.xml", "SOC_testSearchByName_full_res.xml");
    }

    /**
     * Tests search by name functionality. Name and city is provided.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void testSearchByName_city() throws Exception {
        matchInvoke(serviceURL, "SOC_testSearchByName_city_req.xml", "SOC_testSearchByName_city_res.xml");
    }

    /**
     * Tests search by name functionality. Name and level is provided.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void testSearchByName_level() throws Exception {
        matchInvoke(serviceURL, "SOC_testSearchByName_level_req.xml", "SOC_testSearchByName_level_res.xml");
    }

    /**
     * Tests search by name functionality. Name and county is provided.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void testSearchByName_county() throws Exception {
        matchInvoke(serviceURL, "SOC_testSearchByName_county_req.xml", "SOC_testSearchByName_county_res.xml");
    }

    /**
     * Tests search by name functionality. No match.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void testSearchByNameNoMatch() throws Exception {
        matchInvoke(serviceURL, "SOC_testSearchByName_nomatch_req.xml", "SOC_testSearchByName_nomatch_res.xml");
    }

    /**
     * Tests search by name functionality. Invalid.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void testSearchByNameInvalid() throws Exception {
        matchInvoke(serviceURL, "SOC_testSearchByName_invalid_req.xml", "SOC_testSearchByName_invalid_res.xml");
    }

    /**
     * Tests search by name functionality. Paginated and Sorted.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void testSearchByNamePaginatedAndSorted() throws Exception {
        matchInvoke(serviceURL, "SOC_testSearchByName_PaginatedAndSorted_req.xml",
            "SOC_testSearchByName_PaginatedAndSorted_res.xml");
    }

    /**
     * Tests search by license number functionality. Only license number is provided.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void testSearchByLicenseNumber() throws Exception {
        matchInvoke(serviceURL, "SOC_testSearchByLicenseNumber_req.xml", "SOC_testSearchByLicenseNumber_res.xml");
    }

    /**
     * Tests search by license number functionality. No match.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void testSearchByLicenseNumberNoMatch() throws Exception {
        matchInvoke(serviceURL, "SOC_testSearchByLicenseNumber_nomatch_req.xml",
            "SOC_testSearchByLicenseNumber_nomatch_res.xml");
    }

    /**
     * Tests search by license number functionality. Invalid.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void testSearchByLicenseNumberInvalid() throws Exception {
        matchInvoke(serviceURL, "SOC_testSearchByLicenseNumber_invalid_req.xml",
            "SOC_testSearchByLicenseNumber_invalid_res.xml");
    }
}
