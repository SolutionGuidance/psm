package gov.medicaid.api;

import ca.uhn.fhir.rest.annotation.IdParam;
import ca.uhn.fhir.rest.annotation.OptionalParam;
import ca.uhn.fhir.rest.annotation.Read;
import ca.uhn.fhir.rest.annotation.Search;
import ca.uhn.fhir.rest.param.StringOrListParam;
import ca.uhn.fhir.rest.param.StringParam;
import ca.uhn.fhir.rest.server.IResourceProvider;
import ca.uhn.fhir.rest.server.exceptions.InvalidRequestException;
import gov.medicaid.api.transformers.EnrollmentStatusToPsmName;
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
import java.util.Objects;
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
    public List<Task> search(
            @OptionalParam(name = "npi") String npi,
            @OptionalParam(name = "status") StringOrListParam statuses,
            @OptionalParam(name = "providerType") String providerType,
            @OptionalParam(name = "name") String name
    ) {
        validateNpi(npi);

        ProviderSearchCriteria criteria = new ProviderSearchCriteria();
        criteria.setNpi(npi);
        criteria.setStatuses(fhirStatusesToPsmStatusList(statuses));
        criteria.setProviderType(providerType);
        criteria.setProviderName(name);

        SearchResult<UserRequest> results = providerEnrollmentService.searchTickets(
                systemUser,
                criteria
        );

        return results.getItems()
                .stream()
                .map(result -> enrollmentIdToTask(result.getEnrollmentId()))
                .collect(Collectors.toList());
    }

    private void validateNpi(String npi) {
        if (npi == null) {
            return;
        }
        if (npi.matches("[0-9]{10}")) {
            return;
        }

        throw new InvalidRequestException(
                "An NPI must be 10 digits."
        );
    }

    private List<String> fhirStatusesToPsmStatusList(StringOrListParam listParam) {
        if (listParam == null) {
            return null;
        } else {
            return listParam.getValuesAsQueryTokens()
                    .stream()
                    .map(StringParam::getValue)
                    .map(new EnrollmentStatusToPsmName())
                    .filter(Objects::nonNull)
                    .collect(Collectors.toList());
        }
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
