/*
 * Copyright (C) 2013 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.screening.services;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.BlockJUnit4ClassRunner;

/**
 * Functional tests for <code>NPINumberLookupService</code>.
 *
 * @author flexme
 * @version 1.0
 */
@RunWith(BlockJUnit4ClassRunner.class)
public class NPINumberLookupServiceTest extends SOAPInvocationTestCase {
    /**
     * Service end point.
     */
    private String serviceURL;

    /**
     * Empty constructor.
     */
    public NPINumberLookupServiceTest() {
    }

    /**
     * Setup test class.
     * @throws Exception to JUnit
     */
    @Before
    public void setUp() throws Exception {
        serviceURL = getProperty("NPINumberLookupServiceEndPoint");
    }

    /**
     * Destroy properties.
     */
    @After
    public void tearDown() {
        serviceURL = null;
    }

    /**
     * Tests get by NPI number functionality. The NPI number is valid.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void testGetNPINumber() throws Exception {
        matchInvoke(serviceURL, "NPI_testGetNPINumber_req.xml", "NPI_testGetNPINumber_res.xml");
    }

    /**
     * Tests get by NPI number functionality. The NPI number is invalid.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void testGetNPINumberEmptyResult() throws Exception {
        matchInvoke(serviceURL, "NPI_testGetNPINumber_empty_req.xml", "NPI_testGetNPINumber_empty_res.xml");
    }
}
