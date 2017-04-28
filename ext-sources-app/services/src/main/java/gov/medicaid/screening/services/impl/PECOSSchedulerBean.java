/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.screening.services.impl;

import gov.medicaid.entities.PECOSRecord;
import gov.medicaid.screening.dao.PECOSDAO;
import gov.medicaid.screening.dao.impl.Util;
import gov.medicaid.screening.services.ConfigurationException;
import gov.medicaid.screening.services.ParsingException;
import gov.medicaid.screening.services.SchedulerService;
import gov.medicaid.screening.services.ServiceException;

import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collection;
import java.util.Date;
import java.util.List;

import javax.annotation.PostConstruct;
import javax.annotation.Resource;
import javax.ejb.EJB;
import javax.ejb.Local;
import javax.ejb.Schedule;
import javax.ejb.Stateless;

import org.apache.commons.io.FileUtils;

import au.com.bytecode.opencsv.CSVReader;

/**
 * This is an EJB that is used to schedule to be run periodically (by default hourly) to load PECOS files in configured
 * input directory, successfully loaded files are moved to configured archive directory, adding timestamp prefix file
 * name.
 * 
 * @author zsudraco, hanshuai
 * @version 1.0
 */
@Stateless
@Local(SchedulerService.class)
public class PECOSSchedulerBean extends BaseService implements SchedulerService {
    /**
     * Represent the name of this class
     */
    private static final String CLASS_NAME = PECOSSchedulerBean.class.getName();

    /**
     * This is PECOS DAO.
     */
    @EJB
    private PECOSDAO pecosDAO;

    /**
     * This is the input directory to load files.
     */
    @Resource(name = "mita/config/inputDirectory")
    private String inputDirectory;

    /**
     * This is archive directory to put loaded files.
     */
    @Resource(name = "mita/config/archiveDirectory")
    private String archiveDirectory;

    /**
     * Represent the date format.
     */
    private SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd_HH-mm-ss_");

    /**
     * Empty constructor, it does nothing.
     */
    public PECOSSchedulerBean() {
    }

    /**
     * This method checks that all required injection fields are in fact provided.
     * 
     * @throws ConfigurationException
     *             If there are required injection fields that are not properly injected
     */
    @PostConstruct
    protected void init() {
        super.init();
        if (pecosDAO == null) {
            throw new ConfigurationException("The pecosDAO must be not be null.");
        }
        checkFile(inputDirectory, "inputDirectory");
        checkFile(archiveDirectory, "archiveDirectory");
    }

    /**
     * Check the directory name is not null nor empty. And this directory exists.
     * 
     * @param dirname
     *            the directory name.
     * @param name
     *            the variable name.
     * @throws ConfigurationException
     *             if directory name is null or empty. or this directory not exists.
     */
    private void checkFile(String dirname, String name) {
        if (Util.isBlank(dirname)) {
            throw new ConfigurationException("The " + name + " must be not be null nor empty.");
        }
        File file = new File(dirname);
        if (!file.exists()) {
            throw new ConfigurationException("The " + name + " does not exist.");
        }
        if (!file.isDirectory()) {
            throw new ConfigurationException("The " + name + " should be a directory.");
        }
    }

    /**
     * Runs the task to load PECOS files in configured input directory, successfully loaded files are moved to
     * configured archive directory, adding timestamp prefix file name.
     * 
     * @param timer
     *            the timerService timer.
     * @throws ParsingException
     *             - if there is error parsing PECOS file
     * @throws ServiceException
     *             - If an error occurs while performing the operation
     */
    @Schedule(dayOfWeek = "Sat", hour = "0")
    public void run() {
        String signature = CLASS_NAME + "#run()";
        LogUtil.traceEntry(getLog(), signature, new String[] {}, new Object[] {});
        try {
            Collection<File> files = FileUtils.listFiles(new File(inputDirectory), null, false);
            Calendar calendar = Calendar.getInstance();
            calendar.setTime(new Date());
            calendar.add(Calendar.MINUTE, -10);
            for (File file : files) {
                Calendar fileTime = Calendar.getInstance();
                fileTime.setTimeInMillis(file.lastModified());
                if (calendar.before(fileTime)) {
                    continue;
                }
                try {
                    CSVReader reader = null;
                    List<PECOSRecord> records = null;
                    try {
                        reader = new CSVReader(new FileReader(file));
                        records = new ArrayList<PECOSRecord>();
                        while (true) {
                            String[] line = reader.readNext();
                            if (line == null) {
                                break;
                            }
                            if (line.length < 3) {
                                continue;
                            }
                            PECOSRecord record = new PECOSRecord();
                            record.setNpi(line[0]);
                            record.setLastName(line[1]);
                            record.setFirstName(line[2]);
                            records.add(record);
                        }
                    } finally {
                        reader.close();
                    }
                    pecosDAO.clearPECOSRecords();
                    pecosDAO.addPECOSRecords(records);
                    String now = format.format(new Date());
                    File destFile = new File(archiveDirectory + File.separator + now + file.getName());
                    FileUtils.moveFile(file, destFile);
                } catch (IOException e) {
                    throw new ServiceException("error occurs when processing the file", e);
                }
            }
            LogUtil.traceExit(getLog(), signature, null);
        } catch (IllegalArgumentException e) {
            LogUtil.traceError(getLog(), signature, e);
        } catch (ServiceException e) {
            LogUtil.traceError(getLog(), signature, e);
        }
    }
}
