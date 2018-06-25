package gov.medicaid.api.transformers;

import gov.medicaid.entities.Enrollment;
import org.hl7.fhir.dstu3.model.DomainResource;
import org.hl7.fhir.dstu3.model.Reference;
import org.hl7.fhir.dstu3.model.Task;
import java.util.function.Function;

public class EnrollmentToFhir implements Function<Enrollment, Task> {
    @Override
    public Task apply(Enrollment enrollment) {
        DomainResource requester = new ProviderProfileToFhir().apply(
                enrollment.getDetails()
        );

        Task task = new Task();
        task.setId(Long.toString(enrollment.getTicketId()));
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

        task.addInput(
                new EnrollmentAcceptsEftToFhir().apply(enrollment)
        );

        task.addContained(requester);

        return task;
    }
}
