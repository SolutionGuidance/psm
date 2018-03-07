package gov.medicaid.api;

import ca.uhn.fhir.rest.annotation.IdParam;
import ca.uhn.fhir.rest.annotation.Read;
import ca.uhn.fhir.rest.server.IResourceProvider;
import gov.medicaid.api.transformers.EnrollmentToFhir;
import gov.medicaid.entities.Enrollment;
import gov.medicaid.services.CMSConfigurator;
import gov.medicaid.services.PortalServiceException;
import gov.medicaid.services.ProviderEnrollmentService;
import org.hl7.fhir.dstu3.model.IdType;
import org.hl7.fhir.dstu3.model.Task;
import org.hl7.fhir.instance.model.api.IBaseResource;

public class TaskResourceProvider implements IResourceProvider {
    private final ProviderEnrollmentService providerEnrollmentService;

    TaskResourceProvider(ProviderEnrollmentService providerEnrollmentService) {
        this.providerEnrollmentService = providerEnrollmentService;
    }

    @Override
    public Class<? extends IBaseResource> getResourceType() {
        return Task.class;
    }

    @Read
    public Task getResourceById(@IdParam IdType id) throws PortalServiceException {
        Enrollment enrollment = providerEnrollmentService.getTicketDetails(
                new CMSConfigurator().getSystemUser(),
                id.getIdPartAsLong()
        );
        if (enrollment == null) {
            return null;
        }

        return new EnrollmentToFhir().apply(enrollment);
    }
}
