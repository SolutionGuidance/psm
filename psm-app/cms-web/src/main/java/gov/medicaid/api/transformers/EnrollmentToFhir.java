package gov.medicaid.api.transformers;

import gov.medicaid.entities.Enrollment;
import org.hl7.fhir.dstu3.model.DomainResource;
import org.hl7.fhir.dstu3.model.Identifier;
import org.hl7.fhir.dstu3.model.Reference;
import org.hl7.fhir.dstu3.model.Task;

import java.util.function.Function;

public class EnrollmentToFhir implements Function<Enrollment, Task> {
    @Override
    public Task apply(Enrollment enrollment) {
        DomainResource requester = new EntityToFhir().apply(
                enrollment.getDetails().getEntity()
        );

        Task task = new Task();
        task.addIdentifier(getIdentifier(enrollment));
        task.setStatus(
                new EnrollmentStatusToFhir().apply(enrollment.getStatus())
        );
        task.setIntent(Task.TaskIntent.PROPOSAL);
        task.setRequester(new Task.TaskRequesterComponent(new Reference(requester)));
        task.addInput(
                new ProviderTypeToFhir().apply(
                        enrollment.getDetails().getEntity().getProviderType()
                )
        );
        task.addContained(requester);

        return task;
    }

    private Identifier getIdentifier(Enrollment enrollment) {
        return new Identifier()
                .setValue(Long.toString(enrollment.getTicketId()));
    }
}
