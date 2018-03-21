package gov.medicaid.api.transformers;

import ca.uhn.fhir.rest.server.exceptions.InvalidRequestException;
import org.hl7.fhir.dstu3.model.Task;

import java.util.function.Function;

public class EnrollmentStatusToPsmName implements Function<String, String> {
    private static final String INVALID_STATUS_CODE_MESSAGE =
            "Invalid task status code. Must be one of 'draft'," +
            " 'requested', 'rejected', or 'accepted'.";

    @Override
    public String apply(String s) {
        if (Task.TaskStatus.DRAFT.toCode().equalsIgnoreCase(s)) {
            return "Draft";
        } else if (Task.TaskStatus.REQUESTED.toCode().equalsIgnoreCase(s)) {
            return "Pending";
        } else if (Task.TaskStatus.REJECTED.toCode().equalsIgnoreCase(s)) {
            return "Rejected";
        } else if (Task.TaskStatus.ACCEPTED.toCode().equalsIgnoreCase(s)) {
            return "Approved";
        } else {
            throw new InvalidRequestException(INVALID_STATUS_CODE_MESSAGE);
        }
    }
}
