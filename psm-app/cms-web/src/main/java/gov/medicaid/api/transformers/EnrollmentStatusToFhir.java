package gov.medicaid.api.transformers;

import gov.medicaid.entities.EnrollmentStatus;
import org.hl7.fhir.dstu3.model.Task;

import java.util.function.Function;

public class EnrollmentStatusToFhir
        implements Function<EnrollmentStatus, Task.TaskStatus> {
    @Override
    public Task.TaskStatus apply(EnrollmentStatus enrollmentStatus) {
        if (enrollmentStatus == null) {
            return Task.TaskStatus.NULL;
        }

        if ("Draft".equals(enrollmentStatus.getDescription())) {
            return Task.TaskStatus.DRAFT;
        } else if ("Pending".equals(enrollmentStatus.getDescription())) {
            return Task.TaskStatus.REQUESTED;
        } else if ("Rejected".equals(enrollmentStatus.getDescription())) {
            return Task.TaskStatus.REJECTED;
        } else if ("Approved".equals(enrollmentStatus.getDescription())) {
            return Task.TaskStatus.ACCEPTED;
        } else {
            return Task.TaskStatus.NULL;
        }
    }
}
