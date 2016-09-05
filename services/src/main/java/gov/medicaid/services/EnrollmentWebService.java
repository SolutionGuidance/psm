/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.services;

import gov.medicaid.domain.model.GetLookupGroupsRequest;
import gov.medicaid.domain.model.GetLookupGroupsResponse;
import gov.medicaid.domain.model.GetProfileDetailsRequest;
import gov.medicaid.domain.model.GetProfileDetailsResponse;
import gov.medicaid.domain.model.GetTicketDetailsRequest;
import gov.medicaid.domain.model.GetTicketDetailsResponse;
import gov.medicaid.domain.model.ResubmitTicketRequest;
import gov.medicaid.domain.model.ResubmitTicketResponse;
import gov.medicaid.domain.model.SaveTicketRequest;
import gov.medicaid.domain.model.SaveTicketResponse;
import gov.medicaid.domain.model.SubmitTicketRequest;
import gov.medicaid.domain.model.SubmitTicketResponse;

/**
 * Web service facade for enrollment requests.
 * @author TCSASSEMBLER
 * @version 1.0
 */
public interface EnrollmentWebService {

    /**
     * Retrieves the lookup groups.
     *
     * @param request the service request
     * @return the service response
     * @throws PortalServiceException for any errors encountered
     */
    public GetLookupGroupsResponse getLookupGroups(GetLookupGroupsRequest request) throws PortalServiceException;

    /**
     * Retrieves the ticket details.
     *
     * @param request the service request
     * @return the service response
     * @throws PortalServiceException for any errors encountered
     */
    public GetTicketDetailsResponse getTicketDetails(GetTicketDetailsRequest request) throws PortalServiceException;

    /**
     * Saves the ticket details.
     *
     * @param request the service request
     * @return the service response
     * @throws PortalServiceException for any errors encountered
     */
    public SaveTicketResponse saveTicket(SaveTicketRequest request) throws PortalServiceException;

    /**
     * Submits the given enrollment request.
     *
     * @param request the service request
     * @return the service response
     * @throws PortalServiceException for any errors encountered
     */
    public SubmitTicketResponse submitEnrollment(SubmitTicketRequest request) throws PortalServiceException;

    /**
     * Retrieves the profile details.
     *
     * @param request the service request
     * @return the service response
     * @throws PortalServiceException for any errors encountered
     */
    public GetProfileDetailsResponse getProfile(GetProfileDetailsRequest request) throws PortalServiceException;

    /**
     * Resubmits the given enrollment request.
     *
     * @param request the service request
     * @return the service response
     * @throws PortalServiceException for any errors encountered
     */
    public ResubmitTicketResponse resubmitEnrollment(ResubmitTicketRequest serviceRequest) throws PortalServiceException;
}
