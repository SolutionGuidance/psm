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

package gov.medicaid.api.interceptors;

import ca.uhn.fhir.rest.api.server.RequestDetails;
import ca.uhn.fhir.rest.server.interceptor.auth.AuthorizationInterceptor;
import ca.uhn.fhir.rest.server.interceptor.auth.IAuthRule;
import ca.uhn.fhir.rest.server.interceptor.auth.IAuthRuleBuilder;
import ca.uhn.fhir.rest.server.interceptor.auth.RuleBuilder;
import gov.medicaid.entities.CMSUser;
import java.util.List;

public class TaskResourceAuthorizationInterceptor extends AuthorizationInterceptor {

    @Override
    public List<IAuthRule> buildRuleList(RequestDetails theRequestDetails) {

        IAuthRuleBuilder rules = new RuleBuilder();
        CMSUser user = (CMSUser) theRequestDetails.getUserData().get("currentUser");
        if (user.getApiRead()) {
            rules = rules.allow().read().allResources().withAnyId().andThen();
        }
        if (user.getApiWrite()) {
            rules = rules.allow().write().allResources().withAnyId().andThen();
        }

        // Deny everything that has not been granted
        rules.denyAll();
        return rules.build();
    }

}
