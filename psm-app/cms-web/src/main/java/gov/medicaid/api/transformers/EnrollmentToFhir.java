package gov.medicaid.api.transformers;

import gov.medicaid.entities.Affiliation;
import gov.medicaid.entities.Enrollment;
import gov.medicaid.entities.dto.ViewStatics;
import org.hl7.fhir.dstu3.model.*;

import java.util.ArrayList;
import java.util.List;
import java.util.function.Function;

public class EnrollmentToFhir implements Function<Enrollment, Task> {
    @Override
    public Task apply(Enrollment enrollment) {
        DomainResource requester = new EntityToFhir().apply(
                enrollment.getDetails().getEntity()
        );

        if(requester instanceof Practitioner){
            ArrayList<Address> addresses = new ArrayList<>();
            EntityAddressToFhirAddress addressTranslator = new EntityAddressToFhirAddress();

            List<Affiliation> practitionerAffiliations = enrollment.getDetails().getAffiliations();
            for (Affiliation affiliation : practitionerAffiliations) {
                if (ViewStatics.DISCRIMINATOR_LOCATION.equals(affiliation.getObjectType())) {
                    Address affiliationAddress = addressTranslator.apply(affiliation.getEntity().getContactInformation().getAddress());
                    addresses.add(affiliationAddress);
                }
            }

            Practitioner practitioner = (Practitioner)requester;
            practitioner.setAddress(addresses);
            requester = practitioner;
        }

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
