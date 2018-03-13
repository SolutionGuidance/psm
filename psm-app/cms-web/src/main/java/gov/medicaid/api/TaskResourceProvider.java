package gov.medicaid.api;

import ca.uhn.fhir.rest.annotation.IdParam;
import ca.uhn.fhir.rest.annotation.Read;
import ca.uhn.fhir.rest.annotation.Search;
import ca.uhn.fhir.rest.server.IResourceProvider;
import gov.medicaid.api.transformers.EnrollmentToFhir;
import gov.medicaid.entities.CMSUser;
import gov.medicaid.entities.Enrollment;
import gov.medicaid.entities.ProviderSearchCriteria;
import gov.medicaid.entities.SearchResult;
import gov.medicaid.entities.UserRequest;
import gov.medicaid.services.CMSConfigurator;
import gov.medicaid.services.PortalServiceException;
import gov.medicaid.services.ProviderEnrollmentService;
import org.hl7.fhir.dstu3.model.IdType;
import org.hl7.fhir.dstu3.model.Task;
import org.hl7.fhir.instance.model.api.IBaseResource;

import java.util.List;
import java.util.stream.Collectors;

public class TaskResourceProvider implements IResourceProvider {
    private final ProviderEnrollmentService providerEnrollmentService;
    private final CMSUser systemUser;

    TaskResourceProvider(ProviderEnrollmentService providerEnrollmentService) {
        this.providerEnrollmentService = providerEnrollmentService;
        systemUser = new CMSConfigurator().getSystemUser();
    }

    @Override
    public Class<? extends IBaseResource> getResourceType() {
        return Task.class;
    }

    @Read
    public Task getResourceById(@IdParam IdType id) {
        return enrollmentIdToTask(id.getIdPartAsLong());
    }

    @Search
    public List<Task> findAll() throws PortalServiceException {
        ProviderSearchCriteria criteria = new ProviderSearchCriteria();
        SearchResult<UserRequest> results = providerEnrollmentService.searchTickets(
                systemUser,
                criteria
        );

        return results.getItems()
                .stream()
                .map(result -> enrollmentIdToTask(result.getTicketId()))
                .collect(Collectors.toList());
    }

    private Task enrollmentIdToTask(long enrollmentId) {
        Enrollment enrollment;
        try {
            enrollment = providerEnrollmentService.getTicketDetails(
                    systemUser,
                    enrollmentId
            );
        } catch (PortalServiceException e) {
            return null;
        }
        if (enrollment == null) {
            return null;
        }

        return new EnrollmentToFhir().apply(enrollment);
    }
}
