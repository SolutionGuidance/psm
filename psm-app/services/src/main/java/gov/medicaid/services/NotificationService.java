/*
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

package gov.medicaid.services;

import gov.medicaid.domain.model.ApplicationType;
import gov.medicaid.entities.EmailTemplate;
import java.util.Map;

public interface NotificationService {

    /**
     * Sends email notifications.
     *
     * @param email the recipient
     * @param emailType the name of the template to be used
     * @param vars the substitution variables to put in the templating context
     * @throws PortalServiceException for any errors encountered
     */
    void sendNotification(
        String email,
        EmailTemplate emailType,
        Map<String, Object> vars
    ) throws PortalServiceException;

    void sendApplicationNotification(
        ApplicationType applicationType,
        EmailTemplate emailType
    ) throws PortalServiceException;
}
