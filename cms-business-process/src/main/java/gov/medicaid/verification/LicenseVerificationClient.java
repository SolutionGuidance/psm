/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.verification;

import gov.medicaid.binders.XMLUtility;
import gov.medicaid.domain.model.LicenseType;
import gov.medicaid.domain.model.LicenseVerificationRequest;
import gov.medicaid.domain.model.LicenseVerificationResponse;
import gov.medicaid.domain.model.LicenseVerificationSearchResultType;
import gov.medicaid.domain.model.ObjectFactory;
import gov.medicaid.domain.model.ProviderInformationType;
import gov.medicaid.domain.rules.inference.LicenseLookupConfiguration;

import java.io.IOException;
import java.io.StringReader;
import java.io.StringWriter;

import javax.xml.bind.JAXBContext;
import javax.xml.bind.JAXBException;
import javax.xml.bind.Marshaller;
import javax.xml.bind.Unmarshaller;
import javax.xml.transform.TransformerException;

/**
 * Used to verify a license from an external service.
 *
 * @author TCSASSEMBLER
 * @version 1.0
 */
public class LicenseVerificationClient extends BaseSOAPClient {

    /**
     * The license lookup configuration.
     */
    private final LicenseLookupConfiguration config;

    /**
     * Assigns the given values to the field with the same name.
     * @param config the lookup configuration
     */
    public LicenseVerificationClient(LicenseLookupConfiguration config) {
        super(config.getRequestTranslationFile(), config.getResponseTranslationFile());
        this.config = config;
    }

    /**
     * Performs license search.
     * @param provider the provider
     * @param licenseType the license type
     * @return mock result
     * @throws JAXBException for marshalling errors
     * @throws TransformerException  for transformation errors
     * @throws IOException for read/write errors
     */
    public LicenseVerificationSearchResultType verify(ProviderInformationType provider, LicenseType licenseType)
        throws JAXBException, IOException, TransformerException {

        ObjectFactory factory = new ObjectFactory();
        LicenseVerificationRequest request = factory.createLicenseVerificationRequest();
        request.setProviderInformation(provider);
        request.setLicenseType(licenseType);
        JAXBContext context = JAXBContext.newInstance("gov.medicaid.domain.model");
        Marshaller m = context.createMarshaller();
        StringWriter sw = new StringWriter();
        m.marshal(request, sw);

        String response = invoke(config.getServiceEndPoint(), sw.toString());

        Unmarshaller um = context.createUnmarshaller();
        LicenseVerificationResponse result = (LicenseVerificationResponse) um.unmarshal(new StringReader(response));
        LicenseVerificationSearchResultType results = new LicenseVerificationSearchResultType();
        results.setLicenseObjectId(licenseType.getObjectId());
        results.setStatus(XMLUtility.newStatus("SUCCESS"));
        results.setSearchResults(result.getOutput().getSearchResults());
        return results;
    }
}
