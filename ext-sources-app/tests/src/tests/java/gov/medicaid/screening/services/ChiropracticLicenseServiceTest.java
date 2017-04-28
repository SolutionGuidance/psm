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
 * Functional tests for <code>ChiropracticLicenseService</code>.
 *
 * @author j3_guile
 * @version 1.0
 */
@RunWith(BlockJUnit4ClassRunner.class)
public class ChiropracticLicenseServiceTest extends SOAPInvocationTestCase {

    /**
     * Service end point.
     */
    private String serviceURL;

    /**
     * Default empty constructor.
     */
    public ChiropracticLicenseServiceTest() {
    }

    /**
     * Setup test class.
     * @throws Exception to JUnit
     */
    @Before
    public void setUp() throws Exception {
        serviceURL = getProperty("ChiropracticLicenseServiceEndPoint");
    }

    /**
     * Destroy properties.
     */
    @After
    public void tearDown() {
        serviceURL = null;
    }

    /**
     * Tests search by last name functionality. Only last name is provided.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void testSearchByLastName() throws Exception {
        matchInvoke(serviceURL, "CHI_testSearchByLastName_req.xml", "CHI_testSearchByLastName_res.xml");
    }

    /**
     * Tests search by last name functionality. Page 2 is requested and is sorted by first name.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void testSearchByLastName_PaginatedAndSorted() throws Exception {
        matchInvoke(serviceURL, "CHI_testSearchByLastName_PaginatedAndSorted_req.xml",
            "CHI_testSearchByLastName_PaginatedAndSorted_res.xml");
    }

    /**
     * Tests search by last name functionality. Invalid request should show fault.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void testSearchByLastName_invalid() throws Exception {
        matchInvoke(serviceURL, "CHI_testSearchByLastName_invalid_req.xml", "CHI_testSearchByLastName_invalid_res.xml");
    }

    /**
     * Tests search by last name functionality. Shows the result format when no matches are expected.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void testSearchByLastName_nomatch() throws Exception {
        matchInvoke(serviceURL, "CHI_testSearchByLastName_nomatch_req.xml", "CHI_testSearchByLastName_nomatch_res.xml");
    }

    /**
     * Tests search by city functionality. Only city is provided.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void testSearchByCity() throws Exception {
        matchInvoke(serviceURL, "CHI_testSearchByCity_req.xml", "CHI_testSearchByCity_res.xml");
    }

    /**
     * Tests search by city functionality. Page 2 is requested and is sorted by first name.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void testSearchByCity_PaginatedAndSorted() throws Exception {
        matchInvoke(serviceURL, "CHI_testSearchByCity_PaginatedAndSorted_req.xml",
            "CHI_testSearchByCity_PaginatedAndSorted_res.xml");
    }

    /**
     * Tests search by city functionality. Invalid request should show fault.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void testSearchByCity_invalid() throws Exception {
        matchInvoke(serviceURL, "CHI_testSearchByCity_invalid_req.xml", "CHI_testSearchByCity_invalid_res.xml");
    }

    /**
     * Tests search by city functionality. Shows the result format when no matches are expected.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void testSearchByCity_nomatch() throws Exception {
        matchInvoke(serviceURL, "CHI_testSearchByCity_nomatch_req.xml", "CHI_testSearchByCity_nomatch_res.xml");
    }

    /**
     * Tests search by zip functionality. Only zip is provided.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void testSearchByZip() throws Exception {
        matchInvoke(serviceURL, "CHI_testSearchByZip_req.xml", "CHI_testSearchByZip_res.xml");
    }

    /**
     * Tests search by zip functionality. Page 2 is requested and is sorted by first name.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void testSearchByZip_PaginatedAndSorted() throws Exception {
        matchInvoke(serviceURL, "CHI_testSearchByZip_PaginatedAndSorted_req.xml",
            "CHI_testSearchByZip_PaginatedAndSorted_res.xml");
    }

    /**
     * Tests search by zip functionality. Invalid request should show fault.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void testSearchByZip_invalid() throws Exception {
        matchInvoke(serviceURL, "CHI_testSearchByZip_invalid_req.xml", "CHI_testSearchByZip_invalid_res.xml");
    }

    /**
     * Tests search by zip functionality. Shows the result format when no matches are expected.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void testSearchByZip_nomatch() throws Exception {
        matchInvoke(serviceURL, "CHI_testSearchByZip_nomatch_req.xml", "CHI_testSearchByZip_nomatch_res.xml");
    }

    /**
     * Tests search by soundex functionality. Only last name is provided.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void testSearchBySoundex() throws Exception {
        matchInvoke(serviceURL, "CHI_testSearchBySoundex_req.xml", "CHI_testSearchBySoundex_res.xml");
    }

    /**
     * Tests search by soundex functionality. Page 2 is requested and is sorted by first name.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void testSearchBySoundex_PaginatedAndSorted() throws Exception {
        matchInvoke(serviceURL, "CHI_testSearchBySoundex_PaginatedAndSorted_req.xml",
            "CHI_testSearchBySoundex_PaginatedAndSorted_res.xml");
    }

    /**
     * Tests search by soundex functionality. Invalid request should show fault.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void testSearchBySoundex_invalid() throws Exception {
        matchInvoke(serviceURL, "CHI_testSearchBySoundex_invalid_req.xml", "CHI_testSearchBySoundex_invalid_res.xml");
    }

    /**
     * Tests search by soundex functionality. Shows the result format when no matches are expected.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void testSearchBySoundex_nomatch() throws Exception {
        matchInvoke(serviceURL, "CHI_testSearchBySoundex_nomatch_req.xml", "CHI_testSearchBySoundex_nomatch_res.xml");
    }


    /**
     * Tests get denied list.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void testGetDeniedList() throws Exception {
        matchInvoke(serviceURL, "CHI_testGetDeniedList_req.xml", "CHI_testGetDeniedList_res.xml");
    }
}
