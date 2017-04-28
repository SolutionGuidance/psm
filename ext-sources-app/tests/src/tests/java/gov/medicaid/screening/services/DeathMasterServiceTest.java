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
 * Functional tests for <code>DeathMasterServiceBean</code>.
 *
 * @author hanshuai
 * @version 1.0
 */
@RunWith(BlockJUnit4ClassRunner.class)
public class DeathMasterServiceTest extends SOAPInvocationTestCase {

    /**
     * Service end point.
     */
    private String serviceURL;

    /**
     * Default empty constructor.
     */
    public DeathMasterServiceTest() {
    }

    /**
     * Setup test class.
     * @throws Exception to JUnit
     */
    @Before
    public void setUp() throws Exception {
        serviceURL = getProperty("DeathMasterServiceEndPoint");
    }

    /**
     * Destroy properties.
     */
    @After
    public void tearDown() {
        serviceURL = null;
    }

    /**
     * Tests getDeathMasterRecord.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void test_getDeathMasterRecord() throws Exception {
        matchInvoke(serviceURL, "DeathMaster_req.xml", "DeathMaster_res.xml");
    }
}
