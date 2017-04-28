/*
 * Copyright (C) 2013 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.process.enrollment.sync;

import gov.medicaid.entities.Address;
import gov.medicaid.entities.Affiliation;
import gov.medicaid.entities.Asset;
import gov.medicaid.entities.BeneficialOwner;
import gov.medicaid.entities.CategoryOfService;
import gov.medicaid.entities.CountyType;
import gov.medicaid.entities.DesignatedContact;
import gov.medicaid.entities.DesignatedContactType;
import gov.medicaid.entities.Enrollment;
import gov.medicaid.entities.Entity;
import gov.medicaid.entities.License;
import gov.medicaid.entities.Organization;
import gov.medicaid.entities.OrganizationBeneficialOwner;
import gov.medicaid.entities.OwnershipInformation;
import gov.medicaid.entities.Person;
import gov.medicaid.entities.PersonBeneficialOwner;
import gov.medicaid.entities.ProviderCategoryOfService;
import gov.medicaid.entities.ProviderProfile;
import gov.medicaid.entities.SystemId;
import gov.medicaid.entities.dto.ViewStatics;
import gov.medicaid.services.CMSConfigurator;
import gov.medicaid.services.LookupService;
import gov.medicaid.services.PortalServiceException;

import java.math.BigDecimal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.apache.commons.lang.StringUtils;

/**
 * This exports the provider model to a flat file.
 * 
 * @author TCSASSEMBLER
 * @version 1.0
 */
public class FlatFileExporter {

    /**
     * Beneficial owner type mapping name.
     */
    private static final String XREF_OWNER_TYPE = "BEN_OWNER_TYPE";

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
    private static final Address BLANK_ADDRESS = new Address();

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
    private final LookupService lookup;

    /**
     * Empty constructor.
     */
    public FlatFileExporter() {
        CMSConfigurator config = new CMSConfigurator();
        lookup = config.getLookupService();
    }

    /**
     * Exports the provider file.
     * 
     * @param enrollment the enrollment to be exported
     * @return the exported file
     * @throws PortalServiceException for any errors encountered
     */
    public byte[] exportProviderFile(Enrollment enrollment) throws PortalServiceException {
        ProviderProfile profile = enrollment.getDetails();
        StringBuilder sb = new StringBuilder();
        generateHeader(sb, enrollment);
        exportWS000EXTENTITY(sb, enrollment);
        exportWS000EXTOWNINFO(sb, profile);
        exportWS000EXTOWNASSET(sb, profile);
        exportWS000EXTPROVPROFILE(sb, enrollment);
        exportWS000EXTCONTINFO(sb, enrollment);
        exportWS000EXTPRACTICEADDR(sb, enrollment);
        exportWS000EXTBILLADDR(sb, enrollment);
        exportWS000EXTLIC(sb, enrollment);
        exportWS000EXTCOS(sb, enrollment);
        exportWS000EXT2OWNBEN(sb, enrollment);
        return sb.toString().getBytes();
    }

    /**
     * Generates the header for the request.
     * 
     * 
     * <pre>
     * | Add-Update ID| Oracle Row ID| Legacy ID | Sys Err Code | Data Err Code | <provider file>
     * 
     * -          Set add/update
     * -          Leave sys err and data err empty for all records
     * -          Leave legacy ID blank for new providers
     * 
     * Add-Update ID:  1 byte.  A for add, U for update (existing)
     * Oracle Row ID: 22 bytes - our row ID for this provider
     * Legacy ID: 8 bytes - the legacy ID of the provider
     * Sys err Code: 2 bytes - we record this to the log for every processed row, but ignore it
     * Data Err Code: 30 bytes (which will be 3 byte segments)
     * </pre>
     * 
     * @param sb the buffer
     * @param enrollment the enrollment
     * @throws PortalServiceException for any errors encountered
     */
    private void generateHeader(StringBuilder sb, Enrollment enrollment) throws PortalServiceException {
        ProviderProfile profile = enrollment.getDetails();
        String mode = "U";
        if (enrollment.getRequestType().getDescription().equals(ViewStatics.ENROLLMENT_REQUEST)) {
            mode = "A";
        } else {
            if (profile.getEntity().getLegacyId() == null) {
                throw new PortalServiceException("Cannot send UPDATE synchronization as Legacy ID is not known.");
            }
        }
        sb.append(fw(mode, ColumnDef.HEADER_MODE));
        sb.append(fw(enrollment.getTicketId(), ColumnDef.HEADER_PROFILE_ID));
        sb.append(fw("", ColumnDef.HEADER_LEGACY_ID));
        sb.append(fw("", ColumnDef.HEADER_SYS_ERR));
        sb.append(fw("", ColumnDef.HEADER_DATA_ERR));
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
     */
    private void exportWS000EXT2OWNBEN(StringBuilder sb, Enrollment enrollment) {
        ProviderProfile profile = enrollment.getDetails();
        sb.append(fw(profile.getProfileId(), ColumnDef.WS_000_EXT2_OWN_B_PROV_ID));
        sb.append(fw(profile.getEntity().getNpi(), ColumnDef.WS_000_EXT2_OWN_B_NPI));

        OwnershipInformation ownershipInformation = profile.getOwnershipInformation();
        BeneficialOwner owner = null;
        boolean isPerson = true;
        if (ownershipInformation != null) {
            List<BeneficialOwner> owners = ownershipInformation.getBeneficialOwners();
            if (owners.isEmpty()) {
                owner = owners.get(0);
                isPerson = owner instanceof PersonBeneficialOwner;
            }
        }
        if (owner == null) {
            owner = new PersonBeneficialOwner();
        }

        sb.append(fw(mod(owner.getOwnershipInterest(), 1000), ColumnDef.WS_000_EXT2_OWN_B_INT_PCT));
        if (isPerson) {
            PersonBeneficialOwner person = (PersonBeneficialOwner) owner;
            sb.append(fw(person.getDob(), ColumnDef.WS_000_EXT2_OWN_B_BIRTH_DATE));
            sb.append(fw(person.getHireDate(), ColumnDef.WS_000_EXT2_OWN_B_HIRE_DATE));
            sb.append(fw(person.getMiddleName(), ColumnDef.WS_000_EXT2_OWN_B_M_NAME));
            sb.append(fw(person.getFirstName(), ColumnDef.WS_000_EXT2_OWN_B_F_NAME));
            sb.append(fw(person.getLastName(), ColumnDef.WS_000_EXT2_OWN_B_L_NAME));
            sb.append(fw(person.getSsn(), ColumnDef.WS_000_EXT2_OWN_B_SSN));

            String typeCode = owner.getType() == null ? null : owner.getType().getCode();
            String extCode = doLegacyMapping(typeCode, XREF_OWNER_TYPE);
            sb.append(fw(extCode, ColumnDef.WS_000_EXT2_OWN_B_ROLE_IND_1));
            sb.append(fw("", ColumnDef.WS_000_EXT2_OWN_B_ROLE_IND_2));
            sb.append(fw("", ColumnDef.WS_000_EXT2_OWN_B_ROLE_IND_3));
            sb.append(fw("", ColumnDef.WS_000_EXT2_OWN_B_ROLE_IND_4));
            sb.append(fw("", ColumnDef.WS_000_EXT2_OWN_B_FEIN));
        } else {
            OrganizationBeneficialOwner org = (OrganizationBeneficialOwner) owner;
            sb.append(fw("", ColumnDef.WS_000_EXT2_OWN_B_BIRTH_DATE));
            sb.append(fw("", ColumnDef.WS_000_EXT2_OWN_B_HIRE_DATE));
            sb.append(fw("", ColumnDef.WS_000_EXT2_OWN_B_M_NAME));
            sb.append(fw("", ColumnDef.WS_000_EXT2_OWN_B_F_NAME));
            sb.append(fw("", ColumnDef.WS_000_EXT2_OWN_B_L_NAME));
            sb.append(fw("", ColumnDef.WS_000_EXT2_OWN_B_SSN));
            
            String typeCode = owner.getType() == null ? null : owner.getType().getCode();
            String extCode = doLegacyMapping(typeCode, XREF_OWNER_TYPE);
            sb.append(fw(extCode, ColumnDef.WS_000_EXT2_OWN_B_ROLE_IND_1));
            sb.append(fw("", ColumnDef.WS_000_EXT2_OWN_B_ROLE_IND_2));
            sb.append(fw("", ColumnDef.WS_000_EXT2_OWN_B_ROLE_IND_3));
            sb.append(fw("", ColumnDef.WS_000_EXT2_OWN_B_ROLE_IND_4));
            sb.append(fw(org.getFein(), ColumnDef.WS_000_EXT2_OWN_B_FEIN));
        }
    }

    /**
     * Limits the value to a range
     * 
     * @param value the value
     * @param i the range
     * @return the mod of value and i
     */
    private String mod(BigDecimal value, int i) {
        if (value == null) {
            return null;
        }
        return String.valueOf(value.intValue() % i);
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
     */
    private void exportWS000EXTCOS(StringBuilder sb, Enrollment enrollment) {
        ProviderProfile profile = enrollment.getDetails();
        List<ProviderCategoryOfService> cos = profile.getCategoriesOfServiceTypes();
        for (int i = 0; i < 20; i++) {
            ProviderCategoryOfService cat = null;
            if (cos.size() > i) {
                cat = cos.get(i);
            } else {
                cat = new ProviderCategoryOfService();
            }

            sb.append(fw(cat.getStartDate(), ColumnDef.WS_000_EXT_COS_START_DATE));
            sb.append(fw(cat.getEndDate(), ColumnDef.WS_000_EXT_COS_END_DATE));

            List<CategoryOfService> codes = cat.getCategories();
            for (int j = 0; j < 60; j++) {
                CategoryOfService code = null;
                if (codes != null && codes.size() > j) {
                    code = codes.get(j);
                } else {
                    code = new CategoryOfService();
                }
                sb.append(fw(doLegacyMapping(code.getCode(), XREF_COS), ColumnDef.WS_000_EXT_COS_CODE));
            }
        }
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
     */
    private void exportWS000EXTLIC(StringBuilder sb, Enrollment enrollment) {
        ProviderProfile profile = enrollment.getDetails();
        List<License> certifications = profile.getCertifications();
        for (int i = 0; i < 112; i++) {
            License license = null;
            if (certifications.size() > i) {
                license = certifications.get(i);
            } else {
                license = new License();
            }

            String specType = license.getSpecialty() == null ? null : doLegacyMapping(license.getSpecialty().getCode(),
                XREF_SPECIALTY_CODE);
            sb.append(fw(specType, ColumnDef.WS_000_EXT_LIC_SPEC_TYPE));

            String licType = license.getType() == null ? null : doLegacyMapping(license.getType().getCode(),
                XREF_LICENSE_TYPE);
            sb.append(fw(licType, ColumnDef.WS_000_EXT_LIC_TYPE));

            sb.append(fw(license.getLicenseNumber(), ColumnDef.WS_000_EXT_LIC_NBR));
            sb.append(fw(license.getOriginalIssueDate(), ColumnDef.WS_000_EXT_LIC_BEG_DATE));
            sb.append(fw(license.getRenewalEndDate(), ColumnDef.WS_000_EXT_LIC_END_DATE));
            sb.append(fw(license.getIssuingUSState(), ColumnDef.WS_000_EXT_LIC_STATE));

            String status = license.getStatus() == null ? null : doLegacyMapping(license.getStatus()
                .getCode(), XREF_LICENSE_STATUS);
            sb.append(fw(status, ColumnDef.WS_000_EXT_LIC_STAT));
            
            String board = license.getIssuingBoard() == null ? null : doLegacyMapping(license.getIssuingBoard()
                .getCode(), XREF_ISSUING_BOARD);
            sb.append(fw(board, ColumnDef.WS_000_EXT_LIC_ISSUE_BRD));
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
     */
    private void exportWS000EXTBILLADDR(StringBuilder sb, Enrollment enrollment) {
        ProviderProfile profile = enrollment.getDetails();
        Entity entity = profile.getEntity();
        boolean isPerson = entity instanceof Person;
        Organization practice = getPrimaryPractice(profile, entity);
        if (isPerson) {
            exportAddress(sb, practice.getBillingAddress());
        } else {
            exportAddress(sb, ((Organization) entity).getBillingAddress());
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
     */
    private void exportWS000EXTPRACTICEADDR(StringBuilder sb, Enrollment enrollment) {
        ProviderProfile profile = enrollment.getDetails();
        Entity entity = profile.getEntity();
        boolean isPerson = entity instanceof Person;
        Organization practice = getPrimaryPractice(profile, entity);
        if (isPerson && practice != null) {
            exportAddress(sb, practice.getContactInformation().getAddress());
        } else {
            exportAddress(sb, entity.getContactInformation().getAddress());
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
     * @param sb the current buffer
     * @param address the address to be exported
     */
    private void exportAddress(StringBuilder sb, Address address) {
        if (address == null) {
            address = BLANK_ADDRESS;
        }
        sb.append(fw(address.getLine1(), ColumnDef.WS_000_EXT_PRAC_ADDR_1));
        sb.append(fw(address.getLine2(), ColumnDef.WS_000_EXT_PRAC_ADDR_2));
        sb.append(fw(address.getCity(), ColumnDef.WS_000_EXT_PRAC_ADDR_CITY));
        sb.append(fw(address.getState(), ColumnDef.WS_000_EXT_PRAC_ADDR_STATE));
        sb.append(fw(address.getZipcode(), ColumnDef.WS_000_EXT_PRAC_ADDR_ZIP));
        String county = doLegacyMapping(address.getCounty(), XREF_COUNTY);
        sb.append(fw(county, ColumnDef.WS_000_EXT_PRAC_ADDR_COUNTY));
    }

    /**
     * <pre>
     * 001910    05  WS-000-EXT-CONT-INFO.                                
     * 001920      10  WS-000-EXT-CONT-I-PHONE       PIC X(10) VALUE ' '. 
     * 001930      10  WS-000-EXT-CONT-I-FAX         PIC X(10) VALUE ' '. 
     * 001940      10  WS-000-EXT-CONT-I-EMAIL       PIC X(70) VALUE ' '.
     * </pre>
     */
    private void exportWS000EXTCONTINFO(StringBuilder sb, Enrollment enrollment) {
        ProviderProfile profile = enrollment.getDetails();
        Entity entity = profile.getEntity();

        boolean isPerson = entity instanceof Person;
        Organization practice = getPrimaryPractice(profile, entity);
        DesignatedContact designatedContact = findDesignatedContact(profile);

        if (isPerson) {
            if (practice != null) {
                // use practice location phone numbers
                sb.append(fw(practice.getContactInformation().getPhoneNumber(), ColumnDef.WS_000_EXT_CONT_I_PHONE));
                sb.append(fw(practice.getContactInformation().getFaxNumber(), ColumnDef.WS_000_EXT_CONT_I_FAX));
            } else {
                // use residential information (home based?)
                sb.append(fw(entity.getContactInformation().getPhoneNumber(), ColumnDef.WS_000_EXT_CONT_I_PHONE));
                sb.append(fw(entity.getContactInformation().getFaxNumber(), ColumnDef.WS_000_EXT_CONT_I_FAX));
            }

            if (designatedContact != null) {
                // use designated contact
                sb.append(fw(designatedContact.getPerson().getContactInformation().getEmail(),
                    ColumnDef.WS_000_EXT_CONT_I_EMAIL));
            } else {
                // use personal email
                sb.append(fw(entity.getContactInformation().getEmail(), ColumnDef.WS_000_EXT_CONT_I_EMAIL));
            }
        } else {
            if (designatedContact != null) {
                // always expect a designated contact
                sb.append(fw(designatedContact.getPerson().getContactInformation().getPhoneNumber(),
                    ColumnDef.WS_000_EXT_CONT_I_PHONE));
                sb.append(fw(designatedContact.getPerson().getContactInformation().getFaxNumber(),
                    ColumnDef.WS_000_EXT_CONT_I_FAX));
                sb.append(fw(designatedContact.getPerson().getContactInformation().getEmail(),
                    ColumnDef.WS_000_EXT_CONT_I_EMAIL));
            } else {
                // default to organization location
                sb.append(fw(entity.getContactInformation().getPhoneNumber(), ColumnDef.WS_000_EXT_CONT_I_PHONE));
                sb.append(fw(entity.getContactInformation().getFaxNumber(), ColumnDef.WS_000_EXT_CONT_I_FAX));
                sb.append(fw(entity.getContactInformation().getEmail(), ColumnDef.WS_000_EXT_CONT_I_EMAIL));
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
     */
    private void exportWS000EXTPROVPROFILE(StringBuilder sb, Enrollment enrollment) {
        sb.append(fw(enrollment.getStatusDate(), ColumnDef.WS_000_EXT_PROV_P_E_STAT_DT));
        sb.append(fw(doLegacyMapping(enrollment.getStatus().getCode(), XREF_ENROLLMENT_STATUS),
            ColumnDef.WS_000_EXT_PROV_P_ENRL_STAT));
        for (int i = 0; i < 11; i++) {
            sb.append(fw("", ColumnDef.WS_000_EXT_PROV_P_E_STAT_DT));
            sb.append(fw("", ColumnDef.WS_000_EXT_PROV_P_ENRL_STAT));
        }

        ProviderProfile profile = enrollment.getDetails();
        sb.append(fw(profile.getWorksOnReservationInd(), ColumnDef.WS_000_EXT_PROV_P_RESV_IND));
        sb.append(fw(findCountyCode(profile.getCounty()), ColumnDef.WS_000_EXT_PROV_P_CO_CODE));
        sb.append(fw(doLegacyMapping(profile.getRiskLevel().getCode(), XREF_RISK_LEVEL),
            ColumnDef.WS_000_EXT_PROV_P_RISK_LVL));
    }

    /**
     * <pre>
     * 001800    05  WS-000-EXT-OWN-ASSET.                               
     * 001810      10  WS-000-EXT-OWN-A-ARRAY OCCURS 25 TIMES.                     
     * 001820        15  WS-000-EXT-OWN-A-BCKGRD-NAM PIC X(35) VALUE ' '.    
     * 001830        15  WS-000-EXT-OWN-A-BCKGRD-OWN PIC X(01) VALUE ' '.
     * </pre>
     */
    private void exportWS000EXTOWNASSET(StringBuilder sb, ProviderProfile profile) {
        OwnershipInformation ownershipInformation = profile.getOwnershipInformation();
        for (int i = 0; i < 25; i++) {
            Asset asset = null;
            if (ownershipInformation != null && ownershipInformation.getAssets() != null && ownershipInformation.getAssets().size() > i) {
                asset = ownershipInformation.getAssets().get(i);
            } else {
                asset = new Asset();
            }

            sb.append(fw(asset.getName(), ColumnDef.WS_000_EXT_OWN_A_BCKGRD_NAM));
            if (asset.getOwnershipType() != null) {
                String type = doLegacyMapping(asset.getOwnershipType().getCode(), XREF_OWNERSHIP_TYPE);
                sb.append(fw(type, ColumnDef.WS_000_EXT_OWN_A_BCKGRD_OWN));
            } else {
                sb.append(fw("", ColumnDef.WS_000_EXT_OWN_A_BCKGRD_OWN));
            }
        }
    }

    /**
     * <pre>
     * 001780    05  WS-000-EXT-OWN-INFO.                                          
     * 001790      10  WS-000-EXT-OWN-I-OWNER        PIC X(01) VALUE ' '.
     * </pre>
     */
    private void exportWS000EXTOWNINFO(StringBuilder sb, ProviderProfile profile) {
        sb.append(fw(profile.getMaintainsOwnPrivatePractice(), ColumnDef.WS_000_EXT_OWN_I_OWNER));
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
     */
    private void exportWS000EXTENTITY(StringBuilder sb, Enrollment enrollment) {
        ProviderProfile profile = enrollment.getDetails();
        Entity entity = profile.getEntity();
        boolean isPerson = entity instanceof Person;
        Organization practice = getPrimaryPractice(profile, entity);
        Organization organization = isPerson ? null : (Organization) entity;
        Person person = isPerson ? (Person) entity : null;

        String providerTypeCode = doLegacyMapping(entity.getProviderType().getCode(), XREF_PROVIDER_TYPE);
        sb.append(fw(enrollment.getTicketId(), ColumnDef.WS_000_EXT_ENTITY_PROV_ID));
        sb.append(fw(entity.getNpi(), ColumnDef.WS_000_EXT_ENTITY_NPI));
        if (isPerson) {
            sb.append(fw(practice.getName(), ColumnDef.WS_000_EXT_ENTITY_NAME));
            sb.append(fw(practice.getLegalName(), ColumnDef.WS_000_EXT_ENTITY_LEGAL_NAME));
            sb.append(fw(providerTypeCode, ColumnDef.WS_000_EXT_ENTITY_PROV_TYPE));
            sb.append(fw(person.getMiddleName(), ColumnDef.WS_000_EXT_ENTITY_MIDDLE_NAME));
            sb.append(fw(person.getSsn(), ColumnDef.WS_000_EXT_ENTITY_SSN));
            sb.append(fw(person.getDob(), ColumnDef.WS_000_EXT_ENTITY_BIRTH_DATE));
            if (person.getDegree() != null) {
                sb.append(fw(doLegacyMapping(person.getDegree().getCode(), "DEGREE"), ColumnDef.WS_000_EXT_ENTITY_DEGREE));
            } else {
                sb.append(fw("", ColumnDef.WS_000_EXT_ENTITY_DEGREE));
            }
            sb.append(fw(person.getDegreeAwardDate(), ColumnDef.WS_000_EXT_ENTITY_DEGREE_DATE));
            sb.append(fw(person.getFirstName(), ColumnDef.WS_000_EXT_ENTITY_FIRST_NAME));
            sb.append(fw(person.getLastName(), ColumnDef.WS_000_EXT_ENTITY_LAST_NAME));
            sb.append(fw(practice.getStateTaxId(), ColumnDef.WS_000_EXT_ENTITY_ST_TAX_ID));
            sb.append(fw(practice.getFein(), ColumnDef.WS_000_EXT_ENTITY_FEIN));
            sb.append(fw(fiscalYearToDate(practice.getFiscalYearEnd()), ColumnDef.WS_000_EXT_ENTITY_FSCL_YR_END));
            sb.append(fw(practice.getEftVendorNumber(), ColumnDef.WS_000_EXT_ENTITY_EFT_VEND_N));
        } else {
            sb.append(fw(entity.getName(), ColumnDef.WS_000_EXT_ENTITY_NAME));
            sb.append(fw(entity.getLegalName(), ColumnDef.WS_000_EXT_ENTITY_LEGAL_NAME));
            sb.append(fw(providerTypeCode, ColumnDef.WS_000_EXT_ENTITY_PROV_TYPE));
            sb.append(fw("", ColumnDef.WS_000_EXT_ENTITY_MIDDLE_NAME));
            sb.append(fw("", ColumnDef.WS_000_EXT_ENTITY_SSN));
            sb.append(fw("", ColumnDef.WS_000_EXT_ENTITY_BIRTH_DATE));
            sb.append(fw("", ColumnDef.WS_000_EXT_ENTITY_DEGREE));
            sb.append(fw("", ColumnDef.WS_000_EXT_ENTITY_DEGREE_DATE));
            sb.append(fw("", ColumnDef.WS_000_EXT_ENTITY_FIRST_NAME));
            sb.append(fw("", ColumnDef.WS_000_EXT_ENTITY_LAST_NAME));
            sb.append(fw(organization.getStateTaxId(), ColumnDef.WS_000_EXT_ENTITY_ST_TAX_ID));
            sb.append(fw(organization.getFein(), ColumnDef.WS_000_EXT_ENTITY_FEIN));
            sb.append(fw(fiscalYearToDate(organization.getFiscalYearEnd()), ColumnDef.WS_000_EXT_ENTITY_FSCL_YR_END));
            sb.append(fw(organization.getEftVendorNumber(), ColumnDef.WS_000_EXT_ENTITY_EFT_VEND_N));
        }
        sb.append(fw(findCountyCode(profile.getCounty()), ColumnDef.WS_000_EXT_ENTITY_VEND_LOC));
    }

    /**
     * Converts the fiscal year end to a data.
     * 
     * @param fiscalYearEnd the current value
     * @return the formatted date, or null
     */
    private Date fiscalYearToDate(String fiscalYearEnd) {
        if (fiscalYearEnd == null) {
            return null;
        }

        try {
            return new SimpleDateFormat("MM/dd/yyyy").parse(fiscalYearEnd + "/1900");
        } catch (ParseException e) {
            return null;
        }
    }

    /**
     * Retrieves the county code for the description
     * 
     * @param county the county name
     * @return the county code, or the county name if not found
     */
    private String findCountyCode(String county) {
        CountyType countyObj = lookup.findLookupByDescription(CountyType.class, county);
        if (countyObj == null) {
            return county;
        }
        return doLegacyMapping(countyObj.getCode(), XREF_COUNTY);
    }

    /**
     * Performs code value mapping for the given lookup.
     * 
     * @param internalCodeValue the internal application value
     * @param codeType the code type
     * @return the mapped value
     */
    private String doLegacyMapping(String internalCodeValue, String codeType) {

        String externalCode = lookup.findLegacyMapping(SystemId.MN_ITS.name(), codeType, internalCodeValue);
        if (externalCode != null && externalCode.trim().length() > 0) {
            return externalCode;
        }
        return internalCodeValue;
    }

    /**
     * Fixes the width of the given object given the column definition.
     * 
     * @param value the value to fix the width for
     * @param def the column definition
     * @return the fixed width string
     */
    private String fw(Object value, ColumnDef def) {
        if (value == null) {
            fixWidth("", def.getWidth());
        }
        
        if (value != null && value instanceof Date) {
            return fixWidthDate((Date) value, def.getWidth());
        }

        return fixWidth(String.valueOf(value), def.getWidth());
    }

    /**
     * Converts the given date to the export format.
     * 
     * @param value the value to convert
     * @param width the width of the field
     * @return the formatted data
     */
    private String fixWidthDate(Date value, int width) {
        return StringUtils.leftPad(new SimpleDateFormat("yyyy-MM-dd").format(value), width);
    }

    /**
     * Converts the given object to the export format.
     * 
     * @param value the value to convert
     * @param width the width of the field
     * @return the formatted data
     */
    private String fixWidth(String value, int width) {
        if (value != null) {
            return value.length() > width ? value.substring(0, width) : StringUtils.leftPad(value, width);
        }
        return StringUtils.leftPad("", width);
    }
}