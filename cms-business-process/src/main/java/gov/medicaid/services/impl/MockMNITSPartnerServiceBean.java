/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.services.impl;

import gov.medicaid.entities.Address;
import gov.medicaid.entities.Affiliation;
import gov.medicaid.entities.CMSUser;
import gov.medicaid.entities.ContactInformation;
import gov.medicaid.entities.DesignatedContact;
import gov.medicaid.entities.DesignatedContactType;
import gov.medicaid.entities.Document;
import gov.medicaid.entities.License;
import gov.medicaid.entities.LicenseStatus;
import gov.medicaid.entities.LicenseType;
import gov.medicaid.entities.Organization;
import gov.medicaid.entities.Person;
import gov.medicaid.entities.ProviderProfile;
import gov.medicaid.entities.ProviderStatement;
import gov.medicaid.entities.ProviderType;
import gov.medicaid.entities.RemittanceSequenceOrder;
import gov.medicaid.entities.RiskLevel;
import gov.medicaid.entities.dto.ViewStatics;
import gov.medicaid.services.PartnerSystemService;
import gov.medicaid.services.PortalServiceException;
import gov.medicaid.services.util.Sequences;
import gov.medicaid.services.util.Util;

import java.io.ByteArrayInputStream;
import java.security.SecureRandom;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.Set;

import javax.ejb.Local;
import javax.ejb.Stateless;

import com.topcoder.util.keygenerator.random.RandomStringGenerator;

/**
 * Mock implementation of a partner service.
 * @author TCSASSEMBLER
 * @version 1.0
 */
@Stateless
@Local(PartnerSystemService.class)
public class MockMNITSPartnerServiceBean extends BaseService implements PartnerSystemService {

    /**
     * Mock external users database.
     */
    private Set<String> externalUsers = new HashSet<String>();

    /**
     * Mock database for online profiles.
     */
    private Map<String, List<ProviderProfile>> inMemoryProfileDB = new HashMap<String, List<ProviderProfile>>();

    /**
     * Empty constructor.
     */
    public MockMNITSPartnerServiceBean() {
    }

    /**
     * Retrieves the profiles of users from the given link.
     *
     * @param externalUserId the external account link user id
     * @return the list of matched profiles
     * @throws PortalServiceException for any errors encountered
     */
    public List<ProviderProfile> findProfiles(String externalUserId) throws PortalServiceException {
        if (!externalUsers.contains(externalUserId)) {
            generateExternalProfiles(externalUserId);
            externalUsers.add(externalUserId);
        }

        return inMemoryProfileDB.get(externalUserId);
    }


    /**
     * Authenticates the given credentials. This mock always returns true if the password is "secret".
     *
     * @param externalUserId the username
     * @param password the password
     * @return true if the password is "secret"
     */
    public boolean authenticate(String externalUserId, String password) {
        return "secret".equals(password);
    }

    /**
     * Retrieves basic information from the external user.
     * @param username the username
     * @return the basic user profile
     */
    public CMSUser getUserInformation(String username) {
        CMSUser cmsUser = new CMSUser();
        cmsUser.setFirstName("External");
        cmsUser.setLastName("User");
        cmsUser.setEmail(username + "@partner.com");
        return cmsUser;
    }

    /**
     * Generates dummy profiles for the given user.
     *
     * @param externalUserId the user id
     */
    private void generateExternalProfiles(String externalUserId) {
        ProviderProfile profile = new ProviderProfile();
        profile.setProfileId(getSequence().getNextValue(Sequences.PROFILE_SEQ));
        populatePersonalInfo(profile);
        profile.getEntity().setProviderType(findLookupByDescription(ProviderType.class, "Audiologist"));
        populateLicenseInfo(profile);
        populatePracticeInfo(profile);
        populateProviderStatement(profile);

        ProviderProfile profile2 = new ProviderProfile();
        profile2.setProfileId(getSequence().getNextValue(Sequences.PROFILE_SEQ));
        populatePersonalInfo(profile2);
        profile2.getEntity().setProviderType(findLookupByDescription(ProviderType.class, "Optometrist"));
        populateLicenseInfo(profile2);
        populatePracticeInfo(profile2);
        populateProviderStatement(profile2);

        inMemoryProfileDB.put(externalUserId, new ArrayList<ProviderProfile>());
        inMemoryProfileDB.get(externalUserId).add(profile);
        inMemoryProfileDB.get(externalUserId).add(profile2);
    }

    /**
     * Populates test data.
     *
     * @param profile the item to populate
     */
    private void populateProviderStatement(ProviderProfile profile) {
        ProviderStatement ps = new ProviderStatement();
        ps.setName("statement name");
        ps.setTitle("statement title");
        ps.setDate(Calendar.getInstance().getTime());

        profile.setCivilPenaltyInd("N");
        profile.setCriminalConvictionInd("N");
        profile.setPreviousExclusionInd("N");
        profile.setStatement(ps);
    }

    /**
     * Populates the personal info.
     *
     * @param profile the profile to populate
     */
    private void populatePersonalInfo(ProviderProfile profile) {
        int nextInt = new Random().nextInt();
        if (nextInt % 3 == 1) {
            profile.setRiskLevel(findLookupByDescription(RiskLevel.class, ViewStatics.LOW_RISK));
        } else if (nextInt % 3 == 2) {
            profile.setRiskLevel(findLookupByDescription(RiskLevel.class, ViewStatics.MODERATE_RISK));
        } else {
            profile.setRiskLevel(findLookupByDescription(RiskLevel.class, ViewStatics.HIGH_RISK));
        }
        Person person = new Person();
        profile.setEntity(person);
        RandomStringGenerator lettersAndNumbers = new RandomStringGenerator(RandomStringGenerator.ALPHANUMERIC_SYMBOLS,
            20, 20, new SecureRandom());
        person.setLastName(lettersAndNumbers.nextString());
        person.setFirstName(lettersAndNumbers.nextString());
        person.setMiddleName("middlename");
        RandomStringGenerator numbers = new RandomStringGenerator(RandomStringGenerator.NUMBER_SYMBOLS, 9, 9,
            new SecureRandom());

        person.setNpi(numbers.nextString());
        person.setSsn(numbers.nextString());
        person.setDob(Calendar.getInstance().getTime());
        String fullname = Util.defaultString(person.getFirstName()) + " " + Util.defaultString(person.getLastName());
        person.setName(fullname.trim());

        ContactInformation primaryContactInformation = new ContactInformation();
        person.setContactInformation(primaryContactInformation);
        primaryContactInformation.setEmail("email@email.com");

        profile.setDesignatedContacts(new ArrayList<DesignatedContact>());
        DesignatedContact enrollmentDesignee = new DesignatedContact();
        enrollmentDesignee.setType(DesignatedContactType.ENROLLMENT);
        enrollmentDesignee.setSameAsProvider("N");
        profile.getDesignatedContacts().add(enrollmentDesignee);

        Person enrollmentPerson = new Person();
        enrollmentDesignee.setPerson(enrollmentPerson);
        enrollmentPerson.setName(lettersAndNumbers.nextString());
        ContactInformation enrollmentPersonContact = new ContactInformation();
        enrollmentPersonContact.setPhoneNumber("555-333-1234ext123");
        enrollmentPerson.setContactInformation(enrollmentPersonContact);
    }

    /**
     * Populates test data.
     *
     * @param profile the item to populate
     */
    private void populatePracticeInfo(ProviderProfile profile) {
        profile.setMaintainsOwnPrivatePractice("Y");
        profile.setEmployedOrContractedByGroup("Y");

        profile.setAffiliations(new ArrayList<Affiliation>());
        Affiliation primary = new Affiliation();
        primary.setObjectType(ViewStatics.DISCRIMINATOR_LOCATION);
        primary.setEffectiveDate(Calendar.getInstance().getTime());
        primary.setPrimaryInd("Y");
        // create private practice
        Organization pp = new Organization();
        primary.setEntity(pp);
        pp.setName("private practice");
        pp.setNpi("1111111111");
        ContactInformation ppContact = new ContactInformation();
        Address practiceAddress = generateAddress();
        ppContact.setAddress(practiceAddress);
        ppContact.setPhoneNumber("555-333-1234ext123");
        ppContact.setFaxNumber("555-333-1234ext123");
        pp.setContactInformation(ppContact);

        pp.setBillingAddress(generateAddress());
        pp.setFein("1234569");
        pp.setStateTaxId("123489812");
        pp.setFiscalYearEnd("12/31");
        pp.setEftVendorNumber("123");
        pp.setRemittanceSequenceOrder(RemittanceSequenceOrder.PATIENT_ACCOUNT_OR_OWN_REFERENCE_ORDER);

        profile.getAffiliations().add(primary);

        Affiliation partTime = new Affiliation();
        partTime.setObjectType(ViewStatics.DISCRIMINATOR_LOCATION);
        partTime.setPrimaryInd("N");
        partTime.setEffectiveDate(Calendar.getInstance().getTime());
        Organization hospital = new Organization();
        hospital.setName("part time");
        hospital.setNpi("7777777");
        ContactInformation hContact = new ContactInformation();
        hContact.setAddress(generateAddress());
        hospital.setContactInformation(hContact);
        partTime.setEntity(hospital);
        profile.getAffiliations().add(partTime);
    }

    /**
     * Generates an address.
     *
     * @return an address
     */
    private Address generateAddress() {
        Address practiceAddress = new Address();
        practiceAddress.setLine2("street address 1");
        practiceAddress.setLine2("street address 2");
        practiceAddress.setCity("city");
        practiceAddress.setState("MN");
        practiceAddress.setZipcode("12345-1234");
        practiceAddress.setCounty("county");
        return practiceAddress;
    }

    /**
     * Populates test data.
     *
     * @param profile the profile to populate
     */
    private void populateLicenseInfo(ProviderProfile profile) {
        profile.setWorksOnReservationInd("Y");

        ArrayList<License> certifications = new ArrayList<License>();
        profile.setCertifications(certifications);

        if (profile.getAttachments() == null) {
            profile.setAttachments(new ArrayList<Document>());
        }
        certifications.add(createTestLicense(profile));
    }

    /**
     * Creates a test license.
     *
     * @param profile the profile to add license to
     * @return the created license
     */
    private License createTestLicense(ProviderProfile profile) {
        License license = new License();
        license.setObjectType(ViewStatics.DISCRIMINATOR_LICENSE);
        license.setLicenseNumber("1234567890");
        String provider = profile.getEntity().getProviderType().getDescription();
        if ("Audiologist".equals(provider)) {
            license.setType(findLookupByDescription(LicenseType.class, "Audiologist License"));
        } else if ("Optometrist".equals(provider)) {
            license.setType(findLookupByDescription(LicenseType.class, "Optometrist License"));
        }
        license.setOriginalIssueDate(Calendar.getInstance().getTime());
        license.setIssuingUSState("MN");
        license.setStatus(findLookupByDescription(LicenseStatus.class, "Active"));
        license.setRenewalEndDate(Calendar.getInstance().getTime());
        Document attachment = createAttachment();
        profile.getAttachments().add(attachment);
        license.setAttachmentId(attachment.getId());
        return license;
    }

    /**
     * Creates an attachment.
     *
     * @return attachment test data
     */
    private Document createAttachment() {
        Document attach = new Document();
        attach.setId(getSequence().getNextValue(Sequences.ATTACHMENT_SEQ));
        attach.setStream(new ByteArrayInputStream("This is an attachment".getBytes()));
        return attach;
    }
}
