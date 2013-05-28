/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.screening.services.impl;

import gov.medicaid.entities.DeathMasterRecord;
import gov.medicaid.screening.dao.DeathMasterDAO;
import gov.medicaid.screening.dao.impl.Util;
import gov.medicaid.screening.services.ConfigurationException;
import gov.medicaid.screening.services.ParsingException;
import gov.medicaid.screening.services.SchedulerService;
import gov.medicaid.screening.services.ServiceException;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Collection;
import java.util.Date;

import javax.annotation.PostConstruct;
import javax.annotation.Resource;
import javax.ejb.EJB;
import javax.ejb.EJBException;
import javax.ejb.Local;
import javax.ejb.Stateless;
import javax.ejb.Timeout;
import javax.ejb.Timer;
import javax.ejb.TimerService;

import org.apache.commons.io.FileUtils;

/**
 * This is an EJB that is used to schedule to be run periodically (by default hourly) to load death master
 * files in configured input directory, successfully loaded files are moved to configured archive directory,
 * adding timestamp prefix file name.
 * 
 * @author zsudraco, hanshuai
 * @version 1.0
 */
@Stateless
@Local(SchedulerService.class)
public class DeathMasterSchedulerBean extends BaseService implements SchedulerService {
    /**
     * Represent the name of this class
     */
    private static final String CLASS_NAME = DeathMasterSchedulerBean.class.getName();

    /**
     * This is the death master DAO.
     */
    @EJB
    private DeathMasterDAO deathMasterDAO;

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
     * Represent the timer service in EJB.
     */
    @Resource
    private TimerService timerService;

    /**
     * Represent the intervalDuration used to schedule the timer.
     */
    @Resource(name = "mita/config/intervalDuration")
    private Long intervalDuration;

    /**
     * Represent the date format.
     */
    private SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd_HH-mm-ss_");

    /**
     * Empty constructor, it does nothing.
     */
    public DeathMasterSchedulerBean() {
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
        if (deathMasterDAO == null) {
            throw new ConfigurationException("The deathMasterDAO must be not be null.");
        }
        if (intervalDuration <= 0) {
            throw new ConfigurationException("The intervalDuration should be positive.");
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
     * Create a timer.
     * 
     * @throws ServiceException
     *             if any error occurs.
     */
    @Override
    public void scheduleTimer() throws ServiceException {
        String signature = CLASS_NAME + "#scheduleTimer()";
        LogUtil.traceEntry(getLog(), signature, null, null);
        try {
            timerService.createTimer(0, intervalDuration, null);
            LogUtil.traceExit(getLog(), signature, null);
        } catch (IllegalArgumentException e) {
            ServiceException ne = new ServiceException("failed to create the timer.", e);
            LogUtil.traceError(getLog(), signature, ne);
            throw ne;
        } catch (IllegalStateException e) {
            ServiceException ne = new ServiceException("failed to create the timer.", e);
            LogUtil.traceError(getLog(), signature, ne);
            throw ne;
        } catch (EJBException e) {
            ServiceException ne = new ServiceException("failed to create the timer.", e);
            LogUtil.traceError(getLog(), signature, ne);
            throw ne;
        }
    }

    /**
     * Runs the task to load death master files in configured input directory, successfully loaded files are
     * moved to configured archive directory, adding timestamp prefix file name.
     * 
     * @param timer
     *            the timerService timer.
     * @throws ParsingException
     *             - if there is error parsing death master file
     * @throws ServiceException
     *             - If an error occurs while performing the operation
     */
    @Timeout
    public void run(Timer timer) throws ParsingException, ServiceException {
        String signature = CLASS_NAME + "#run(Timer timer)";
        LogUtil.traceEntry(getLog(), signature, new String[] { "timer" }, new Object[] { timer.toString() });
        try {
            Collection<File> files = FileUtils.listFiles(new File(inputDirectory), null, false);
            Calendar calendar = Calendar.getInstance();
            calendar.add(Calendar.MINUTE, -10);
            for (File file : files) {
                Calendar fileTime = Calendar.getInstance();
                fileTime.setTimeInMillis(file.lastModified());
                if (calendar.before(fileTime)) {
                    continue;
                }
                processRecords(file);

                String now = format.format(new Date());
                File destFile = new File(archiveDirectory + File.separator + now + file.getName());
                try {
                    FileUtils.moveFile(file, destFile);
                } catch (IOException e) {
                    throw new ServiceException("error occurs when processing the file", e);
                }
            }
            LogUtil.traceExit(getLog(), signature, null);
        } catch (IllegalArgumentException e) {
            LogUtil.traceError(getLog(), signature, e);
            throw e;
        } catch (ServiceException e) {
            LogUtil.traceError(getLog(), signature, e);
            throw e;
        }
    }

    /**
     * Get the records from a file.
     * 
     * @param file
     *            the file.
     * @throws ParsingException
     *             if any error occurs when parsing the file.
     */
    private void processRecords(File file) throws ParsingException {
        try {
            for (String line : FileUtils.readLines(file)) {
                if (line.length() < 81) {
                    continue;
                }
                if (line.charAt(0) == 'D') {
                    deathMasterDAO.deleteDeathMasterRecord(line.substring(1, 10));
                } else {
                    DeathMasterRecord record = new DeathMasterRecord();
                    record.setSsn(line.substring(1, 10));
                    record.setLastName(line.substring(10, 30));
                    record.setNameSuffix(line.substring(30, 34));
                    record.setFirstName(line.substring(34, 49));
                    record.setMiddleName(line.substring(49, 64));
                    record.setVpCode(line.substring(64, 65));

                    record.setDateOfDeath(getDate(line.substring(65, 73)));
                    record.setDateOfBirth(getDate(line.substring(73, 81)));
                    deathMasterDAO.saveDeathMasterRecord(record);
                }
            }
        } catch (Throwable e) {
            throw new ParsingException("failed to parse the record", e);
        }
    }

    /**
     * Get a date from a string.
     * 
     * @param str
     *            the string.
     * @return the date.
     */
    private Date getDate(String str) {
        int month = Integer.parseInt(str.substring(0, 2));
        int day = Integer.parseInt(str.substring(2, 4));
        int year = Integer.parseInt(str.substring(4, 8));
        Calendar calendar = Calendar.getInstance();
        calendar.set(Calendar.MONTH, month - 1);
        calendar.set(Calendar.DAY_OF_MONTH, day + 1);
        calendar.set(Calendar.YEAR, year);
        return calendar.getTime();
    }
}
