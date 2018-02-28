package gov.medicaid.api.transformers;

import gov.medicaid.entities.ProviderType;
import org.hl7.fhir.dstu3.model.CodeableConcept;
import org.hl7.fhir.dstu3.model.StringType;
import org.hl7.fhir.dstu3.model.Task;

import java.util.function.Function;

public class ProviderTypeToFhir
        implements Function<ProviderType, Task.ParameterComponent> {
    @Override
    public Task.ParameterComponent apply(ProviderType providerType) {
        return new Task.ParameterComponent(
                new CodeableConcept().setText("Provider Type"),
                new StringType(providerType.getDescription())
        );
    }
}
