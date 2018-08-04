/*
 * Copyright 2012, 2013 TopCoder, Inc.
 * Copyright 2018 The MITRE Corporation
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package gov.medicaid.services.impl;

import gov.medicaid.entities.Event;
import gov.medicaid.services.CMSConfigurator;
import gov.medicaid.services.EventService;
import gov.medicaid.services.PortalServiceException;

import javax.annotation.PostConstruct;
import javax.ejb.Local;
import javax.ejb.Stateless;
import javax.ejb.TransactionAttribute;
import javax.ejb.TransactionAttributeType;
import javax.ejb.TransactionManagement;
import javax.ejb.TransactionManagementType;
import javax.persistence.PersistenceException;
import java.util.List;

/**
 * <p>
 * This class provides an implementation of the AgreementDocumentDAO.
 * </p>
 * <p>
 * This bean is mutable and not thread-safe as it deals with non-thread-safe entities. However, in the context of being
 * used in a container, it is thread-safe.
 * </p>
 */
@Stateless
@TransactionManagement(TransactionManagementType.CONTAINER)
@Local(EventService.class)
public class HibernateEventServiceBean extends BaseService implements EventService {

    /**
     * Represents the amount of items to retrieve in the getLatest call. It is injected by the container. it is used in
     * the getLatest method. It may have any value. It is fully mutable, but not expected to change after dependency
     * injection.
     */
    private int maxResults;

    /**
     * Empty constructor.
     */
    public HibernateEventServiceBean() {
    }

    /**
     * This method checks that all required injection fields are in fact provided.
     */
    @PostConstruct
    protected void init() {
        super.init();
        CMSConfigurator config = new CMSConfigurator();
        if (maxResults == 0) {
            maxResults = config.getMaxNotificationsDisplay();
        }
    }

    /**
     * This method creates the event and returns the new ID of the created entity.
     *
     * @param event the event to create
     *
     * @return the ID of the added event
     *
     * @throws IllegalArgumentException if event is null
     * @throws PortalServiceException if there are any errors during the execution of this method
     */
    @TransactionAttribute(TransactionAttributeType.REQUIRED)
    public long create(Event event) throws PortalServiceException {
        try {
            if (event == null) {
                throw new IllegalArgumentException("Argument 'event' cannot be null.");
            }

            getEm().persist(event);

            return event.getId();
        } catch (PersistenceException e) {
            throw new PortalServiceException("Could not complete database operation.", e);
        }
    }

    /**
     * This method gets the latest events.
     *
     * @return - the latest events
     *
     * @throws IllegalStateException if maxResults is not positive
     * @throws PortalServiceException if there are any errors during the execution of this method
     */
    @TransactionAttribute(TransactionAttributeType.SUPPORTS)
    public List<Event> getLatest() throws PortalServiceException {
        try {
            if (maxResults <= 0) {
                throw new IllegalStateException("maxResults should be configured as positive");
            }
            // Create query string:
            String queryString = "SELECT entity FROM Event entity ORDER BY entity.createdOn DESC";

            return getEm()
                .createQuery(queryString, Event.class)
                .setFirstResult(0)
                .setMaxResults(maxResults)
                .getResultList();
        } catch (PersistenceException e) {
            throw new PortalServiceException("Could not complete database operation.", e);
        }
    }
}
