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

import gov.medicaid.domain.model.AcceptedAgreementsType;
import gov.medicaid.domain.model.AdditionalPracticeLocationsType;
import gov.medicaid.domain.model.AddressType;
import gov.medicaid.domain.model.AgencyInformationType;
import gov.medicaid.domain.model.ApplicantInformationType;
import gov.medicaid.domain.model.ApplicationProcess;
import gov.medicaid.domain.model.ApplicationStatusChangeType;
import gov.medicaid.domain.model.ApplicationStatusHistoryType;
import gov.medicaid.domain.model.ApplicationStatusType;
import gov.medicaid.domain.model.ApplicationType;
import gov.medicaid.domain.model.AttachedDocumentsType;
import gov.medicaid.domain.model.ContactInformationType;
import gov.medicaid.domain.model.DesignatedContactInformationType;
import gov.medicaid.domain.model.FacilityCredentialsType;
import gov.medicaid.domain.model.IndividualApplicantType;
import gov.medicaid.domain.model.LicenseInformationType;
import gov.medicaid.domain.model.MemberInformationType;
import gov.medicaid.domain.model.OperationStatusType;
import gov.medicaid.domain.model.OrganizationApplicantType;
import gov.medicaid.domain.model.OwnershipInformationType;
import gov.medicaid.domain.model.PersonType;
import gov.medicaid.domain.model.PracticeInformationType;
import gov.medicaid.domain.model.ProcessAuditType;
import gov.medicaid.domain.model.ProcessExecutionType;
import gov.medicaid.domain.model.ProcessResultsType;
import gov.medicaid.domain.model.ProviderInformationType;
import gov.medicaid.domain.model.ProviderSetupInformationType;
import gov.medicaid.domain.model.ProviderStatementType;
import gov.medicaid.domain.model.QualifiedProfessionalsType;
import gov.medicaid.domain.model.ScreeningResultsType;
import gov.medicaid.domain.model.SpecialtiesType;
import gov.medicaid.domain.model.ValidationResultType;
import gov.medicaid.domain.model.VerificationStatusType;

import javax.xml.bind.JAXBContext;
import javax.xml.bind.Marshaller;

import java.util.Calendar;
import java.util.List;

/**
 * Utility methods for manipulating the process model.
 */
public class XMLUtility {

    /**
     * Private constructor.
     */
    private XMLUtility() {
    }

    /**
     * Wraps the given string in an operation status entity.
     *
     * @param value the status code
     * @return the wrapper for the status
     */
    public static OperationStatusType newStatus(String value) {
        OperationStatusType status = new OperationStatusType();
        status.setStatusCode(value);
        return status;
    }

    /**
     * Null safe get for the <code>ScreeningResultsType</code> entity.
     *
     * @param model the model to get it from
     * @return the element (created if not found)
     */
    public static ScreeningResultsType nsGetScreeningResults(ApplicationProcess model) {
        ProcessResultsType results = nsGetProcessResults(model);
        if (results.getScreeningResults() == null) {
            results.setScreeningResults(new ScreeningResultsType());
        }

        return results.getScreeningResults();
    }

    /**
     * Null safe get for the <code>ProcessResultsType</code> entity.
     *
     * @param model the model to get it from
     * @return the element (created if not found)
     */
    public static ProcessResultsType nsGetProcessResults(ApplicationProcess model) {
        if (model.getProcessResults() == null) {
            model.setProcessResults(new ProcessResultsType());
        }
        return model.getProcessResults();
    }

    /**
     * Null safe get for the <code>ValidationResultType</code> entity.
     *
     * @param model the model to get it from
     * @return the element (created if not found)
     */
    public static ValidationResultType nsGetValidationResult(ApplicationProcess model) {
        ProcessResultsType results = nsGetProcessResults(model);
        if (results.getValidationResult() == null) {
            results.setValidationResult(new ValidationResultType());
        }
        return results.getValidationResult();
    }

    /**
     * Null safe get for the <code>ApplicationStatusHistoryType</code> entity.
     *
     * @param model the model to get it from
     * @return the element (created if not found)
     */
    public static ApplicationStatusHistoryType nsGetApplicationStatusHistory(ApplicationProcess model) {
        if (model.getApplicationStatusHistory() == null) {
            model.setApplicationStatusHistory(new ApplicationStatusHistoryType());
        }

        return model.getApplicationStatusHistory();
    }

    /**
     * Null safe get for the <code>ProcessAuditType</code> entity.
     *
     * @param model the model to get it from
     * @return the element (created if not found)
     */
    public static ProcessAuditType nsGetProcessAudit(ApplicationProcess model) {
        if (model.getProcessAudit() == null) {
            model.setProcessAudit(new ProcessAuditType());
        }
        return model.getProcessAudit();
    }

    /**
     * Null safe get for the <code>LicenseInformationType</code> entity.
     *
     * @param model the model to get it from
     * @return the element (created if not found)
     */
    public static LicenseInformationType nsGetLicenseInformation(ApplicationProcess model) {
        ProviderInformationType provider = nsGetProvider(model);
        return nsGetLicenseInformation(provider);
    }


    /**
     * Null safe get for the <code>FacilityCredentialsType</code> entity.
     *
     * @param model the model to get it from
     * @return the element (created if not found)
     */
    public static FacilityCredentialsType nsGetFacilityCredentials(ApplicationProcess model) {
        ProviderInformationType provider = nsGetProvider(model);
        if (provider.getFacilityCredentials() == null) {
            provider.setFacilityCredentials(new FacilityCredentialsType());
        }
        return provider.getFacilityCredentials();
    }

    /**
     * Null safe get for the <code>ProviderInformationType</code> entity.
     *
     * @param model the model to get it from
     * @return the element (created if not found)
     */
    public static ProviderInformationType nsGetProvider(ApplicationProcess model) {
        ApplicationType applicationType = model.getApplication();
        return nsGetProvider(applicationType);
    }

    /**
     * Null safe get for the <code>ProviderInformationType</code> entity.
     *
     * @param application the model to get it from
     * @return the element (created if not found)
     */
    public static ProviderInformationType nsGetProvider(ApplicationType applicationType) {
        if (applicationType.getProviderInformation() == null) {
            applicationType.setProviderInformation(new ProviderInformationType());
        }
        return applicationType.getProviderInformation();
    }

    /**
     * Sets the status of the given application. This will change the given model.
     *
     * @param model the model to update
     * @param actor the user/system that initiated the status change
     * @param statusCode the new status
     * @param comment the status comment
     */
    public static void moveToStatus(ApplicationProcess model, String actor, String statusCode, String comment) {
        String oldStatus = null;

        if (model.getApplicationStatus() != null) {
            oldStatus = model.getApplicationStatus().getStatus();
        }

        ApplicationStatusType status = new ApplicationStatusType();
        status.setStatus(statusCode);
        status.setStatusDate(Calendar.getInstance());
        status.setStatusReason(comment);
        model.setApplicationStatus(status);

        ApplicationStatusHistoryType statusHistory = nsGetApplicationStatusHistory(model);
        List<ApplicationStatusChangeType> applicationStatusChange = statusHistory.getApplicationStatusChange();
        ApplicationStatusChangeType change = new ApplicationStatusChangeType();
        change.setFromStatus(oldStatus);
        change.setToStatus(status.getStatus());
        change.setModifiedBy(actor);
        change.setStatusDate(status.getStatusDate());
        change.setStatusReason(status.getStatusReason());
        applicationStatusChange.add(change);
    }

    /**
     * Audits the start of a process execution.
     *
     * @param model the application process model
     * @param nodeId the node id
     * @param nodeName the node name
     */
    public static void auditStart(ApplicationProcess model, long nodeId, String nodeName) {
        ProcessAuditType processAudit = nsGetProcessAudit(model);
        ProcessExecutionType processExecutionType = new ProcessExecutionType();
        processExecutionType.setObjectId("" + nodeId);
        processExecutionType.setProcessName(nodeName);
        processExecutionType.setStartTime(Calendar.getInstance());
        processAudit.getProcessExecutions().add(processExecutionType);
    }

    /**
     * Audits the end of a process execution (note that this is only called for non-sequential nodes).
     *
     * @param model the application process model
     * @param nodeId the node id
     */
    public static void auditEnd(ApplicationProcess model, long nodeId) {
        ProcessAuditType processAudit = nsGetProcessAudit(model);
        List<ProcessExecutionType> processExecutions = processAudit.getProcessExecutions();
        for (ProcessExecutionType processExecutionType : processExecutions) {
            if (processExecutionType.getObjectId().equals("" + nodeId)) {
                processExecutionType.setEndTime(Calendar.getInstance());
            }
        }
    }

    /**
     * Prints the document for debug.
     *
     * @param model the model to be printed
     * @throws Exception for any errors encountered
     */
    public static void printModel(Object model) throws Exception {
        JAXBContext jaxbContext = JAXBContext.newInstance("gov.medicaid.domain.model");
        Marshaller marshaller = jaxbContext.createMarshaller();
        marshaller.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT, Boolean.TRUE);
        marshaller.marshal(model, System.out);
    }

    /**
     * Null safe get for the individual applicant.
     *
     * @param application the object to get the property from
     * @return the required property
     */
    public static IndividualApplicantType nsGetIndividual(ApplicationType applicationType) {
        ApplicantInformationType applicant = nsGetApplicant(applicationType);
        if (applicant.getPersonalInformation() == null) {
            applicant.setPersonalInformation(new IndividualApplicantType());
        }

        return applicant.getPersonalInformation();
    }

    /**
     * Null safe get for the applicant.
     *
     * @param application the object to get the property from
     * @return the required property
     */
    private static ApplicantInformationType nsGetApplicant(ApplicationType applicationType) {
        ProviderInformationType provider = nsGetProvider(applicationType);
        if (provider.getApplicantInformation() == null) {
            provider.setApplicantInformation(new ApplicantInformationType());
        }
        return provider.getApplicantInformation();
    }

    /**
     * Null safe get for the contact information.
     *
     * @param person the object to get the property from
     * @return the required property
     */
    public static ContactInformationType nsGetContactInformation(PersonType person) {
        if (person.getContactInformation() == null) {
            person.setContactInformation(new ContactInformationType());
        }
        return person.getContactInformation();
    }

    /**
     * Null safe get for the contact information.
     *
     * @param application the object to get the property from
     * @return the required property
     */
    public static ContactInformationType nsGetContactInformation(ApplicationType applicationType) {
        if (applicationType.getContactInformation() == null) {
            applicationType.setContactInformation(new ContactInformationType());
        }
        return applicationType.getContactInformation();
    }

    /**
     * Null safe get for the license information.
     *
     * @param provider the object to get the property from
     * @return the required property
     */
    public static LicenseInformationType nsGetLicenseInformation(ProviderInformationType provider) {
        if (provider.getLicenseInformation() == null) {
            provider.setLicenseInformation(new LicenseInformationType());
        }
        return provider.getLicenseInformation();
    }

    /**
     * Null safe get for the attachments.
     *
     * @param provider the object to get the property from
     * @return the required property
     */
    public static AttachedDocumentsType nsGetAttachments(ProviderInformationType provider) {
        AttachedDocumentsType attachments;
        if (provider.getAttachedDocuments() == null) {
            provider.setAttachedDocuments(new AttachedDocumentsType());
        }
        attachments = provider.getAttachedDocuments();
        return attachments;
    }

    /**
     * Null safe get for the practice information.
     *
     * @param application the object to get the property from
     * @return the required property
     */
    public static PracticeInformationType nsGetPracticeInformation(ApplicationType applicationType) {
        ProviderInformationType provider = nsGetProvider(applicationType);
        if (provider.getPracticeInformation() == null) {
            provider.setPracticeInformation(new PracticeInformationType());
        }
        return provider.getPracticeInformation();
    }

    /**
     * Null safe get for the address.
     *
     * @param practice the object to get the property from
     * @return the required property
     */
    public static AddressType nsGetAddress(PracticeInformationType practice) {
        return nsGetAddress(nsGetContactInformation(practice));
    }

    /**
     * Null safe get for the contact information.
     *
     * @param practice the object to get the property from
     * @return the required property
     */
    public static ContactInformationType nsGetContactInformation(PracticeInformationType practice) {
        if (practice.getContactInformation() == null) {
            practice.setContactInformation(new ContactInformationType());
        }
        return practice.getContactInformation();
    }

    /**
     * Null safe get for the address.
     *
     * @param contact the object to get the property from
     * @return the required property
     */
    public static AddressType nsGetAddress(ContactInformationType contact) {
        if (contact.getAddress() == null) {
            contact.setAddress(new AddressType());
        }
        return contact.getAddress();
    }

    /**
     * Null safe get for additional practice locations.
     *
     * @param practice the object to get the property from
     * @return the required property
     */
    public static AdditionalPracticeLocationsType nsGetOtherLocations(PracticeInformationType practice) {
        if (practice.getAdditionalPracticeLocations() == null) {
            practice.setAdditionalPracticeLocations(new AdditionalPracticeLocationsType());
        }
        return practice.getAdditionalPracticeLocations();
    }

    /**
     * Null safe get for accepted agreements.
     *
     * @param application the object to get the property from
     * @return the required property
     */
    public static AcceptedAgreementsType nsGetAcceptedAgreements(ApplicationType applicationType) {
        ProviderInformationType provider = nsGetProvider(applicationType);
        if (provider.getAcceptedAgreements() == null) {
            provider.setAcceptedAgreements(new AcceptedAgreementsType());
        }
        return provider.getAcceptedAgreements();
    }

    /**
     * Null safe get for provider statement.
     *
     * @param application the object to get the property from
     * @return the required property
     */
    public static ProviderStatementType nsGetProviderStatement(ApplicationType applicationType) {
        ProviderInformationType provider = nsGetProvider(applicationType);
        if (provider.getProviderStatement() == null) {
            provider.setProviderStatement(new ProviderStatementType());
        }
        return provider.getProviderStatement();
    }

    /**
     * Null safe get for provider agency.
     *
     * @param application the object to get the property from
     * @return the required property
     */
    public static AgencyInformationType nsGetAgencyInformation(ApplicationType applicationType) {
        ProviderInformationType provider = nsGetProvider(applicationType);
        if (provider.getAgencyInformation() == null) {
            provider.setAgencyInformation(new AgencyInformationType());
        }
        return provider.getAgencyInformation();
    }

    /**
     * Null safe get for provider verification status.
     *
     * @param processModel the object to get the property from
     * @return the required property
     */
    public static VerificationStatusType nsGetVerificationStatus(ApplicationProcess processModel) {
        ProviderInformationType provider = nsGetProvider(processModel);
        if (provider.getVerificationStatus() == null) {
            provider.setVerificationStatus(new VerificationStatusType());
        }
        return provider.getVerificationStatus();
    }

    /**
     * Null safe get for provider specialites.
     *
     * @param provider the object to get the property from
     * @return the required property
     */
    public static SpecialtiesType nsGetSpecialties(ProviderInformationType provider) {
        if (provider.getSpecialties() == null) {
            provider.setSpecialties(new SpecialtiesType());
        }
        return provider.getSpecialties();
    }

    /**
     * Null safe get for the organization applicant.
     *
     * @param application the object to get the property from
     * @return the required property
     */
    public static OrganizationApplicantType nsGetOrganization(ApplicationType applicationType) {
        ApplicantInformationType applicant = nsGetApplicant(applicationType);
        if (applicant.getOrganizationInformation() == null) {
            applicant.setOrganizationInformation(new OrganizationApplicantType());
        }

        return applicant.getOrganizationInformation();
    }

    /**
     * Null safe get for the contact information.
     *
     * @param org the object to get the property from
     * @return the required property
     */
    public static ContactInformationType nsGetContactInformation(OrganizationApplicantType org) {
        if (org.getContactInformation() == null) {
            org.setContactInformation(new ContactInformationType());
        }
        return org.getContactInformation();
    }

    /**
     * Null safe get for the member information.
     *
     * @param application the object to get the property from
     * @return the required property
     */
    public static MemberInformationType nsGetMembershipInformation(ApplicationType applicationType) {
        ProviderInformationType provider = nsGetProvider(applicationType);
        if (provider.getMemberInformation() == null) {
            provider.setMemberInformation(new MemberInformationType());
        }
        return provider.getMemberInformation();
    }

    /**
     * Null safe get for the ownership information.
     *
     * @param application the object to get the property from
     * @return the required property
     */
    public static OwnershipInformationType nsGetOwnershipInformation(ApplicationType applicationType) {
        ProviderInformationType provider = nsGetProvider(applicationType);
        if (provider.getOwnershipInformation() == null) {
            provider.setOwnershipInformation(new OwnershipInformationType());
        }
        return provider.getOwnershipInformation();
    }

    /**
     * Null safe get for the setup information.
     *
     * @param application the object to get the property from
     * @return the required property
     */
    public static ProviderSetupInformationType nsGetProviderSetup(ApplicationType applicationType) {
        ProviderInformationType provider = nsGetProvider(applicationType);
        if (provider.getProviderSetupInformation() == null) {
            provider.setProviderSetupInformation(new ProviderSetupInformationType());
        }
        return provider.getProviderSetupInformation();
    }

    /**
     * Null safe get for the facility license information.
     *
     * @param application the object to get the property from
     * @return the required property
     */
    public static FacilityCredentialsType nsGetFacilityCredentials(ApplicationType applicationType) {
        ProviderInformationType provider = nsGetProvider(applicationType);
        if (provider.getFacilityCredentials() == null) {
            provider.setFacilityCredentials(new FacilityCredentialsType());
        }
        return provider.getFacilityCredentials();
    }

    /**
     * Null safe get for the qualified prof information.
     *
     * @param application the object to get the property from
     * @return the required property
     */
    public static QualifiedProfessionalsType nsGetQualifiedProfessionals(ApplicationType applicationType) {
        ProviderInformationType provider = nsGetProvider(applicationType);
        if (provider.getQualifiedProfessionals() == null) {
            provider.setQualifiedProfessionals(new QualifiedProfessionalsType());
        }
        return provider.getQualifiedProfessionals();
    }

    /**
     * Null safe get for the designated contact information.
     *
     * @param application the object to get the property from
     * @return the required property
     */
    public static DesignatedContactInformationType nsGetDesignatedContactInformation(ApplicationType application) {
        ProviderInformationType provider = nsGetProvider(application);
        if (provider.getDesignatedContactInformation() == null) {
            provider.setDesignatedContactInformation(new DesignatedContactInformationType());
        }
        return provider.getDesignatedContactInformation();
    }
}
