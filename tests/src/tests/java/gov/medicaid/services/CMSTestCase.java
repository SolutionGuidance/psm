/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.services;

import org.jbpm.test.JBPMHelper;
import org.junit.BeforeClass;

import bitronix.tm.resource.jdbc.PoolingDataSource;

/**
 * Base test case.
 *
 * @author TCSASSEMBLER
 * @version 1.0
 */
public abstract class CMSTestCase {

    /**
     * Pool size.
     */
    private static final int POOL_SIZE = 5;

    /**
     * Empty constructor.
     */
    protected CMSTestCase() {
    }

    /**
     * Setup the data source for the transaction manager.
     */
    public static void setupDataSource() {
        PoolingDataSource pds = new PoolingDataSource();
        pds.setUniqueName("jdbc/jbpm-ds");
        pds.setClassName("bitronix.tm.resource.jdbc.lrc.LrcXADataSource");
        pds.setMaxPoolSize(POOL_SIZE);
        pds.setAllowLocalTransactions(true);
        pds.getDriverProperties().put("user", "mita3dev");
        pds.getDriverProperties().put("password", "mita3dev");
        pds.getDriverProperties().put("url", "jdbc:oracle:thin:@SERVER01:1521:orcl");
        pds.getDriverProperties().put("driverClassName", "oracle.jdbc.driver.OracleDriver");
        pds.init();
    }

    /**
     * Startup the unit test JBPM services.
     *
     * @throws Exception for any errors encountered
     */
    @BeforeClass
    public static void setUpClass() throws Exception {
        setupDataSource();
        JBPMHelper.startTaskService();
    }
}
