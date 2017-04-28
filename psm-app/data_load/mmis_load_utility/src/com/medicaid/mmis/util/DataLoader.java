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
package com.medicaid.mmis.util;

import gov.medicaid.domain.model.ApplicantType;
import gov.medicaid.entities.AcceptedAgreements;
import gov.medicaid.entities.Address;
import gov.medicaid.entities.Affiliation;
import gov.medicaid.entities.Asset;
import gov.medicaid.entities.BeneficialOwner;
import gov.medicaid.entities.BeneficialOwnerType;
import gov.medicaid.entities.CMSUser;
import gov.medicaid.entities.CategoryOfService;
import gov.medicaid.entities.ContactInformation;
import gov.medicaid.entities.CountyType;
import gov.medicaid.entities.Degree;
import gov.medicaid.entities.DesignatedContact;
import gov.medicaid.entities.DesignatedContactType;
import gov.medicaid.entities.Document;
import gov.medicaid.entities.Enrollment;
import gov.medicaid.entities.EnrollmentStatus;
import gov.medicaid.entities.Entity;
import gov.medicaid.entities.IssuingBoard;
import gov.medicaid.entities.License;
import gov.medicaid.entities.LicenseStatus;
import gov.medicaid.entities.LicenseType;
import gov.medicaid.entities.Organization;
import gov.medicaid.entities.OrganizationBeneficialOwner;
import gov.medicaid.entities.OwnershipInformation;
import gov.medicaid.entities.OwnershipType;
import gov.medicaid.entities.Person;
import gov.medicaid.entities.PersonBeneficialOwner;
import gov.medicaid.entities.ProviderCategoryOfService;
import gov.medicaid.entities.ProviderProfile;
import gov.medicaid.entities.ProviderType;
import gov.medicaid.entities.RiskLevel;
import gov.medicaid.entities.Role;
import gov.medicaid.entities.SpecialtyType;
import gov.medicaid.entities.SystemId;
import gov.medicaid.entities.dto.ViewStatics;
import gov.medicaid.process.enrollment.sync.ColumnDef;
import gov.medicaid.services.LookupService;
import gov.medicaid.services.PortalServiceException;
import gov.medicaid.services.impl.LookupServiceBean;
import gov.medicaid.services.impl.ProviderEnrollmentServiceBean;
import gov.medicaid.services.impl.SequenceGeneratorBean;
import gov.medicaid.services.util.Util;

import java.io.BufferedReader;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

/**
 * This is the data loader implementation.
 * 
 * @author TCSASSEMBLER
 * @version 1.0
 */
public class DataLoader {

    /**
     * Words that are considered part of the last name if found as the 2nd to the last token.
     */
    private static final List<String> SURNAME_PREFIX = Arrays.asList("VAN", "VON", "LA", "LE","DE");

    /**
     * Beneficial owner type mapping name.
     */
    private static final String XREF_OWNER_TYPE = "BEN_OWNER_TYPE";

    /**
     * The logger.
     */
    private static Logger logger;

    /**
     * COS Mapping.
     */
    private static final String XREF_COS = "COS";

    /**
     * Code value external mapping.
     */
    private static final String XREF_COUNTY = "COUNTY_CODE";

    /**
     * Code value external mapping.
     */
    private static final String XREF_OWNERSHIP_TYPE = "OWNERSHIP_TYPE";

    /**
     * Code value external mapping.
     */
    private static final String XREF_PROVIDER_TYPE = "PROVIDER_TYPE";

    /**
     * Code value external mapping.
     */
    private static final String XREF_ISSUING_BOARD = "ISSUING_BOARD";

    /**
     * Code value external mapping.
     */
    private static final String XREF_LICENSE_TYPE = "LICENSE_TYPE";

    /**
     * Code value external mapping.
     */
    private static final String XREF_SPECIALTY_CODE = "SPECIALTY_CODE";

    /**
     * Code value external mapping.
     */
    private static final String XREF_RISK_LEVEL = "RISK_LEVEL";

    /**
     * Code value external mapping.
     */
    private static final String XREF_ENROLLMENT_STATUS = "ENROLLMENT_STATUS";

    /**
     * License status.
     */
    private static final String XREF_LICENSE_STATUS = "LICENSE_STATUS";

    /**
     * Lookup service for code values.
     */
    private LookupService lookup;

    /**
     * The enrollment service.
     */
    private ProviderEnrollmentServiceBean enrollmentService;

    /**
     * Empty constructor.
     */
    public DataLoader() {
    }

    /**
     * Exports the provider file.
     * 
     * @param enrollment the enrollment to be exported
     * @return the exported file
     * @throws PortalServiceException for any errors encountered
     */
    public byte[] readProviderFile(ByteArrayInputStream stream) throws PortalServiceException {
        Enrollment enrollment = new Enrollment();
        ProviderProfile profile = new ProviderProfile();
        profile.setAttachments(new ArrayList<Document>());
        profile.setAgreements(new ArrayList<AcceptedAgreements>());

        enrollment.setDetails(profile);
        String legacyId = readWS000EXTENTITY(stream, enrollment);

        StringBuilder sb = new StringBuilder();
        readWS000EXTOWNINFO(stream, profile);
        readWS000EXTOWNASSET(stream, profile);
        readWS000EXTPROVPROFILE(stream, enrollment);
        readWS000EXTCONTINFO(stream, enrollment);
        readWS000EXTPRACTICEADDR(stream, enrollment);
        readWS000EXTBILLADDR(stream, enrollment);
        readWS000EXTLIC(stream, enrollment);
        readWS000EXTCOS(stream, enrollment);

        boolean purged = enrollmentService.purgeLegacyRecord(legacyId);
        if (purged) {
            logger.warn("The legacy record will be replaced overwritten (ticket/audit will remain).");
        }
        enrollmentService.importProfile(getSystemUser(), SystemId.MN_ITS, profile);
        return sb.toString().getBytes();
    }

    private static CMSUser getSystemUser() {
        CMSUser cmsUser = new CMSUser();
        cmsUser.setUserId("SYSTEM");
        cmsUser.setUsername("system");
        Role role = new Role();
        role.setDescription("System Administrator");
        role.setCode("R4");
        cmsUser.setRole(role);
        return cmsUser;
    }

    /**
     * <pre>
     * 002270    05  WS-000-EXT2-OWN-BEN.                               
     * 002280      10  WS-000-EXT2-OWN-B-PROV-ID     PIC X(09) VALUE ' '. 
     * 002290      10  WS-000-EXT2-OWN-B-NPI         PIC X(10) VALUE ' '.  
     * 002300      10  WS-000-EXT2-OWN-B-INT-PCT     PIC S9(03)V VALUE 0.   
     * 002310      10  WS-000-EXT2-OWN-B-BIRTH-DATE  PIC X(10) VALUE ' '.
     * 002320      10  WS-000-EXT2-OWN-B-HIRE-DATE   PIC X(10) VALUE ' '.
     * 002330      10  WS-000-EXT2-OWN-B-M-NAME      PIC X(35) VALUE ' '.
     * 002340      10  WS-000-EXT2-OWN-B-F-NAME      PIC X(35) VALUE ' '.
     * 002350      10  WS-000-EXT2-OWN-B-L-NAME      PIC X(35) VALUE ' '.
     * 002360      10  WS-000-EXT2-OWN-B-SSN         PIC X(09) VALUE ' '.
     * 002370      10  WS-000-EXT2-OWN-B-ROLE-IND-1  PIC X(01) VALUE ' '.
     * 002380      10  WS-000-EXT2-OWN-B-ROLE-IND-2  PIC X(01) VALUE ' '.  
     * 002390      10  WS-000-EXT2-OWN-B-ROLE-IND-3  PIC X(01) VALUE ' '.  
     * 002400      10  WS-000-EXT2-OWN-B-ROLE-IND-4  PIC X(01) VALUE ' '.  
     * 002410      10  WS-000-EXT2-OWN-B-FEIN        PIC X(09) VALUE ' '.
     * </pre>
     * 
     * @return
     * @throws PortalServiceException for any errors encounterd
     */
    public Map<String, OwnershipInformation> readWS000EXT2OWNBEN(ByteArrayInputStream stream)
        throws PortalServiceException {
        String strWS_000_EXT_ENTITY_PROV_ID = readField(stream, ColumnDef.WS_000_EXT_ENTITY_PROV_ID);
        String strWS_000_EXT_ENTITY_NPI = readField(stream, ColumnDef.WS_000_EXT_ENTITY_NPI);
        logger.trace("Adding ownership info for NPI " + strWS_000_EXT_ENTITY_NPI);

        String strWS_000_EXT2_OWN_B_INT_PCT = readField(stream, ColumnDef.WS_000_EXT2_OWN_B_INT_PCT);
        String strWS_000_EXT2_OWN_B_BIRTH_DATE = readField(stream, ColumnDef.WS_000_EXT2_OWN_B_BIRTH_DATE);
        String strWS_000_EXT2_OWN_B_HIRE_DATE = readField(stream, ColumnDef.WS_000_EXT2_OWN_B_HIRE_DATE);
        String strWS_000_EXT2_OWN_B_M_NAME = readField(stream, ColumnDef.WS_000_EXT2_OWN_B_M_NAME);
        String strWS_000_EXT2_OWN_B_F_NAME = readField(stream, ColumnDef.WS_000_EXT2_OWN_B_F_NAME);
        String strWS_000_EXT2_OWN_B_L_NAME = readField(stream, ColumnDef.WS_000_EXT2_OWN_B_L_NAME);
        String strWS_000_EXT2_OWN_B_SSN = readField(stream, ColumnDef.WS_000_EXT2_OWN_B_SSN);
        String strWS_000_EXT2_OWN_B_ROLE_IND_1 = readField(stream, ColumnDef.WS_000_EXT2_OWN_B_ROLE_IND_1);
        readField(stream, ColumnDef.WS_000_EXT2_OWN_B_ROLE_IND_2);
        readField(stream, ColumnDef.WS_000_EXT2_OWN_B_ROLE_IND_3);
        readField(stream, ColumnDef.WS_000_EXT2_OWN_B_ROLE_IND_4);
        String strWS_000_EXT2_OWN_B_FEIN = readField(stream, ColumnDef.WS_000_EXT2_OWN_B_FEIN);

        BeneficialOwner owner = null;
        if (Util.isNotBlank(strWS_000_EXT2_OWN_B_SSN)) {
            owner = new PersonBeneficialOwner();
            PersonBeneficialOwner person = (PersonBeneficialOwner) owner;
            owner.setOwnershipInterest(parseBigDecimal(strWS_000_EXT2_OWN_B_INT_PCT));
            person.setDob(parseDate(strWS_000_EXT2_OWN_B_BIRTH_DATE));
            person.setHireDate(parseDate(strWS_000_EXT2_OWN_B_HIRE_DATE));

            parseFullnameToOwnerName(person, strWS_000_EXT2_OWN_B_L_NAME);
            // if (StringUtils.isNotBlank(strWS_000_EXT2_OWN_B_L_NAME)) {
            // person.setMiddleName(strWS_000_EXT2_OWN_B_M_NAME);
            // person.setFirstName(strWS_000_EXT2_OWN_B_F_NAME);
            // }
            // person.setLastName(strWS_000_EXT2_OWN_B_L_NAME);
            person.setSsn(strWS_000_EXT2_OWN_B_SSN);
        } else {
            owner = new OrganizationBeneficialOwner();
            OrganizationBeneficialOwner org = (OrganizationBeneficialOwner) owner;
            org.setFein(strWS_000_EXT2_OWN_B_FEIN);
            org.setLegalName(strWS_000_EXT2_OWN_B_L_NAME);
        }

        String internalCode = doLegacyMapping(strWS_000_EXT2_OWN_B_ROLE_IND_1, XREF_OWNER_TYPE);
        owner.setType(lookup.findLookupByCode(BeneficialOwnerType.class, internalCode));

        String key = strWS_000_EXT_ENTITY_PROV_ID;
        OwnershipInformation ownershipInformation = new OwnershipInformation();
        ownershipInformation.setBeneficialOwners(new ArrayList<BeneficialOwner>());
        ownershipInformation.getBeneficialOwners().add(owner);
        Map<String, OwnershipInformation> ownerMap = new HashMap<String, OwnershipInformation>();
        ownerMap.put(key, ownershipInformation);
        return ownerMap;
    }

    /**
     * Parses the names and sets it to the owner.
     * @param person the person to set to
     * @param fullname the full name
     */
    private void parseFullnameToOwnerName(PersonBeneficialOwner person, String fullname) {
        if (StringUtils.isBlank(fullname)) {
            return;
        }
        String[] tokens = fullname.split(" ");
        if (tokens.length == 1) { // we can only set the last name
            person.setLastName(tokens[0]);
        } else if (tokens.length > 1) { // first name, last name
            for (int index = tokens.length - 1; index > -1; index--) {
                if (index == tokens.length - 1) {
                    // last word always part of the last name
                    person.setLastName(tokens[index]);
                } else if (index == tokens.length - 2 && SURNAME_PREFIX.contains(tokens[index])) {
                    person.setLastName(tokens[index] + " " + person.getLastName());
                } else if (index == 0) {
                    person.setFirstName(tokens[index]);
                } else {
                    person.setMiddleName((tokens[index] + " " + StringUtils.defaultString(person.getMiddleName())).trim());
                }
            }
        }
    }

    private BigDecimal parseBigDecimal(String value) {
        if (StringUtils.isBlank(value)) {
            return null;
        }
        try {
            return new BigDecimal(value);
        } catch (NumberFormatException nfe) {
            logger.debug("Cannot convert to ownership pct: " + value);
            return null;
        }
    }

    /**
     * <pre>
     * 002190    05  WS-000-EXT-COS.                                               
     * 002200      10  WS-000-EXT-COS-ARRAY OCCURS 20 TIMES.                       
     * 002210        15  WS-000-EXT-COS-START-DATE   PIC X(10) VALUE ' '.  
     * 002220        15  WS-000-EXT-COS-END-DATE     PIC X(10) VALUE ' '.  
     * 002230        15  WS-000-EXT-COS-ARRAY OCCURS 60 TIMES.
     * 002240          20  WS-000-EXT-COS-CODE       PIC X(03) VALUE ' '.
     * </pre>
     * 
     * @throws PortalServiceException for any errors encountered
     */
    private void readWS000EXTCOS(ByteArrayInputStream stream, Enrollment enrollment) throws PortalServiceException {
        ProviderProfile profile = enrollment.getDetails();
        List<ProviderCategoryOfService> cos = new ArrayList<ProviderCategoryOfService>();
        for (int i = 0; i < 20; i++) {
            String strWS_000_EXT_COS_START_DATE = readField(stream, ColumnDef.WS_000_EXT_COS_START_DATE);
            String strWS_000_EXT_COS_END_DATE = readField(stream, ColumnDef.WS_000_EXT_COS_END_DATE);
            if (areAllBlank(strWS_000_EXT_COS_END_DATE, strWS_000_EXT_COS_START_DATE)) {
                continue;
            }

            ProviderCategoryOfService c1 = new ProviderCategoryOfService();
            c1.setCategories(new ArrayList<CategoryOfService>());
            for (int j = 0; j < 60; j++) {
                String strWS_000_EXT_COS_CODE = readField(stream, ColumnDef.WS_000_EXT_COS_CODE);
                String internalCos = doLegacyMapping(strWS_000_EXT_COS_CODE, XREF_COS);
                if (StringUtils.isNotBlank(strWS_000_EXT_COS_CODE)) {
                    CategoryOfService categoryOfService = lookup.findLookupByCode(CategoryOfService.class, internalCos);
                    if (categoryOfService != null) {
                        c1.getCategories().add(categoryOfService);
                    } else {
                        logger.warn("Unrecognized COS code: " + strWS_000_EXT_COS_CODE);
                    }
                }
            }
            cos.add(c1);
        }
        profile.setCategoriesOfServiceTypes(cos);
    }

    /**
     * <pre>
     * 002090    05  WS-000-EXT-LIC.                                                
     * 002100      10  WS-000-EXT-LIC-ARRAY OCCURS 112 TIMES.                      
     * 002110        15  WS-000-EXT-LIC-SPEC-TYPE    PIC X(02) VALUE ' '.
     * 002120        15  WS-000-EXT-LIC-TYPE         PIC X(02) VALUE ' '.
     * 002130        15  WS-000-EXT-LIC-NBR          PIC X(13) VALUE ' '. 
     * 002140        15  WS-000-EXT-LIC-BEG-DATE     PIC X(10) VALUE ' '.  
     * 002150        15  WS-000-EXT-LIC-END-DATE     PIC X(10) VALUE ' '.  
     * 002160        15  WS-000-EXT-LIC-STATE        PIC X(02) VALUE ' '.  
     * 002170        15  WS-000-EXT-LIC-STAT         PIC X(01) VALUE ' '.
     * 002180        15  WS-000-EXT-LIC-ISSUE-BRD    PIC X(09) VALUE ' '.
     * </pre>
     * 
     * @throws PortalServiceException for any errors encountered
     */
    private void readWS000EXTLIC(ByteArrayInputStream stream, Enrollment enrollment) throws PortalServiceException {
        ProviderProfile profile = enrollment.getDetails();
        List<License> certifications = profile.getCertifications();
        if (certifications == null) {
            certifications = new ArrayList<License>();
            profile.setCertifications(certifications);
        }
        for (int i = 0; i < 112; i++) {
            String strWS_000_EXT_LIC_SPEC_TYPE = readField(stream, ColumnDef.WS_000_EXT_LIC_SPEC_TYPE);
            String strWS_000_EXT_LIC_TYPE = readField(stream, ColumnDef.WS_000_EXT_LIC_TYPE);
            String strWS_000_EXT_LIC_NBR = readField(stream, ColumnDef.WS_000_EXT_LIC_NBR);
            String strWS_000_EXT_LIC_BEG_DATE = readField(stream, ColumnDef.WS_000_EXT_LIC_BEG_DATE);
            String strWS_000_EXT_LIC_END_DATE = readField(stream, ColumnDef.WS_000_EXT_LIC_END_DATE);
            String strWS_000_EXT_LIC_STATE = readField(stream, ColumnDef.WS_000_EXT_LIC_STATE);
            String strWS_000_EXT_LIC_STAT = readField(stream, ColumnDef.WS_000_EXT_LIC_STAT);
            String strWS_000_EXT_LIC_ISSUE_BRD = readField(stream, ColumnDef.WS_000_EXT_LIC_ISSUE_BRD);

            if (areAllBlank(strWS_000_EXT_LIC_SPEC_TYPE, strWS_000_EXT_LIC_TYPE, strWS_000_EXT_LIC_NBR,
                strWS_000_EXT_LIC_BEG_DATE, strWS_000_EXT_LIC_END_DATE, strWS_000_EXT_LIC_STATE,
                strWS_000_EXT_LIC_STAT, strWS_000_EXT_LIC_ISSUE_BRD)) {
                continue;
            }

            License license = new License();

            if (StringUtils.isNotBlank(strWS_000_EXT_LIC_SPEC_TYPE)) {
                license.setObjectType(ViewStatics.DISCRIMINATOR_SPECIALTY);
                String internalCode = doLegacyMapping(strWS_000_EXT_LIC_SPEC_TYPE, XREF_SPECIALTY_CODE);
                license.setSpecialty(lookup.findLookupByCode(SpecialtyType.class, internalCode));
                if (license.getSpecialty() != null) {
                    // if there is a tribe certificate, then set resv flag to Y
                    if ("TC".equals(license.getSpecialty().getSubCategory())) {
                        license.setObjectType(ViewStatics.DISCRIMINATOR_TRIBE);
                        profile.setWorksOnReservationInd("Y");
                    }
                }
            } else {
                license.setObjectType(ViewStatics.DISCRIMINATOR_LICENSE);
                String internalCode = doLegacyMapping(strWS_000_EXT_LIC_SPEC_TYPE, XREF_LICENSE_TYPE);
                license.setType(lookup.findLookupByCode(LicenseType.class, internalCode));
            }
            license.setLicenseNumber(strWS_000_EXT_LIC_NBR);
            license.setOriginalIssueDate(parseDate(strWS_000_EXT_LIC_BEG_DATE));
            license.setRenewalEndDate(parseDate(strWS_000_EXT_LIC_END_DATE));
            license.setIssuingUSState(strWS_000_EXT_LIC_STATE);

            String statusCode = doLegacyMapping(strWS_000_EXT_LIC_STAT, XREF_LICENSE_STATUS);
            license.setStatus(lookup.findLookupByCode(LicenseStatus.class, statusCode));

            String board = doLegacyMapping(strWS_000_EXT_LIC_STAT, XREF_ISSUING_BOARD);
            license.setIssuingBoard(lookup.findLookupByCode(IssuingBoard.class, board));

            certifications.add(license);
        }
    }

    /**
     * <pre>
     * 002020    05  WS-000-EXT-BILL-ADDR.                               
     * 002030      10  WS-000-EXT-BILL-ADDR-1        PIC X(28) VALUE ' '. 
     * 002040      10  WS-000-EXT-BILL-ADDR-2        PIC X(28) VALUE ' '. 
     * 002050      10  WS-000-EXT-BILL-ADDR-CITY     PIC X(18) VALUE ' '. 
     * 002060      10  WS-000-EXT-BILL-ADDR-STATE    PIC X(02) VALUE ' '.  
     * 002070      10  WS-000-EXT-BILL-ADDR-ZIP      PIC X(05) VALUE ' '. 
     * 002080      10  WS-000-EXT-BILL-ADDR-COUNTY   PIC X(30) VALUE ' '.
     * </pre>
     * 
     * @throws PortalServiceException for any errors encountered
     */
    private void readWS000EXTBILLADDR(ByteArrayInputStream stream, Enrollment enrollment) throws PortalServiceException {
        ProviderProfile profile = enrollment.getDetails();
        Entity entity = profile.getEntity();
        boolean isPerson = entity instanceof Person;
        Organization practice = getPrimaryPractice(profile, entity);
        if (isPerson) {
            if (practice != null) {
                practice.setBillingAddress(readAddress(stream));
            } else {
                // cannot use address as there is not practice
                readAddress(stream);
            }
        } else {
            ((Organization) entity).setBillingAddress(readAddress(stream));
        }
    }

    /**
     * <pre>
     * 001950    05  WS-000-EXT-PRACTICE-ADDR.
     * 001960      10  WS-000-EXT-PRAC-ADDR-1        PIC X(28) VALUE ' '. 
     * 001970      10  WS-000-EXT-PRAC-ADDR-2        PIC X(28) VALUE ' '. 
     * 001980      10  WS-000-EXT-PRAC-ADDR-CITY     PIC X(18) VALUE ' '. 
     * 001990      10  WS-000-EXT-PRAC-ADDR-STATE    PIC X(02) VALUE ' '.  
     * 002000      10  WS-000-EXT-PRAC-ADDR-ZIP      PIC X(05) VALUE ' '. 
     * 002010      10  WS-000-EXT-PRAC-ADDR-COUNTY   PIC X(30) VALUE ' '.
     * </pre>
     * 
     * @throws PortalServiceException for any errors encountered
     */
    private void readWS000EXTPRACTICEADDR(ByteArrayInputStream stream, Enrollment enrollment)
        throws PortalServiceException {
        ProviderProfile profile = enrollment.getDetails();
        Entity entity = profile.getEntity();
        boolean isPerson = entity instanceof Person;
        Organization practice = getPrimaryPractice(profile, entity);
        if (isPerson && practice != null) {
            if (practice.getContactInformation() == null) {
                practice.setContactInformation(new ContactInformation());
            }
            practice.getContactInformation().setAddress(readAddress(stream));
        } else {
            if (entity.getContactInformation() == null) {
                entity.setContactInformation(new ContactInformation());
            }
            entity.getContactInformation().setAddress(readAddress(stream));
        }
    }

    /**
     * Finds the primary practice for the given profile.
     * 
     * @param profile the profile
     * @param entity the profile entity
     * @return the primary practice if it exists
     */
    private Organization getPrimaryPractice(ProviderProfile profile, Entity entity) {
        Organization practice = null;
        if (entity instanceof Person) {
            List<Affiliation> affiliations = profile.getAffiliations();
            for (Affiliation affiliation : affiliations) {
                if (ViewStatics.DISCRIMINATOR_LOCATION.equals(affiliation.getObjectType())
                    && "Y".equals(affiliation.getPrimaryInd())) {
                    practice = (Organization) affiliation.getEntity();
                }
            }
        }
        return practice;
    }

    /**
     * Exports the given address.
     * 
     * @param stream the current buffer
     * @param address the address to be exported
     * @throws PortalServiceException for any errors encountered
     */
    private Address readAddress(ByteArrayInputStream stream) throws PortalServiceException {
        String strWS_000_EXT_PRAC_ADDR_1 = readField(stream, ColumnDef.WS_000_EXT_PRAC_ADDR_1);
        String strWS_000_EXT_PRAC_ADDR_2 = readField(stream, ColumnDef.WS_000_EXT_PRAC_ADDR_2);
        String strWS_000_EXT_PRAC_ADDR_CITY = readField(stream, ColumnDef.WS_000_EXT_PRAC_ADDR_CITY);
        String strWS_000_EXT_PRAC_ADDR_STATE = readField(stream, ColumnDef.WS_000_EXT_PRAC_ADDR_STATE);
        String strWS_000_EXT_PRAC_ADDR_ZIP = readField(stream, ColumnDef.WS_000_EXT_PRAC_ADDR_ZIP);
        String strWS_000_EXT_PRAC_ADDR_COUNTY = readField(stream, ColumnDef.WS_000_EXT_PRAC_ADDR_COUNTY);

        if (!areAllBlank(strWS_000_EXT_PRAC_ADDR_1, strWS_000_EXT_PRAC_ADDR_2, strWS_000_EXT_PRAC_ADDR_CITY,
            strWS_000_EXT_PRAC_ADDR_COUNTY, strWS_000_EXT_PRAC_ADDR_ZIP)) {
            Address address = new Address();
            address.setLine1(strWS_000_EXT_PRAC_ADDR_1);
            address.setLine2(strWS_000_EXT_PRAC_ADDR_2);
            address.setCity(strWS_000_EXT_PRAC_ADDR_CITY);
            address.setState(strWS_000_EXT_PRAC_ADDR_STATE);
            address.setCounty(strWS_000_EXT_PRAC_ADDR_COUNTY);
            address.setZipcode(strWS_000_EXT_PRAC_ADDR_ZIP);
            return address;
        }
        return null;
    }

    private boolean areAllBlank(String... values) {
        for (String string : values) {
            if (StringUtils.isNotBlank(string)) {
                return false;
            }
        }
        return true;
    }

    /**
     * <pre>
     * 001910    05  WS-000-EXT-CONT-INFO.                                
     * 001920      10  WS-000-EXT-CONT-I-PHONE       PIC X(10) VALUE ' '. 
     * 001930      10  WS-000-EXT-CONT-I-FAX         PIC X(10) VALUE ' '. 
     * 001940      10  WS-000-EXT-CONT-I-EMAIL       PIC X(70) VALUE ' '.
     * </pre>
     * 
     * @throws PortalServiceException for any errors encountered
     */
    private void readWS000EXTCONTINFO(ByteArrayInputStream stream, Enrollment enrollment) throws PortalServiceException {
        ProviderProfile profile = enrollment.getDetails();
        Entity entity = profile.getEntity();

        boolean isPerson = entity instanceof Person;
        Organization practice = getPrimaryPractice(profile, entity);
        DesignatedContact designatedContact = findDesignatedContact(profile);

        String strWS_000_EXT_CONT_I_PHONE = readField(stream, ColumnDef.WS_000_EXT_CONT_I_PHONE);
        String strWS_000_EXT_CONT_I_FAX = readField(stream, ColumnDef.WS_000_EXT_CONT_I_FAX);
        String strWS_000_EXT_CONT_I_EMAIL = readField(stream, ColumnDef.WS_000_EXT_CONT_I_EMAIL);

        if (isPerson) {
            if (practice != null) {
                if (practice.getContactInformation() == null) {
                    practice.setContactInformation(new ContactInformation());
                }

                // use practice location phone numbers
                practice.getContactInformation().setPhoneNumber(strWS_000_EXT_CONT_I_PHONE);
                practice.getContactInformation().setFaxNumber(strWS_000_EXT_CONT_I_FAX);
            } else {
                // use residential information (home based?)
                if (entity.getContactInformation() == null) {
                    entity.setContactInformation(new ContactInformation());
                }
                entity.getContactInformation().setPhoneNumber(strWS_000_EXT_CONT_I_PHONE);
                entity.getContactInformation().setFaxNumber(strWS_000_EXT_CONT_I_FAX);
            }

            if (entity.getContactInformation() == null) {
                entity.setContactInformation(new ContactInformation());
            }
            entity.getContactInformation().setEmail(strWS_000_EXT_CONT_I_EMAIL);
        } else {
            if (designatedContact != null) {
                if (designatedContact.getPerson().getContactInformation() == null) {
                    designatedContact.getPerson().setContactInformation(new ContactInformation());
                }
                designatedContact.getPerson().getContactInformation().setPhoneNumber(strWS_000_EXT_CONT_I_PHONE);
                designatedContact.getPerson().getContactInformation().setFaxNumber(strWS_000_EXT_CONT_I_FAX);
                designatedContact.getPerson().getContactInformation().setEmail(strWS_000_EXT_CONT_I_EMAIL);
            } else {
                if (entity.getContactInformation() == null) {
                    entity.setContactInformation(new ContactInformation());
                }

                // default to organization location
                entity.getContactInformation().setPhoneNumber(strWS_000_EXT_CONT_I_PHONE);
                entity.getContactInformation().setFaxNumber(strWS_000_EXT_CONT_I_FAX);
                entity.getContactInformation().setEmail(strWS_000_EXT_CONT_I_EMAIL);
            }
        }
    }

    /**
     * Finds the designated contact for the profile
     * 
     * @param profile the profile
     * @return the designated contact person if it exists
     */
    private DesignatedContact findDesignatedContact(ProviderProfile profile) {
        List<DesignatedContact> contacts = profile.getDesignatedContacts();
        if (contacts == null) {
            return null;
        }
        for (DesignatedContact designatedContact : contacts) {
            if (designatedContact.getType() == DesignatedContactType.ENROLLMENT) {
                return designatedContact;
            }
        }
        // default to the first designated contact (agencies?)
        return contacts.isEmpty() ? null : contacts.get(0);
    }

    /**
     * <pre>
     * 001840    05  WS-000-EXT-PROV-PROFILE.                                      
     * 001850      10  WS-000-EXT-PROV-P-ARRAY OCCURS 12 TIMES.
     * 001860        15  WS-000-EXT-PROV-P-E-STAT-DT PIC X(10) VALUE ' '.  
     * 001870        15  WS-000-EXT-PROV-P-ENRL-STAT PIC X(01) VALUE ' '.
     * 001880      10  WS-000-EXT-PROV-P-RESV-IND    PIC X(01) VALUE ' '.  
     * 001890      10  WS-000-EXT-PROV-P-CO-CODE     PIC X(03) VALUE ' '.
     * 001900      10  WS-000-EXT-PROV-P-RISK-LVL    PIC X(01) VALUE ' '.
     * </pre>
     * 
     * @throws PortalServiceException for any errors encountered
     */
    private void readWS000EXTPROVPROFILE(ByteArrayInputStream stream, Enrollment enrollment)
        throws PortalServiceException {
        String strWS_000_EXT_PROV_P_E_STAT_DT = readField(stream, ColumnDef.WS_000_EXT_PROV_P_E_STAT_DT);
        String strWS_000_EXT_PROV_P_ENRL_STAT = readField(stream, ColumnDef.WS_000_EXT_PROV_P_ENRL_STAT);
        enrollment.setStatusDate(parseDate(strWS_000_EXT_PROV_P_E_STAT_DT));
        String status = doLegacyMapping(strWS_000_EXT_PROV_P_ENRL_STAT, XREF_ENROLLMENT_STATUS);
        if (status != null) {
            enrollment.setStatus(lookup.findLookupByCode(EnrollmentStatus.class, status));
        }

        for (int i = 0; i < 11; i++) {
            // just read status histories, no need to copy to front-end
            readField(stream, ColumnDef.WS_000_EXT_PROV_P_E_STAT_DT);
            readField(stream, ColumnDef.WS_000_EXT_PROV_P_ENRL_STAT);
        }

        String strWS_000_EXT_PROV_P_RESV_IND = readField(stream, ColumnDef.WS_000_EXT_PROV_P_RESV_IND);
        String strWS_000_EXT_PROV_P_CO_CODE = readField(stream, ColumnDef.WS_000_EXT_PROV_P_CO_CODE);
        String strWS_000_EXT_PROV_P_RISK_LVL = readField(stream, ColumnDef.WS_000_EXT_PROV_P_RISK_LVL);

        ProviderProfile profile = enrollment.getDetails();
        profile.setWorksOnReservationInd(strWS_000_EXT_PROV_P_RESV_IND);
        profile.setCounty(strWS_000_EXT_PROV_P_CO_CODE);
        String riskLevelCd = doLegacyMapping(strWS_000_EXT_PROV_P_RISK_LVL, XREF_RISK_LEVEL);
        RiskLevel riskLevel = lookup.findLookupByCode(RiskLevel.class, riskLevelCd);
        profile.setRiskLevel(riskLevel);
    }

    /**
     * <pre>
     * 001800    05  WS-000-EXT-OWN-ASSET.                               
     * 001810      10  WS-000-EXT-OWN-A-ARRAY OCCURS 25 TIMES.                     
     * 001820        15  WS-000-EXT-OWN-A-BCKGRD-NAM PIC X(35) VALUE ' '.    
     * 001830        15  WS-000-EXT-OWN-A-BCKGRD-OWN PIC X(01) VALUE ' '.
     * </pre>
     * 
     * @throws PortalServiceException for any errors encountered
     */
    private void readWS000EXTOWNASSET(ByteArrayInputStream stream, ProviderProfile profile)
        throws PortalServiceException {
        OwnershipInformation ownershipInformation = profile.getOwnershipInformation();
        if (ownershipInformation == null) {
            ownershipInformation = new OwnershipInformation();
            profile.setOwnershipInformation(ownershipInformation);
        }
        if (ownershipInformation.getAssets() == null) {
            ownershipInformation.setAssets(new ArrayList<Asset>());
        }

        for (int i = 0; i < 25; i++) {
            String strWS_000_EXT_OWN_A_BCKGRD_NAM = readField(stream, ColumnDef.WS_000_EXT_OWN_A_BCKGRD_NAM);
            String strWS_000_EXT_OWN_A_BCKGRD_OWN = readField(stream, ColumnDef.WS_000_EXT_OWN_A_BCKGRD_OWN);

            if (!StringUtils.isBlank(strWS_000_EXT_OWN_A_BCKGRD_OWN)
                || !StringUtils.isBlank(strWS_000_EXT_OWN_A_BCKGRD_NAM)) {
                Asset asset = new Asset();
                asset.setName(strWS_000_EXT_OWN_A_BCKGRD_NAM);
                String code = doLegacyMapping(strWS_000_EXT_OWN_A_BCKGRD_OWN, XREF_OWNERSHIP_TYPE);
                if (code == null) {
                    logger.warn("Uknown ownership type code: " + code);
                }
                OwnershipType ownershipType = lookup.findLookupByCode(OwnershipType.class, code);
                asset.setOwnershipType(ownershipType);
                ownershipInformation.getAssets().add(asset);
            }
        }
    }

    /**
     * <pre>
     * 001780    05  WS-000-EXT-OWN-INFO.                                          
     * 001790      10  WS-000-EXT-OWN-I-OWNER        PIC X(01) VALUE ' '.
     * </pre>
     * 
     * @throws PortalServiceException for any errors encountered.
     */
    private void readWS000EXTOWNINFO(ByteArrayInputStream stream, ProviderProfile profile)
        throws PortalServiceException {
        String strWS_000_EXT_OWN_I_OWNER = readField(stream, ColumnDef.WS_000_EXT_OWN_I_OWNER);
        profile.setMaintainsOwnPrivatePractice(StringUtils.defaultIfEmpty(strWS_000_EXT_OWN_I_OWNER, "N"));
    }

    /**
     * <pre>
     * 001600    05  WS-000-EXT-ENTITY.                                             
     * 001610      10  WS-000-EXT-ENTITY-PROV-ID     PIC X(09) VALUE ' '.
     * 001620      10  WS-000-EXT-ENTITY-NPI         PIC X(10) VALUE ' '.  
     * 001630      10  WS-000-EXT-ENTITY-NAME        PIC X(35) VALUE ' '.
     * 001640      10  WS-000-EXT-ENTITY-LEGAL-NAME  PIC X(35) VALUE ' '.
     * 001650      10  WS-000-EXT-ENTITY-PROV-TYPE   PIC X(02) VALUE ' '.  
     * 001660      10  WS-000-EXT-ENTITY-MIDDLE-NAME PIC X(35) VALUE ' '.
     * 001670      10  WS-000-EXT-ENTITY-SSN         PIC X(09) VALUE ' '.  
     * 001680      10  WS-000-EXT-ENTITY-BIRTH-DATE  PIC X(10) VALUE ' '.
     * 001690      10  WS-000-EXT-ENTITY-DEGREE      PIC X(01) VALUE ' '.
     * 001700      10  WS-000-EXT-ENTITY-DEGREE-DATE PIC X(10) VALUE ' '.  
     * 001710      10  WS-000-EXT-ENTITY-FIRST-NAME  PIC X(35) VALUE ' '. 
     * 001720      10  WS-000-EXT-ENTITY-LAST-NAME   PIC X(35) VALUE ' '. 
     * 001730      10  WS-000-EXT-ENTITY-ST-TAX-ID   PIC X(07) VALUE ' '. 
     * 001740      10  WS-000-EXT-ENTITY-FEIN        PIC X(09) VALUE ' '. 
     * 001750      10  WS-000-EXT-ENTITY-FSCL-YR-END PIC X(10) VALUE ' '.
     * 001760      10  WS-000-EXT-ENTITY-EFT-VEND-N  PIC X(10) VALUE ' '. 
     * 001770      10  WS-000-EXT-ENTITY-VEND-LOC    PIC X(03) VALUE ' '.
     * </pre>
     * 
     * @return the legacy id
     * 
     * @throws PortalServiceException for any errors encountered
     */
    private String readWS000EXTENTITY(ByteArrayInputStream stream, Enrollment enrollment) throws PortalServiceException {
        logger.debug("Reading WS-000-EXT-ENTITY");
        ProviderProfile profile = enrollment.getDetails();

        String strWS_000_EXT_ENTITY_PROV_ID = readField(stream, ColumnDef.WS_000_EXT_ENTITY_PROV_ID);
        String strWS_000_EXT_ENTITY_NPI = readField(stream, ColumnDef.WS_000_EXT_ENTITY_NPI);
        String strWS_000_EXT_ENTITY_NAME = readField(stream, ColumnDef.WS_000_EXT_ENTITY_NAME);
        String strWS_000_EXT_ENTITY_LEGAL_NAME = readField(stream, ColumnDef.WS_000_EXT_ENTITY_LEGAL_NAME);
        String strWS_000_EXT_ENTITY_PROV_TYPE = readField(stream, ColumnDef.WS_000_EXT_ENTITY_PROV_TYPE);
        String strWS_000_EXT_ENTITY_MIDDLE_NAME = readField(stream, ColumnDef.WS_000_EXT_ENTITY_MIDDLE_NAME);
        String strWS_000_EXT_ENTITY_SSN = readField(stream, ColumnDef.WS_000_EXT_ENTITY_SSN);
        String strWS_000_EXT_ENTITY_BIRTH_DATE = readField(stream, ColumnDef.WS_000_EXT_ENTITY_BIRTH_DATE);
        String strWS_000_EXT_ENTITY_DEGREE = readField(stream, ColumnDef.WS_000_EXT_ENTITY_DEGREE);
        String strWS_000_EXT_ENTITY_DEGREE_DATE = readField(stream, ColumnDef.WS_000_EXT_ENTITY_DEGREE_DATE);
        String strWS_000_EXT_ENTITY_FIRST_NAME = readField(stream, ColumnDef.WS_000_EXT_ENTITY_FIRST_NAME);
        String strWS_000_EXT_ENTITY_LAST_NAME = readField(stream, ColumnDef.WS_000_EXT_ENTITY_LAST_NAME);
        String strWS_000_EXT_ENTITY_ST_TAX_ID = readField(stream, ColumnDef.WS_000_EXT_ENTITY_ST_TAX_ID);
        String strWS_000_EXT_ENTITY_FEIN = readField(stream, ColumnDef.WS_000_EXT_ENTITY_FEIN);
        String strWS_000_EXT_ENTITY_FSCL_YR_END = readField(stream, ColumnDef.WS_000_EXT_ENTITY_FSCL_YR_END);
        String strWS_000_EXT_ENTITY_EFT_VEND_N = readField(stream, ColumnDef.WS_000_EXT_ENTITY_EFT_VEND_N);
        String strWS_000_EXT_ENTITY_VEND_LOC = readField(stream, ColumnDef.WS_000_EXT_ENTITY_VEND_LOC);

        String providerTypeCode = doLegacyMapping(strWS_000_EXT_ENTITY_PROV_TYPE, XREF_PROVIDER_TYPE);
        ProviderType type = lookup.findLookupByCode(ProviderType.class, providerTypeCode);
        if (type == null) {
            String msg = "There is no matching provider type for this record(" + strWS_000_EXT_ENTITY_PROV_TYPE + ").";
            throw new PortalServiceException(msg);
        }
        boolean pcaInd = type.getDescription().equalsIgnoreCase(
            gov.medicaid.domain.model.ProviderType.PERSONAL_CARE_ASSISTANT.value());
        Person person = new Person();
        Organization org = new Organization();
        Organization practice = null;
        boolean isPerson = type.getApplicantType() == ApplicantType.INDIVIDUAL.ordinal();
        if (isPerson) {
            profile.setEntity(person);
            profile.setAffiliations(new ArrayList<Affiliation>());
            if (!pcaInd) {
                Affiliation affiliation = new Affiliation();
                practice = new Organization();
                affiliation.setEntity(practice);
                affiliation.setObjectType(ViewStatics.DISCRIMINATOR_LOCATION);
                affiliation.setPrimaryInd("Y");
                profile.getAffiliations().add(affiliation);
            }
        } else {
            DesignatedContact contact = new DesignatedContact();
            contact.setPerson(new Person());
            contact.setType(DesignatedContactType.ENROLLMENT);
            profile.setDesignatedContacts(new ArrayList<DesignatedContact>());
            profile.getDesignatedContacts().add(contact);
            profile.setEntity(org);
        }

        Entity entity = profile.getEntity();
        entity.setProviderType(type);

        entity.setLegacyId(strWS_000_EXT_ENTITY_PROV_ID);
        entity.setNpi(strWS_000_EXT_ENTITY_NPI);

        if (isPerson) {
            if (practice != null) {
                practice.setName(strWS_000_EXT_ENTITY_NAME);
                practice.setLegalName(strWS_000_EXT_ENTITY_LEGAL_NAME);
                practice.setStateTaxId(strWS_000_EXT_ENTITY_ST_TAX_ID);
                practice.setFein(strWS_000_EXT_ENTITY_FEIN);
                practice.setFiscalYearEnd(parseFiscalYear(strWS_000_EXT_ENTITY_FSCL_YR_END));
                practice.setEftVendorNumber(strWS_000_EXT_ENTITY_EFT_VEND_N);
            }
            person.setSsn(strWS_000_EXT_ENTITY_SSN);
            person.setDob(parseDate(strWS_000_EXT_ENTITY_BIRTH_DATE));
            String degreeCode = doLegacyMapping(strWS_000_EXT_ENTITY_DEGREE, "DEGREE");
            person.setDegree(lookup.findLookupByCode(Degree.class, degreeCode));
            person.setDegreeAwardDate(parseDate(strWS_000_EXT_ENTITY_DEGREE_DATE));
            parseFullnameToPersonName(person, strWS_000_EXT_ENTITY_LAST_NAME);
            // if (StringUtils.isNotBlank(strWS_000_EXT_ENTITY_LAST_NAME)) {
            // person.setFirstName(strWS_000_EXT_ENTITY_FIRST_NAME);
            // person.setMiddleName(strWS_000_EXT_ENTITY_MIDDLE_NAME);
            // }
            // person.setLastName(strWS_000_EXT_ENTITY_LAST_NAME);
        } else {
            org.setName(strWS_000_EXT_ENTITY_NAME);
            org.setLegalName(strWS_000_EXT_ENTITY_LEGAL_NAME);
            org.setStateTaxId(strWS_000_EXT_ENTITY_ST_TAX_ID);
            org.setFein(strWS_000_EXT_ENTITY_FEIN);
            org.setFiscalYearEnd(parseFiscalYear(strWS_000_EXT_ENTITY_FSCL_YR_END));
            org.setEftVendorNumber(strWS_000_EXT_ENTITY_EFT_VEND_N);
        }

        String internalCountyCode = doLegacyMapping(strWS_000_EXT_ENTITY_VEND_LOC, XREF_COUNTY);
        CountyType county = lookup.findLookupByCode(CountyType.class, internalCountyCode);
        if (county != null) {
            profile.setCounty(county.getDescription());
        }
        logger.debug("End Reading WS-000-EXT-ENTITY");
        return strWS_000_EXT_ENTITY_PROV_ID;
    }

    /**
     * Parses the names and sets it to the owner.
     * @param person the person to set to
     * @param fullname the full name
     */
    static void parseFullnameToPersonName(Person person, String fullname) {
        if (StringUtils.isBlank(fullname)) {
            return;
        }
        String[] tokens = fullname.split(" ");
        if (tokens.length == 1) { // we can only set the last name
            person.setLastName(tokens[0]);
        } else if (tokens.length > 1) { // first name, last name
            for (int index = tokens.length - 1; index > -1; index--) {
                if (index == tokens.length - 1) {
                    // last word always part of the last name
                    person.setLastName(tokens[index]);
                } else if (index == tokens.length - 2 && SURNAME_PREFIX.contains(tokens[index])) {
                    person.setLastName(tokens[index] + " " + person.getLastName());
                } else if (index == 0) {
                    person.setFirstName(tokens[index]);
                } else {
                    person.setMiddleName((tokens[index] + " " + StringUtils.defaultString(person.getMiddleName())).trim());
                }
            }
        }
    }

    private String parseFiscalYear(String fiscalYear) throws PortalServiceException {
        Date date = parseDate(fiscalYear);
        if (date == null) {
            return null;
        }
        return new SimpleDateFormat("MM/dd").format(date);
    }

    private Date parseDate(String dateField) throws PortalServiceException {
        if (StringUtils.isBlank(dateField)) {
            return null;
        }
        try {
            return new SimpleDateFormat("yyyy-MM-dd").parse(dateField);
        } catch (ParseException e) {
            throw new PortalServiceException("Unrecognized date format: " + dateField);
        }
    }

    private String readField(ByteArrayInputStream stream, ColumnDef def) throws PortalServiceException {
        byte[] buf = new byte[def.getWidth()];
        try {
            int res = stream.read(buf);
            if (res < 1) {
                logger.debug("Reached end of line for record. No bytes to read " + def.name());
                return "";
            }
        } catch (IOException e) {
            // should not really happen on ByteArrayInputStream
            logger.warn("Could not read from in-memory buffer.");
        }
        String value = new String(buf);
        if (StringUtils.isNotBlank(value)) {
            logger.debug("Read: " + def.name() + " : " + value);
            return value.trim();
        }

        return "";
    }

    /**
     * Performs code value mapping for the given lookup.
     * 
     * @param externalCodeValue the internal application value
     * @param codeType the code type
     * @return the mapped value
     */
    private String doLegacyMapping(String externalCodeValue, String codeType) {
        String internalCode = lookup.findInternalMapping(SystemId.MN_ITS.name(), codeType, externalCodeValue);
        if (internalCode != null && internalCode.trim().length() > 0) {
            logger.debug("Mapped code [" + codeType + "] [" + externalCodeValue + "] to [" + internalCode + "]");
            return internalCode;
        }

        if (!Util.isBlank(externalCodeValue)) {
            logger.warn("No internal mapping found for code [" + codeType + "] [" + externalCodeValue + "].");
        }
        return externalCodeValue;
    }

    /**
     * The main function, imports the files given as arguments.
     * 
     * @param args the file names
     * @throws IOException for read/write errors
     * @throws PortalServiceException for any other errors
     */
    public static void main(String[] args) throws IOException, PortalServiceException {
        if (args.length != 2) {
            System.out.println("2 file path arguments are required.");
            return;
        }

        PropertyConfigurator.configure("log4j.properties");
        logger = Logger.getLogger(DataLoader.class);

        LookupServiceBean lookupBean = new LookupServiceBean();
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("cms-data-load");
        EntityManager em = emf.createEntityManager();
        lookupBean.setEm(em);
        DataLoader loader = new DataLoader();
        loader.setLookup(lookupBean);

        SequenceGeneratorBean sequence = new SequenceGeneratorBean();
        sequence.setEm(em);

        ProviderEnrollmentServiceBean enrollmentBean = new ProviderEnrollmentServiceBean();
        enrollmentBean.setEm(em);
        enrollmentBean.setSequence(sequence);
        enrollmentBean.setLookupService(lookupBean);

        loader.setEnrollmentService(enrollmentBean);

        long processId = sequence.getNextValue("PROCESS_ID");
        System.out.println("Started process id " + processId);

        BufferedReader br = null;
        PrintWriter accepted = null;
        PrintWriter rejected = null;
        try {
            System.out.println("Processing file 1...");
            File success = new File("accepted_1_" + processId + ".txt");
            File failure = new File("rejected_1_" + processId + ".txt");
            success.createNewFile();
            failure.createNewFile();
            accepted = new PrintWriter(success);
            rejected = new PrintWriter(failure);
            br = new BufferedReader(new FileReader(args[0]));
            String line = null;
            int total = 0;
            int errors = 0;
            while ((line = br.readLine()) != null) {
                total++;
                try {
                    em.getTransaction().begin();
                    loader.readProviderFile(new ByteArrayInputStream(line.getBytes()));
                    em.getTransaction().commit();
                    accepted.println(line);
                    logger.info("Commit row " + total);
                } catch (PortalServiceException e) {
                    rejected.println(line);
                    em.getTransaction().rollback();
                    errors++;
                    logger.error("Rollback row " + total + " :" + e.getMessage());
                }
            }

            accepted.flush();
            accepted.close();
            rejected.flush();
            rejected.close();
            br.close();
            System.out.println("Total records read: " + total);
            System.out.println("Total rejected: " + errors);

            System.out.println("Processing file 2...");
            success = new File("accepted_2_" + processId + ".txt");
            failure = new File("rejected_2_" + processId + ".txt");
            success.createNewFile();
            failure.createNewFile();
            accepted = new PrintWriter(success);
            rejected = new PrintWriter(failure);
            br = new BufferedReader(new FileReader(args[1]));
            line = null;
            total = 0;
            errors = 0;
            while ((line = br.readLine()) != null) {
                total++;
                try {
                    em.getTransaction().begin();
                    Map<String, OwnershipInformation> owners = loader.readWS000EXT2OWNBEN(new ByteArrayInputStream(line
                        .getBytes()));
                    for (Map.Entry<String, OwnershipInformation> entry : owners.entrySet()) {
                        enrollmentBean.addBeneficialOwners(entry.getKey(), entry.getValue());
                    }
                    em.getTransaction().commit();
                    accepted.println(line);
                    logger.info("Commit row " + total);
                } catch (PortalServiceException e) {
                    rejected.println(line);
                    em.getTransaction().rollback();
                    errors++;
                    logger.error("Rollback row " + total + " :" + e.getMessage());
                }
            }
            accepted.flush();
            rejected.flush();
            System.out.println("Total records read: " + total);
            System.out.println("Total rejected: " + errors);

        } finally {
            if (br != null) {
                br.close();
            }
            if (accepted != null) {
                accepted.close();
            }
            if (rejected != null) {
                rejected.close();
            }
        }
    }

    /**
     * Gets the value of the field <code>lookup</code>.
     * 
     * @return the lookup
     */
    public LookupService getLookup() {
        return lookup;
    }

    /**
     * Sets the value of the field <code>lookup</code>.
     * 
     * @param lookup the lookup to set
     */
    public void setLookup(LookupService lookup) {
        this.lookup = lookup;
    }

    /**
     * Gets the value of the field <code>enrollmentService</code>.
     * 
     * @return the enrollmentService
     */
    public ProviderEnrollmentServiceBean getEnrollmentService() {
        return enrollmentService;
    }

    /**
     * Sets the value of the field <code>enrollmentService</code>.
     * 
     * @param enrollmentService the enrollmentService to set
     */
    public void setEnrollmentService(ProviderEnrollmentServiceBean enrollmentService) {
        this.enrollmentService = enrollmentService;
    }
}
