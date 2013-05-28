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
 * Functional tests for <code>OIGService</code>.
 *
 * @author j3_guile
 * @version 1.0
 */
@RunWith(BlockJUnit4ClassRunner.class)
public class OIGServiceTest extends SOAPInvocationTestCase {

    /**
     * Service end point.
     */
    private String serviceURL;

    /**
     * Default empty constructor.
     */
    public OIGServiceTest() {
    }

    /**
     * Setup test class.
     * @throws Exception to JUnit
     */
    @Before
    public void setUp() throws Exception {
        serviceURL = getProperty("OIGServiceEndPoint");
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
        matchInvoke(serviceURL, "OIG_testSearchByLastName_req.xml", "OIG_testSearchByLastName_res.xml");
    }

    /**
     * Tests search functionality. Only first name is provided.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void testSearchByFirstName() throws Exception {
        matchInvoke(serviceURL, "OIG_testSearchByFirstName_req.xml", "OIG_testSearchByFirstName_res.xml");
    }

    /**
     * Tests search functionality. First and last name are provided.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void testSearchByFirstLastName() throws Exception {
        matchInvoke(serviceURL, "OIG_testSearchByFirstLastName_req.xml", "OIG_testSearchByFirstLastName_res.xml");
    }

    /**
     * Tests search functionality. Only business name is provided.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void testSearchByBusinessName() throws Exception {
        matchInvoke(serviceURL, "OIG_testSearchByBusinessName_req.xml", "OIG_testSearchByBusinessName_res.xml");
    }

    /**
     * Tests search functionality. Invalid.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void testSearchInvalid() throws Exception {
        matchInvoke(serviceURL, "OIG_testSearch_invalid_req.xml", "OIG_testSearch_invalid_res.xml");
    }

    /**
     * Tests verify SSN functionality.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void testVerifySSN() throws Exception {
        matchInvoke(serviceURL, "OIG_testVerifySSN_req.xml", "OIG_testVerifySSN_res.xml");
    }

    /**
     * Tests verify SSN functionality. Invalid.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void testVerifySSNInvalid() throws Exception {
        matchInvoke(serviceURL, "OIG_testVerifySSN_invalid_req.xml", "OIG_testVerifySSN_invalid_res.xml");
    }

    /**
     * Tests get exclusion types functionality.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void testGetExclusionTypes() throws Exception {
        matchInvoke(serviceURL, "OIG_testGetExclusionTypes_req.xml", "OIG_testGetExclusionTypes_res.xml");
    }
}
