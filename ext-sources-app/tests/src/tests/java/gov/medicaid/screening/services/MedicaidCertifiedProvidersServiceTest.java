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
 * Functional tests for <code>MedicaidCertifiedProvidersService</code>.
 *
 * @author j3_guile
 * @version 1.0
 */
@RunWith(BlockJUnit4ClassRunner.class)
public class MedicaidCertifiedProvidersServiceTest extends SOAPInvocationTestCase {

    /**
     * Service end point.
     */
    private String serviceURL;

    /**
     * Default empty constructor.
     */
    public MedicaidCertifiedProvidersServiceTest() {
    }

    /**
     * Setup test class.
     *
     * @throws Exception to JUnit
     */
    @Before
    public void setUp() throws Exception {
        serviceURL = getProperty("MedicaidCertifiedProvidersServiceEndPoint");
    }

    /**
     * Destroy properties.
     */
    @After
    public void tearDown() {
        serviceURL = null;
    }

    /**
     * Tests search functionality. County criteria is used.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void testSearch_county() throws Exception {
        matchInvoke(serviceURL, "MCP_testSearch_county_req.xml", "MCP_testSearch_county_res.xml");
    }

    /**
     * Tests search functionality. City criteria is used.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void testSearch_city() throws Exception {
        matchInvoke(serviceURL, "MCP_testSearch_city_req.xml", "MCP_testSearch_city_res.xml");
    }

    /**
     * Tests search functionality. Provider Name criteria is used.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void testSearch_provider() throws Exception {
        matchInvoke(serviceURL, "MCP_testSearch_provider_req.xml", "MCP_testSearch_provider_res.xml");
    }

    /**
     * Tests search functionality. Paginated and sorted.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void testSearch_PaginatedAndSorted() throws Exception {
        matchInvoke(serviceURL, "MCP_testSearch_PaginatedAndSorted_req.xml",
            "MCP_testSearch_PaginatedAndSorted_res.xml");
    }

    /**
     * Tests search functionality. No match.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void testSearch_nomatch() throws Exception {
        matchInvoke(serviceURL, "MCP_testSearch_nomatch_req.xml", "MCP_testSearch_nomatch_res.xml");
    }

    /**
     * Tests search functionality. Invalid type.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void testSearch_invalid_type_1() throws Exception {
        matchInvoke(serviceURL, "MCP_testSearch_invalid_type1_req.xml", "MCP_testSearch_invalid_type1_res.xml");
    }

    /**
     * Tests search functionality. Invalid type.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void testSearch_invalid_type_2() throws Exception {
        matchInvoke(serviceURL, "MCP_testSearch_invalid_type2_req.xml", "MCP_testSearch_invalid_type2_res.xml");
    }

    /**
     * Tests search functionality. Invalid request.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void testSearch_invalid_request() throws Exception {
        matchInvoke(serviceURL, "MCP_testSearch_invalid_request_req.xml", "MCP_testSearch_invalid_request_res.xml");
    }

    /**
     * Tests search functionality. Invalid criteria.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void testSearch_invalid_criteria() throws Exception {
        matchInvoke(serviceURL, "MCP_testSearch_invalid_criteria_req.xml", "MCP_testSearch_invalid_criteria_res.xml");
    }

    /**
     * Tests search functionality. Invalid City value.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void testSearch_invalid_city_value() throws Exception {
        matchInvoke(serviceURL, "MCP_testSearch_invalid_city_value_req.xml",
            "MCP_testSearch_invalid_city_value_res.xml");
    }

    /**
     * Tests search functionality. Invalid County value.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void testSearch_invalid_county_value() throws Exception {
        matchInvoke(serviceURL, "MCP_testSearch_invalid_county_value_req.xml",
            "MCP_testSearch_invalid_county_value_res.xml");
    }

    /**
     * Tests search functionality. Invalid County value.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void testSearch_invalid_provider_value() throws Exception {
        matchInvoke(serviceURL, "MCP_testSearch_invalid_provider_value_req.xml",
            "MCP_testSearch_invalid_provider_value_res.xml");
    }
}
