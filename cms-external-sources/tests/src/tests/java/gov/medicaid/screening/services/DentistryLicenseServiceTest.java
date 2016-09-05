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
 * Functional tests for <code>DentistryLicenseService</code>.
 *
 * @author j3_guile
 * @version 1.0
 */
@RunWith(BlockJUnit4ClassRunner.class)
public class DentistryLicenseServiceTest extends SOAPInvocationTestCase {

    /**
     * Service end point.
     */
    private String serviceURL;

    /**
     * Default empty constructor.
     */
    public DentistryLicenseServiceTest() {
    }

    /**
     * Setup test class.
     *
     * @throws Exception to JUnit
     */
    @Before
    public void setUp() throws Exception {
        serviceURL = getProperty("DentistryLicenseServiceEndPoint");
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
        matchInvoke(serviceURL, "DENT_testSearchByLastName_req.xml", "DENT_testSearchByLastName_res.xml");
    }

    /**
     * Tests search functionality. Only middle name is provided.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void testSearchByMiddleName() throws Exception {
        matchInvoke(serviceURL, "DENT_testSearchByMiddleName_req.xml", "DENT_testSearchByMiddleName_res.xml");
    }

    /**
     * Tests search functionality. Only first name is provided.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void testSearchByFirstName() throws Exception {
        matchInvoke(serviceURL, "DENT_testSearchByFirstName_req.xml", "DENT_testSearchByFirstName_res.xml");
    }

    /**
     * Tests search functionality. Only license number is provided.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void testSearchByLicenseNumber() throws Exception {
        matchInvoke(serviceURL, "DENT_testSearchByLicenseNumber_req.xml", "DENT_testSearchByLicenseNumber_res.xml");
    }

    /**
     * Tests search functionality. License number and type are provided.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void testSearchByLicenseNumberAndType() throws Exception {
        matchInvoke(serviceURL, "DENT_testSearchByLicenseNumberAndType_req.xml",
            "DENT_testSearchByLicenseNumberAndType_res.xml");
    }

    /**
     * Tests search functionality. Only city is provided.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void testSearchByCity() throws Exception {
        matchInvoke(serviceURL, "DENT_testSearchByCity_req.xml", "DENT_testSearchByCity_res.xml");
    }

    /**
     * Tests search functionality. Invalid.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void testSearchInvalid() throws Exception {
        matchInvoke(serviceURL, "DENT_testSearch_invalid_req.xml", "DENT_testSearch_invalid_res.xml");
    }

    /**
     * Tests search functionality. No match.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void testSearchNoMatch() throws Exception {
        matchInvoke(serviceURL, "DENT_testSearch_nomatch_req.xml", "DENT_testSearch_nomatch_res.xml");
    }

    /**
     * Tests search functionality. Paginated.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void testSearchPaginated() throws Exception {
        matchInvoke(serviceURL, "DENT_testSearch_paginated_req.xml", "DENT_testSearch_paginated_res.xml");
    }

    /**
     * Tests search functionality. Sorted.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void testSearchSorted() throws Exception {
        matchInvoke(serviceURL, "DENT_testSearch_sorted_req.xml", "DENT_testSearch_sorted_res.xml");
    }
}
