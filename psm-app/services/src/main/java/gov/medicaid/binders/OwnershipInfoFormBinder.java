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

package gov.medicaid.binders;

import com.lowagie.text.Document;
import com.lowagie.text.DocumentException;

import gov.medicaid.domain.model.AddressType;
import gov.medicaid.domain.model.ApplicationType;
import gov.medicaid.domain.model.BeneficialOwnerType;
import gov.medicaid.domain.model.ContactInformationType;
import gov.medicaid.domain.model.OrganizationType;
import gov.medicaid.domain.model.OwnershipInformationType;
import gov.medicaid.domain.model.PersonType;
import gov.medicaid.domain.model.ProviderInformationType;
import gov.medicaid.domain.model.StatusMessageType;
import gov.medicaid.domain.model.StatusMessagesType;
import gov.medicaid.entities.Application;
import gov.medicaid.entities.BeneficialOwner;
import gov.medicaid.entities.CMSUser;
import gov.medicaid.entities.EntityStructureType;
import gov.medicaid.entities.OrganizationBeneficialOwner;
import gov.medicaid.entities.OwnershipInformation;
import gov.medicaid.entities.PersonBeneficialOwner;
import gov.medicaid.entities.ProviderProfile;
import gov.medicaid.entities.RelationshipType;
import gov.medicaid.entities.dto.FormError;
import gov.medicaid.services.PortalServiceException;
import gov.medicaid.services.util.Util;

import javax.servlet.http.HttpServletRequest;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * This binder handles the organization information form.
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
     * @param application the model to bind to
     * @param request the request containing the form fields
     *
     * @throws BinderException if the format of the fields could not be bound properly
     */
    public List<BinderException> bindFromPage(CMSUser user, ApplicationType applicationType, HttpServletRequest request) {
        List<BinderException> exceptions = new ArrayList<BinderException>();
        OwnershipInformationType ownership = XMLUtility.nsGetOwnershipInformation(applicationType);

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

        ProviderInformationType provider = XMLUtility.nsGetProvider(applicationType);
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
        address.setAddressLine1(param(request, prefix + "AddressLine1", i));
        address.setAddressLine2(param(request, prefix + "AddressLine2", i));
        address.setCity(param(request, prefix + "City", i));
        address.setState(param(request, prefix + "State", i));
        address.setZipCode(param(request, prefix + "Zip", i));
        address.setCounty(param(request, prefix + "County", i));
        return address;
    }

    /**
     * Binds the model to the request attributes.
     * @param application the model to bind from
     * @param mv the model and view to bind to
     * @param readOnly if the view is read only
     */
    public void bindToPage(CMSUser user, ApplicationType applicationType, Map<String, Object> mv, boolean readOnly) {
        attr(mv, "bound", "Y");
        OwnershipInformationType ownershipInformation = XMLUtility.nsGetOwnershipInformation(applicationType);

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
                            attr(mv, "ibo", personIndex, homeAddress);
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
                    attr(mv, "iboOther", personIndex, otherAddress);
                }

                personIndex++;
            } else {
                attr(mv, "cboType", corpIndex, bo.getBeneficialOwnerType());
                attr(mv, "cboOtherType", personIndex, bo.getOtherBeneficialOwnerDescription());
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
                            attr(mv, "cbo", corpIndex, homeAddress);
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
                    attr(mv, "cboOther", personIndex, otherAddress);
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

    private void attr(
            Map<String, Object> mv,
            String prefix,
            int index,
            AddressType address
    ) {
        attr(mv, prefix + "AddressLine1", index, address.getAddressLine1());
        attr(mv, prefix + "AddressLine2", index, address.getAddressLine2());
        attr(mv, prefix + "City", index, address.getCity());
        attr(mv, prefix + "State", index, address.getState());
        attr(mv, prefix + "Zip", index, address.getZipCode());
        attr(mv, prefix + "County", index, address.getCounty());
    }

    /**
     * Translates the validation results to form error messages where applicable.
     * @param application the application that was validated
     * @param messages the error messages
     *
     * @return the list of errors related to this form
     */
    protected List<FormError> selectErrors(ApplicationType applicationType, StatusMessagesType messages) {
        List<FormError> errors = new ArrayList<FormError>();

        List<StatusMessageType> ruleErrors = messages.getStatusMessage();
        List<StatusMessageType> caughtMessages = new ArrayList<StatusMessageType>();

        OwnershipInformationType ownershipInformation = XMLUtility.nsGetOwnershipInformation(applicationType);
        synchronized (ruleErrors) {
            for (StatusMessageType ruleError : ruleErrors) {
                int count = errors.size();
                String path = ruleError.getRelatedElementPath();
                if (path == null) {
                    continue;
                }

                int entityIndex = 0;
                OwnershipInformationType ownership = XMLUtility.nsGetOwnershipInformation(applicationType);
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
                    FormError error = resolveFieldError(ruleError, entityIndex);
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
     *
     * @param ruleError   the error to resolve
     * @param entityIndex
     * @return the resolved error
     */
    private FormError resolveFieldError(
            StatusMessageType ruleError,
            int entityIndex
    ) {
        String path = ruleError.getRelatedElementPath();
        Integer index = resolveIndex(path);
        boolean entity = false;

        if (index != null) {
            if (index >= entityIndex) {
                index = index - entityIndex;
                entity = true;
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
                return createError(entity ? "cboOtherAddressLine1" : "iboOtherAddressLine1", index, message);
            } else if (path.endsWith("/OtherInterestAddress/AddressLine2")) {
                return createError(entity ? "cboOtherAddressLine2" : "iboOtherAddressLine2", index, message);
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
                return createError("iboAddressLine1", index, message);
            } else if (path.endsWith("/PersonInformation/ContactInformation/Address/AddressLine2")) {
                return createError("iboAddressLine2", index, message);
            } else if (path.endsWith("/PersonInformation/ContactInformation/Address/City")) {
                return createError("iboCity", index, message);
            } else if (path.endsWith("/PersonInformation/ContactInformation/Address/State")) {
                return createError("iboState", index, message);
            } else if (path.endsWith("/PersonInformation/ContactInformation/Address/ZipCode")) {
                return createError("iboZip", index, message);
            } else if (path.endsWith("/PersonInformation/ContactInformation/Address/County")) {
                return createError("iboCounty", index, message);
            } else if (path.endsWith("/EntityInformation/ContactInformation/Address/AddressLine1")) {
                return createError("cboAddressLine1", index, message);
            } else if (path.endsWith("/EntityInformation/ContactInformation/Address/AddressLine2")) {
                return createError("cboAddressLine2", index, message);
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
     * @param applicationType the front end model
     * @param application the persistent model
     * @throws PortalServiceException for any errors encountered
     */
    public void bindToHibernate(ApplicationType applicationType, Application application) throws PortalServiceException {
        ProviderProfile profile = application.getDetails();
        OwnershipInformationType ownership = XMLUtility.nsGetOwnershipInformation(applicationType);
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
     * @param application the persistent model
     * @param applicationType the front end model
     */
    public void bindFromHibernate(Application application, ApplicationType applicationType) {
        ProviderProfile profile = application.getDetails();
        OwnershipInformation ownership = profile.getOwnershipInformation();
        if (ownership != null) {
            OwnershipInformationType xOwnership = XMLUtility.nsGetOwnershipInformation(applicationType);

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
    public void renderPDF(ApplicationType applicationType, Document document, Map<String, Object> model)
        throws DocumentException {}
}
