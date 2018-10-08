/*
 * Copyright 2012, 2013 TopCoder, Inc.
 * Copyright 2018 The MITRE Corporation
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package gov.medicaid.domain.rules;

import gov.medicaid.domain.model.ReservationNames;
import gov.medicaid.domain.rules.inference.LookupEntry;
import gov.medicaid.entities.AgreementDocument;
import gov.medicaid.entities.EntityStructureType;
import gov.medicaid.entities.IssuingBoard;
import gov.medicaid.entities.dto.ViewStatics;
import gov.medicaid.services.CMSConfigurator;
import gov.medicaid.services.LookupService;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

/**
 * This class is responsible for loading all lookup values to be used by the rules.
 *
 * <p>
 * <b>v1.4 - Provider Application Drools Front End Validation Part 4</b>
 * <ul>
 * <li>added new provider types and licenses</li>
 * </ul>
 * </p>
 * <p>
 * <b>v1.5 - Provider Application Drools Front End Validation Part 5</b>
 * <ul>
 * <li>added new provider types and licenses</li>
 * <li>added new EntityType and EDITradingPartnerType</li>
 * </ul>
 * </p>
 */
public class GlobalLookups {

    /**
     * Single instance of the lookups.
     */
    private static GlobalLookups instance = new GlobalLookups();

    /**
     * Map of all provider types.
     */
    private final Map<String, String> providerTypes;

    /**
     * Map of all license codes.
     */
    private final Map<String, String> licenseCodes;

    /**
     * Map of all tribal codes.
     */
    private final Map<String, String> tribalCodes;

    /**
     * Map of all entity types.
     */
    private final Map<String, String> entityTypes;

    /**
     * Map of all EDI sub types.
     */
    private final Map<String, String> ediTradingPartnerTypes;

    /**
     * Map of all MnSCU codes.
     */
    private final Map<String, String> mnSCUCodes;

    /**
     * Map of all PO BOX matches.
     */
    private final Map<String, String> poboxRegex;

    /**
     * All lookup entries for the rules.
     */
    private final List<LookupEntry> allEntries;

    /**
     * Lookup service.
     */
    private final LookupService lookupService;

    /**
     * These should be integrated to the portal services.
     * http://apps.topcoder.com/forums/?module=Thread&threadID=764919&start=0&mc=1#1618336
     */
    private GlobalLookups() {
        CMSConfigurator config = new CMSConfigurator();
        lookupService = config.getLookupService();
        ArrayList<LookupEntry> entries = new ArrayList<LookupEntry>();
        providerTypes = initProviderTypes(entries);
        initRequiredAgreements(entries);
        initIssuingBoards(entries);
        licenseCodes = initLicenseCodes(entries);
        tribalCodes = initTribalCodes(entries);
        mnSCUCodes = initMnSCUCodes(entries);
        poboxRegex = initPoboxRegex(entries);
        entityTypes = initEntityTypes(entries);
        ediTradingPartnerTypes = initEDISubTypes(entries);
        allEntries = Collections.unmodifiableList(entries);
    }

    /**
     * Initializes the required agreement documents.
     * @param entries the current entries.
     */
    private void initRequiredAgreements(ArrayList<LookupEntry> entries) {
        List<gov.medicaid.entities.ProviderType> all = lookupService
            .findAllLookups(gov.medicaid.entities.ProviderType.class);

        for (gov.medicaid.entities.ProviderType providerType : all) {
            for (AgreementDocument document : providerType.getAgreementDocuments()) {
                entries.add(new LookupEntry("RequiredAgreement", providerType.getDescription(), document.getTitle()));
            }
        }
    }

    /**
     * Initializes the issuing boards.
     * @param entries the current entries.
     */
    private void initIssuingBoards(ArrayList<LookupEntry> entries) {
        List<gov.medicaid.entities.ProviderType> all = lookupService
            .findAllLookups(gov.medicaid.entities.ProviderType.class);

        for (gov.medicaid.entities.ProviderType providerType : all) {
            List<IssuingBoard> boards = lookupService.findRelatedLookup(IssuingBoard.class,
                providerType.getCode(), ViewStatics.REL_SPECIALTY_BOARD_OPTIONS);
            for (IssuingBoard board : boards) {
                String type = providerType.getDescription();
                String description = board.getDescription();
                LookupEntry entry = new LookupEntry("IssuingBoardOption", type, description);
                entries.add(entry);
            }
        }
    }

    /**
     * Initializes the code value pair of EDI sub types.
     *
     * @param entries all code value pair entries to be referenced by the rules
     * @return code value lookup of EDI sub types.
     */
    private Map<String, String> initEDISubTypes(ArrayList<LookupEntry> entries) {
        HashMap<String, String> types = new HashMap<String, String>();
        types.put("1", "Billing Agent");
        types.put("2", "Eligibility Verification Vendor");
        types.put("3", "Consolidated Billing Agent");
        types.put("4", "Health Care Data Trading Partner");
        types.put("5", "Medicare Carrier");
        types.put("6", "Mental Health Information System Grantee");
        types.put("7", "MN Health Insurance Exchange Carrier");
        for (Entry<String, String> entry : types.entrySet()) {
            entries.add(new LookupEntry("EDITradingPartnerType", entry.getKey(), entry.getValue()));
        }
        return Collections.unmodifiableMap(types);
    }

    /**
     * Initializes the code value pair of entity types.
     *
     * @param entries all code value pair entries to be referenced by the rules
     * @return code value lookup of entity types.
     */
    private Map<String, String> initEntityTypes(ArrayList<LookupEntry> entries) {
        HashMap<String, String> types = new HashMap<String, String>();
        List<EntityStructureType> all = lookupService.findAllLookups(EntityStructureType.class);
        for (EntityStructureType structure : all) {
            types.put(structure.getCode(), structure.getDescription());
        }
        for (Entry<String, String> entry : types.entrySet()) {
            entries.add(new LookupEntry("EntityType", entry.getKey(), entry.getValue()));
        }
        return Collections.unmodifiableMap(types);
    }

    /**
     * Initializes the code value pair of provider types.
     *
     * @param entries all code value pair entries to be referenced by the rules
     * @return code value lookup of provider types.
     */
    private Map<String, String> initProviderTypes(ArrayList<LookupEntry> entries) {
        HashMap<String, String> types = new HashMap<String, String>();

        List<gov.medicaid.entities.ProviderType> all = lookupService
            .findAllLookups(gov.medicaid.entities.ProviderType.class);

        for (gov.medicaid.entities.ProviderType providerType : all) {
            types.put(providerType.getCode(), providerType.getDescription());
        }

        for (Entry<String, String> entry : types.entrySet()) {
            entries.add(new LookupEntry("ProviderType", entry.getKey(), entry.getValue()));
        }
        return Collections.unmodifiableMap(types);
    }

    /**
     * Initializes the code value pair of license codes.
     *
     * @param entries all code value pair entries to be referenced by the rules
     * @return code value lookup of provider types.
     */
    private Map<String, String> initLicenseCodes(ArrayList<LookupEntry> entries) {
        HashMap<String, String> types = new HashMap<String, String>();

        List<gov.medicaid.entities.LicenseType> all = lookupService
            .findAllLookups(gov.medicaid.entities.LicenseType.class);

        for (gov.medicaid.entities.LicenseType type : all) {
            types.put(type.getCode(), type.getDescription());
        }

        for (Entry<String, String> entry : types.entrySet()) {
            entries.add(new LookupEntry("LicenseName", entry.getKey(), entry.getValue()));
        }
        return Collections.unmodifiableMap(types);
    }

    /**
     * Initializes the code value pair of tribal codes.
     *
     * @param entries all code value pair entries to be referenced by the rules
     * @return code value lookup of provider types.
     */
    private Map<String, String> initTribalCodes(ArrayList<LookupEntry> entries) {
        HashMap<String, String> types = new HashMap<String, String>();
        types.put("FL", ReservationNames.FOND_DU_LAC_INDIAN_RESERVATION.value());
        types.put("GP", ReservationNames.GRAND_PORTAGE_INDIAN_RESERVATION.value());
        types.put("LL", ReservationNames.LEECH_LAKE_INDIAN_RESERVATION.value());
        types.put("LS", ReservationNames.LOWER_SIOUX_INDIAN_RESERVATION.value());
        types.put("ML", ReservationNames.MILLE_LACS_INDIAN_RESERVATION.value());
        types.put("NL", ReservationNames.NET_LAKE_INDIAN_RESERVATION.value());
        types.put("PI", ReservationNames.PRAIRIE_ISLAND_INDIAN_RESERVATION.value());
        types.put("RL", ReservationNames.RED_LAKE_RESERVATION.value());
        types.put("US", ReservationNames.UPPER_SIOUX_INDIAN_RESERVATION.value());
        types.put("WE", ReservationNames.WHITE_EARTH_INDIAN_RESERVATION.value());
        for (Entry<String, String> entry : types.entrySet()) {
            entries.add(new LookupEntry("TribalCode", entry.getKey(), entry.getValue()));
        }
        return Collections.unmodifiableMap(types);
    }

    /**
     * Initializes the code value pair of MnSCU codes.
     *
     * @param entries all code value pair entries to be referenced by the rules
     * @return code value lookup of provider types.
     */
    private Map<String, String> initMnSCUCodes(ArrayList<LookupEntry> entries) {
        HashMap<String, String> types = new HashMap<String, String>();
        types.put("SA", "Summit Academy");
        types.put("IGCTC", "Inver Grove Community and Technical College");
        types.put("MCTC", "Minneapolis Community and Tech College");
        types.put("RCTC", "Rochester Community and Tech College");
        types.put("SCTM", "South Central Tech - Mankato");
        types.put("SCU", "St. Catherine University");
        types.put("NCTC", "Normandale Community and Tech College");
        for (Entry<String, String> entry : types.entrySet()) {
            entries.add(new LookupEntry("ApprovedMnSCU", entry.getKey(), entry.getValue()));
        }
        return Collections.unmodifiableMap(types);
    }

    /**
     * Initializes the regular expressions that match a P.O Box.
     *
     * @param entries all code value pair entries to be referenced by the rules
     * @return code value lookup of provider types.
     */
    private Map<String, String> initPoboxRegex(ArrayList<LookupEntry> entries) {
        HashMap<String, String> types = new HashMap<String, String>();
        types.put("POST OFFICE BOX", "(?i).*POST OFFICE BOX.*");
        types.put("PO BOX", "(?i).*PO BOX.*");
        types.put("PO BOX,", "(?i).*PO BOX,.*");
        types.put("POB", "(?i).*POB\\s.*");
        types.put("P O BOX", "(?i).*P O Box.*");
        types.put("P.O.BOX", "(?i).*P\\.O\\.BOX.*");
        types.put("P. O. BOX", "(?i).*P\\. O\\. BOX.*");
        for (Entry<String, String> entry : types.entrySet()) {
            entries.add(new LookupEntry("POBoxWordRegex", entry.getKey(), entry.getValue()));
        }
        return Collections.unmodifiableMap(types);
    }

    /**
     * Refreshes the lookups from the database.
     */
    public static void refresh() {
        synchronized (GlobalLookups.class) {
            instance = new GlobalLookups();
        }
    }

    /**
     * Retrieves the singleton lookup instance.
     *
     * @return the singleton instance
     */
    public static GlobalLookups getInstance() {
        // refresh();
        return instance;
    }

    /**
     * Retrieves all supported lookup entries for the rules.
     *
     * @return the list of lookup entries.
     */
    public List<LookupEntry> getAllLookupEntries() {
        return allEntries;
    }

    /**
     * Gets the value of the field <code>providerTypes</code>.
     *
     * @return the providerTypes
     */
    public Map<String, String> getProviderTypes() {
        return providerTypes;
    }

    /**
     * Gets the value of the field <code>licenseCodes</code>.
     *
     * @return the licenseCodes
     */
    public Map<String, String> getLicenseCodes() {
        return licenseCodes;
    }

    /**
     * Gets the value of the field <code>tribalCodes</code>.
     *
     * @return the tribalCodes
     */
    public Map<String, String> getTribalCodes() {
        return tribalCodes;
    }

    /**
     * Gets the value of the field <code>mnSCUCodes</code>.
     *
     * @return the mnSCUCodes
     */
    public Map<String, String> getMnSCUCodes() {
        return mnSCUCodes;
    }

    /**
     * Gets the value of the field <code>poboxRegex</code>.
     *
     * @return the poboxRegex
     */
    public Map<String, String> getPoboxRegex() {
        return poboxRegex;
    }

    /**
     * Gets the value of the field <code>entityTypes</code>.
     *
     * @return the entityTypes
     */
    public Map<String, String> getEntityTypes() {
        return entityTypes;
    }

    /**
     * Gets the value of the field <code>ediTradingPartnerTypes</code>.
     *
     * @return the ediTradingPartnerTypes
     */
    public Map<String, String> getEdiTradingPartnerTypes() {
        return ediTradingPartnerTypes;
    }
}
