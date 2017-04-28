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
 * Functional tests for <code>BusinessLienSystemService</code>.
 *
 * @author j3_guile
 * @version 1.0
 */
@RunWith(BlockJUnit4ClassRunner.class)
public class BusinessLienSystemServiceTest extends SOAPInvocationTestCase {

    /**
     * Service end point.
     */
    private String serviceURL;

    /**
     * Default empty constructor.
     */
    public BusinessLienSystemServiceTest() {
    }

    /**
     * Setup test class.
     *
     * @throws Exception to JUnit
     */
    @Before
    public void setUp() throws Exception {
        serviceURL = getProperty("BusinessLienSystemServiceEndPoint");
    }

    /**
     * Destroy properties.
     */
    @After
    public void tearDown() {
        serviceURL = null;
    }

    /**
     * Tests search by name functionality. Business name is provided.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void testSearchByName() throws Exception {
        matchInvoke(serviceURL, "BLSS_testSearchByName_req.xml", "BLSS_testSearchByName_res.xml");
    }

    /**
     * Tests search by name functionality. No match.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void testSearchByNameNoMatch() throws Exception {
        matchInvoke(serviceURL, "BLSS_testSearchByName_nomatch_req.xml", "BLSS_testSearchByName_nomatch_res.xml");
    }

    /**
     * Tests search by name functionality. Invalid.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void testSearchByNameInvalid() throws Exception {
        matchInvoke(serviceURL, "BLSS_testSearchByName_invalid_req.xml", "BLSS_testSearchByName_invalid_res.xml");
    }

    /**
     * Tests search by name functionality. Paginated and Sorted.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void testSearchByNamePaginatedSorted() throws Exception {
        matchInvoke(serviceURL, "BLSS_testSearchByName_PaginatedAndSorted_req.xml",
            "BLSS_testSearchByName_PaginatedAndSorted_res.xml");
    }

    /**
     * Tests search by file number functionality. File number is provided.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void testSearchByFileNumber() throws Exception {
        matchInvoke(serviceURL, "BLSS_testSearchByFileNumber_req.xml", "BLSS_testSearchByFileNumber_res.xml");
    }

    /**
     * Tests search by file number functionality. Invalid.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void testSearchByFileNumberInvalid() throws Exception {
        matchInvoke(serviceURL, "BLSS_testSearchByFileNumber_invalid_req.xml",
            "BLSS_testSearchByFileNumber_invalid_res.xml");
    }

    /**
     * Tests search by file number functionality. No match.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void testSearchByFileNumberNomatch() throws Exception {
        matchInvoke(serviceURL, "BLSS_testSearchByFileNumber_nomatch_req.xml",
            "BLSS_testSearchByFileNumber_nomatch_res.xml");
    }
}
