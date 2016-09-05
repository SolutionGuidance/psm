/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.verification;

import gov.medicaid.domain.model.ExternalSourcesScreeningResultType;
import gov.medicaid.domain.model.OIGVerificationRequest;
import gov.medicaid.domain.model.OIGVerificationResponse;
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
 * Used to search for exclusion records for a provider.
 *
 * @author TCSASSEMBLER
 * @version 1.0
 */
public class OIGExclusionSearchClient extends BaseSOAPClient {

    /**
     * Assigns the given values to the field with the same name.
     */
    public OIGExclusionSearchClient() {
        super("/xslt/oig_search_req.xsl", "/xslt/oig_search_res.xsl");
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
        String endPoint = config.getExternalSourceBase() + "/services/OIGServiceBean";

        // Search step
        ObjectFactory factory = new ObjectFactory();
        OIGVerificationRequest request = factory.createOIGVerificationRequest();
        request.setProviderInformation(provider);
        JAXBContext context = JAXBContext.newInstance("gov.medicaid.domain.model");
        Marshaller m = context.createMarshaller();
        StringWriter sw = new StringWriter();
        m.marshal(request, sw);
        String response = invoke(endPoint, sw.toString());

        Unmarshaller um = context.createUnmarshaller();
        OIGVerificationResponse result = (OIGVerificationResponse) um.unmarshal(new StringReader(response));
        return result.getOutput();
    }
}
