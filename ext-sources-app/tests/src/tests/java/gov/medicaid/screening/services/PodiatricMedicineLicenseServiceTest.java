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
 * Functional tests for <code>PodiatricMedicineLicenseService</code>.
 *
 * @author j3_guile
 * @version 1.0
 */
@RunWith(BlockJUnit4ClassRunner.class)
public class PodiatricMedicineLicenseServiceTest extends SOAPInvocationTestCase {

    /**
     * Service end point.
     */
    private String serviceURL;

    /**
     * Default empty constructor.
     */
    public PodiatricMedicineLicenseServiceTest() {
    }

    /**
     * Setup test class.
     *
     * @throws Exception to JUnit
     */
    @Before
    public void setUp() throws Exception {
        serviceURL = getProperty("PodiatricMedicineLicenseServiceEndPoint");
    }

    /**
     * Destroy properties.
     */
    @After
    public void tearDown() {
        serviceURL = null;
    }

    /**
     * Tests search by name functionality. Only last name is provided.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void testSearchByLastName() throws Exception {
        matchInvoke(serviceURL, "PML_testSearchByLastName_req.xml", "PML_testSearchByLastName_res.xml");
    }

    /**
     * Tests search by name functionality. No match.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void testSearchByLastNameNoMatch() throws Exception {
        matchInvoke(serviceURL, "PML_testSearchByLastName_nomatch_req.xml", "PML_testSearchByLastName_nomatch_res.xml");
    }

    /**
     * Tests search by name functionality. Invalid.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void testSearchByLastNameInvalid() throws Exception {
        matchInvoke(serviceURL, "PML_testSearchByLastName_invalid_req.xml", "PML_testSearchByLastName_invalid_res.xml");
    }

    /**
     * Tests search by name functionality. Paginated and Sorted.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void testSearchByLastNamePaginatedAndSorted() throws Exception {
        matchInvoke(serviceURL, "PML_testSearchByLastName_PaginatedAndSorted_req.xml",
            "PML_testSearchByLastName_PaginatedAndSorted_res.xml");
    }

    /**
     * Tests search by license number functionality. Only license number is provided.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void testSearchByLicenseNumber() throws Exception {
        matchInvoke(serviceURL, "PML_testSearchByLicenseNumber_req.xml", "PML_testSearchByLicenseNumber_res.xml");
    }

    /**
     * Tests search by license number functionality. No match.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void testSearchByLicenseNumberNoMatch() throws Exception {
        matchInvoke(serviceURL, "PML_testSearchByLicenseNumber_nomatch_req.xml",
            "PML_testSearchByLicenseNumber_nomatch_res.xml");
    }

    /**
     * Tests search by license number functionality. Invalid.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void testSearchByLicenseNumberInvalid() throws Exception {
        matchInvoke(serviceURL, "PML_testSearchByLicenseNumber_invalid_req.xml",
            "PML_testSearchByLicenseNumber_invalid_res.xml");
    }
}
