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

import gov.medicaid.domain.model.ExternalSourcesScreeningResultType;
import gov.medicaid.domain.model.NameValuePairType;
import gov.medicaid.domain.model.OIGVerificationRequest;
import gov.medicaid.domain.model.ObjectFactory;
import gov.medicaid.domain.model.ProviderInformationType;
import gov.medicaid.domain.model.SearchResultItemType;
import gov.medicaid.domain.rules.inference.MatchStatus;
import gov.medicaid.domain.rules.inference.ResultMatchResolver;
import gov.medicaid.services.CMSConfigurator;
import gov.medicaid.services.util.LogUtil;

import java.io.IOException;
import java.io.StringWriter;
import java.util.List;

import javax.xml.bind.JAXBContext;
import javax.xml.bind.JAXBException;
import javax.xml.bind.Marshaller;
import javax.xml.transform.TransformerException;

import com.topcoder.util.log.Level;
import com.topcoder.util.log.Log;

/**
 * Uses a web service call to filter multiple search results into an exact match.
 * 
 * @author TCSASSEMBLER
 * @version 1.0
 */
public class OIGExclusionServiceMatcher extends BaseSOAPClient implements ResultMatchResolver {

    /**
     * Class logger.
     */
    private Log log = LogUtil.getLog("ExcludedProvidersScreeningHandler");

    /**
     * Assigns the given values to the field with the same name.
     */
    public OIGExclusionServiceMatcher() {
        super("/xslt/oig_verify_req.xsl", "/xslt/oig_verify_res.xsl");
    }

    /**
     * Performs OIG exclusion check, it is carried out in two steps, search and verification.
     * 
     * @param provider
     *            the provider
     * @param entityId
     *            the entity id returned by a search request
     * @return the screening results
     * @throws JAXBException
     *             for marshaling errors
     * @throws TransformerException
     *             for transformation errors
     * @throws IOException
     *             for read/write errors
     */
    public boolean verify(ProviderInformationType provider, String entityId) throws JAXBException, IOException,
            TransformerException {

        CMSConfigurator config = new CMSConfigurator();
        String endPoint = config.getExternalSourceBase() + "/cms-ext/ws/OIGService";

        // Search step
        ObjectFactory factory = new ObjectFactory();
        OIGVerificationRequest request = factory.createOIGVerificationRequest();
        request.setEntityId(entityId);
        request.setProviderInformation(provider);
        JAXBContext context = JAXBContext.newInstance("gov.medicaid.domain.model");
        Marshaller m = context.createMarshaller();
        StringWriter sw = new StringWriter();
        m.marshal(request, sw);
        String response = invoke(endPoint, sw.toString());
        return "true".equals(response.trim());
    }

    /**
     * This handles resolving specific matches from the external search results.
     * 
     * @param provider
     *            the applicant
     * @param object
     *            the object being verified
     * @param results
     *            the external search results
     * @return the match status
     */
    public MatchStatus match(ProviderInformationType provider, Object object, ExternalSourcesScreeningResultType results) {

        List<SearchResultItemType> list = results.getSearchResults().getSearchResultItem();
        if (provider.getApplicantInformation().getPersonalInformation() == null) {
            // no SSN for orgs so we cant call VERIFY SSN service
            if (list.isEmpty()) {
                return MatchStatus.NO_MATCH;
            } else {
                return MatchStatus.PARTIAL_MATCH;
            }
        }

        SearchResultItemType exactMatch = null;
        for (SearchResultItemType searchResultItemType : list) {
            List<NameValuePairType> cols = searchResultItemType.getColumnData().getNameValuePair();
            for (NameValuePairType col : cols) {
                if ("Entity ID".equals(col.getName())) {
                    try {
                        boolean exact = verify(provider, col.getValue());
                        if (exact) {
                            exactMatch = searchResultItemType;
                        }
                    } catch (JAXBException e) {
                        log.log(Level.ERROR, e);
                    } catch (IOException e) {
                        log.log(Level.ERROR, e);
                    } catch (TransformerException e) {
                        log.log(Level.ERROR, e);
                    }
                    break;
                }
            }
            if (exactMatch != null) {
                break;
            }
        }

        if (exactMatch != null) {
            results.getSearchResults().getSearchResultItem().clear();
            results.getSearchResults().getSearchResultItem().add(exactMatch);
            for (NameValuePairType col : exactMatch.getColumnData().getNameValuePair()) {
                if ("SSN/EIN Matched".equals(col.getName())) {
                    col.setValue("Yes");
                    break;
                }
            }
            return MatchStatus.EXACT_MATCH;
        } else if (list.isEmpty()) {
            return MatchStatus.NO_MATCH;
        } else {
            return MatchStatus.PARTIAL_MATCH;
        }
    }
}
