/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.services;

import gov.medicaid.entities.Event;

import java.util.List;


/**
 * <p>
 * This represents the service API to manage events.
 * </p>
 * <p>
 * Implementations should be effectively thread-safe.
 * </p>
 * @author argolite, TCSASSEMBLER
 * @version 1.0
 */
public interface EventService {

    /**
     * This method creates the event and returns the new ID of the created entity.
     *
     * @param event the event to create
     *
     * @return the ID of the added event
     *
     * @throws IllegalArgumentException If event is null
     * @throws PortalServiceException If there are any errors during the execution of this method
     */
    public long create(Event event) throws PortalServiceException;

    /**
     * This method gets the latest events.
     *
     * @return the latest events
     *
     * @throws PortalServiceException If there are any errors during the execution of this method
     */
    public List<Event> getLatest() throws PortalServiceException;
}
