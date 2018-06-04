package gov.medicaid.api.transformers;

import gov.medicaid.entities.Affiliation;
import gov.medicaid.entities.Enrollment;
import gov.medicaid.entities.Entity;
import gov.medicaid.entities.Organization;
import org.hl7.fhir.dstu3.model.CodeableConcept;
import org.hl7.fhir.dstu3.model.BooleanType;
import org.hl7.fhir.dstu3.model.Task;
import java.util.List;

import java.util.function.Function;

public class EnrollmentAcceptsEftToFhir
        implements Function<Enrollment, Task.ParameterComponent> {
    @Override
    public Task.ParameterComponent apply(Enrollment enrollment) {
        boolean isEftAccepted = isEftAccepted(enrollment);
        return new Task.ParameterComponent(
                new CodeableConcept().setText("Accepts EFT"),
                new BooleanType(isEftAccepted)
        );
    }

    // If any primary affiliations accept EFT, this enrollment is considered
    // to accept EFT.
    private boolean isEftAccepted(Enrollment enrollment) {
        List<Affiliation> affiliations = enrollment.getDetails().getAffiliations();
        if (affiliations != null) {
            for (Affiliation affiliation : affiliations) {
                if ("Y".equals(affiliation.getPrimaryInd())) {
                    Entity entity = affiliation.getEntity();
                    if (entity instanceof Organization) {
                        if (((Organization) entity).isEftAccepted()) {
                            return true;
                        }
                    }
                }
            }
        }
        return false;
    }
}
