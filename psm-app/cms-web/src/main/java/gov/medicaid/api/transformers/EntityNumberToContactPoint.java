package gov.medicaid.api.transformers;

import org.hl7.fhir.dstu3.model.ContactPoint;

import java.util.function.Function;

public class EntityNumberToContactPoint implements Function<String, ContactPoint> {
    @Override
    public ContactPoint apply(String number) {
        ContactPoint fhirNumber = new ContactPoint();
        fhirNumber.setValue(number);
        return fhirNumber;
    }
}
