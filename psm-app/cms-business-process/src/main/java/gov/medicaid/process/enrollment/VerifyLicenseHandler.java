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

package gov.medicaid.process.enrollment;

import gov.medicaid.binders.XMLUtility;
import gov.medicaid.domain.model.EnrollmentProcess;
import gov.medicaid.domain.model.FacilityCredentialsType;
import gov.medicaid.domain.model.LicenseInformationType;
import gov.medicaid.domain.model.LicenseType;
import gov.medicaid.domain.model.LicenseVerificationSearchResultType;
import gov.medicaid.domain.model.NameValuePairType;
import gov.medicaid.domain.model.PropertyListType;
import gov.medicaid.domain.model.ProviderInformationType;
import gov.medicaid.domain.model.ScreeningResultType;
import gov.medicaid.domain.model.ScreeningResultsType;
import gov.medicaid.domain.model.SearchResultItemType;
import gov.medicaid.domain.model.SearchResultType;
import gov.medicaid.domain.rules.CMSKnowledgeUtility;
import gov.medicaid.domain.rules.inference.LicenseLookupConfiguration;
import gov.medicaid.domain.rules.inference.MatchStatus;
import gov.medicaid.services.CMSConfigurator;
import gov.medicaid.services.util.LogUtil;
import gov.medicaid.services.util.Util;
import gov.medicaid.verification.LicenseVerificationClient;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.xml.bind.JAXBException;
import javax.xml.transform.TransformerException;

import org.drools.runtime.StatefulKnowledgeSession;
import org.drools.runtime.process.WorkItem;
import org.drools.runtime.process.WorkItemManager;

import com.topcoder.util.log.Level;
import com.topcoder.util.log.Log;

/**
 * This handler is used to verify facility and individual licenses.
 *
 * @author TCSASSEMBLER
 * @version 1.0
 * @since External Sources Integration Assembly II
 */
public class VerifyLicenseHandler extends GenericHandler {

    /**
     * Class logger.
     */
    private Log log = LogUtil.getLog("VerifyLicenseHandler");

    /**
     * Executes verification of licenses and facility credentials.
     *
     * For each license/certification, the external source is determined by the {@link CMSKnowledgeUtility}. Given this
     * knowledge, the request is transformed and called through the <code>LicenseVerificationClient</code>, which
     * performs the SOAP call to the external sources web services. The screening result is then added back to the
     * process model.
     *
     * @param item the work item to abort
     * @param manager the work item manager
     */
    public void executeWorkItem(WorkItem item, WorkItemManager manager) {
        log.log(Level.INFO, "Verifying license and certifications.");
        EnrollmentProcess processModel = (EnrollmentProcess) item.getParameter("model");

        ProviderInformationType provider = XMLUtility.nsGetProvider(processModel);
        LicenseInformationType licenseInformation = XMLUtility.nsGetLicenseInformation(processModel);
        List<LicenseType> credentials = new ArrayList<LicenseType>();
        credentials.addAll(licenseInformation.getLicense());
        FacilityCredentialsType facilityLicenses = XMLUtility.nsGetFacilityCredentials(processModel);
        credentials.addAll(facilityLicenses.getLicense());

        ScreeningResultsType results = XMLUtility.nsGetScreeningResults(processModel);

        Map<String, LicenseLookupConfiguration> config = getConfiguration(provider.getProviderType(), credentials);
        for (LicenseType licenseType : credentials) {
            LicenseLookupConfiguration lookup = config.get(licenseType.getLicenseType());

            if ("Y".equals(lookup.getLookupSupported())) {
                log.log(Level.INFO, "Verifying license type " + licenseType.getLicenseType());

                ScreeningResultType licenseResult = new ScreeningResultType();
                licenseResult.setScreeningType("LICENSE VERIFICATION");
                licenseResult.setLicenseVerificationResult(verifyLicense(lookup, provider, licenseType));
                licenseResult.setStatus(XMLUtility.newStatus("SUCCESS"));
                results.getScreeningResult().add(licenseResult);
            } else {
                log.log(Level.INFO, "License " + licenseType.getLicenseType()
                    + " does not support automatic verification");
            }
        }
        item.getResults().put("model", processModel);
        manager.completeWorkItem(item.getId(), item.getResults());
    }

    /**
     * Retrieves the configuration of external sources for the licenses and certifications presented by the user.
     * @param providerType the provider type
     * @param licenses the licenses that were submitted
     * @return the configuration (per type) of the license
     */
    private Map<String, LicenseLookupConfiguration> getConfiguration(String providerType, List<LicenseType> licenses) {
        Map<String, LicenseLookupConfiguration> config = new HashMap<String, LicenseLookupConfiguration>();
        StatefulKnowledgeSession ksession = CMSKnowledgeUtility.newExternalSourcesConfigSession();
        ksession.setGlobal("appConfig", new CMSConfigurator());
        for (LicenseType licenseType : licenses) {
            LicenseLookupConfiguration lookup = new LicenseLookupConfiguration();
            lookup.setProviderType(providerType);
            lookup.setSpecialtyType(licenseType.getSpecialtyType());
            lookup.setLicenseType(licenseType.getLicenseType());
            lookup.setEnv(System.getProperty(Util.CMS_ENV, "TEST"));
            lookup.setIssuingState(licenseType.getIssuingState());
            config.put(licenseType.getLicenseType(), lookup);
            ksession.insert(lookup);
        }

        try {
            ksession.fireAllRules();
        } finally {
            ksession.dispose();
        }
        return config;
    }

    /**
     * Performs web service search.
     *
     * @param lookup the configuration
     * @param provider the provider
     * @param licenseType the license type
     * @return search result
     */
    private LicenseVerificationSearchResultType verifyLicense(LicenseLookupConfiguration lookup,
        ProviderInformationType provider, LicenseType licenseType) {
        LicenseVerificationSearchResultType results;
        try {
            LicenseVerificationClient client = new LicenseVerificationClient(lookup);
            results = client.verify(provider, licenseType);
            SearchResultType externalResults = results.getSearchResults();
            if (externalResults != null && !externalResults.getSearchResultItem().isEmpty()) {
                log.log(Level.INFO, "External service returned results, resolving exact match.");
                // multiple records, resolve any "REAL" match
                MatchStatus matchStatus = lookup.getMatcher().match(provider, licenseType, results);
                if (matchStatus == MatchStatus.EXACT_MATCH) {
                    licenseType.setVerified("Y");
                    populateStatus(licenseType, results.getSearchResults());
                    log.log(Level.INFO, "Resolving to an exact match.");
                } else {
                    licenseType.setVerified("N");
                    log.log(Level.INFO, "Cannot resolve exact match : " + matchStatus);
                }
            } else {
                log.log(Level.INFO, "External service returned no results.");
                licenseType.setVerified("N");
            }
        } catch (JAXBException e) {
            log.log(Level.ERROR, e);
            results = new LicenseVerificationSearchResultType();
            results.setLicenseObjectId(licenseType.getObjectId());
            results.setStatus(XMLUtility.newStatus("ERROR"));
        } catch (IOException e) {
            log.log(Level.ERROR, e);
            results = new LicenseVerificationSearchResultType();
            results.setLicenseObjectId(licenseType.getObjectId());
            results.setStatus(XMLUtility.newStatus("ERROR"));
        } catch (TransformerException e) {
            log.log(Level.ERROR, e);
            results = new LicenseVerificationSearchResultType();
            results.setLicenseObjectId(licenseType.getObjectId());
            results.setStatus(XMLUtility.newStatus("ERROR"));
        }
        return results;
    }

    /**
     * Populates the license status if present in the response.
     *
     * @param licenseType the license being tested
     * @param searchResults the search results
     */
    private void populateStatus(LicenseType licenseType, SearchResultType searchResults) {
        List<SearchResultItemType> items = searchResults.getSearchResultItem();
        if (items.size() > 1) {
            log.log(Level.INFO, "Cannot set license status because multiple results are present.");
            return;
        }
        for (SearchResultItemType searchResultItemType : items) {
            PropertyListType cols = searchResultItemType.getColumnData();
            List<NameValuePairType> nameValuePair = cols.getNameValuePair();
            for (NameValuePairType col : nameValuePair) {
                if (col.getName().equals("License Status")) {
                    log.log(Level.INFO, "Setting license status to: " + col.getValue());
                    licenseType.setStatus(col.getValue());
                    break;
                }
            }
        }
    }
}