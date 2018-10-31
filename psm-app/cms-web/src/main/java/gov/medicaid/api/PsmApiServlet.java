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

package gov.medicaid.api;

import ca.uhn.fhir.context.FhirContext;
import ca.uhn.fhir.rest.api.EncodingEnum;
import ca.uhn.fhir.rest.server.RestfulServer;
import gov.medicaid.api.interceptors.BasicSecurityInterceptor;
import gov.medicaid.api.interceptors.TaskResourceAuthorizationInterceptor;
import gov.medicaid.services.ProviderApplicationService;
import gov.medicaid.services.RegistrationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.context.support.SpringBeanAutowiringSupport;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import java.util.Collections;

@WebServlet(urlPatterns = {"/fhir/*"}, displayName = "PSM FHIR Server")
public class PsmApiServlet extends RestfulServer {
    private static final long serialVersionUID = 1L;

    @Autowired
    private ProviderApplicationService providerApplicationService;

    @Autowired
    private RegistrationService registrationService;

    @Override
    protected void initialize() throws ServletException {
        initializeSpring();
        initializeHapiFhir();
    }

    private void initializeSpring() throws ServletException {
        SpringBeanAutowiringSupport.processInjectionBasedOnServletContext(
                this,
                getServletContext()
        );
        if (providerApplicationService == null) {
            throw new ServletException("Not initialized!");
        }
    }

    private void initializeHapiFhir() {
        this.setFhirContext(FhirContext.forDstu3());
        this.setDefaultPrettyPrint(true);
        this.setDefaultResponseEncoding(EncodingEnum.JSON);

        setUpInterceptors();
        setResourceProviders(Collections.singletonList(
                new TaskResourceProvider(providerApplicationService)
        ));
    }

    @SuppressWarnings("unused") // reflectively called by Spring
    public void setProviderApplicationService(ProviderApplicationService providerApplicationService) {
        this.providerApplicationService = providerApplicationService;
    }

    public void setRegistrationService(RegistrationService registrationService) {
        this.registrationService = registrationService;
    }

    private void setUpInterceptors() {
        addBasicSecurityInterceptor();
        addTaskResourceAuthorizationInterceptor();
    }

    private void addBasicSecurityInterceptor() {
        BasicSecurityInterceptor basicSecurity = new BasicSecurityInterceptor(registrationService);
        registerInterceptor(basicSecurity);
    }

    private void addTaskResourceAuthorizationInterceptor() {
        TaskResourceAuthorizationInterceptor taskResourceAuthorization = new TaskResourceAuthorizationInterceptor();
        registerInterceptor(taskResourceAuthorization);
    }

}
