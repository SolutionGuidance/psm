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
 * Functional tests for <code>PECOSServiceBean</code>.
 *
 * @author hanshuai
 * @version 1.0
 */
@RunWith(BlockJUnit4ClassRunner.class)
public class PECOSServiceTest extends SOAPInvocationTestCase {

    /**
     * Service end point.
     */
    private String serviceURL;

    /**
     * Default empty constructor.
     */
    public PECOSServiceTest() {
    }

    /**
     * Setup test class.
     * @throws Exception to JUnit
     */
    @Before
    public void setUp() throws Exception {
        serviceURL = getProperty("PECOSServiceEndPoint");
    }

    /**
     * Destroy properties.
     */
    @After
    public void tearDown() {
        serviceURL = null;
    }

    /**
     * Tests getPECOSRecord.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void test_getPECOSRecord() throws Exception {
        matchInvoke(serviceURL, "PECOS_req.xml", "PECOS_res.xml");
    }
}
