/*
 * Copyright 2018 The MITRE Corporation
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

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
