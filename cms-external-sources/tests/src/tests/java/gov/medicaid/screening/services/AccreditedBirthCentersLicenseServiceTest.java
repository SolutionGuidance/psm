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
 * Functional tests for <code>AccreditedBirthCentersLicenseService</code>.
 *
 * @author j3_guile
 * @version 1.0
 */
@RunWith(BlockJUnit4ClassRunner.class)
public class AccreditedBirthCentersLicenseServiceTest extends SOAPInvocationTestCase {

    /**
     * Service end point.
     */
    private String serviceURL;

    /**
     * Default empty constructor.
     */
    public AccreditedBirthCentersLicenseServiceTest() {
    }

    /**
     * Setup test class.
     *
     * @throws Exception to JUnit
     */
    @Before
    public void setUp() throws Exception {
        serviceURL = getProperty("AccreditedBirthCentersLicenseServiceEndPoint");
    }

    /**
     * Destroy properties.
     */
    @After
    public void tearDown() {
        serviceURL = null;
    }

    /**
     * Tests get accredited birth centers functionality.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void testGetAccreditedBirthCenters() throws Exception {
        matchInvoke(serviceURL, "ABC_testGetAccreditedBirthCenters_req.xml",
            "ABC_testGetAccreditedBirthCenters_res.xml");
    }
}
