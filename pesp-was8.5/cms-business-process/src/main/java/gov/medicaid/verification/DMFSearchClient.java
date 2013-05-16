/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
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
        String endPoint = config.getExternalSourceBase() + "/services/DeathMasterServiceBean";

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
