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

import gov.medicaid.binders.BinderUtils;
import gov.medicaid.domain.model.ApplicationType;
import gov.medicaid.domain.model.SubmitApplicationRequest;
import gov.medicaid.domain.model.SubmitApplicationResponse;
import gov.medicaid.entities.Application;
import gov.medicaid.entities.CMSUser;
import gov.medicaid.entities.ExternalAccountLink;
import gov.medicaid.entities.ProviderProfile;
import gov.medicaid.entities.RoleView;
import gov.medicaid.entities.SystemId;
import gov.medicaid.entities.Validity;
import gov.medicaid.entities.dto.ViewStatics;
import gov.medicaid.services.ApplicationWebService;
import gov.medicaid.services.BusinessProcessService;
import gov.medicaid.services.PortalServiceConfigurationException;
import gov.medicaid.services.PortalServiceException;
import gov.medicaid.services.ProviderApplicationService;
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
 * Web service facade for application requests.
 *
 * v1.1 - WAS Porting - split transaction of save and submit, so JBPM errors still saves the request
 */
@Stateless
@Local(ApplicationWebService.class)
@TransactionAttribute(TransactionAttributeType.REQUIRED)
@TransactionManagement(TransactionManagementType.CONTAINER)
public class ApplicationWebServiceBean extends BaseService implements ApplicationWebService {

    /**
     * Persistence service.
     */
    @EJB
    private ProviderApplicationService providerApplicationService;

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
    public ApplicationWebServiceBean() {
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
        if (providerApplicationService == null) {
            throw new PortalServiceConfigurationException("providerApplicationService must be configured.");
        }
    }

    /**
     * Retrieves the application details.
     *
     * @param username     the username of the requesting user
     * @param systemId     the system that authenticated the requesting user
     * @param npi          the NPI for which this user is a proxy, if any
     * @param applicationId the ID of the application
     * @return the application
     * @throws PortalServiceException for any errors encountered
     */
    public ApplicationType getApplicationDetails(
            String username,
            String systemId,
            String npi,
            long applicationId
    ) throws PortalServiceException {
        CMSUser user = findUser(username, systemId, npi);
        Application application = providerApplicationService.getApplicationWithScreenings(user, applicationId).
            orElseThrow(() -> new PortalServiceException("Couldn't find application"));
        return XMLAdapter.toXML(application);
    }

    /**
     * Saves the application details.
     *
     * @param username   the username of the requesting user
     * @param systemId   the system that authenticated the requesting user
     * @param npi        the NPI for which this user is a proxy, if any
     * @param application the application to save
     * @return the application ID
     * @throws PortalServiceException for any errors encountered
     */
    public long saveApplication(
            String username,
            String systemId,
            String npi,
            ApplicationType applicationType
    ) throws PortalServiceException {
        CMSUser user = findUser(username, systemId, npi);
        return saveApplication(user, applicationType, true);
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
     * Saves the given application.
     *
     * @param user the user performing the action
     * @param application the application model
     * @param resetToDraft if true, resets the submission into DRAFT status
     * @return the application id
     * @throws PortalServiceException for any errors encountered
     */
    @TransactionAttribute(TransactionAttributeType.REQUIRED)
    public long saveApplication(CMSUser user, ApplicationType applicationType, boolean resetToDraft) throws PortalServiceException {
        long applicationId = BinderUtils.getAsLong(applicationType.getObjectId());
        Application application;
        if (applicationId > 0) {
            // update existing application
            Application applicationDetails = providerApplicationService.getApplicationWithScreenings(user, applicationId).
                orElseThrow(() -> new PortalServiceException("Couldn't find application"));
            if (resetToDraft) {
                if (!ViewStatics.DRAFT_STATUS.equals(applicationDetails.getStatus().getDescription())) {
                    throw new PortalServiceException("Cannot modify submitted application.");
                }
            }
            application = XMLAdapter.mergeFromXML(user, applicationType, applicationDetails);
        } else {
            application = XMLAdapter.fromXML(user, applicationType);
        }

        if (resetToDraft) {
            applicationId = providerApplicationService.saveAsDraft(user, application);
        } else {
            // retain current status
            providerApplicationService.saveApplicationDetails(application);
        }
        return applicationId;
    }

    /**
     * Submits the given application request.
     *
     * @param request the service request
     * @return the service response
     * @throws PortalServiceException for any errors encountered
     */
    @Override
    @TransactionAttribute(TransactionAttributeType.NOT_SUPPORTED) // allow SAVE even if SUBMIT fails
    public SubmitApplicationResponse submitApplication(SubmitApplicationRequest request) throws PortalServiceException {
        try {
            ApplicationType applicationType = request.getApplication();
            CMSUser user = findUser(request.getUsername(), request.getSystemId(), request.getNpi());
            // transaction #1
            long applicationId = saveApplication(user, applicationType, true);

            long profileId = BinderUtils.getAsLong(applicationType.getProviderInformation().getObjectId());
            Validity validity = providerApplicationService.getSubmissionValidity(applicationId, profileId);

            SubmitApplicationResponse response = new SubmitApplicationResponse();
            response.setApplicationNumber(applicationId);
            if (validity == Validity.VALID) {

                // transaction #2
                businessProcessService.submitApplication(user, applicationId);

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
    public ApplicationType getProfile(
            String username,
            String systemId,
            String npi,
            long profileId
    ) throws PortalServiceException {
        CMSUser user = findUser(username, systemId, npi);
        ProviderProfile profile = providerApplicationService.getProviderDetails(
                user,
                profileId
        );
        Application wrapper = new Application();
        wrapper.setDetails(profile);
        return XMLAdapter.toXML(wrapper);
    }

    @Override
    @TransactionAttribute(TransactionAttributeType.NOT_SUPPORTED) // allow SAVE even if SUBMIT fails
    public String resubmitApplication(
            String username,
            String systemId,
            String npi,
            ApplicationType applicationType
    ) throws PortalServiceException {
        CMSUser user = findUser(username, systemId, npi);

        long applicationId = BinderUtils.getAsLong(applicationType.getObjectId());
        long profileId = BinderUtils.getAsLong(applicationType.getProviderInformation().getObjectId());
        Validity validity = providerApplicationService.getSubmissionValidity(applicationId, profileId);

        if (validity == Validity.VALID) {
            try {
                saveApplication(user, applicationType, false); // retain status
                // synchronize with DB
                Application application = providerApplicationService.getApplicationWithScreenings(user, applicationId).
                    orElseThrow(() -> new PortalServiceException("Couldn't find application"));
                businessProcessService.updateRequest(XMLAdapter.toXML(application), user);
            } catch (Exception e) {
                throw new PortalServiceException("Resubmit failed.", e);
            }
            return "SUCCESS";
        } else {
            return validity.name();
        }
    }
}
