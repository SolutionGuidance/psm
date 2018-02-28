package gov.medicaid.api;

import ca.uhn.fhir.context.FhirContext;
import ca.uhn.fhir.rest.api.EncodingEnum;
import ca.uhn.fhir.rest.server.RestfulServer;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import java.util.Collections;

@WebServlet(urlPatterns = {"/fhir/*"}, displayName = "PSM FHIR Server")
public class PsmApiServlet extends RestfulServer {
    private static final long serialVersionUID = 1L;

    @Override
    protected void initialize() throws ServletException {
        initializeHapiFhir();
    }

    private void initializeHapiFhir() {
        this.setFhirContext(FhirContext.forDstu3());
        this.setDefaultPrettyPrint(true);
        this.setDefaultResponseEncoding(EncodingEnum.JSON);

        setResourceProviders(Collections.emptyList());
    }
}
