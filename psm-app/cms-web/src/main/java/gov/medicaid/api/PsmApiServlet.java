package gov.medicaid.api;

import ca.uhn.fhir.context.FhirContext;
import ca.uhn.fhir.rest.api.EncodingEnum;
import ca.uhn.fhir.rest.server.RestfulServer;
import gov.medicaid.api.interceptors.BasicSecurityInterceptor;
import gov.medicaid.api.interceptors.TaskResourceAuthorizationInterceptor;
import gov.medicaid.services.ProviderEnrollmentService;
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
    private ProviderEnrollmentService providerEnrollmentService;

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
        if (providerEnrollmentService == null) {
            throw new ServletException("Not initialized!");
        }
    }

    private void initializeHapiFhir() {
        this.setFhirContext(FhirContext.forDstu3());
        this.setDefaultPrettyPrint(true);
        this.setDefaultResponseEncoding(EncodingEnum.JSON);

        setUpInterceptors();
        setResourceProviders(Collections.singletonList(
                new TaskResourceProvider(providerEnrollmentService)
        ));
    }

    @SuppressWarnings("unused") // reflectively called by Spring
    public void setProviderEnrollmentService(ProviderEnrollmentService providerEnrollmentService) {
        this.providerEnrollmentService = providerEnrollmentService;
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
