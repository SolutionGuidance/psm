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
 * Functional tests for <code>PharmacyLicensingService</code>.
 *
 * @author TCSASSEMBLER
 * @version 1.0
 * @since Organizational Provider Screening External Datasources Services 2
 */
@RunWith(BlockJUnit4ClassRunner.class)
public class PharmacyLicensingServiceTest extends SOAPInvocationTestCase {

    /**
     * Service end point.
     */
    private String serviceURL;

    /**
     * Default empty constructor.
     */
    public PharmacyLicensingServiceTest() {
    }

    /**
     * Setup test class.
     *
     * @throws Exception to JUnit
     */
    @Before
    public void setUp() throws Exception {
        serviceURL = getProperty("PharmacyLicensingServiceEndPoint");
    }

    /**
     * Destroy properties.
     */
    @After
    public void tearDown() {
        serviceURL = null;
    }

    /**
     * Tests PharmacyLicensingService#search, invalid criteria.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void test_invalid() throws Exception {
        matchInvoke(serviceURL, "Pharmacy_testSearch_invalid_req.xml",
            "Pharmacy_testSearch_invalid_res.xml");
    }
    
    /**
     * Tests PharmacyLicensingService#search, by name.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void test_Name() throws Exception {
        matchInvoke(serviceURL, "Pharmacy_testSearch_name_req.xml",
            "Pharmacy_testSearch_name_res.xml");
    }
    
    /**
     * Tests PharmacyLicensingService#search, search by name, sort by location.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void test_Sort() throws Exception {
        matchInvoke(serviceURL, "Pharmacy_testSearch_sort_req.xml",
            "Pharmacy_testSearch_sort_res.xml");
    }
    
    /**
     * Tests PharmacyLicensingService#search, by city and state.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void test_City() throws Exception {
        matchInvoke(serviceURL, "Pharmacy_testSearch_city_req.xml",
            "Pharmacy_testSearch_city_res.xml");
    }
    
    /**
     * Tests PharmacyLicensingService#search, search by zipcode and test pagination.
     *
     * @throws Exception to JUnit
     */
    @Test
    public void test_Zipcode() throws Exception {
        matchInvoke(serviceURL, "Pharmacy_testSearch_zipcode_req.xml",
            "Pharmacy_testSearch_zipcode_res.xml");
    }
}
