package gov.medicaid.api.transformers;

import org.hl7.fhir.dstu3.model.Address;

import java.util.function.Function;

public class EntityAddressToFhirAddress implements Function<gov.medicaid.entities.Address, Address> {
    @Override
    public Address apply(gov.medicaid.entities.Address address) {
        Address fhirAddress = new Address();
        if (address == null) {
            fhirAddress.setUse(Address.AddressUse.NULL);
            return fhirAddress;
        }
        fhirAddress.setState(address.getState());
        fhirAddress.setCity(address.getCity());
        fhirAddress.setPostalCode(address.getZipcode());
        fhirAddress.setDistrict(address.getCounty());
        fhirAddress.addLine(address.getLine1());
        fhirAddress.addLine(address.getLine2());
        fhirAddress.addLine(address.getAttentionTo());
        return fhirAddress;
    }
}
