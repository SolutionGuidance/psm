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
 * Functional tests for <code>MedicalPracticeLicenseService</code>.
 *
 * @author j3_guile
 * @version 1.0
 */
@RunWith(BlockJUnit4ClassRunner.class)
public class MedicalPracticeLicenseServiceTest extends SOAPInvocationTestCase {

    /**
     * Service end point.
     */
    private String serviceURL;

    /**
     * Default empty constructor.
     */
    public MedicalPracticeLicenseServiceTest() {
    }

    /**
     * Setup test class.
     *
     * @throws Exception to JUnit
     */
    @Before
    public void setUp() throws Exception {
        serviceURL = getProperty("MedicalPracticeLicenseServiceEndPoint");
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
    public void testSearchByName() throws Exception {
        matchInvoke(serviceURL, "MED_testSearchByName_req.xml", "MED_testSearchByName_res.xml");
    }

    /**
     * Tests search by name functionality. first name and last name is provided.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void testSearchByName_FirstName() throws Exception {
        matchInvoke(serviceURL, "MED_testSearchByName_FirstName_req.xml", "MED_testSearchByName_FirstName_res.xml");
    }

    /**
     * Tests search by name functionality. city and last name is provided.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void testSearchByName_City() throws Exception {
        matchInvoke(serviceURL, "MED_testSearchByName_City_req.xml", "MED_testSearchByName_City_res.xml");
    }

    /**
     * Tests search by name functionality. license number is provided.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void testSearchByName_LicenseNumber() throws Exception {
        matchInvoke(serviceURL, "MED_testSearchByName_LicenseNumber_req.xml",
            "MED_testSearchByName_LicenseNumber_res.xml");
    }

    /**
     * Tests search by name functionality. Page 2 is requested and is sorted by first name.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void testSearchByName_PaginatedAndSorted() throws Exception {
        matchInvoke(serviceURL, "MED_testSearchByName_PaginatedAndSorted_req.xml",
            "MED_testSearchByName_PaginatedAndSorted_res.xml");
    }

    /**
     * Tests search by name functionality. Invalid request should show fault.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void testSearchByName_invalid() throws Exception {
        matchInvoke(serviceURL, "MED_testSearchByName_invalid_req.xml", "MED_testSearchByName_invalid_res.xml");
    }

    /**
     * Tests search by name functionality. Only specialty code is provided.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void testSearchBySpecialty() throws Exception {
        matchInvoke(serviceURL, "MED_testSearchBySpecialty_req.xml", "MED_testSearchBySpecialty_res.xml");
    }

    /**
     * Tests search by name functionality. Only specialty description is provided.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void testSearchBySpecialty_Desc() throws Exception {
        matchInvoke(serviceURL, "MED_testSearchBySpecialty_Desc_req.xml", "MED_testSearchBySpecialty_Desc_res.xml");
    }

    /**
     * Tests search by name functionality. specialty code and city is provided.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void testSearchBySpecialty_City() throws Exception {
        matchInvoke(serviceURL, "MED_testSearchBySpecialty_City_req.xml", "MED_testSearchBySpecialty_City_res.xml");
    }

    /**
     * Tests search by name functionality. specialty code and zip code is provided.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void testSearchBySpecialty_Zip() throws Exception {
        matchInvoke(serviceURL, "MED_testSearchBySpecialty_Zip_req.xml", "MED_testSearchBySpecialty_Zip_res.xml");
    }

    /**
     * Tests search by name functionality. Page 3 is requested and is sorted by first name..
     *
     * @throws Exception to JUnit
     */
    @Test
    public void testSearchBySpecialty_PaginatedAndSorted() throws Exception {
        matchInvoke(serviceURL, "MED_testSearchBySpecialty_PaginatedAndSorted_req.xml",
            "MED_testSearchBySpecialty_PaginatedAndSorted_res.xml");
    }

    /**
     * Tests search by name functionality. no criteria is provided.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void testSearchBySpecialty_invalid() throws Exception {
        matchInvoke(serviceURL, "MED_testSearchBySpecialty_invalid_req.xml",
            "MED_testSearchBySpecialty_invalid_res.xml");
    }

    /**
     * Tests search by name functionality. no matches are expected.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void testSearchBySpecialty_nomatch() throws Exception {
        matchInvoke(serviceURL, "MED_testSearchBySpecialty_nomatch.xml", "MED_testSearchBySpecialty_nomatch_res.xml");
    }
}
