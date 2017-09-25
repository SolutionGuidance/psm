/*
 * Copyright (C) 2013 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.verification;

import gov.medicaid.domain.model.ExternalSourcesScreeningResultType;
import gov.medicaid.domain.model.NameValuePairType;
import gov.medicaid.domain.model.ObjectFactory;
import gov.medicaid.domain.model.ProviderInformationType;
import gov.medicaid.domain.model.SAMVerificationRequest;
import gov.medicaid.domain.model.SearchResultItemType;
import gov.medicaid.domain.rules.inference.MatchStatus;
import gov.medicaid.domain.rules.inference.ResultMatchResolver;
import gov.medicaid.services.CMSConfigurator;

import javax.xml.bind.JAXBContext;
import javax.xml.bind.JAXBException;
import javax.xml.bind.Marshaller;
import javax.xml.transform.TransformerException;
import java.io.IOException;
import java.io.StringWriter;
import java.util.List;
import java.util.logging.Logger;

/**
 * Uses a web service call to filter multiple search results into an exact match.
 * 
 * @author cyberjag
 * @version 1.0
 */
public class SAMExclusionServiceMatcher extends BaseSOAPClient implements ResultMatchResolver {
    private static final Logger LOGGER =
            Logger.getLogger(SAMExclusionServiceMatcher.class.getName());

    /**
     * Assigns the given values to the field with the same name.
     */
    public SAMExclusionServiceMatcher() {
        super("/xslt/sam_verify_req.xsl", "/xslt/sam_verify_res.xsl");
    }

    /**
     * Performs SAM exclusion check, it is carried out in two steps, search and verification.
     * 
     * @param provider
     *            the provider
     * @param name
     *            the provider name returned by a search request
     * @return the screening results
     * @throws JAXBException
     *             for marshaling errors
     * @throws TransformerException
     *             for transformation errors
     * @throws IOException
     *             for read/write errors
     */
    public boolean verify(ProviderInformationType provider, String name) throws JAXBException, IOException,
            TransformerException {

        CMSConfigurator config = new CMSConfigurator();
        String endPoint = config.getExternalSourceBase() + "/cms-ext/ws/SAMSearchService";

        // Search step
        ObjectFactory factory = new ObjectFactory();
        SAMVerificationRequest request = factory.createSAMVerificationRequest();
        request.setEntityId(name);
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
                if ("Provider Name".equals(col.getName())) {
                    try {
                        boolean exact = verify(provider, col.getValue());
                        if (exact) {
                            exactMatch = searchResultItemType;
                        }
                    } catch (JAXBException e) {
                        LOGGER.severe(e.toString());
                    } catch (IOException e) {
                        LOGGER.severe(e.toString());
                    } catch (TransformerException e) {
                        LOGGER.severe(e.toString());
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
