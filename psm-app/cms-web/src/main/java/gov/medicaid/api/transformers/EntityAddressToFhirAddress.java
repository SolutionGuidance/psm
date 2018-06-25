package gov.medicaid.api.transformers;

import gov.medicaid.entities.Address;

import java.util.function.Function;

public class EntityAddressToFhirAddress implements Function<Address, org.hl7.fhir.dstu3.model.Address> {
    @Override
    public org.hl7.fhir.dstu3.model.Address apply(Address address) {
        org.hl7.fhir.dstu3.model.Address fhirAddress = new org.hl7.fhir.dstu3.model.Address();
        if(address != null){
            fhirAddress.setState(address.getState());
            fhirAddress.setCity(address.getCity());
            fhirAddress.setPostalCode(address.getZipcode());
            fhirAddress.setDistrict(address.getCounty());
            fhirAddress.addLine(address.getLine1());
            fhirAddress.addLine(address.getLine2());
            fhirAddress.addLine(address.getAttentionTo());
        }
        return fhirAddress;
    }
}