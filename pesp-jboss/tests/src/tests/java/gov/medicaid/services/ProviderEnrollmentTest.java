/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.services;

import gov.medicaid.entities.Address;
import gov.medicaid.entities.Affiliation;
import gov.medicaid.entities.CMSUser;
import gov.medicaid.entities.ContactInformation;
import gov.medicaid.entities.DesignatedContact;
import gov.medicaid.entities.DesignatedContactType;
import gov.medicaid.entities.Document;
import gov.medicaid.entities.Enrollment;
import gov.medicaid.entities.EnrollmentStatus;
import gov.medicaid.entities.IssuingBoard;
import gov.medicaid.entities.License;
import gov.medicaid.entities.LicenseStatus;
import gov.medicaid.entities.LicenseType;
import gov.medicaid.entities.LookupEntity;
import gov.medicaid.entities.Organization;
import gov.medicaid.entities.Person;
import gov.medicaid.entities.PracticeLookup;
import gov.medicaid.entities.PracticeSearchCriteria;
import gov.medicaid.entities.ProfileStatus;
import gov.medicaid.entities.ProviderProfile;
import gov.medicaid.entities.ProviderSearchCriteria;
import gov.medicaid.entities.ProviderStatement;
import gov.medicaid.entities.RemittanceSequenceOrder;
import gov.medicaid.entities.RequestType;
import gov.medicaid.entities.Role;
import gov.medicaid.entities.SearchResult;
import gov.medicaid.entities.SpecialtyType;
import gov.medicaid.entities.UserRequest;
import gov.medicaid.entities.dto.ViewStatics;
import gov.medicaid.services.impl.ProviderEnrollmentServiceBean;
import gov.medicaid.services.impl.SequenceGeneratorBean;
import gov.medicaid.services.util.Sequences;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.Query;

import org.junit.Assert;
import org.junit.BeforeClass;
import org.junit.Test;

/**
 * Simple flow test case.
 *
 * @author TCSASSEMBLER
 * @version 1.0
 */
public class ProviderEnrollmentTest extends CMSTestCase {

    /**
     * Test profile id.
     */
    private static final int TEST_ID = 999999999;

    /**
     * Sequence generator.
     */
    private static SequenceGeneratorBean sequence = new SequenceGeneratorBean();

    /**
     * Enrollment service.
     */
    private static ProviderEnrollmentServiceBean enrollmentService = new ProviderEnrollmentServiceBean();

    /**
     * Entity manager.
     */
    private static EntityManager em;

    /**
     * Test license type.
     */
    private static LicenseType licenseType;

    /**
     * Test license status.
     */
    private static LicenseStatus licenseStatus;

    /**
     * Test specialty type.
     */
    private static SpecialtyType specialtyType;

    /**
     * Test issuing board.
     */
    private static IssuingBoard issuingBoard;

    /**
     * Setup class.
     *
     * @throws FileNotFoundException to JUnit
     * @throws PortalServiceException to JUnit
     */
    @BeforeClass
    public static void setupClass() throws PortalServiceException, FileNotFoundException {
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("cms");
        em = emf.createEntityManager();
        enrollmentService.setEm(em);
        sequence.setEm(em);
        enrollmentService.setSequence(sequence);
        createTestOrg();
        createLookups();
    }

    /**
     * Creates a test organization.
     *
     * @throws FileNotFoundException to JUnit
     * @throws PortalServiceException to JUnit
     */
    private static void createTestOrg() throws PortalServiceException, FileNotFoundException {
        em.getTransaction().begin();
        Organization o = new Organization();
        o.setProfileId(TEST_ID);
        o.setName("test org");
        o.setEnrolled("Y");

        em.persist(o);
        em.getTransaction().commit();
        em.clear();
    }

    /**
     * Creates test lookups.
     */
    private static void createLookups() {
        em.getTransaction().begin();
        licenseType = new LicenseType();
        licenseType.setCode("01");
        licenseType.setDescription("Test License");

        licenseStatus = new LicenseStatus();
        licenseStatus.setCode("02");
        licenseStatus.setDescription("Test License");

        specialtyType = new SpecialtyType();
        specialtyType.setCode("03");
        specialtyType.setDescription("Test License");

        issuingBoard = new IssuingBoard();
        issuingBoard.setCode("04");
        issuingBoard.setDescription("Test License");

        EnrollmentStatus ts1 = new EnrollmentStatus();
        ts1.setCode("S1");
        ts1.setDescription(ViewStatics.DRAFT_STATUS);
        em.persist(ts1);

        EnrollmentStatus ts2 = new EnrollmentStatus();
        ts2.setCode("S2");
        ts2.setDescription(ViewStatics.PENDING_STATUS);
        em.persist(ts2);

        EnrollmentStatus ts3 = new EnrollmentStatus();
        ts3.setCode("S3");
        ts3.setDescription(ViewStatics.APPROVED_STATUS);
        em.persist(ts3);

        EnrollmentStatus ts4 = new EnrollmentStatus();
        ts4.setCode("S4");
        ts4.setDescription(ViewStatics.REJECTED_STATUS);
        em.persist(ts4);

        ProfileStatus ps1 = new ProfileStatus();
        ps1.setCode("06");
        ps1.setDescription(ViewStatics.SUSPENDED);
        em.persist(ps1);

        RequestType rt1 = new RequestType();
        rt1.setCode("R6");
        rt1.setDescription(ViewStatics.SUSPENSION_REQUEST);
        em.persist(rt1);

        RequestType rt2 = new RequestType();
        rt2.setCode("R1");
        rt2.setDescription(ViewStatics.ENROLLMENT_REQUEST);
        em.persist(rt2);

        em.persist(licenseType);
        em.persist(licenseStatus);
        em.persist(specialtyType);
        em.persist(issuingBoard);
        em.getTransaction().commit();
        em.clear();
    }

    /**
     * Tests search.
     *
     * @throws PortalServiceException to JUnit
     * @throws IOException to JUnit
     */
    @Test
    public void testSearch() throws PortalServiceException, IOException {
        em.getTransaction().begin();
        Enrollment ticket = new Enrollment();
        ProviderProfile profile = new ProviderProfile();
        ticket.setDetails(profile);
        populatePersonalInfo(profile);
        populateLicenseInfo(profile);
        populatePracticeInfo(profile);
        populateProviderStatement(profile);
        enrollmentService.saveAsDraft(getUser(), ticket);
        em.getTransaction().commit();
        em.clear();

        ProviderSearchCriteria criteria = new ProviderSearchCriteria();
        criteria.setSortColumn("4");
        SearchResult<UserRequest> searchTickets = enrollmentService.searchTickets(getUser(), criteria);
        System.out.println(searchTickets.getTotal());

        criteria.setEnrollmentNumber("1");
        criteria.setNpi("x");
        criteria.setProviderType("x");
        criteria.setRequestTypes(Arrays.asList("x"));
        criteria.setRiskLevel("x");
        criteria.setStatusDateEnd(Calendar.getInstance().getTime());
        criteria.setStatusDateStart(Calendar.getInstance().getTime());
        criteria.setSubmissionDateEnd(Calendar.getInstance().getTime());
        criteria.setSubmissionDateStart(Calendar.getInstance().getTime());
        searchTickets = enrollmentService.searchTickets(getUser(), criteria);
        System.out.println(searchTickets.getTotal());

    }

    /**
     * Tests practice lookup.
     *
     * @throws PortalServiceException to JUnit
     * @throws IOException to JUnit
     */
    @Test
    public void testSearchPractice() throws PortalServiceException, IOException {
        em.getTransaction().begin();
        Enrollment ticket = new Enrollment();
        ProviderProfile profile = new ProviderProfile();
        ticket.setDetails(profile);
        populatePersonalInfo(profile);
        populateLicenseInfo(profile);
        populatePracticeInfo(profile);
        populateProviderStatement(profile);
        enrollmentService.saveAsDraft(getUser(), ticket);
        em.getTransaction().commit();
        em.clear();

        PracticeSearchCriteria criteria = new PracticeSearchCriteria();
        criteria.setSortColumn("4");
        SearchResult<PracticeLookup> searchTickets = enrollmentService.searchPractice(getUser(), criteria);
        System.out.println(searchTickets.getTotal());

        criteria.setName("x");
        criteria.setCity("x");
        criteria.setState("x");
        criteria.setZip("x");
        criteria.setNpi("x");
        searchTickets = enrollmentService.searchPractice(getUser(), criteria);
        System.out.println(searchTickets.getTotal());
    }

    /**
     * Tests add note.
     *
     * @throws PortalServiceException to JUnit
     * @throws IOException to JUnit
     */
    @Test
    public void testAddNote() throws PortalServiceException, IOException {
        em.getTransaction().begin();
        Enrollment ticket = new Enrollment();
        ProviderProfile profile = new ProviderProfile();
        ticket.setDetails(profile);
        populatePersonalInfo(profile);
        long ticketId = enrollmentService.saveAsDraft(getUser(), ticket);
        em.getTransaction().commit();
        em.clear();

        em.getTransaction().begin();
        enrollmentService.addNoteToTicket(getUser(), ticketId, "hello world");
        em.getTransaction().commit();
        em.clear();

        Enrollment ticketDetails = enrollmentService.getTicketDetails(getUser(), ticketId);
        ProviderProfile profile2 = ticketDetails.getDetails();
        Assert.assertEquals("hello world", profile2.getNotes().get(0).getText());
    }

    /**
     * Tests upload attachments.
     *
     * @throws PortalServiceException to JUnit
     * @throws IOException to JUnit
     */
    @Test
    public void testSaveAttachments() throws PortalServiceException, IOException {
        em.getTransaction().begin();
        Document attach = new Document();
        attach.setStream(new FileInputStream(new File("tests/test_files/attach.txt")));
        enrollmentService.uploadAttachment(getUser(), attach);
        attach.getContentId();
        em.getTransaction().commit();
        em.clear();
        enrollmentService.streamContent(getUser(), attach.getId(), System.err);
    }

    /**
     * Tests save of drafts.
     *
     * @throws PortalServiceException to JUnit
     */
    @Test
    public void testSaveDraftsPage1() throws PortalServiceException {
        em.getTransaction().begin();
        Enrollment ticket = new Enrollment();
        ProviderProfile profile = new ProviderProfile();
        ticket.setDetails(profile);
        populatePersonalInfo(profile);
        long ticketId = enrollmentService.saveAsDraft(getUser(), ticket);
        em.getTransaction().commit();

        em.clear();

        Enrollment fullTicket = enrollmentService.getTicketDetails(getUser(), ticketId);
        comparePersonalInformation(profile, fullTicket.getDetails());
    }

    /**
     * Tests save of drafts.
     *
     * @throws PortalServiceException to JUnit
     * @throws FileNotFoundException to JUnit
     */
    @Test
    public void testSaveDraftsPage2() throws PortalServiceException, FileNotFoundException {
        em.getTransaction().begin();
        Enrollment ticket = new Enrollment();
        ProviderProfile profile = new ProviderProfile();
        ticket.setDetails(profile);
        populateLicenseInfo(profile);
        long ticketId = enrollmentService.saveAsDraft(getUser(), ticket);
        em.getTransaction().commit();

        em.clear();
        Enrollment fullTicket = enrollmentService.getTicketDetails(getUser(), ticketId);
        compareLicenseInformation(profile, fullTicket.getDetails());
    }

    /**
     * Tests save of drafts.
     *
     * @throws PortalServiceException to JUnit
     * @throws FileNotFoundException to JUnit
     */
    @Test
    public void testSaveDraftsPage3() throws PortalServiceException, FileNotFoundException {
        em.getTransaction().begin();
        Enrollment ticket = new Enrollment();
        ProviderProfile profile = new ProviderProfile();
        ticket.setDetails(profile);
        populatePracticeInfo(profile);
        long ticketId = enrollmentService.saveAsDraft(getUser(), ticket);
        em.getTransaction().commit();

        em.clear();
        Enrollment fullTicket = enrollmentService.getTicketDetails(getUser(), ticketId);
        comparePracticeInfo(profile, fullTicket.getDetails());
    }

    /**
     * Tests save of drafts.
     *
     * @throws PortalServiceException to JUnit
     * @throws FileNotFoundException to JUnit
     */
    @Test
    public void testSaveDraftsPage5() throws PortalServiceException, FileNotFoundException {
        em.getTransaction().begin();
        Enrollment ticket = new Enrollment();
        ProviderProfile profile = new ProviderProfile();
        ticket.setDetails(profile);
        populateProviderStatement(profile);
        long ticketId = enrollmentService.saveAsDraft(getUser(), ticket);
        em.getTransaction().commit();

        em.clear();
        Enrollment fullTicket = enrollmentService.getTicketDetails(getUser(), ticketId);
        compareProviderStatement(profile, fullTicket.getDetails());
    }

    /**
     * Tests re-versioning when saving multiple times.
     *
     * @throws PortalServiceException to JUnit
     * @throws FileNotFoundException to JUnit
     */
    @Test
    public void testPurge() throws PortalServiceException, FileNotFoundException {
        em.getTransaction().begin();
        Enrollment ticket = new Enrollment();
        ProviderProfile profile = new ProviderProfile();
        ticket.setDetails(profile);
        populatePersonalInfo(profile);
        populateLicenseInfo(profile);
        populatePracticeInfo(profile);
        populateProviderStatement(profile);
        long ticketId = enrollmentService.saveAsDraft(getUser(), ticket);
        em.getTransaction().commit();

        em.clear();

        em.getTransaction().begin();
        enrollmentService.saveAsDraft(getUser(), ticket);
        em.getTransaction().commit();

        Enrollment fullTicket = enrollmentService.getTicketDetails(getUser(), ticketId);
        compareLicenseInformation(profile, fullTicket.getDetails());
        comparePracticeInfo(profile, fullTicket.getDetails());
        comparePersonalInformation(profile, fullTicket.getDetails());
        compareProviderStatement(profile, fullTicket.getDetails());
    }

    /**
     * Tests approve and suspend flow.
     *
     * @throws PortalServiceException to JUnit
     * @throws FileNotFoundException to JUnit
     */
    @Test
    public void testApproveAndSuspend() throws PortalServiceException, FileNotFoundException {
        Enrollment ticket = new Enrollment();
        ProviderProfile profile = new ProviderProfile();
        ticket.setDetails(profile);
        populatePersonalInfo(profile);
        populateLicenseInfo(profile);
        populatePracticeInfo(profile);
        populateProviderStatement(profile);

        em.getTransaction().begin();
        long ticketId = enrollmentService.saveAsDraft(getUser(), ticket);
        em.getTransaction().commit();
        em.clear();

        mockSubmit(enrollmentService.getTicketDetails(getUser(), ticketId));

        em.getTransaction().begin();
        enrollmentService.approveTicket(getUser(), ticketId);
        em.getTransaction().commit();
        em.clear();

        Enrollment ticketDetails = enrollmentService.getTicketDetails(getUser(), ticketId);
        Assert.assertEquals(ViewStatics.APPROVED_STATUS, ticketDetails.getStatus().getDescription());

        ProviderProfile providerDetails = enrollmentService.getProviderDetails(getUser(),
            ticketDetails.getProfileReferenceId());
        Assert.assertNotNull(providerDetails);

        em.getTransaction().begin();
        enrollmentService.suspendProvider(getUser(), providerDetails.getProfileId(), "test suspend");
        em.getTransaction().commit();
        em.clear();

        profile = enrollmentService.getProviderDetails(getUser(), providerDetails.getProfileId());
        Assert.assertEquals(profile.getProfileStatus().getDescription(), ViewStatics.SUSPENDED);

    }

    /**
     * Retrieves the lookup values given the description.
     *
     * @param cls the expected type
     * @param description the description
     * @param <T> the type of lookup entity
     * @return the matching lookup entry
     */
    @SuppressWarnings("unchecked")
    protected <T extends LookupEntity> T findLookupByDescription(Class<T> cls, String description) {
        Query query = em.createQuery("FROM " + cls.getName() + " WHERE description = :description");
        query.setParameter("description", description);
        return (T) query.getSingleResult();
    }

    /**
     * Mock submit (directly set it to pending status).
     *
     * @param ticketDetails the ticket to submit
     */
    private void mockSubmit(Enrollment ticketDetails) {
        em.getTransaction().begin();
        ticketDetails.setStatus(findLookupByDescription(EnrollmentStatus.class,
            ViewStatics.PENDING_STATUS));
        em.merge(ticketDetails);
        em.getTransaction().commit();
        em.clear();
    }

    /**
     * Checks saved statement.
     *
     * @param profile expected
     * @param details actual
     */
    private void compareProviderStatement(ProviderProfile profile, ProviderProfile details) {
        Assert.assertNotNull(details.getStatement());
    }

    /**
     * Populates test data.
     *
     * @param profile the item to populate
     */
    private static void populateProviderStatement(ProviderProfile profile) {
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
     * Checks saved info.
     *
     * @param profile expected
     * @param details actual
     */
    private void comparePracticeInfo(ProviderProfile profile, ProviderProfile details) {
        Assert.assertEquals(profile.getMaintainsOwnPrivatePractice(), details.getMaintainsOwnPrivatePractice());
        Assert.assertEquals(profile.getEmployedOrContractedByGroup(), details.getEmployedOrContractedByGroup());

        Assert.assertNotNull(details.getAffiliations());
        List<Affiliation> actual = details.getAffiliations();
        for (Affiliation affiliation : actual) {
            Assert.assertNotNull(affiliation.getEntity());
            Assert.assertNotNull(affiliation.getEffectiveDate());
            Assert.assertNotNull(affiliation.getPrimaryInd());
            if ("Y".equals(affiliation.getPrimaryInd())) {
                ContactInformation c2 = affiliation.getEntity().getContactInformation();
                Assert.assertNotNull(c2);
                List<Affiliation> orig = profile.getAffiliations();
                Affiliation a1 = null;
                for (Affiliation op : orig) {
                    if (op.getPrimaryInd().equals("Y")) {
                        a1 = op;
                    }
                }
                Organization p1 = (Organization) a1.getEntity();
                Affiliation a2 = affiliation;
                Organization p2 = (Organization) a2.getEntity();

                Assert.assertNotNull(p2.getContactInformation().getAddress());
                Assert.assertEquals("12345678901234567890", c2.getPhoneNumber());
                Assert.assertEquals("555555555555555555", c2.getFaxNumber());

                Assert.assertEquals(p1.getName(), p2.getName());
                Assert.assertEquals(p1.getFein(), p2.getFein());
                Assert.assertEquals(p1.getStateTaxId(), p2.getStateTaxId());
                Assert.assertEquals(p1.getFiscalYearEnd(), p2.getFiscalYearEnd());
                Assert.assertEquals(p1.getEftVendorNumber(), p2.getEftVendorNumber());
            }
        }
    }

    /**
     * Populates test data.
     *
     * @param profile the item to populate
     */
    private static void populatePracticeInfo(ProviderProfile profile) {
        profile.setMaintainsOwnPrivatePractice("Y");
        profile.setEmployedOrContractedByGroup("Y");

        profile.setAffiliations(new ArrayList<Affiliation>());
        Affiliation primary = new Affiliation();
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
        ppContact.setPhoneNumber("12345678901234567890");
        ppContact.setFaxNumber("555555555555555555");
        pp.setContactInformation(ppContact);

        pp.setBillingAddress(generateAddress());
        pp.setFein("1234569");
        pp.setStateTaxId("123489812");
        pp.setFiscalYearEnd("12/31");
        pp.setEftVendorNumber("123");
        pp.setRemittanceSequenceOrder(RemittanceSequenceOrder.PATIENT_ACCOUNT_OR_OWN_REFERENCE_ORDER);

        profile.getAffiliations().add(primary);

        Affiliation partTime = new Affiliation();
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

        Affiliation partTime2 = new Affiliation();
        partTime2.setPrimaryInd("N");
        partTime2.setEffectiveDate(Calendar.getInstance().getTime());
        partTime2.setTargetProfileId(TEST_ID);
        profile.getAffiliations().add(partTime2);
    }

    /**
     * Generates an address.
     *
     * @return an address
     */
    private static Address generateAddress() {
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
     * Checks saved info.
     *
     * @param profile expected
     * @param details actual
     */
    private void compareLicenseInformation(ProviderProfile profile, ProviderProfile details) {
        List<License> expected = profile.getCertifications();
        List<License> actual = details.getCertifications();

        Assert.assertNotNull("licenses expected", actual);
        Assert.assertEquals(expected.size(), actual.size());

        for (int i = 0; i < expected.size(); i++) {
            License l1 = expected.get(i);
            License l2 = actual.get(i);

            Assert.assertEquals(l1.getIssuingUSState(), l2.getIssuingUSState());
            Assert.assertEquals(l1.getLicenseNumber(), l2.getLicenseNumber());
            Assert.assertEquals(l1.getStatus().getDescription(), l2.getStatus().getDescription());
            Assert.assertEquals(l1.getType().getDescription(), l2.getType().getDescription());
            Assert.assertEquals(l1.getSpecialty().getDescription(), l2.getSpecialty().getDescription());
            Assert.assertEquals(l1.getIssuingBoard().getDescription(), l2.getIssuingBoard().getDescription());
            Assert.assertEquals(formatDateOnly(l1.getRenewalEndDate()), formatDateOnly(l2.getRenewalEndDate()));
            Assert.assertEquals(formatDateOnly(l1.getOriginalIssueDate()), formatDateOnly(l2.getOriginalIssueDate()));
            Assert.assertEquals(l1.getAttachmentId(), l2.getAttachmentId());
        }

        Assert.assertNotNull("attachments expected", details.getAttachments());
        Assert.assertEquals(profile.getAttachments().size(), details.getAttachments().size());
    }

    /**
     * Populates test data.
     *
     * @param profile the profile to populate
     * @throws FileNotFoundException to JUnit
     * @throws PortalServiceException to JUnit
     */
    private static void populateLicenseInfo(ProviderProfile profile) throws FileNotFoundException,
        PortalServiceException {
        profile.setWorksOnReservationInd("Y");

        ArrayList<License> certifications = new ArrayList<License>();
        profile.setCertifications(certifications);

        if (profile.getAttachments() == null) {
            profile.setAttachments(new ArrayList<Document>());
        }
        certifications.add(createTestLicense(profile));
        certifications.add(createTestLicense(profile));
    }

    /**
     * Creates a test license.
     *
     * @param profile the profile to add license to
     * @return the created license
     * @throws FileNotFoundException to JUnit
     * @throws PortalServiceException to JUnit
     */
    private static License createTestLicense(ProviderProfile profile) throws PortalServiceException,
        FileNotFoundException {
        License license = new License();
        license.setLicenseNumber("1234567890");
        license.setType(licenseType);
        license.setOriginalIssueDate(Calendar.getInstance().getTime());
        license.setIssuingUSState("MN");
        license.setSpecialty(specialtyType);
        license.setIssuingBoard(issuingBoard);
        license.setStatus(licenseStatus);
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
     * @throws FileNotFoundException to JUnit
     * @throws PortalServiceException to JUnit
     */
    private static Document createAttachment() throws PortalServiceException, FileNotFoundException {
        Document attach = new Document();
        attach.setId(sequence.getNextValue(Sequences.ATTACHMENT_SEQ));
        attach.setStream(new FileInputStream(new File("tests/test_files/attach.txt")));
        return attach;
    }

    /**
     * Mock user.
     *
     * @return mock user
     */
    private CMSUser getUser() {
        CMSUser user = new CMSUser();
        user.setUsername("myuser");
        Role role = new Role();
        role.setDescription("System Admin");
        user.setRole(role);
        return user;
    }

    /**
     * Compares saved info.
     *
     * @param expected expected value
     * @param actual actual value
     */
    private void comparePersonalInformation(ProviderProfile expected, ProviderProfile actual) {
        Assert.assertNotNull("missing profile", actual);
        Assert.assertNotNull("missing person", actual.getEntity());
        Assert.assertTrue("incorrect type", actual.getEntity() instanceof Person);

        Person p1 = (Person) expected.getEntity();
        Person p2 = (Person) actual.getEntity();

        Assert.assertEquals(p1.getLastName(), p2.getLastName());
        Assert.assertEquals(p1.getFirstName(), p2.getFirstName());
        Assert.assertEquals(p1.getMiddleName(), p2.getMiddleName());
        Assert.assertEquals(p1.getNpi(), p2.getNpi());
        Assert.assertEquals(p1.getSsn(), p2.getSsn());
        Assert.assertEquals(formatDateOnly(p1.getDob()), formatDateOnly(p2.getDob()));

        Assert.assertEquals(p1.getContactInformation().getEmail(), p2.getContactInformation().getEmail());

        Assert.assertNotNull(actual.getDesignatedContacts());
        Assert.assertEquals(expected.getDesignatedContacts().size(), actual.getDesignatedContacts().size());

        DesignatedContact d1 = expected.getDesignatedContacts().get(0);
        DesignatedContact d2 = expected.getDesignatedContacts().get(0);
        Assert.assertEquals(d1.getType(), d2.getType());
        Assert.assertEquals(d1.getSameAsProvider(), d2.getSameAsProvider());
        Assert.assertEquals(d1.getPerson().getName(), d2.getPerson().getName());
        Assert.assertEquals(d1.getPerson().getContactInformation().getPhoneNumber(), d2.getPerson()
            .getContactInformation().getPhoneNumber());
    }

    /**
     * Formats the date.
     *
     * @param dob the date to format
     * @return the formatted date.
     */
    private String formatDateOnly(Date dob) {
        return new SimpleDateFormat("MM/dd/yyyy").format(dob);
    }

    /**
     * Populates the personal info.
     * @param profile the profile to populate
     */
    private static void populatePersonalInfo(ProviderProfile profile) {
        Person person = new Person();
        profile.setEntity(person);
        person.setLastName("lastname");
        person.setFirstName("firstName");
        person.setMiddleName("middlename");
        person.setNpi("1234567890");
        person.setSsn("123456789");
        person.setDob(Calendar.getInstance().getTime());

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
        enrollmentPerson.setName("contact name");
        ContactInformation enrollmentPersonContact = new ContactInformation();
        enrollmentPersonContact.setPhoneNumber("555-5555");
        enrollmentPerson.setContactInformation(enrollmentPersonContact);
    }

}
