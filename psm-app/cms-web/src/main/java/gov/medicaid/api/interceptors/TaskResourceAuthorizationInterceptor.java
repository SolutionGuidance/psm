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
