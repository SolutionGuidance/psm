/*
 * Copyright 2012-2013 TopCoder, Inc.
 *
 * This code was developed under U.S. government contract NNH10CD71C.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * You may not use this file except in compliance with the License.
 * You may obtain a copy of the License at:
 *     http://www.apache.org/licenses/LICENSE-2.0
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package gov.medicaid.verification;

import gov.medicaid.domain.model.DMFVerificationRequest;
import gov.medicaid.domain.model.DMFVerificationResponse;
import gov.medicaid.domain.model.ExternalSourcesScreeningResultType;
import gov.medicaid.domain.model.ObjectFactory;
import gov.medicaid.domain.model.ProviderInformationType;
import gov.medicaid.services.CMSConfigurator;

import java.io.IOException;
import java.io.StringReader;
import java.io.StringWriter;

import javax.xml.bind.JAXBContext;
import javax.xml.bind.JAXBException;
import javax.xml.bind.Marshaller;
import javax.xml.bind.Unmarshaller;
import javax.xml.transform.TransformerException;

/**
 * Used to verify SSN against the Death Master file records.
 *
 * @author TCSASSEMBLER
 * @version 1.0
 */
public class DMFSearchClient extends BaseSOAPClient {

    /**
     * Assigns the given values to the field with the same name.
     */
    public DMFSearchClient() {
        super("/xslt/dmf_req.xsl", "/xslt/dmf_res.xsl");
    }

    /**
     * Performs OIG exclusion check, it is carried out in two steps, search and verification.
     *
     * @param provider the provider
     * @return the screening results
     * @throws JAXBException for marshalling errors
     * @throws TransformerException  for transformation errors
     * @throws IOException for read/write errors
     */
    public ExternalSourcesScreeningResultType verify(ProviderInformationType provider)
        throws JAXBException, IOException, TransformerException {

        CMSConfigurator config = new CMSConfigurator();
        String endPoint = config.getExternalSourceBase() + "/cms-ext/ws/DeathMasterService";

        // Search step
        ObjectFactory factory = new ObjectFactory();
        DMFVerificationRequest request = factory.createDMFVerificationRequest();
        request.setProviderInformation(provider);
        JAXBContext context = JAXBContext.newInstance("gov.medicaid.domain.model");
        Marshaller m = context.createMarshaller();
        StringWriter sw = new StringWriter();
        m.marshal(request, sw);
        String response = invoke(endPoint, sw.toString());

        Unmarshaller um = context.createUnmarshaller();
        DMFVerificationResponse result = (DMFVerificationResponse) um.unmarshal(new StringReader(response));
        return result.getOutput();
    }
}
