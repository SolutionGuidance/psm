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
package gov.medicaid.domain.rules.inference;

/**
 * This is a container for license lookup configurations.
 *
 * @author TCSASSEMBLER
 * @version 1.0
 */
public class LicenseLookupConfiguration {

    /**
     * Default match resolver.
     */
    private static final ResultMatchResolver DEFAULT_MATCHER = new ProviderNameMatcher();

    /**
     * The configuration region (TEST/PROD).
     */
    private String env;

    /**
     * The provider type.
     */
    private String providerType;

    /**
     * The specialty type.
     */
    private String specialtyType;

    /**
     * The license type.
     */
    private String licenseType;

    /**
     * The issuing state.
     */
    private String issuingState;

    /**
     * Will be set by the rules to Y if a license lookup is supported for this type.
     */
    private String lookupSupported;

    /**
     * Will be set by the rules to the service end point.
     */
    private String serviceEndPoint;

    /**
     * Will be set by the rules to the request XSLT resource path.
     */
    private String requestTranslationFile;

    /**
     * Will be set by the rules to the response XSLT resource path.
     */
    private String responseTranslationFile;

    /**
     * Matches the results.
     */
    private ResultMatchResolver matcher;

    /**
     * Empty constructor.
     */
    public LicenseLookupConfiguration() {
    }

    /**
     * Gets the value of the field <code>licenseType</code>.
     *
     * @return the licenseType
     */
    public String getLicenseType() {
        return licenseType;
    }

    /**
     * Sets the value of the field <code>licenseType</code>.
     *
     * @param licenseType the licenseType to set
     */
    public void setLicenseType(String licenseType) {
        this.licenseType = licenseType;
    }

    /**
     * Gets the value of the field <code>lookupSupported</code>.
     *
     * @return the lookupSupported
     */
    public String getLookupSupported() {
        return lookupSupported;
    }

    /**
     * Sets the value of the field <code>lookupSupported</code>.
     *
     * @param lookupSupported the lookupSupported to set
     */
    public void setLookupSupported(String lookupSupported) {
        this.lookupSupported = lookupSupported;
    }

    /**
     * Gets the value of the field <code>serviceEndPoint</code>.
     *
     * @return the serviceEndPoint
     */
    public String getServiceEndPoint() {
        return serviceEndPoint;
    }

    /**
     * Sets the value of the field <code>serviceEndPoint</code>.
     *
     * @param serviceEndPoint the serviceEndPoint to set
     */
    public void setServiceEndPoint(String serviceEndPoint) {
        this.serviceEndPoint = serviceEndPoint;
    }

    /**
     * Gets the value of the field <code>requestTranslationFile</code>.
     *
     * @return the requestTranslationFile
     */
    public String getRequestTranslationFile() {
        return requestTranslationFile;
    }

    /**
     * Sets the value of the field <code>requestTranslationFile</code>.
     *
     * @param requestTranslationFile the requestTranslationFile to set
     */
    public void setRequestTranslationFile(String requestTranslationFile) {
        this.requestTranslationFile = requestTranslationFile;
    }

    /**
     * Gets the value of the field <code>responseTranslationFile</code>.
     *
     * @return the responseTranslationFile
     */
    public String getResponseTranslationFile() {
        return responseTranslationFile;
    }

    /**
     * Sets the value of the field <code>responseTranslationFile</code>.
     *
     * @param responseTranslationFile the responseTranslationFile to set
     */
    public void setResponseTranslationFile(String responseTranslationFile) {
        this.responseTranslationFile = responseTranslationFile;
    }

    /**
     * Gets the value of the field <code>issuingState</code>.
     * @return the issuingState
     */
    public String getIssuingState() {
        return issuingState;
    }

    /**
     * Sets the value of the field <code>issuingState</code>.
     * @param issuingState the issuingState to set
     */
    public void setIssuingState(String issuingState) {
        this.issuingState = issuingState;
    }

    /**
     * Gets the value of the field <code>env</code>.
     * @return the env
     */
    public String getEnv() {
        return env;
    }

    /**
     * Sets the value of the field <code>env</code>.
     * @param env the env to set
     */
    public void setEnv(String env) {
        this.env = env;
    }

    /**
     * Gets the value of the field <code>matcher</code>.
     * @return the matcher
     */
    public ResultMatchResolver getMatcher() {
        if (matcher == null) {
            return DEFAULT_MATCHER;
        }
        return matcher;
    }

    /**
     * Sets the value of the field <code>matcher</code>.
     * @param matcher the matcher to set
     */
    public void setMatcher(ResultMatchResolver matcher) {
        this.matcher = matcher;
    }

    /**
     * Gets the value of the field <code>specialtyType</code>.
     * @return the specialtyType
     */
    public String getSpecialtyType() {
        return specialtyType;
    }

    /**
     * Sets the value of the field <code>specialtyType</code>.
     * @param specialtyType the specialtyType to set
     */
    public void setSpecialtyType(String specialtyType) {
        this.specialtyType = specialtyType;
    }

    /**
     * Gets the value of the field <code>providerType</code>.
     * @return the providerType
     */
    public String getProviderType() {
        return providerType;
    }

    /**
     * Sets the value of the field <code>providerType</code>.
     * @param providerType the providerType to set
     */
    public void setProviderType(String providerType) {
        this.providerType = providerType;
    }
}
