/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.services.impl;

import gov.medicaid.binders.BinderUtils;
import gov.medicaid.binders.XMLUtility;
import gov.medicaid.domain.model.ApplicantType;
import gov.medicaid.domain.model.EnrollmentType;
import gov.medicaid.domain.model.GetLookupGroupsRequest;
import gov.medicaid.domain.model.GetLookupGroupsResponse;
import gov.medicaid.domain.model.GetProfileDetailsRequest;
import gov.medicaid.domain.model.GetProfileDetailsResponse;
import gov.medicaid.domain.model.GetTicketDetailsRequest;
import gov.medicaid.domain.model.GetTicketDetailsResponse;
import gov.medicaid.domain.model.LookupGroup;
import gov.medicaid.domain.model.LookupGroupNames;
import gov.medicaid.domain.model.LookupTableEntry;
import gov.medicaid.domain.model.ResubmitTicketRequest;
import gov.medicaid.domain.model.ResubmitTicketResponse;
import gov.medicaid.domain.model.SaveTicketRequest;
import gov.medicaid.domain.model.SaveTicketResponse;
import gov.medicaid.domain.model.SubmitTicketRequest;
import gov.medicaid.domain.model.SubmitTicketResponse;
import gov.medicaid.entities.CMSUser;
import gov.medicaid.entities.Enrollment;
import gov.medicaid.entities.LookupEntity;
import gov.medicaid.entities.ProviderProfile;
import gov.medicaid.entities.ProviderType;
import gov.medicaid.entities.SystemId;
import gov.medicaid.entities.Validity;
import gov.medicaid.entities.dto.ViewStatics;
import gov.medicaid.services.BusinessProcessService;
import gov.medicaid.services.EnrollmentWebService;
import gov.medicaid.services.PortalServiceConfigurationException;
import gov.medicaid.services.PortalServiceException;
import gov.medicaid.services.ProviderEnrollmentService;
import gov.medicaid.services.RegistrationService;
import gov.medicaid.services.util.XMLAdapter;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

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
     * Retrieves the lookup groups.
     *
     * @param request the service request
     * @return the service response
     */
    public GetLookupGroupsResponse getLookupGroups(GetLookupGroupsRequest request) {
        GetLookupGroupsResponse response = new GetLookupGroupsResponse();
        List<LookupGroupNames> types = request.getGroupType();
        for (LookupGroupNames lookupGroup : types) {
            List<LookupGroup> results = response.getLookupGroup();
            results.add(findLookups(lookupGroup));
        }
        return response;
    }

    /**
     * Finds the lookup group members.
     * @param groupType the lookup group type.
     * @return the lookup group
     */
    private LookupGroup findLookups(LookupGroupNames groupType) {
        LookupGroup group = new LookupGroup();
        group.setGroupType(groupType);
        List<ProviderType> providerTypes = null;
        switch (groupType) {
        case INDIVIDUAL_PROVIDER_TYPES:
            providerTypes = sortCollection(getLookupService().getProviderTypes(ApplicantType.INDIVIDUAL));
            break;
        case ORGANIZATION_PROVIDER_TYPES:
            providerTypes = sortCollection(getLookupService().getProviderTypes(ApplicantType.ORGANIZATION));
            break;
        default:
            providerTypes = getLookupService().getProviderTypes(null);
            break;
        }
        group.getLookupTableEntry().addAll(mapLookupEntity(providerTypes));
        return group;
    }

    /**
     * Sorts the displayed provider types (PESP-252_
     * @param providerTypes the provider types to sort
     * @return the sorted types
     */
    private List<ProviderType> sortCollection(List<ProviderType> providerTypes) {
        List<ProviderType> sortedList = new ArrayList<ProviderType>(providerTypes);
        Collections.sort(sortedList, new Comparator<ProviderType>() {
            @Override
            public int compare(ProviderType o1, ProviderType o2) {
                return o1.getDescription().compareTo(o2.getDescription());
            }
        });
        return sortedList;
    }

    /**
     * Maps the given list by lookup code.
     *
     * @param resultList the list to map
     * @return the mapped list
     */
    private Collection<? extends LookupTableEntry> mapLookupEntity(List<? extends LookupEntity> resultList) {
        Collection<LookupTableEntry> list = new ArrayList<LookupTableEntry>();
        for (LookupEntity lookupEntity : resultList) {
            LookupTableEntry entry = new LookupTableEntry();
            entry.setCode(lookupEntity.getCode());
            entry.setDescription(lookupEntity.getDescription());
            list.add(entry);
        }
        return list;
    }

    /**
     * Retrieves the ticket details.
     *
     * @param request the service request
     * @return the service response
     * @throws PortalServiceException for any errors encountered
     */
    public GetTicketDetailsResponse getTicketDetails(GetTicketDetailsRequest request) throws PortalServiceException {
        GetTicketDetailsResponse response = new GetTicketDetailsResponse();
        CMSUser user = findUser(request.getUsername(), request.getSystemId());
        Enrollment ticket = providerEnrollmentService.getTicketDetails(user, request.getTicketNumber());
        response.setEnrollment(XMLAdapter.toXML(ticket));
        return response;
    }

    /**
     * Saves the ticket details.
     *
     * @param request the service request
     * @return the service response
     * @throws PortalServiceException for any errors encountered
     */
    public SaveTicketResponse saveTicket(SaveTicketRequest request) throws PortalServiceException {
        EnrollmentType enrollment = request.getEnrollment();
        CMSUser user = findUser(request.getUsername(), request.getSystemId());
        long ticketId = saveTicket(user, enrollment, true);
        SaveTicketResponse response = new SaveTicketResponse();
        response.setTicketNumber(ticketId);
        return response;
    }

    /**
     * Retrieves the user with the given id.
     *
     * @param username the username
     * @param systemId the system authenticator
     * @return the user matched
     * @throws PortalServiceException for any errors encountered
     */
    private CMSUser findUser(String username, String systemId) throws PortalServiceException {
        CMSUser user;
        SystemId system = SystemId.valueOf(systemId);
        if (system != SystemId.CMS_ONLINE) {
            user = registrationService.findByExternalUsername(system, username);
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
	        CMSUser user = findUser(request.getUsername(), request.getSystemId());
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

    /**
     * Retrieves the profile details.
     *
     * @param request the service request
     * @return the service response
     * @throws PortalServiceException for any errors encountered
     */
    public GetProfileDetailsResponse getProfile(GetProfileDetailsRequest request) throws PortalServiceException {
        GetProfileDetailsResponse response = new GetProfileDetailsResponse();
        CMSUser user = findUser(request.getUsername(), request.getSystemId());
        ProviderProfile profile = providerEnrollmentService.getProviderDetails(user, request.getProfileId());
        Enrollment wrapper = new Enrollment();
        wrapper.setDetails(profile);
        response.setEnrollment(XMLAdapter.toXML(wrapper));
        return response;
    }

    @Override
    @TransactionAttribute(TransactionAttributeType.NOT_SUPPORTED) // allow SAVE even if SUBMIT fails
    public ResubmitTicketResponse resubmitEnrollment(ResubmitTicketRequest request) throws PortalServiceException {
        EnrollmentType enrollment = request.getEnrollment();
        CMSUser user = findUser(request.getUsername(), request.getSystemId());
        
        long ticketId = BinderUtils.getAsLong(request.getTicketId());
        long profileId = BinderUtils.getAsLong(enrollment.getProviderInformation().getObjectId());
        Validity validity = providerEnrollmentService.getSubmissionValidity(ticketId, profileId);

        ResubmitTicketResponse response = new ResubmitTicketResponse();
        if (validity == Validity.VALID) {
            try {
                saveTicket(user, enrollment, false); // retain status
                // synchronize with DB
                Enrollment ticket = providerEnrollmentService.getTicketDetails(user, ticketId);
                businessProcessService.updateRequest(XMLAdapter.toXML(ticket), user.getUserId(), user.getRole().getDescription());
            } catch (Exception e) {
                throw new PortalServiceException("Resubmit failed.", e);
            }
            response.setStatus("SUCCESS");
            return response;
        } else {
            response.setStatus(validity.name());
            return response;
        }
    }

}
