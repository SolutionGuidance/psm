/*
 * Copyright (C) 2013 TopCoder Inc., All Rights Reserved.
 */

package gov.medicaid.verification;

import gov.medicaid.domain.model.ExternalSourcesScreeningResultType;
import gov.medicaid.domain.model.ObjectFactory;
import gov.medicaid.domain.model.ProviderInformationType;
import gov.medicaid.domain.model.SAMVerificationRequest;
import gov.medicaid.domain.model.SAMVerificationResponse;
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
 * @author cyberjag
 * @version 1.0
 */
public class SAMExclusionSearchClient extends BaseSOAPClient {

    /**
     * Assigns the given values to the field with the same name.
     */
    public SAMExclusionSearchClient() {
        super("/xslt/sam_search_req.xsl", "/xslt/sam_search_res.xsl");
    }

    /**
     * Performs SAM exclusion check, it is carried out in two steps, search and verification.
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
        String endPoint = config.getExternalSourceBase() + "/cms-ext/ws/SAMSearchService";

        // Search step
        ObjectFactory factory = new ObjectFactory();
        SAMVerificationRequest request = factory.createSAMVerificationRequest();
        request.setProviderInformation(provider);
        JAXBContext context = JAXBContext.newInstance("gov.medicaid.domain.model");
        Marshaller m = context.createMarshaller();
        StringWriter sw = new StringWriter();
        m.marshal(request, sw);
        String response = invoke(endPoint, sw.toString());

        Unmarshaller um = context.createUnmarshaller();
        SAMVerificationResponse result = (SAMVerificationResponse) um.unmarshal(new StringReader(response));
        return result.getOutput();
    }
}
