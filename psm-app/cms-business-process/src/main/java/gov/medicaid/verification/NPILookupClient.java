/*
 * Copyright (C) 2013 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.verification;

import gov.medicaid.domain.model.ExternalSourcesScreeningResultType;
import gov.medicaid.domain.model.NPIVerificationRequest;
import gov.medicaid.domain.model.NPIVerificationResponse;
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
 * Used to lookup NPI.
 *
 * @author cyberjag
 * @version 1.0
 */
public class NPILookupClient extends BaseSOAPClient {

    /**
     * Assigns the given values to the field with the same name.
     */
    public NPILookupClient() {
        super("/xslt/npi_lookup_req.xsl", "/xslt/npi_lookup_res.xsl");
    }

    /**
     * Performs NPI number Lookup.
     *
     * @param provider
     *            the provider
     * @return the screening results
     * @throws JAXBException
     *             for marshalling errors
     * @throws TransformerException
     *             for transformation errors
     * @throws IOException
     *             for read/write errors
     */
    public ExternalSourcesScreeningResultType verify(ProviderInformationType provider) throws JAXBException,
            IOException, TransformerException {

        CMSConfigurator config = new CMSConfigurator();
        String endPoint = config.getExternalSourceBase() + "/cms-ext/ws/NPINumberLookupService";

        // Search step
        ObjectFactory factory = new ObjectFactory();
        NPIVerificationRequest request = factory.createNPIVerificationRequest();
        request.setProviderInformation(provider);
        JAXBContext context = JAXBContext.newInstance("gov.medicaid.domain.model");
        Marshaller m = context.createMarshaller();
        StringWriter sw = new StringWriter();
        m.marshal(request, sw);
        String response = invoke(endPoint, sw.toString());

        Unmarshaller um = context.createUnmarshaller();
        NPIVerificationResponse result = (NPIVerificationResponse) um.unmarshal(new StringReader(response));
        return result.getOutput();
    }
}
