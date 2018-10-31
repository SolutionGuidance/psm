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

import gov.medicaid.entities.CMSUser;
import gov.medicaid.entities.ExternalAccountLink;
import gov.medicaid.entities.ExternalProfileLink;
import gov.medicaid.entities.ProviderProfile;
import gov.medicaid.entities.SystemId;
import gov.medicaid.services.CMSConfigurator;
import gov.medicaid.services.OnboardingService;
import gov.medicaid.services.PartnerSystemService;
import gov.medicaid.services.PortalServiceException;
import gov.medicaid.services.ProviderApplicationService;

import javax.annotation.PostConstruct;
import javax.ejb.EJB;
import javax.ejb.Local;
import javax.ejb.Stateless;
import javax.ejb.TransactionAttribute;
import javax.ejb.TransactionAttributeType;
import javax.ejb.TransactionManagement;
import javax.ejb.TransactionManagementType;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * This is a mock onboarding service implementation used to demo profile imports.
 */
@Stateless
@Local(OnboardingService.class)
@TransactionAttribute(TransactionAttributeType.REQUIRED)
@TransactionManagement(TransactionManagementType.CONTAINER)
public class OnboardingServiceBean extends BaseService implements OnboardingService {

    /**
     * Provider application service.
     */
    @EJB
    private ProviderApplicationService providerApplicationService;

    /**
     * External provider systems interface.
     */
    private Map<SystemId, PartnerSystemService> partnerSystemServices;

    /**
     * Empty constructor.
     */
    public OnboardingServiceBean() {
    }

    /**
     * This method checks that all required injection fields are in fact provided.
     */
    @PostConstruct
    public void init() {
        super.init();

        CMSConfigurator config = new CMSConfigurator();
        if (providerApplicationService == null) {
            providerApplicationService = config.getApplicationService();
        }

        partnerSystemServices = config.getPartnerServices();
    }

    /**
     * Retrieves the profiles of users from the given link.
     *
     * @param link the external account link
     * @return the list of matched profiles
     * @throws PortalServiceException for any errors encountered
     */
    public List<ProviderProfile> findProfiles(ExternalAccountLink link) throws PortalServiceException {
        PartnerSystemService partner = partnerSystemServices.get(link.getSystemId());
        List<ProviderProfile> matches = partner.findProfiles(link.getExternalUserId());

        List<ProviderProfile> profiles = new ArrayList<ProviderProfile>(matches);

        // filter already imported profiles
        List<ProviderProfile> toRemove = new ArrayList<ProviderProfile>();
        for (ProviderProfile providerProfile : profiles) {
            String str = "FROM ExternalProfileLink e WHERE e.systemId = :system AND e.externalProfileId = :profileId";

            List<ExternalProfileLink> rs = getEm()
                .createQuery(str, ExternalProfileLink.class)
                .setParameter("system", link.getSystemId())
                .setParameter("profileId", "" + providerProfile.getProfileId())
                .getResultList();
            if (!rs.isEmpty()) {
                toRemove.add(providerProfile);
            }
        }

        profiles.removeAll(toRemove);
        return profiles;
    }

    /**
     * Imports the selected profiles from the external data source.
     *
     * @param user the user performing the action
     * @param link the external account link
     * @param externalProfileIds the selected profile IDs
     * @return the number of profiles successfully imported
     * @throws PortalServiceException for any errors encountered
     */
    public int importProfiles(CMSUser user, ExternalAccountLink link, String[] externalProfileIds)
        throws PortalServiceException {
        List<ProviderProfile> profiles = findProfiles(link);

        List<ProviderProfile> success = new ArrayList<ProviderProfile>();
        for (String externalProfileId : externalProfileIds) {
            for (ProviderProfile providerProfile : profiles) {
                if (providerProfile.getProfileId() == Long.parseLong(externalProfileId)) {
                    long internalProfileId = providerApplicationService.importProfile(user, link.getSystemId(),
                        providerProfile);

                    ExternalProfileLink profileLink = new ExternalProfileLink();
                    profileLink.setId(0);
                    profileLink.setProfileId(internalProfileId);
                    profileLink.setExternalProfileId("" + providerProfile.getProfileId());
                    profileLink.setSystemId(link.getSystemId());
                    getEm().persist(profileLink);

                    success.add(providerProfile);
                }
            }
        }
        profiles.removeAll(success);
        return success.size();
    }

    /**
     * Verifies the credentials of the user.
     *
     * @param link the external account link to verify credentials for
     * @param password the credentials
     * @return true if the credentials provided are valid
     */
    public boolean verifyCredentials(ExternalAccountLink link, String password) {
        PartnerSystemService partner = partnerSystemServices.get(link.getSystemId());
        return partner.authenticate(link.getExternalUserId(), password, null, null);
    }
}
