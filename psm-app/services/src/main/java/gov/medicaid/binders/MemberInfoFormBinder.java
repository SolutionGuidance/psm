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
import com.lowagie.text.pdf.PdfPCell;
import com.lowagie.text.pdf.PdfPTable;

import gov.medicaid.domain.model.ApplicantType;
import gov.medicaid.domain.model.ApplicationType;
import gov.medicaid.domain.model.GroupMemberType;
import gov.medicaid.domain.model.MemberInformationType;
import gov.medicaid.domain.model.StatusMessageType;
import gov.medicaid.domain.model.StatusMessagesType;
import gov.medicaid.entities.Affiliation;
import gov.medicaid.entities.Application;
import gov.medicaid.entities.CMSUser;
import gov.medicaid.entities.Person;
import gov.medicaid.entities.ProviderProfile;
import gov.medicaid.entities.ProviderType;
import gov.medicaid.entities.dto.FormError;
import gov.medicaid.entities.dto.ViewStatics;
import gov.medicaid.services.PortalServiceException;
import gov.medicaid.services.util.PDFHelper;
import gov.medicaid.services.util.Util;

import javax.servlet.http.HttpServletRequest;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import java.util.Map;

/**
 * This binder handles the organization information form.
 */
public class MemberInfoFormBinder extends BaseFormBinder implements FormBinder {

    /**
     * The namespace for this form.
     */
    private static final String NAMESPACE = "_16_";

    /**
     * Creates a new instance.
     */
    public MemberInfoFormBinder() {
        super(NAMESPACE);
    }

    /**
     * Binds the request to the model.
     * @param application
     *            the model to bind to
     * @param request
     *            the request containing the form fields
     *
     * @throws BinderException
     *             if the format of the fields could not be bound properly
     */
    public List<BinderException> bindFromPage(CMSUser user, ApplicationType applicationType, HttpServletRequest request) {
        List<BinderException> exceptions = new ArrayList<BinderException>();
        MemberInformationType membership = XMLUtility.nsGetMembershipInformation(applicationType);
        membership.getGroupMember().clear();

        int i = 0;
        while (param(request, "objectId", i) != null) {
            GroupMemberType member = new GroupMemberType();
            member.setObjectId(param(request, "objectId", i));
            member.setNPI(param(request, "npi", i));
            member.setProviderType(param(request, "providerType", i));
            try {
                member.setDateOfBirth(BinderUtils.getAsCalendar(param(request, "dob", i)));
            } catch (BinderException e) {
                e.setAttribute(name("dob", i), param(request, "dob", i));
                exceptions.add(e);
            }
            try {
                member.setStartDate(BinderUtils.getAsCalendar(param(request, "startDate", i)));
            } catch (BinderException e) {
                e.setAttribute(name("startDate", i), param(request, "startDate", i));
                exceptions.add(e);
            }
            try {
                member.setBGSClearanceDate(BinderUtils.getAsCalendar(param(request, "bgsClearanceDate", i)));
            } catch (BinderException e) {
                e.setAttribute(name("bgsClearanceDate", i), param(request, "bgsClearanceDate", i));
                exceptions.add(e);
            }
            member.setBGSStudyId(param(request, "bgsStudyId", i));
            member.setFullName(param(request, "name", i));
            member.setSocialSecurityNumber(BinderUtils.unformatSSN(param(request, "ssn", i)));
            member.setEnrolled("Y"); // this may need lookup or hash verification
            membership.getGroupMember().add(member);
            i++;
        }
        return exceptions;
    }

    /**
     * Binds the model to the request attributes.
     * @param application
     *            the model to bind from
     * @param mv
     *            the model and view to bind to
     * @param readOnly
     *            if the view is read only
     */
    public void bindToPage(CMSUser user, ApplicationType applicationType, Map<String, Object> mv, boolean readOnly) {
        attr(mv, "bound", "Y");
        MemberInformationType membership = XMLUtility.nsGetMembershipInformation(applicationType);

        List<GroupMemberType> members = membership.getGroupMember();
        int i = 0;
        for (GroupMemberType member : members) {
            attr(mv, "objectId", i, member.getObjectId());
            attr(mv, "npi", i, member.getNPI());
            attr(mv, "providerType", i, member.getProviderType());
            attr(mv, "dob", i, member.getDateOfBirth());
            attr(mv, "startDate", i, member.getStartDate());
            attr(mv, "name", i, member.getFullName());
            attr(mv, "ssn", i, BinderUtils.formatSSN(member.getSocialSecurityNumber()));
            attr(mv, "bgsStudyId", i, member.getBGSStudyId());
            attr(mv, "bgsClearanceDate", i, member.getBGSClearanceDate());
            i++;
        }
        attr(mv, "memberSize", members.size());
        if (applicationType.getProviderInformation().getProviderType().equals(gov.medicaid.domain.model.ProviderType.PHARMACY.value())) {
            mv.put("onlyPharmacist", true);
        } else {
            mv.put("individualMemberProviderTypes", sortCollection(getProviderTypeService().getProviderTypes(ApplicantType.INDIVIDUAL)));
        }

    }

    /**
     * Translates the validation results to form error messages where applicable.
     *
     * @param application
     *            the application that was validated
     * @param messages
     *            the error messages
     *
     * @return the list of errors related to this form
     */
    protected List<FormError> selectErrors(ApplicationType applicationType, StatusMessagesType messages) {
        List<FormError> errors = new ArrayList<FormError>();

        List<StatusMessageType> ruleErrors = messages.getStatusMessage();
        List<StatusMessageType> caughtMessages = new ArrayList<StatusMessageType>();
        synchronized (ruleErrors) {
            for (StatusMessageType ruleError : ruleErrors) {
                int count = errors.size();
                String path = ruleError.getRelatedElementPath();
                if (path == null) {
                    continue;
                }

                if (path.equals("/ProviderInformation/MemberInformation")) {
                    errors.add(createError("memberInformation", ruleError.getMessage()));
                } else if (path.startsWith("/ProviderInformation/MemberInformation/GroupMember[")) {
                    FormError error = resolveFieldError(ruleError);
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
     * @param ruleError
     *            the error to resolve
     * @return the resolved error
     */
    private FormError resolveFieldError(StatusMessageType ruleError) {
        String path = ruleError.getRelatedElementPath();
        Integer index = resolveIndex(path);

        String message = ruleError.getMessage();

        if (index != null) {
            if (path.endsWith("StartDate")) {
                return createError("startDate", index, message);
            } else if (path.endsWith("NPI")) {
                return createError("npi", index, message);
            } else if (path.endsWith("ProviderType")) {
                return createError("providerType", index, message);
            } else if (path.endsWith("DateOfBirth")) {
                return createError("dob", index, message);
            } else if (path.endsWith("FullName")) {
                return createError("name", index, message);
            } else if (path.endsWith("SocialSecurityNumber")) {
                return createError("ssn", index, message);
            } else if (path.endsWith("BGSClearanceDate")) {
                return createError("bgsClearanceDate", index, message);
            } else if (path.endsWith("BGSStudyId")) {
                return createError("bgsStudyId", index, message);
            }
        }

        // general location error
        return createError("group", message);
    }

    /**
     * Resolves the index of the field that caused the error.
     *
     * @param path
     *            the field path
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
     * @param application
     *            the front end model
     * @param application
     *            the persistent model
     * @throws PortalServiceException
     *             for any errors encountered
     */
    public void bindToHibernate(ApplicationType applicationType, Application application) throws PortalServiceException {
        ProviderProfile profile = application.getDetails();

        MemberInformationType membership = XMLUtility.nsGetMembershipInformation(applicationType);
        if (profile.getAffiliations() == null) {
            profile.setAffiliations(new ArrayList<Affiliation>());
        }
        List<Affiliation> members = new ArrayList<Affiliation>();
        List<GroupMemberType> groupMembers = membership.getGroupMember();
        for (GroupMemberType groupMemberType : groupMembers) {
            Affiliation member = new Affiliation();
            member.setObjectType(ViewStatics.DISCRIMINATOR_MEMBER);
            member.setEffectiveDate(BinderUtils.toDate(groupMemberType.getStartDate()));
            member.setBgsStudyId(groupMemberType.getBGSStudyId());
            member.setBgsClearanceDate(BinderUtils.toDate(groupMemberType.getBGSClearanceDate()));
            Person person = new Person();
            person.setName(groupMemberType.getFullName());
            person.setSsn(groupMemberType.getSocialSecurityNumber());
            person.setDob(BinderUtils.toDate(groupMemberType.getDateOfBirth()));
            person.setNpi(groupMemberType.getNPI());
            person.setProviderType(getLookupService().findLookupByDescription(ProviderType.class,
                    groupMemberType.getProviderType()));
            member.setEntity(person);
            members.add(member);
        }

        List<Affiliation> affiliations = profile.getAffiliations();
        synchronized (affiliations) {
            affiliations.removeAll(filterMembers(affiliations));
            affiliations.addAll(members);
        }
    }

    /**
     * Retrieves the primary affiliation, null if not found.
     *
     * @param groups
     *            all affiliations
     * @return the one with PRIMARY=Y
     */
    protected List<Affiliation> filterMembers(List<Affiliation> groups) {
        List<Affiliation> members = new ArrayList<Affiliation>();
        synchronized (groups) {
            for (Affiliation affiliation : groups) {
                if (ViewStatics.DISCRIMINATOR_MEMBER.equals(affiliation.getObjectType())) {
                    members.add(affiliation);
                }
            }
        }
        return members;
    }

    /**
     * Binds the fields of the persistence model to the front end xml.
     *
     * @param application
     *            the persistent model
     * @param application
     *            the front end model
     */
    public void bindFromHibernate(Application application, ApplicationType applicationType) {
        ProviderProfile profile = application.getDetails();
        if (profile != null) {
            List<Affiliation> affiliations = profile.getAffiliations();
            MemberInformationType membership = XMLUtility.nsGetMembershipInformation(applicationType);
            if (affiliations != null) {
                for (Affiliation affiliation : filterMembers(affiliations)) {
                    GroupMemberType member = new GroupMemberType();
                    Person entity = (Person) affiliation.getEntity();
                    member.setDateOfBirth(BinderUtils.toCalendar(entity.getDob()));
                    member.setStartDate(BinderUtils.toCalendar(affiliation.getEffectiveDate()));
                    member.setNPI(entity.getNpi());
                    member.setFullName(entity.getName());
                    if (entity.getProviderType() != null) {
                        member.setProviderType(entity.getProviderType().getDescription());
                    }
                    member.setSocialSecurityNumber(entity.getSsn());
                    member.setBGSStudyId(affiliation.getBgsStudyId());
                    member.setBGSClearanceDate(BinderUtils.toCalendar(affiliation.getBgsClearanceDate()));
                    membership.getGroupMember().add(member);
                }
            }
        }
    }

    @Override
    public void renderPDF(ApplicationType applicationType, Document document, Map<String, Object> model)
            throws DocumentException {
        String ns = NAMESPACE;
        if ("Y".equals(PDFHelper.value(model, ns, "bound"))) {
            // License Info Section
            PdfPTable membersInfo = new PdfPTable(new float[] { 5, 65 });
            membersInfo.getDefaultCell().setBorder(0);
            membersInfo.getDefaultCell().setHorizontalAlignment(PdfPCell.ALIGN_CENTER);

            membersInfo.setTotalWidth(72 * 7);
            membersInfo.setLockedWidth(true);

            int size = Integer.parseInt(PDFHelper.value(model, ns, "memberSize"));
            for (int i = 0; i < size; i++) {
                PDFHelper.addCenterCell(membersInfo, String.valueOf(i + 1));
                PdfPTable memberDetail = new PdfPTable(2);
                PDFHelper.addLabelValueCell(memberDetail, "NPI", PDFHelper.value(model, ns, "npi", i));
                PDFHelper.addLabelValueCell(memberDetail, "Provider Type",
                        PDFHelper.value(model, ns, "providerType", i));
                PDFHelper.addLabelValueCell(memberDetail, "Name", PDFHelper.value(model, ns, "name", i));
                PDFHelper.addLabelValueCell(memberDetail, "Date Of Birth", PDFHelper.value(model, ns, "dob", i));
                PDFHelper.addLabelValueCell(memberDetail, "SSN", PDFHelper.value(model, ns, "ssn", i));
                PDFHelper.addLabelValueCell(memberDetail, "Start Date", PDFHelper.value(model, ns, "startDate", i));
                membersInfo.addCell(memberDetail);
                membersInfo.completeRow();
            }
            document.add(membersInfo);
        }

    }

    /**
     * Sorts the displayed provider types (PESP-252_
     *
     * @param providerTypes
     *            the provider types to sort
     * @return the sorted types
     */
    private List<ProviderType> sortCollection(List<ProviderType> providerTypes) {
        List<ProviderType> sortedList = new ArrayList<ProviderType>(providerTypes);
        Collections.sort(sortedList, new Comparator<ProviderType>() {
            @Override
            public int compare(ProviderType o1, ProviderType o2) {
                return o1.getDescription().compareTo(o2.getDescription());
            }
        });
        return sortedList;
    }
}
