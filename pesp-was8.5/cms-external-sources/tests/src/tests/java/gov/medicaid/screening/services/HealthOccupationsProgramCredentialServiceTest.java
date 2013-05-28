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
 * Functional tests for <code>HealthOccupationsProgramCredentialService</code>.
 *
 * @author j3_guile
 * @version 1.0
 */
@RunWith(BlockJUnit4ClassRunner.class)
public class HealthOccupationsProgramCredentialServiceTest extends SOAPInvocationTestCase {

    /**
     * Service end point.
     */
    private String serviceURL;

    /**
     * Default empty constructor.
     */
    public HealthOccupationsProgramCredentialServiceTest() {
    }

    /**
     * Setup test class.
     *
     * @throws Exception to JUnit
     */
    @Before
    public void setUp() throws Exception {
        serviceURL = getProperty("HealthOccupationsProgramCredentialServiceEndPoint");
    }

    /**
     * Destroy properties.
     */
    @After
    public void tearDown() {
        serviceURL = null;
    }

    /**
     * Tests search functionality. Last name is provided.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void testSearchByLastName() throws Exception {
        matchInvoke(serviceURL, "HOPC_testSearchByLastName_req.xml", "HOPC_testSearchByLastName_res.xml");
    }

    /**
     * Tests search functionality. First name is provided.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void testSearchByFirstName() throws Exception {
        matchInvoke(serviceURL, "HOPC_testSearchByFirstName_req.xml", "HOPC_testSearchByFirstName_res.xml");
    }

    /**
     * Tests search functionality. City is provided.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void testSearchByCity() throws Exception {
        matchInvoke(serviceURL, "HOPC_testSearchByCity_req.xml", "HOPC_testSearchByCity_res.xml");
    }

    /**
     * Tests search functionality. County is provided.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void testSearchByCounty() throws Exception {
        matchInvoke(serviceURL, "HOPC_testSearchByCounty_req.xml", "HOPC_testSearchByCounty_res.xml");
    }

    /**
     * Tests search functionality. State is provided.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void testSearchByState() throws Exception {
        matchInvoke(serviceURL, "HOPC_testSearchByState_req.xml", "HOPC_testSearchByState_res.xml");
    }

    /**
     * Tests search functionality. Occupation type is provided.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void testSearchByOccupationType() throws Exception {
        matchInvoke(serviceURL, "HOPC_testSearchByOccupationType_req.xml", "HOPC_testSearchByOccupationType_res.xml");
    }

    /**
     * Tests search functionality. Credential status is provided.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void testSearchByCredentialStatus() throws Exception {
        matchInvoke(serviceURL, "HOPC_testSearchByCredentialStatus_req.xml",
            "HOPC_testSearchByCredentialStatus_res.xml");
    }

    /**
     * Tests search functionality. Discipline is provided.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void testSearchByDiscipline() throws Exception {
        matchInvoke(serviceURL, "HOPC_testSearchByDiscipline_req.xml", "HOPC_testSearchByDiscipline_res.xml");
    }

    /**
     * Tests search functionality. Credential number is provided.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void testSearchByCredentialNumber() throws Exception {
        matchInvoke(serviceURL, "HOPC_testSearchByCredentialNumber_req.xml",
            "HOPC_testSearchByCredentialNumber_res.xml");
    }

    /**
     * Tests search functionality. No match.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void testSearchNoMatch() throws Exception {
        matchInvoke(serviceURL, "HOPC_testSearch_nomatch_req.xml", "HOPC_testSearch_nomatch_res.xml");
    }

    /**
     * Tests search functionality. No match.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void testSearchPaginatedAndSorted() throws Exception {
        matchInvoke(serviceURL, "HOPC_testSearch_PaginatedAndSorted_req.xml",
            "HOPC_testSearch_PaginatedAndSorted_res.xml");
    }
}
