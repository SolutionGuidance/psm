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

import com.topcoder.util.log.Level;
import com.topcoder.util.log.Log;
import gov.medicaid.domain.model.ExternalSourcesScreeningResultType;
import gov.medicaid.domain.model.NETStudyVerificationRequest;
import gov.medicaid.domain.model.NETStudyVerificationResponse;
import gov.medicaid.domain.model.ObjectFactory;
import gov.medicaid.domain.model.ProviderInformationType;
import gov.medicaid.domain.model.SearchResultItemType;
import gov.medicaid.domain.model.SearchResultType;
import gov.medicaid.services.CMSConfigurator;
import gov.medicaid.services.util.LogUtil;
import gov.medicaid.services.util.Util;

import javax.xml.bind.JAXBContext;
import javax.xml.bind.JAXBException;
import javax.xml.bind.Marshaller;
import javax.xml.bind.Unmarshaller;
import javax.xml.transform.TransformerException;
import java.io.IOException;
import java.io.StringReader;
import java.io.StringWriter;

/**
 * Used to verify SSN against the Death Master file records.
 *
 * @author TCSASSEMBLER
 * @version 1.0
 */
public class BackgroundStudyClient extends BaseSOAPClient {

    /**
     * Class logger.
     */
    private Log log = LogUtil.getLog("BackgroundStudyClient");

    /**
     * Assigns the given values to the field with the same name.
     */
    public BackgroundStudyClient() {
        super("/xslt/netstudy_req.xsl", "/xslt/netstudy_res.xsl");
    }

    /**
     * Performs a call to the NET study service to check the results of the entered ID.
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
        String endPoint = config.getExternalSourceBase() + "/cms-ext/ws/NETStudyService";

        // Search step
        ObjectFactory factory = new ObjectFactory();
        NETStudyVerificationRequest request = factory.createNETStudyVerificationRequest();
        request.setProviderInformation(provider);
        JAXBContext context = JAXBContext.newInstance("gov.medicaid.domain.model");
        Marshaller m = context.createMarshaller();
        StringWriter sw = new StringWriter();
        m.marshal(request, sw);
        String response = invoke(endPoint, sw.toString());

        Unmarshaller um = context.createUnmarshaller();
        NETStudyVerificationResponse result = (NETStudyVerificationResponse) um.unmarshal(new StringReader(response));
        SearchResultItemType r1 = result.getOutput().getSearchResults().getSearchResultItem().iterator().next();

        String raw = result.getRawResponse();
        if (raw == null || raw.trim().length() == 0) {
            // no external results
            ExternalSourcesScreeningResultType empty = new ExternalSourcesScreeningResultType();
            empty.setSearchResults(new SearchResultType());
            return empty;
        } else {
            // this should have been done by the service. but what can we do?
            String xml = Util.getStringInBetween(raw, "<string xmlns=\"DHS.NETStudyWebService\">", "</string>");
            xml = xml.replaceAll("\"xmlns", "\" xmlns"); // add space between attributes
            NETStudyVerificationResponse rawResults = (NETStudyVerificationResponse) um.unmarshal(new StringReader(
                transform("/xslt/netstudy_raw.xsl", xml)));
            SearchResultItemType r2 = rawResults.getOutput().getSearchResults().getSearchResultItem().iterator().next();
            // merge raw results
            r1.getColumnData().getNameValuePair().addAll(r2.getColumnData().getNameValuePair());
            result.setRawResponse(null); // not needed now that we have transformed it

            if (log.isEnabled(Level.INFO)) {
                sw = new StringWriter();
                m.marshal(result, sw);
                log.log(Level.INFO, sw.toString()); // finally! an XML we can actually process!
            }
        }

        return result.getOutput();
    }
}
