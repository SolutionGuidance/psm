/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.binders;

import gov.medicaid.domain.model.AddressType;
import gov.medicaid.domain.model.BeneficialOwnerType;
import gov.medicaid.domain.model.ContactInformationType;
import gov.medicaid.domain.model.EnrollmentType;
import gov.medicaid.domain.model.OrganizationType;
import gov.medicaid.domain.model.OwnershipInformationType;
import gov.medicaid.domain.model.PersonType;
import gov.medicaid.domain.model.ProviderInformationType;
import gov.medicaid.domain.model.StatusMessageType;
import gov.medicaid.domain.model.StatusMessagesType;
import gov.medicaid.entities.BeneficialOwner;
import gov.medicaid.entities.CMSUser;
import gov.medicaid.entities.Enrollment;
import gov.medicaid.entities.EntityStructureType;
import gov.medicaid.entities.OrganizationBeneficialOwner;
import gov.medicaid.entities.OwnershipInformation;
import gov.medicaid.entities.PersonBeneficialOwner;
import gov.medicaid.entities.ProviderProfile;
import gov.medicaid.entities.RelationshipType;
import gov.medicaid.entities.dto.FormError;
import gov.medicaid.services.PortalServiceException;
import gov.medicaid.services.util.Util;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.lowagie.text.Document;
import com.lowagie.text.DocumentException;

/**
 * This binder handles the organization information form.
 *
 * @author TCSASSEMBLER
 * @version 1.0
 */
public class OwnershipInfoFormBinder extends BaseFormBinder implements FormBinder {

    /**
     * The namespace for this form.
     */
    private static final String NAMESPACE = "_17_";

    /**
     * Creates a new instance.
     */
    public OwnershipInfoFormBinder() {
        super(NAMESPACE);
    }

    /**
     * Binds the request to the model.
     * @param enrollment the model to bind to
     * @param request the request containing the form fields
     *
     * @throws BinderException if the format of the fields could not be bound properly
     */
    public List<BinderException> bindFromPage(CMSUser user, EnrollmentType enrollment, HttpServletRequest request) {
        List<BinderException> exceptions = new ArrayList<BinderException>();
        OwnershipInformationType ownership = XMLUtility.nsGetOwnershipInformation(enrollment);

        ownership.setEntityType(param(request, "entityType"));
        ownership.setEntitySubType(param(request, "entitySubType"));
        ownership.setOtherEntityDescription(param(request, "entityDescription"));

        ownership.getBeneficialOwner().clear();
        int i = 0;
        while (param(request, "iboType", i) != null) {
            BeneficialOwnerType bo = new BeneficialOwnerType();
            bo.setPersonInd("Y");
            bo.setBeneficialOwnerType(param(request, "iboType", i));
            bo.setOtherBeneficialOwnerDescription(param(request, "iboOtherType", i));
            bo.setSubcontractorName(param(request, "iboSubcontractorName", i));
            bo.setPercentOwnership(BinderUtils.getAsDouble(param(request, "iboPercentOwnership", i)));

            PersonType person = new PersonType();
            bo.setPersonInformation(person);
            person.setLastName(param(request, "iboLastName", i));
            person.setFirstName(param(request, "iboFirstName", i));
            person.setMiddleName(param(request, "iboMiddleName", i));
            person.setSocialSecurityNumber(BinderUtils.unformatSSN(param(request, "iboSSN", i)));
            try {
                person.setDateOfBirth(BinderUtils.getAsCalendar(param(request, "iboDOB", i)));
            } catch (BinderException e) {
                e.setAttribute(name("iboDOB", i), param(request, "iboDOB", i));
                exceptions.add(e);
            }

            person.setContactInformation(new ContactInformationType());
            AddressType address = readAddress(request, "ibo", i);
            person.getContactInformation().setAddress(address);


            try {
                bo.setHireDate(BinderUtils.getAsCalendar(param(request, "iboHireDate", i)));
            } catch (BinderException e) {
                e.setAttribute(name("iboHireDate", i), param(request, "iboHireDate", i));
                exceptions.add(e);
            }
            bo.setRelationship(param(request, "iboRelationship", i));

            bo.setOtherInterestInd("N");
            if (param(request, "iboOtherInterestInd", i) != null) {
                bo.setOtherInterestInd("Y");
                bo.setOtherInterestPercentOwnership(BinderUtils.getAsDouble(param(request, "iboOtherInterestPct", i)));
                bo.setOtherInterestName(param(request, "iboOtherInterestName", i));

                AddressType otherAddress = readAddress(request, "iboOther", i);
                bo.setOtherInterestAddress(otherAddress);
            }

            ownership.getBeneficialOwner().add(bo);
            i++;
        }

        i = 0;
        while (param(request, "cboType", i) != null) {
            BeneficialOwnerType bo = new BeneficialOwnerType();
            bo.setPersonInd("N");
            bo.setBeneficialOwnerType(param(request, "cboType", i));
            bo.setOtherBeneficialOwnerDescription(param(request, "cboOtherType", i));
            bo.setSubcontractorName(param(request, "cboSubcontractorName", i));
            bo.setPercentOwnership(BinderUtils.getAsDouble(param(request, "cboPercentOwnership", i)));

            OrganizationType org = new OrganizationType();
            bo.setEntityInformation(org);
            org.setLegalName(param(request, "cboLegalName", i));
            org.setFEIN(param(request, "cboFEIN", i));

            org.setContactInformation(new ContactInformationType());
            AddressType address = readAddress(request, "cbo", i);
            org.getContactInformation().setAddress(address);

            bo.setOtherInterestInd(param(request, "cboOtherInterestInd", i));
            bo.setOtherInterestName(param(request, "cboOtherInterestName", i));

            if ("Y".equals(param(request, "cboOtherInterestInd", i))) {
                bo.setOtherInterestPercentOwnership(BinderUtils.getAsDouble(param(request, "cboOtherInterestPct", i)));
                AddressType otherAddress = readAddress(request, "cboOther", i);
                bo.setOtherInterestAddress(otherAddress);
            }

            ownership.getBeneficialOwner().add(bo);
            i++;
        }

        ProviderInformationType provider = XMLUtility.nsGetProvider(enrollment);
        provider.setOwnershipInformation(ownership);
        return exceptions;
    }

    /**
     * @param request
     * @param i
     * @return
     */
    private AddressType readAddress(HttpServletRequest request, String prefix, int i) {
        AddressType address = new AddressType();
        String line1 = param(request, prefix + "AddressLine1", i);
        String line2 = param(request, prefix +  "AddressLine2", i);
        
        if (Util.isBlank(line2)) { // prioritize line 2 usage
            line2 = line1;
            line1 = null;
        }

        address.setAddressLine1(line1);
        address.setAddressLine2(line2);
        address.setCity(param(request, prefix +  "City", i));
        address.setState(param(request, prefix + "State", i));
        address.setZipCode(param(request, prefix +  "Zip", i));
        address.setCounty(param(request, prefix + "County", i));
        return address;
    }

    /**
     * Binds the model to the request attributes.
     * @param enrollment the model to bind from
     * @param mv the model and view to bind to
     * @param readOnly if the view is read only
     */
    public void bindToPage(CMSUser user, EnrollmentType enrollment, Map<String, Object> mv, boolean readOnly) {
        attr(mv, "bound", "Y");
        OwnershipInformationType ownershipInformation = XMLUtility.nsGetOwnershipInformation(enrollment);

        attr(mv, "entityType", ownershipInformation.getEntityType());
        attr(mv, "entitySubType", ownershipInformation.getEntitySubType());
        attr(mv, "entityDescription", ownershipInformation.getOtherEntityDescription());

        List<BeneficialOwnerType> beneficialOwners = ownershipInformation.getBeneficialOwner();
        int personIndex = 0;
        int corpIndex = 0;
        for (BeneficialOwnerType bo : beneficialOwners) {
            String personInd = bo.getPersonInd();
            if ("Y".equals(personInd)) {
                attr(mv, "iboType", personIndex, bo.getBeneficialOwnerType());
                attr(mv, "iboOtherType", personIndex, bo.getOtherBeneficialOwnerDescription());
                attr(mv, "iboSubcontractorName", personIndex, bo.getSubcontractorName());
                if (bo.getPercentOwnership() != null) {
                    attr(mv, "iboPercentOwnership", personIndex, bo.getPercentOwnership().toString());
                }
                PersonType personInformation = bo.getPersonInformation();
                if (personInformation != null) {
                    attr(mv, "iboLastName", personIndex, personInformation.getLastName());
                    attr(mv, "iboFirstName", personIndex, personInformation.getFirstName());
                    attr(mv, "iboMiddleName", personIndex, personInformation.getMiddleName());
                    attr(mv, "iboSSN", personIndex, BinderUtils.formatSSN(personInformation.getSocialSecurityNumber()));
                    attr(mv, "iboDOB", personIndex, personInformation.getDateOfBirth());

                    if (personInformation.getContactInformation() != null) {
                        AddressType homeAddress = personInformation.getContactInformation().getAddress();
                        if (homeAddress != null) {
                            String line1 = homeAddress.getAddressLine1();
                            String line2 = homeAddress.getAddressLine2();
                            if (Util.isBlank(line1)) {
                                line1 = line2;
                                line2 = null;
                            }
                            attr(mv, "iboAddressLine1", personIndex, line1);
                            attr(mv, "iboAddressLine2", personIndex, line2);
                            attr(mv, "iboCity", personIndex, homeAddress.getCity());
                            attr(mv, "iboState", personIndex, homeAddress.getState());
                            attr(mv, "iboZip", personIndex, homeAddress.getZipCode());
                            attr(mv, "iboCounty", personIndex, homeAddress.getCounty());
                        }
                    }
                }

                attr(mv, "iboHireDate", personIndex, bo.getHireDate());
                attr(mv, "iboRelationship", personIndex, bo.getRelationship());
                attr(mv, "iboOtherInterestInd", personIndex, bo.getOtherInterestInd());
                attr(mv, "iboOtherInterestName", personIndex, bo.getOtherInterestName());
                if (bo.getOtherInterestPercentOwnership() != null) {
                    attr(mv, "iboOtherInterestPct", personIndex, bo.getOtherInterestPercentOwnership().toString());
                }

                AddressType otherAddress = bo.getOtherInterestAddress();
                if (otherAddress != null) {
                    String line1 = otherAddress.getAddressLine1();
                    String line2 = otherAddress.getAddressLine2();
                    if (Util.isBlank(line1)) {
                        line1 = line2;
                        line2 = null;
                    }
                    attr(mv, "iboOtherAddressLine1", personIndex, line1);
                    attr(mv, "iboOtherAddressLine2", personIndex, line2);
                    attr(mv, "iboOtherCity", personIndex, otherAddress.getCity());
                    attr(mv, "iboOtherState", personIndex, otherAddress.getState());
                    attr(mv, "iboOtherZip", personIndex, otherAddress.getZipCode());
                    attr(mv, "iboOtherCounty", personIndex, otherAddress.getCounty());
                }

                personIndex++;
            } else {
                attr(mv, "cboType", corpIndex, bo.getBeneficialOwnerType());
                attr(mv, "cboOtherType", personIndex, bo.getOtherBeneficialOwnerDescription());
                attr(mv, "cboSubcontractorName", personIndex, bo.getSubcontractorName());
                if (bo.getPercentOwnership() != null) {
                    attr(mv, "cboPercentOwnership", personIndex, bo.getPercentOwnership().toString());
                }

                OrganizationType orgInformation = bo.getEntityInformation();
                if (orgInformation != null) {
                    attr(mv, "cboLegalName", corpIndex, orgInformation.getLegalName());
                    attr(mv, "cboFEIN", corpIndex, orgInformation.getFEIN());

                    if (orgInformation.getContactInformation() != null) {
                        AddressType homeAddress = orgInformation.getContactInformation().getAddress();
                        if (homeAddress != null) {
                            String line1 = homeAddress.getAddressLine1();
                            String line2 = homeAddress.getAddressLine2();
                            if (Util.isBlank(line1)) {
                                line1 = line2;
                                line2 = null;
                            }
                            attr(mv, "cboAddressLine1", corpIndex, line1);
                            attr(mv, "cboAddressLine2", corpIndex, line2);
                            attr(mv, "cboCity", corpIndex, homeAddress.getCity());
                            attr(mv, "cboState", corpIndex, homeAddress.getState());
                            attr(mv, "cboZip", corpIndex, homeAddress.getZipCode());
                            attr(mv, "cboCounty", corpIndex, homeAddress.getCounty());
                        }
                    }
                }

                attr(mv, "cboOtherInterestInd", corpIndex, bo.getOtherInterestInd());
                attr(mv, "cboOtherInterestName", corpIndex, bo.getOtherInterestName());
                if (bo.getOtherInterestPercentOwnership() != null) {
                    attr(mv, "cboOtherInterestPct", corpIndex, bo.getOtherInterestPercentOwnership().toString());
                }

                AddressType otherAddress = bo.getOtherInterestAddress();
                if (otherAddress != null) {
                    String line1 = otherAddress.getAddressLine1();
                    String line2 = otherAddress.getAddressLine2();
                    if (Util.isBlank(line1)) {
                        line1 = line2;
                        line2 = null;
                    }
                    attr(mv, "cboOtherAddressLine1", personIndex, line1);
                    attr(mv, "cboOtherAddressLine2", personIndex, line2);
                    attr(mv, "cboOtherCity", corpIndex, otherAddress.getCity());
                    attr(mv, "cboOtherState", corpIndex, otherAddress.getState());
                    attr(mv, "cboOtherZip", corpIndex, otherAddress.getZipCode());
                    attr(mv, "cboOtherCounty", corpIndex, otherAddress.getCounty());
                }

                corpIndex++;
            }
        }

        attr(mv, "personOwnersSize", personIndex);
        attr(mv, "corpOwnersSize", corpIndex);

        if (!readOnly) {
            String entityType = ownershipInformation.getEntityType();
            List<gov.medicaid.entities.BeneficialOwnerType> customTypes = getLookupService().findBeneficialOwnerTypes(
                entityType);
            mv.put("beneficialOwnerTypes", customTypes);
            mv.put("entityStructureTypes", getLookupService().findAllLookups(EntityStructureType.class));
            mv.put("relationshipTypes", getLookupService().findAllLookups(RelationshipType.class));
        }
    }

    /**
     * Translates the validation results to form error messages where applicable.
     * @param enrollment the enrollment that was validated
     * @param messages the error messages
     *
     * @return the list of errors related to this form
     */
    protected List<FormError> selectErrors(EnrollmentType enrollment, StatusMessagesType messages) {
        List<FormError> errors = new ArrayList<FormError>();

        List<StatusMessageType> ruleErrors = messages.getStatusMessage();
        List<StatusMessageType> caughtMessages = new ArrayList<StatusMessageType>();
        
        OwnershipInformationType ownershipInformation = XMLUtility.nsGetOwnershipInformation(enrollment);
        synchronized (ruleErrors) {
            for (StatusMessageType ruleError : ruleErrors) {
                int count = errors.size();
                String path = ruleError.getRelatedElementPath();
                if (path == null) {
                    continue;
                }

                int entityIndex = 0;
                OwnershipInformationType ownership = XMLUtility.nsGetOwnershipInformation(enrollment);
                List<BeneficialOwnerType> boList = ownership.getBeneficialOwner();
                for (BeneficialOwnerType beneficialOwnerType : boList) {
                    if ("Y".equals(beneficialOwnerType.getPersonInd())) {
                        entityIndex++;
                    }
                }

                if (path.equals("/ProviderInformation/OwnershipInformation/EntityType")) {
                    errors.add(createError("entityType", ruleError.getMessage()));
                } else if (path.equals("/ProviderInformation/OwnershipInformation")) {
                    errors.add(createError("ownershipInformation", ruleError.getMessage()));
                } else if (path.startsWith("/ProviderInformation/OwnershipInformation/BeneficialOwner[")) {
                    FormError error = resolveFieldError(ownershipInformation, ruleError, entityIndex);
                    errors.add(error);
                }

                if (errors.size() > count) { // caught
                    caughtMessages.add(ruleError);
                }
            }

            // so it does not get processed anywhere again
            ruleErrors.removeAll(caughtMessages);
        }

        return errors.isEmpty() ? NO_ERRORS : errors;
    }

    /**
     * Resolves the specific license that is causing the error from the license list.
     * @param ownershipInformation 
     * @param ruleError the error to resolve
     * @param entityIndex
     * @return the resolved error
     */
    private FormError resolveFieldError(OwnershipInformationType ownershipInformation, StatusMessageType ruleError, int entityIndex) {
        String path = ruleError.getRelatedElementPath();
        Integer index = resolveIndex(path);
        boolean entity = false;
        
        boolean switch1 = false;
        boolean switch2 = false;
        if (index != null) {
            BeneficialOwnerType owner = ownershipInformation.getBeneficialOwner().get(index);
            
            if (index >= entityIndex) {
                index = index - entityIndex;
                entity = true;
            }
            
            if (entity) {
                if (owner.getEntityInformation() != null) {
                    ContactInformationType contact = owner.getEntityInformation().getContactInformation();
                    if (contact == null || contact.getAddress() == null || Util.isBlank(contact.getAddress().getAddressLine1())) {
                        switch1 = true;
                    }
                }
            } else {
                if (owner.getPersonInformation() != null) {
                    ContactInformationType contact = owner.getPersonInformation().getContactInformation();
                    if (contact == null || contact.getAddress() == null || Util.isBlank(contact.getAddress().getAddressLine1())) {
                        switch2 = true;
                    }
                }
            }
        }

        String message = ruleError.getMessage();
        if (index != null) {
            if (path.endsWith("BeneficialOwnerType")) {
                return createError(entity ? "cboType" : "iboType", index, message);
            } else if (path.endsWith("/PersonInformation/SocialSecurityNumber")) {
                return createError("iboSSN", index, message);
            } else if (path.endsWith("/HireDate")) {
                return createError("iboHireDate", index, message);
            } else if (path.endsWith("/OtherInterestName")) {
                return createError(entity ? "cboOtherInterestName" : "iboOtherInterestName", index, message);
            } else if (path.endsWith("/OtherInterestPercentOwnership")) {
                return createError(entity ? "cboOtherInterestPct" : "iboOtherInterestPct", index, message);
            } else if (path.endsWith("/OtherInterestAddress/AddressLine1")) {
                if (switch2) {
                    return createError(entity ? "cboOtherAddressLine2" : "iboOtherAddressLine2", index, message);
                } else {
                    return createError(entity ? "cboOtherAddressLine1" : "iboOtherAddressLine1", index, message);
                }
            } else if (path.endsWith("/OtherInterestAddress/AddressLine2")) {
                if (switch2) {
                    return createError(entity ? "cboOtherAddressLine1" : "iboOtherAddressLine1", index, message);
                } else {
                    return createError(entity ? "cboOtherAddressLine2" : "iboOtherAddressLine2", index, message);
                }
            } else if (path.endsWith("/OtherInterestAddress/City")) {
                return createError(entity ? "cboOtherCity" : "iboOtherCity", index, message);
            } else if (path.endsWith("/OtherInterestAddress/State")) {
                return createError(entity ? "cboOtherState" : "iboOtherState", index, message);
            } else if (path.endsWith("/OtherInterestAddress/ZipCode")) {
                return createError(entity ? "cboOtherZip" : "iboOtherZip", index, message);
            } else if (path.endsWith("/OtherInterestAddress/County")) {
                return createError(entity ? "cboOtherCounty" : "iboOtherCounty", index, message);
            } else if (path.endsWith("/EntityInformation/LegalName")) {
                return createError("cboLegalName", index, message);
            } else if (path.endsWith("/EntityInformation/FEIN")) {
                return createError("cboFEIN", index, message);
            } else if (path.endsWith("/PersonInformation/LastName")) {
                return createError("iboLastName", index, message);
            } else if (path.endsWith("/PersonInformation/FirstName")) {
                return createError("iboFirstName", index, message);
            } else if (path.endsWith("/PersonInformation/DateOfBirth")) {
                return createError("iboDOB", index, message);
            } else if (path.endsWith("/PersonInformation/SocialSecurityNumber")) {
                return createError("iboSSN", index, message);
            } else if (path.endsWith("/PersonInformation/ContactInformation/Address/AddressLine1")) {
                return createError(switch1 ? "iboAddressLine2" : "iboAddressLine1", index, message);
            } else if (path.endsWith("/PersonInformation/ContactInformation/Address/AddressLine2")) {
                return createError(switch1 ? "iboAddressLine1" : "iboAddressLine2", index, message);
            } else if (path.endsWith("/PersonInformation/ContactInformation/Address/City")) {
                return createError("iboCity", index, message);
            } else if (path.endsWith("/PersonInformation/ContactInformation/Address/State")) {
                return createError("iboState", index, message);
            } else if (path.endsWith("/PersonInformation/ContactInformation/Address/ZipCode")) {
                return createError("iboZip", index, message);
            } else if (path.endsWith("/PersonInformation/ContactInformation/Address/County")) {
                return createError("iboCounty", index, message);
            } else if (path.endsWith("/EntityInformation/ContactInformation/Address/AddressLine1")) {
                return createError(switch1 ? "cboAddressLine2" : "cboAddressLine1", index, message);
            } else if (path.endsWith("/EntityInformation/ContactInformation/Address/AddressLine2")) {
                return createError(switch1 ? "cboAddressLine1" : "cboAddressLine2", index, message);
            } else if (path.endsWith("/EntityInformation/ContactInformation/Address/City")) {
                return createError("cboCity", index, message);
            } else if (path.endsWith("/EntityInformation/ContactInformation/Address/State")) {
                return createError("cboState", index, message);
            } else if (path.endsWith("/EntityInformation/ContactInformation/Address/ZipCode")) {
                return createError("cboZip", index, message);
            } else if (path.endsWith("/EntityInformation/ContactInformation/Address/County")) {
                return createError("cboCounty", index, message);
            }
        }

        // general location error
        return createError("group", message);
    }


    /**
     * Resolves the index of the field that caused the error.
     * @param path the field path
     * @return the index of the field, null if cannot be resolved
     */
    private Integer resolveIndex(String path) {
        String strIdx = Util.getStringInBetween(path, "[", "]");
        if (!Util.isBlank(strIdx)) {
            return Integer.parseInt(strIdx);
        }
        return null;
    }

    /**
     * Binds the fields of the form to the persistence model.
     *
     * @param enrollment the front end model
     * @param ticket the persistent model
     * @throws PortalServiceException for any errors encountered
     */
    public void bindToHibernate(EnrollmentType enrollment, Enrollment ticket) throws PortalServiceException {
        ProviderProfile profile = ticket.getDetails();
        OwnershipInformationType ownership = XMLUtility.nsGetOwnershipInformation(enrollment);
        OwnershipInformation o = new OwnershipInformation();
        ArrayList<BeneficialOwner> beneficialOwners = new ArrayList<BeneficialOwner>();
        o.setBeneficialOwners(beneficialOwners);
        List<BeneficialOwnerType> owners = ownership.getBeneficialOwner();

        o.setEntityType(getLookupService().findLookupByDescription(EntityStructureType.class, ownership.getEntityType()));
        o.setEntitySubType(getLookupService().findLookupByDescription(EntityStructureType.class, ownership.getEntitySubType()));
        o.setOtherEntityTypeDesc(ownership.getOtherEntityDescription());

        for (BeneficialOwnerType owner : owners) {
            BeneficialOwner hbOwner = null;
            if ("Y".equals(owner.getPersonInd())) {
                PersonBeneficialOwner bo = new PersonBeneficialOwner();
                PersonType xPerson = owner.getPersonInformation();
                if (xPerson.getContactInformation() != null) {
                    bo.setAddress(BinderUtils.bindAddress(xPerson.getContactInformation().getAddress()));
                }
                bo.setRelationship(getLookupService().findLookupByDescription(RelationshipType.class, owner.getRelationship()));
                bo.setSsn(xPerson.getSocialSecurityNumber());
                bo.setFirstName(xPerson.getFirstName());
                bo.setLastName(xPerson.getLastName());
                bo.setMiddleName(xPerson.getMiddleName());
                bo.setDob(BinderUtils.toDate(xPerson.getDateOfBirth()));
                bo.setHireDate(BinderUtils.toDate(owner.getHireDate()));
                hbOwner = bo;
            } else {
                OrganizationBeneficialOwner bo = new OrganizationBeneficialOwner();
                OrganizationType xOrg = owner.getEntityInformation();
                if (xOrg.getContactInformation() != null) {
                    bo.setAddress(BinderUtils.bindAddress(xOrg.getContactInformation().getAddress()));
                }
                bo.setFein(xOrg.getFEIN());
                bo.setLegalName(xOrg.getLegalName());
                hbOwner = bo;
            }

            hbOwner.setType(getLookupService().findLookupByDescription(gov.medicaid.entities.BeneficialOwnerType.class,
                owner.getBeneficialOwnerType()));
            hbOwner.setTypeDescription(owner.getOtherBeneficialOwnerDescription());
            hbOwner.setSubcontractorName(owner.getSubcontractorName());
            if (owner.getPercentOwnership() != null) {
                hbOwner.setOwnershipInterest(BigDecimal.valueOf(owner.getPercentOwnership()));
            }
            hbOwner.setOtherProviderInterestInd(owner.getOtherInterestInd());
            hbOwner.setOtherProviderAddress(BinderUtils.bindAddress(owner.getOtherInterestAddress()));
            hbOwner.setOtherProviderLegalName(owner.getOtherInterestName());
            if (owner.getOtherInterestPercentOwnership() != null) {
                hbOwner.setOtherProviderOwnershipInterest(BigDecimal.valueOf(owner.getOtherInterestPercentOwnership()));
            }

            beneficialOwners.add(hbOwner);
        }

        profile.setOwnershipInformation(o);
    }

    /**
     * Binds the fields of the persistence model to the front end xml.
     *
     * @param ticket the persistent model
     * @param enrollment the front end model
     */
    public void bindFromHibernate(Enrollment ticket, EnrollmentType enrollment) {
        ProviderProfile profile = ticket.getDetails();
        OwnershipInformation ownership = profile.getOwnershipInformation();
        if (ownership != null) {
            OwnershipInformationType xOwnership = XMLUtility.nsGetOwnershipInformation(enrollment);

            if (ownership.getEntityType() != null) {
                xOwnership.setEntityType(ownership.getEntityType().getDescription());
            }

            if (ownership.getEntitySubType() != null) {
                xOwnership.setEntitySubType(ownership.getEntitySubType().getDescription());
            }

            xOwnership.setOtherEntityDescription(ownership.getOtherEntityTypeDesc());

            xOwnership.getBeneficialOwner().clear();
            List<BeneficialOwner> owners = ownership.getBeneficialOwners();
            for (BeneficialOwner owner : owners) {
                BeneficialOwnerType bo = new BeneficialOwnerType();
                if (owner.getType() != null) {
                    bo.setBeneficialOwnerType(owner.getType().getDescription());
                }
                bo.setSubcontractorName(owner.getSubcontractorName());
                if (owner.getOwnershipInterest() != null) {
                    bo.setPercentOwnership(owner.getOwnershipInterest().doubleValue());
                }
                bo.setOtherBeneficialOwnerDescription(owner.getTypeDescription());
                bo.setOtherInterestInd(owner.getOtherProviderInterestInd());
                bo.setOtherInterestAddress(BinderUtils.bindAddress(owner.getOtherProviderAddress()));
                bo.setOtherInterestName(owner.getOtherProviderLegalName());
                if (owner.getOtherProviderOwnershipInterest() != null) {
                    bo.setOtherInterestPercentOwnership(owner.getOtherProviderOwnershipInterest().doubleValue());
                }

                if (owner instanceof PersonBeneficialOwner) {
                    PersonBeneficialOwner person = (PersonBeneficialOwner) owner;
                    PersonType xPerson = new PersonType();
                    bo.setPersonInd("Y");
                    bo.setPersonInformation(xPerson);

                    xPerson.setContactInformation(new ContactInformationType());
                    xPerson.getContactInformation().setAddress(BinderUtils.bindAddress(owner.getAddress()));
                    xPerson.setFirstName(person.getFirstName());
                    xPerson.setMiddleName(person.getMiddleName());
                    xPerson.setLastName(person.getLastName());
                    xPerson.setSocialSecurityNumber(person.getSsn());

                    bo.setHireDate(BinderUtils.toCalendar(person.getHireDate()));
                    xPerson.setDateOfBirth(BinderUtils.toCalendar(person.getDob()));
                    if (person.getRelationship() != null) {
                        bo.setRelationship(person.getRelationship().getDescription());
                    }
                } else {
                    OrganizationBeneficialOwner org = (OrganizationBeneficialOwner) owner;
                    OrganizationType xOrg = new OrganizationType();
                    bo.setPersonInd("N");
                    bo.setEntityInformation(xOrg);

                    xOrg.setContactInformation(new ContactInformationType());
                    xOrg.getContactInformation().setAddress(BinderUtils.bindAddress(owner.getAddress()));
                    xOrg.setLegalName(org.getLegalName());
                    xOrg.setFEIN(org.getFein());
                }

                xOwnership.getBeneficialOwner().add(bo);
            }
        }
    }

    @Override
    public void renderPDF(EnrollmentType enrollment, Document document, Map<String, Object> model)
        throws DocumentException {
        
        
    }
}
