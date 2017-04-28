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
 * Functional tests for <code>NETStudyServiceBean</code>.
 *
 * @author hanshuai
 * @version 1.0
 */
@RunWith(BlockJUnit4ClassRunner.class)
public class NETStudyServiceTest extends SOAPInvocationTestCase {

    /**
     * Service end point.
     */
    private String serviceURL;

    /**
     * Default empty constructor.
     */
    public NETStudyServiceTest() {
    }

    /**
     * Setup test class.
     * @throws Exception to JUnit
     */
    @Before
    public void setUp() throws Exception {
        serviceURL = getProperty("NETStudyServiceEndPoint");
    }

    /**
     * Destroy properties.
     */
    @After
    public void tearDown() {
        serviceURL = null;
    }

    /**
     * Tests getNETStudyResponse.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void test_getNETStudyResponse() throws Exception {
        matchInvoke(serviceURL, "NETStudy_req.xml", "NETStudy_res.xml");
    }
    
    /**
     * Tests getNETStudyResponse.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void test_getNETStudyResponse2() throws Exception {
        matchInvoke(serviceURL, "NETStudy2_req.xml", "NETStudy2_res.xml");
    }
}
