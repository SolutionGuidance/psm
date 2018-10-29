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
import gov.medicaid.domain.model.ApplicationType;
import gov.medicaid.domain.model.ProviderAgreementType;
import gov.medicaid.domain.model.ProviderInformationType;
import gov.medicaid.domain.model.ProviderStatementType;
import gov.medicaid.domain.model.RequestType;
import gov.medicaid.domain.model.StatusMessageType;
import gov.medicaid.domain.model.StatusMessagesType;
import gov.medicaid.entities.AcceptedAgreements;
import gov.medicaid.entities.AgreementDocument;
import gov.medicaid.entities.Application;
import gov.medicaid.entities.CMSUser;
import gov.medicaid.entities.ProviderStatement;
import gov.medicaid.entities.dto.FormError;

import javax.servlet.http.HttpServletRequest;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collection;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.stream.Collectors;

/**
 * This binder handles the provider type selection form.
 */
public class OrganizationStatementFormBinder extends BaseFormBinder {

    /**
     * The namespace for this form.
     */
    public static final String NAMESPACE = "_19_";

    /**
     * Statement path.
     */
    private static final String STATEMENT = "/ProviderInformation/ProviderStatement/";

    /**
     * Agreement Path.
     */
    private static final String AGREEMENTS = "/ProviderInformation/AcceptedAgreements";

    /**
     * Creates a new binder.
     */
    public OrganizationStatementFormBinder() {
        super(NAMESPACE);
    }

    /**
     * Binds the request to the model.
     *
     * @param application the model to bind to
     * @param request    the request containing the form fields
     * @throws BinderException if the format of the fields could not be bound properly
     */
    public List<BinderException> bindFromPage(
            CMSUser user,
            ApplicationType applicationType,
            HttpServletRequest request
    ) {
        List<BinderException> exceptions = new ArrayList<BinderException>();
        ProviderInformationType provider = XMLUtility.nsGetProvider(applicationType);
        provider.setRenewalShowBlankStatement(param(request, "renewalBlankInit"));
        ProviderStatementType statement = XMLUtility.nsGetProviderStatement(applicationType);
        statement.setName(param(request, "name"));
        statement.setTitle(param(request, "title"));

        Set<AgreementDocument> docs = getProviderTypeService().getByDescription(
            provider.getProviderType()
        ).getAgreementDocuments();

        List<ProviderAgreementType> xList = new ArrayList<ProviderAgreementType>();
        HashSet<String> agreed = new HashSet<String>();
        for (int i = 0; i < docs.size(); i++) {
            String accepted = param(request, "accepted", i);
            String documentId = param(request, "documentId", i);
            if (accepted != null) {
                agreed.add(documentId);
            }
        }

        for (AgreementDocument doc : docs) {
            String documentId = String.valueOf(doc.getId());
            if (agreed.contains(documentId)) {
                ProviderAgreementType item = new ProviderAgreementType();
                item.setAgreementDocumentId(documentId);
                item.setAcceptedDate(Calendar.getInstance());
                item.setAgreementDocumentTitle(doc.getTitle());
                item.setAgreementDocumentType(doc.getType());
                item.setAgreementDocumentVersion(String.valueOf(doc.getVersion()));
                xList.add(item);
            }
        }

        AcceptedAgreementsType acceptedAgreements = XMLUtility.nsGetAcceptedAgreements(applicationType);
        List<ProviderAgreementType> providerAgreement = acceptedAgreements.getProviderAgreement();
        synchronized (providerAgreement) {
            providerAgreement.clear();
            providerAgreement.addAll(xList);
        }

        return exceptions;
    }

    /**
     * Binds the model to the request attributes.
     *
     * @param application the model to bind from
     * @param mv         the model and view to bind to
     * @param readOnly   true if the view is read only
     */
    public void bindToPage(
            CMSUser user,
            ApplicationType applicationType,
            Map<String, Object> mv,
            boolean readOnly
    ) {
        attr(mv, "bound", "Y");
        ProviderInformationType provider = XMLUtility.nsGetProvider(applicationType);

        Set<AgreementDocument> docs = getProviderTypeService().getByDescription(
            provider.getProviderType()
        ).getAgreementDocuments();

        if (applicationType.getRequestType() == RequestType.RENEWAL && "Y".equals(provider.getRenewalShowBlankStatement())) {
            attr(mv, "renewalBlankInit", "YY");

            int i = 0;
            for (AgreementDocument doc : docs) {
                attr(mv, "documentId", i, "" + doc.getId());
                attr(mv, "documentName", i, doc.getTitle());

                attr(mv, "accepted", i, "N");
                attr(mv, "updatedVersion", i, "N");
                i++;
            }
        } else {
            ProviderStatementType statement = XMLUtility.nsGetProviderStatement(applicationType);
            attr(mv, "name", statement.getName());
            attr(mv, "title", statement.getTitle());

            AcceptedAgreementsType acceptedAgreements = provider.getAcceptedAgreements();

            int i = 0;
            for (AgreementDocument doc : docs) {
                attr(mv, "documentId", i, "" + doc.getId());
                attr(mv, "documentName", i, doc.getTitle());

                boolean agreed = false;
                boolean updatedVersion = false;

                if (acceptedAgreements != null) {
                    List<ProviderAgreementType> agreements = acceptedAgreements.getProviderAgreement();
                    for (ProviderAgreementType agreement : agreements) {
                        if (doc.getType().equals(agreement.getAgreementDocumentType())) {
                            if (String.valueOf(doc.getVersion()).equals(agreement.getAgreementDocumentVersion())) {
                                agreed = true;
                            } else {
                                updatedVersion = true;
                            }
                            break;
                        }
                    }
                }

                attr(mv, "accepted", i, agreed ? "Y" : "N");
                attr(mv, "updatedVersion", i, updatedVersion ? "Y" : "N");
                i++;
            }

            attr(mv, "requiredAgreementsSize", docs.size());
        }
    }

    /**
     * Captures the error messages related to the form.
     *
     * @param application the application that was validated
     * @param messages   the messages to select from
     * @return the list of errors related to the form
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

                if (path.equals(AGREEMENTS)) {
                    errors.add(createError("agreements", ruleError.getMessage()));
                } else if (path.equals(STATEMENT + "Name")) {
                    errors.add(createError("name", ruleError.getMessage()));
                } else if (path.equals(STATEMENT + "Title")) {
                    errors.add(createError("title", ruleError.getMessage()));
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
     * Binds the fields of the form to the persistence model.
     *
     * @param applicationType the front end model
     * @param application     the persistent model
     */
    public void bindToHibernate(ApplicationType applicationType, Application application) {
        ProviderInformationType provider = XMLUtility.nsGetProvider(applicationType);

        Set<AgreementDocument> activeList = getProviderTypeService().getByDescription(
                provider.getProviderType()
        ).getAgreementDocuments();
        Map<String, AgreementDocument> documentMap = mapDocumentsById(activeList);

        AcceptedAgreementsType acceptedAgreementTypes = XMLUtility.nsGetAcceptedAgreements(applicationType);
        List<ProviderAgreementType> xList = acceptedAgreementTypes.getProviderAgreement();

        List<AcceptedAgreements> acceptedAgreements =
            xList.stream()
            .map(ProviderAgreementType::getAgreementDocumentId)
            .map(documentMap::get)
            .map(AcceptedAgreements::new)
            .collect(Collectors.toList());

        application.setAgreements(acceptedAgreements);

        ProviderStatementType xStatement = XMLUtility.nsGetProviderStatement(applicationType);
        ProviderStatement hStatement = application.getStatement();
        if (hStatement == null) {
            hStatement = new ProviderStatement();
            application.setStatement(hStatement);
        }

        hStatement.setName(xStatement.getName());
        hStatement.setTitle(xStatement.getTitle());
    }

    /**
     * Maps the given list by id.
     *
     * @param list the list to be mapped
     * @return the lookup map
     */
    private Map<String, AgreementDocument> mapDocumentsById(Collection<AgreementDocument> list) {
        Map<String, AgreementDocument> map = new HashMap<String, AgreementDocument>();
        for (AgreementDocument item : list) {
            map.put(String.valueOf(item.getId()), item);
        }
        return map;
    }

    /**
     * Binds the fields of the persistence model to the front end xml.
     *
     * @param application     the persistent model
     * @param applicationType the front end model
     */
    public void bindFromHibernate(Application application, ApplicationType applicationType) {
        ProviderInformationType provider = XMLUtility.nsGetProvider(applicationType);

        Set<AgreementDocument> activeList = getProviderTypeService().getByDescription(
            provider.getProviderType()
        ).getAgreementDocuments();
        Map<String, AgreementDocument> documentMap = mapDocumentsById(activeList);

        AcceptedAgreementsType acceptedAgreements = XMLUtility.nsGetAcceptedAgreements(applicationType);
        ArrayList<ProviderAgreementType> xlist = new ArrayList<ProviderAgreementType>();

        List<AcceptedAgreements> hList = application.getAgreements();
        for (AcceptedAgreements agreements : hList) {
            // bind only active items
            AgreementDocument document = agreements.getAgreementDocument();
            String documentId = String.valueOf(document.getId());
            if (documentMap.get(documentId) != null) {
                ProviderAgreementType type = new ProviderAgreementType();
                type.setAcceptedDate(BinderUtils.toCalendar(agreements.getAcceptedDate()));
                type.setAgreementDocumentId(documentId);
                type.setAgreementDocumentTitle(document.getTitle());
                type.setAgreementDocumentVersion(String.valueOf(document.getVersion()));
                type.setAgreementDocumentType(document.getType());
                xlist.add(type);
            }
        }

        acceptedAgreements.getProviderAgreement().clear();
        acceptedAgreements.getProviderAgreement().addAll(xlist);

        ProviderStatement hStatement = application.getStatement();
        if (hStatement != null) {
            ProviderStatementType xStatement = XMLUtility.nsGetProviderStatement(applicationType);
            xStatement.setName(hStatement.getName());
            xStatement.setTitle(hStatement.getTitle());
        }
    }
}
