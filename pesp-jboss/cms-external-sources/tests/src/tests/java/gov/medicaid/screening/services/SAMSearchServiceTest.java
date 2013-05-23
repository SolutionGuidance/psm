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
 * Functional tests for <code>SAMSearchService</code>.
 *
 * @author flexme
 * @version 1.0
 */
@RunWith(BlockJUnit4ClassRunner.class)
public class SAMSearchServiceTest extends SOAPInvocationTestCase {
    /**
     * Service end point.
     */
    private String serviceURL;

    /**
     * Empty constructor.
     */
    public SAMSearchServiceTest() {
    }

    /**
     * Setup test class.
     * @throws Exception to JUnit
     */
    @Before
    public void setUp() throws Exception {
        serviceURL = getProperty("SAMSearchServiceEndPoint");
    }

    /**
     * Destroy properties.
     */
    @After
    public void tearDown() {
        serviceURL = null;
    }

    /**
     * Tests searching by name (first name, middle name and last name).
     *
     * @throws Exception to JUnit
     */
    @Test
    public void testSearchByName() throws Exception {
        matchInvoke(serviceURL, "SAM_doSearch_byName_req.xml", "SAM_doSearch_byName_res.xml");
    }

    /**
     * Tests searching by partial name.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void testSearchByPartialName() throws Exception {
        matchInvoke(serviceURL, "SAM_doSearch_byPartialName_req.xml", "SAM_doSearch_byPartialName_res.xml");
    }

    /**
     * Tests the searching criteria is invalid.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void testSearchCriteriaInvalid() throws Exception {
        matchInvoke(serviceURL, "SAM_doSearch_invalid_req.xml", "SAM_doSearch_invalid_res.xml");
    }
}
