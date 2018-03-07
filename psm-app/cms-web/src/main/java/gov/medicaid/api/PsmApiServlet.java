package gov.medicaid.api;

import ca.uhn.fhir.context.FhirContext;
import ca.uhn.fhir.rest.api.EncodingEnum;
import ca.uhn.fhir.rest.server.RestfulServer;
import gov.medicaid.services.ProviderEnrollmentService;
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

        setResourceProviders(Collections.singletonList(
                new TaskResourceProvider(providerEnrollmentService)
        ));
    }

    @SuppressWarnings("unused") // reflectively called by Spring
    public void setProviderEnrollmentService(ProviderEnrollmentService providerEnrollmentService) {
        this.providerEnrollmentService = providerEnrollmentService;
    }
}
