/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.services;

import java.util.Date;

import javax.jws.WebService;

import gov.medicaid.entities.ScreeningSchedule;

/**
 * This represents the service API to perform screenings.
 *
 * <p>
 * <b>Thread Safety</b> Implementations should be effectively thread-safe.
 * </p>
 *
 * @author argolite, TCSASSEMBLER
 * @version 1.0
 */
@WebService
public interface ScreeningService {

    /**
     * This method performs the screening.
     *
     * @param userId - the user ID
     * @throws PortalServiceException - If there are any errors during the execution of this method
     */
    public void performScreening(long userId) throws PortalServiceException;

    /**
     * This method performs the screening by ID.
     *
     * @param enrollmentId - the enrollment ID
     * @throws PortalServiceException - If there are any errors during the execution of this method
     */
    public void performScreeningById(long enrollmentId) throws PortalServiceException;

    /**
     * This method schedules the medicaid program data change.
     *
     * @param time - the time
     * @throws PortalServiceException - If there are any errors during the execution of this method
     */
    public void scheduleMediCareProgramDataChange(int time) throws PortalServiceException;

    /**
     * This method schedules a revalidation.
     *
     * @param time - the time
     * @param userId - the user ID
     * @throws PortalServiceException - If there are any errors during the execution of this method
     */
    public void scheduleRevalidation(int time, long userId) throws PortalServiceException;

    /**
     * This method schedules a screening.
     *
     * @param time - the time
     * @throws PortalServiceException - If there are any errors during the execution of this method
     */
    public void scheduleScreening(int time) throws PortalServiceException;

    /**
     * This method gets the screening schedule.
     *
     * @return the screening schedule
     * @throws PortalServiceException - If there are any errors during the execution of this method
     */
    public ScreeningSchedule getScreeningSchedule() throws PortalServiceException;

    /**
     * This method saves the screening schedule.
     *
     * @param screeningSchedule - the screening schedule
     *
     * @throws IllegalArgumentException - If screeningSchedule is null
     * @throws PortalServiceException - If there are any errors during the execution of this method
     */
    public void saveScreeningSchedule(ScreeningSchedule screeningSchedule) throws PortalServiceException;

    /**
     * Schedules screening for the given ticket.
     * @param id the ticket to schedule
     * @param date the schedule date.
     * @throws PortalServiceException - If there are any errors during the execution of this method
     */
    public void scheduleScreening(long id, Date date) throws PortalServiceException;
}