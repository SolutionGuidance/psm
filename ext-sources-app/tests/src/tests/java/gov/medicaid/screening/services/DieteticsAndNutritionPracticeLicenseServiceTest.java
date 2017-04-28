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
 * Functional tests for <code>DieteticsAndNutritionPracticeLicenseService</code>.
 *
 * @author j3_guile
 * @version 1.0
 */
@RunWith(BlockJUnit4ClassRunner.class)
public class DieteticsAndNutritionPracticeLicenseServiceTest extends SOAPInvocationTestCase {

    /**
     * Service end point.
     */
    private String serviceURL;

    /**
     * Default empty constructor.
     */
    public DieteticsAndNutritionPracticeLicenseServiceTest() {
    }

    /**
     * Setup test class.
     *
     * @throws Exception to JUnit
     */
    @Before
    public void setUp() throws Exception {
        serviceURL = getProperty("DieteticsAndNutritionPracticeLicenseServiceEndPoint");
    }

    /**
     * Destroy properties.
     */
    @After
    public void tearDown() {
        serviceURL = null;
    }

    /**
     * Tests search functionality. Only last name is provided.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void testSearchByLastName() throws Exception {
        matchInvoke(serviceURL, "DNP_testSearchByLastName_req.xml", "DNP_testSearchByLastName_res.xml");
    }

    /**
     * Tests search functionality. Only license number is provided.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void testSearchByLicenseNumber() throws Exception {
        matchInvoke(serviceURL, "DNP_testSearchByLicenseNumber_req.xml", "DNP_testSearchByLicenseNumber_res.xml");
    }

    /**
     * Tests search functionality. Invalid request.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void testSearchInvalidRequest() throws Exception {
        matchInvoke(serviceURL, "DNP_testSearch_invalid_req.xml", "DNP_testSearch_invalid_res.xml");
    }

    /**
     * Tests search functionality. Paginated request.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void testSearchPaginatedRequest() throws Exception {
        matchInvoke(serviceURL, "DNP_testSearch_paginated_req.xml", "DNP_testSearch_paginated_res.xml");
    }

    /**
     * Tests search functionality. Sorted request.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void testSearchSortedRequest() throws Exception {
        matchInvoke(serviceURL, "DNP_testSearch_sorted_req.xml", "DNP_testSearch_sorted_res.xml");
    }
}
