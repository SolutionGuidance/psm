/*
 * Copyright 2012-2013 TopCoder, Inc.
 *
 * This code was developed under U.S. government contract NNH10CD71C.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * You may not use this file except in compliance with the License.
 * You may obtain a copy of the License at:
 *     http://www.apache.org/licenses/LICENSE-2.0
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package gov.medicaid.services.impl;

import gov.medicaid.binders.BinderUtils;
import gov.medicaid.domain.model.EnrollmentType;
import gov.medicaid.domain.model.SubmitTicketRequest;
import gov.medicaid.domain.model.SubmitTicketResponse;
import gov.medicaid.entities.CMSUser;
import gov.medicaid.entities.Enrollment;
import gov.medicaid.entities.ExternalAccountLink;
import gov.medicaid.entities.ProviderProfile;
import gov.medicaid.entities.RoleView;
import gov.medicaid.entities.SystemId;
import gov.medicaid.entities.Validity;
import gov.medicaid.entities.dto.ViewStatics;
import gov.medicaid.services.BusinessProcessService;
import gov.medicaid.services.EnrollmentWebService;
import gov.medicaid.services.PortalServiceConfigurationException;
import gov.medicaid.services.PortalServiceException;
import gov.medicaid.services.ProviderEnrollmentService;
import gov.medicaid.services.RegistrationService;
import gov.medicaid.services.util.Util;
import gov.medicaid.services.util.XMLAdapter;

import javax.annotation.PostConstruct;
import javax.ejb.EJB;
import javax.ejb.Local;
import javax.ejb.Stateless;
import javax.ejb.TransactionAttribute;
import javax.ejb.TransactionAttributeType;
import javax.ejb.TransactionManagement;
import javax.ejb.TransactionManagementType;

/**
 * Web service facade for enrollment requests.
 *
 * v1.1 - WAS Porting - split transaction of save and submit, so JBPM errors still saves the request
 * @author TCSASSEMBLER
 * @version 1.1
 */
@Stateless
@Local(EnrollmentWebService.class)
@TransactionAttribute(TransactionAttributeType.REQUIRED)
@TransactionManagement(TransactionManagementType.CONTAINER)
public class EnrollmentWebServiceBean extends BaseService implements EnrollmentWebService {

    /**
     * Persistence service.
     */
    @EJB
    private ProviderEnrollmentService providerEnrollmentService;

    /**
     * Registration service.
     */
    @EJB
    private RegistrationService registrationService;

    /**
     * JBPM services.
     */
    @EJB
    private BusinessProcessService businessProcessService;

    /**
     * Empty constructor.
     */
    public EnrollmentWebServiceBean() {
    }

    /**
     * Initializes this service.
     */
    @PostConstruct
    protected void init() {
        super.init();
        if (registrationService == null) {
            throw new PortalServiceConfigurationException("registrationService must be configured.");
        }
        if (providerEnrollmentService == null) {
            throw new PortalServiceConfigurationException("providerEnrollmentService must be configured.");
        }
    }

    /**
     * Retrieves the ticket details.
     *
     * @param username     the username of the requesting user
     * @param systemId     the system that authenticated the requesting user
     * @param npi          the NPI for which this user is a proxy, if any
     * @param enrollmentId the ID of the enrollment (ticket)
     * @return the enrollment (ticket)
     * @throws PortalServiceException for any errors encountered
     */
    public EnrollmentType getTicketDetails(
            String username,
            String systemId,
            String npi,
            long enrollmentId
    ) throws PortalServiceException {
        CMSUser user = findUser(username, systemId, npi);
        Enrollment ticket = providerEnrollmentService.getTicketDetails(user, enrollmentId);
        return XMLAdapter.toXML(ticket);
    }

    /**
     * Saves the ticket details.
     *
     * @param username   the username of the requesting user
     * @param systemId   the system that authenticated the requesting user
     * @param npi        the NPI for which this user is a proxy, if any
     * @param enrollment the enrollment to save
     * @return the enrollment (ticket) ID
     * @throws PortalServiceException for any errors encountered
     */
    public long saveTicket(
            String username,
            String systemId,
            String npi,
            EnrollmentType enrollment
    ) throws PortalServiceException {
        CMSUser user = findUser(username, systemId, npi);
        return saveTicket(user, enrollment, true);
    }

    /**
     * Retrieves the user with the given id.
     *
     * @param username the username
     * @param systemId the system authenticator
     * @param string
     * @return the user matched
     * @throws PortalServiceException for any errors encountered
     */
    private CMSUser findUser(String username, String systemId, String npi) throws PortalServiceException {
        CMSUser user;
        SystemId system = SystemId.valueOf(systemId);
        if (system != SystemId.CMS_ONLINE) {
            user = registrationService.findByExternalUsername(system, username);
            if (Util.isNotBlank(npi)) { // proxy user
                user.setProxyForNPI(npi);
                if (username.equals(npi)) {
                    user.setExternalRoleView(RoleView.SELF);
                } else {
                    user.setExternalRoleView(RoleView.EMPLOYER);
                }
                ExternalAccountLink link = registrationService.findAccountLink(
                        user.getUserId(), system, username);
                user.setExternalAccountLink(link);
            }
        } else {
            user = registrationService.findByUsername(username);
        }

        if (user == null) {
            throw new PortalServiceException("Invalid username or system identification.");
        }
        return user;
    }

    /**
     * Saves the given ticket.
     *
     * @param user the user performing the action
     * @param enrollment the enrollment model
     * @param resetToDraft if true, resets the submission into DRAFT status
     * @return the ticket id
     * @throws PortalServiceException for any errors encountered
     */
    @TransactionAttribute(TransactionAttributeType.REQUIRED)
    public long saveTicket(CMSUser user, EnrollmentType enrollment, boolean resetToDraft) throws PortalServiceException {
        long ticketId = BinderUtils.getAsLong(enrollment.getObjectId());
        Enrollment ticket;
        if (ticketId > 0) {
            // update existing ticket
            Enrollment ticketDetails = providerEnrollmentService.getTicketDetails(user, ticketId);
            if (resetToDraft) {
                if (!ViewStatics.DRAFT_STATUS.equals(ticketDetails.getStatus().getDescription())) {
                    throw new PortalServiceException("Cannot modify submitted ticket.");
                }
            }
            ticket = XMLAdapter.mergeFromXML(user, enrollment, ticketDetails);
        } else {
            ticket = XMLAdapter.fromXML(user, enrollment);
        }

        if (resetToDraft) {
            ticketId = providerEnrollmentService.saveAsDraft(user, ticket);
        } else {
            // retain current status
            providerEnrollmentService.saveEnrollmentDetails(ticket);
        }
        return ticketId;
    }

    /**
     * Submits the given enrollment request.
     *
     * @param request the service request
     * @return the service response
     * @throws PortalServiceException for any errors encountered
     */
    @Override
    @TransactionAttribute(TransactionAttributeType.NOT_SUPPORTED) // allow SAVE even if SUBMIT fails
    public SubmitTicketResponse submitEnrollment(SubmitTicketRequest request) throws PortalServiceException {
        try {
            EnrollmentType enrollment = request.getEnrollment();
            CMSUser user = findUser(request.getUsername(), request.getSystemId(), request.getNpi());
            // transaction #1
            long ticketId = saveTicket(user, enrollment, true);

            long profileId = BinderUtils.getAsLong(enrollment.getProviderInformation().getObjectId());
            Validity validity = providerEnrollmentService.getSubmissionValidity(ticketId, profileId);

            SubmitTicketResponse response = new SubmitTicketResponse();
            response.setTicketNumber(ticketId);
            if (validity == Validity.VALID) {

                // transaction #2
                businessProcessService.submitTicket(user, ticketId);

                response.setStatus("SUCCESS");
                return response;
            } else {
                response.setStatus(validity.name());
                return response;
            }
        } catch (Throwable t) {
            throw new PortalServiceException("error during submit.", t);
        }
    }

    @Override
    public EnrollmentType getProfile(
            String username,
            String systemId,
            String npi,
            long profileId
    ) throws PortalServiceException {
        CMSUser user = findUser(username, systemId, npi);
        ProviderProfile profile = providerEnrollmentService.getProviderDetails(
                user,
                profileId
        );
        Enrollment wrapper = new Enrollment();
        wrapper.setDetails(profile);
        return XMLAdapter.toXML(wrapper);
    }

    @Override
    @TransactionAttribute(TransactionAttributeType.NOT_SUPPORTED) // allow SAVE even if SUBMIT fails
    public String resubmitEnrollment(
            String username,
            String systemId,
            String npi,
            EnrollmentType enrollment
    ) throws PortalServiceException {
        CMSUser user = findUser(username, systemId, npi);

        long ticketId = BinderUtils.getAsLong(enrollment.getObjectId());
        long profileId = BinderUtils.getAsLong(enrollment.getProviderInformation().getObjectId());
        Validity validity = providerEnrollmentService.getSubmissionValidity(ticketId, profileId);

        if (validity == Validity.VALID) {
            try {
                saveTicket(user, enrollment, false); // retain status
                // synchronize with DB
                Enrollment ticket = providerEnrollmentService.getTicketDetails(user, ticketId);
                businessProcessService.updateRequest(XMLAdapter.toXML(ticket), user);
            } catch (Exception e) {
                throw new PortalServiceException("Resubmit failed.", e);
            }
            return "SUCCESS";
        } else {
            return validity.name();
        }
    }
}
