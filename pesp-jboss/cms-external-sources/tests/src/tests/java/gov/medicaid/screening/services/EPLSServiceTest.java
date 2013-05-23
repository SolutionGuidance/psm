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
 * Functional tests for <code>EPLSService</code>.
 *
 * @author j3_guile
 * @version 1.0
 */
@RunWith(BlockJUnit4ClassRunner.class)
public class EPLSServiceTest extends SOAPInvocationTestCase {

    /**
     * Service end point.
     */
    private String serviceURL;

    /**
     * Default empty constructor.
     */
    public EPLSServiceTest() {
    }

    /**
     * Setup test class.
     * @throws Exception to JUnit
     */
    @Before
    public void setUp() throws Exception {
        serviceURL = getProperty("EPLSServiceEndPoint");
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
    public void testSearch_LastName() throws Exception {
        matchInvoke(serviceURL, "EPLS_testSearch_LastName_req.xml", "EPLS_testSearch_LastName_res.xml");
    }

    /**
     * Tests search functionality. First and last name is provided.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void testSearch_FirstAndLastName() throws Exception {
        matchInvoke(serviceURL, "EPLS_testSearch_FirstAndLastName_req.xml", "EPLS_testSearch_FirstAndLastName_res.xml");
    }

    /**
     * Tests search functionality. First name and state are provided.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void testSearch_FirstNameAndState() throws Exception {
        matchInvoke(serviceURL, "EPLS_testSearch_FirstNameAndState_req.xml",
            "EPLS_testSearch_FirstNameAndState_res.xml");
    }

    /**
     * Tests search functionality. Agency and action date are provided.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void testSearch_ActionDateAndAgency() throws Exception {
        matchInvoke(serviceURL, "EPLS_testSearch_ActionDateAndAgency_req.xml",
            "EPLS_testSearch_ActionDateAndAgency_res.xml");
    }

    /**
     * Tests search functionality. Create date is provided.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void testSearch_CreateDate() throws Exception {
        matchInvoke(serviceURL, "EPLS_testSearch_CreateDate_req.xml", "EPLS_testSearch_CreateDate_res.xml");
    }

    /**
     * Tests search functionality. Modify date is provided.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void testSearch_ModifyDate() throws Exception {
        matchInvoke(serviceURL, "EPLS_testSearch_ModifyDate_req.xml", "EPLS_testSearch_ModifyDate_res.xml");
    }

    /**
     * Tests search functionality. Country is provided.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void testSearch_Country() throws Exception {
        matchInvoke(serviceURL, "EPLS_testSearch_Country_req.xml", "EPLS_testSearch_Country_res.xml");
    }

    /**
     * Tests search functionality. Reciprocal Code is provided.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void testSearch_CTCode() throws Exception {
        matchInvoke(serviceURL, "EPLS_testSearch_CTCode_req.xml", "EPLS_testSearch_CTCode_res.xml");
    }

    /**
     * Tests search functionality. Procurement Code is provided.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void testSearch_CTCode_2() throws Exception {
        matchInvoke(serviceURL, "EPLS_testSearch_CTCode_2_req.xml", "EPLS_testSearch_CTCode_2_res.xml");
    }

    /**
     * Tests search functionality. Non Procurement Code is provided.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void testSearch_CTCode_3() throws Exception {
        matchInvoke(serviceURL, "EPLS_testSearch_CTCode_3_req.xml", "EPLS_testSearch_CTCode_3_res.xml");
    }

    /**
     * Tests search functionality. Exclusion type is provided.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void testSearch_ExclusionType() throws Exception {
        matchInvoke(serviceURL, "EPLS_testSearch_ExclusionType_req.xml", "EPLS_testSearch_ExclusionType_res.xml");
    }

    /**
     * Tests search functionality. Page number and sort column is provided.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void testSearch_PaginatedAndSorted() throws Exception {
        matchInvoke(serviceURL, "EPLS_testSearch_PaginatedAndSorted_req.xml",
            "EPLS_testSearch_PaginatedAndSorted_res.xml");
    }

    /**
     * Tests search functionality. No matches are expected.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void testSearch_nomatch() throws Exception {
        matchInvoke(serviceURL, "EPLS_testSearch_nomatch_req.xml", "EPLS_testSearch_nomatch_res.xml");
    }

    /**
     * Tests search functionality. Validation error is expected.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void testSearch_invalid() throws Exception {
        matchInvoke(serviceURL, "EPLS_testSearch_invalid_req.xml", "EPLS_testSearch_invalid_res.xml");
    }

    /**
     * Tests search functionality. Only entity is expected.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void testSearch_entity() throws Exception {
        matchInvoke(serviceURL, "EPLS_testSearch_entity_req.xml", "EPLS_testSearch_entity_res.xml");
    }
}
