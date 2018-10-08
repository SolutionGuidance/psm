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

import gov.medicaid.domain.model.ApplicantType;
import gov.medicaid.domain.model.ApplicationType;
import gov.medicaid.domain.model.OperationStatusType;
import gov.medicaid.domain.model.ProviderInformationType;
import gov.medicaid.domain.model.StatusMessageType;
import gov.medicaid.domain.model.StatusMessagesType;
import gov.medicaid.domain.model.UISection;
import gov.medicaid.domain.model.ValidationRequest;
import gov.medicaid.domain.model.ValidationResponse;
import gov.medicaid.domain.model.ValidationResultType;
import gov.medicaid.domain.rules.inference.LookupEntry;

import org.drools.KnowledgeBase;
import org.drools.KnowledgeBaseFactory;
import org.drools.builder.KnowledgeBuilder;
import org.drools.builder.KnowledgeBuilderError;
import org.drools.builder.KnowledgeBuilderErrors;
import org.drools.builder.KnowledgeBuilderFactory;
import org.drools.builder.ResourceType;
import org.drools.definition.rule.Rule;
import org.drools.event.rule.BeforeActivationFiredEvent;
import org.drools.event.rule.DefaultAgendaEventListener;
import org.drools.io.ResourceFactory;
import org.drools.runtime.StatefulKnowledgeSession;

import java.util.ArrayList;
import java.util.List;

/**
 * Simple test case for the Domain Specific Language Rules.
 */
public class DSLTester {

    /**
     * The composed knowledge base containing validation.
     */
    private KnowledgeBase dslKnowledgeBase = readValidationKnowledgeBase();

    public DSLTester() {
    }

    public StatefulKnowledgeSession newDSLValidationSession() {
        StatefulKnowledgeSession session = dslKnowledgeBase.newStatefulKnowledgeSession();
        session.addEventListener(new EventListener());
        return session;
    }

    /**
     * Creates the knowledge base from the screening packages.
     *
     * @return the knowledge base
     */
    private KnowledgeBase readValidationKnowledgeBase() {
        KnowledgeBuilder kbuilder = KnowledgeBuilderFactory.newKnowledgeBuilder();
        kbuilder.add(ResourceFactory.newClassPathResource("cms.dsl"), ResourceType.DSL);
        kbuilder.add(ResourceFactory.newClassPathResource("cms.validation.dslr"), ResourceType.DSLR);
        kbuilder.add(ResourceFactory.newClassPathResource("cms.validation.drl"), ResourceType.DRL);

        KnowledgeBuilderErrors errors = kbuilder.getErrors();
        if (errors.size() > 0) {
            for (KnowledgeBuilderError error : errors) {
                System.err.println(error);
            }
            throw new IllegalStateException("Could not parse knowledge.");
        }
        KnowledgeBase kbase = KnowledgeBaseFactory.newKnowledgeBase();
        kbase.addKnowledgePackages(kbuilder.getKnowledgePackages());
        return kbase;
    }

    /**
     * Uses the front-end validation rules to check the provider profile.
     *
     * @param request the validation request
     * @return the validation messages.
     */
    private ValidationResponse checkForErrors(ValidationRequest request) {
        StatefulKnowledgeSession ksession = newDSLValidationSession();
        try {
            ValidationResultType validation = new ValidationResultType();
            List<LookupEntry> allLookupEntries = getAllLookupEntries();

            for (LookupEntry lookupEntry : allLookupEntries) {
                ksession.insert(lookupEntry);
            }

            // configure sections to validate
            if ("Y".equals(request.getPartial())) {
                List<UISection> sections = request.getSections();
                for (UISection uiSection : sections) {
                    ksession.insert(new LookupEntry("UISection", uiSection.value(), uiSection.value()));
                }
            }

            ProviderInformationType provider = request.getApplication().getProviderInformation();
            ksession.insert(request.getApplication());
            ksession.insert(provider);
            ksession.insert(validation);
            ksession.fireAllRules();

            ValidationResponse validationResponse = new ValidationResponse();
            validationResponse.setValidationResult(validation);
            return validationResponse;
        } finally {
            ksession.dispose();
        }
    }

    private List<LookupEntry> getAllLookupEntries() {
        ArrayList<LookupEntry> entry = new ArrayList<LookupEntry>();
        entry.add(new LookupEntry("ProviderType", "01", "Audiologist"));
        entry.add(new LookupEntry("UISection", "01", UISection.PERSONAL_INFORMATION.value()));
        return entry;
    }

    public static void main(String[] args) throws Exception {
        DSLTester tester = new DSLTester();
        ValidationRequest request = new ValidationRequest();
        ApplicationType applicationType = new ApplicationType();
        ProviderInformationType provider = new ProviderInformationType();
        provider.setApplicantType(ApplicantType.INDIVIDUAL);
        applicationType.setProviderInformation(provider);
        provider.setProviderType("Audiologist");
        request.setApplication(applicationType);
        ValidationResponse response = tester.checkForErrors(request);
        ValidationResultType validationResult = response.getValidationResult();
        OperationStatusType status = validationResult.getStatus();
        StatusMessagesType statusMessages = status.getStatusMessages();
        if (statusMessages != null) {
            List<StatusMessageType> list = statusMessages.getStatusMessage();
            for (StatusMessageType statusMessageType : list) {
                System.out.print(statusMessageType.getRelatedElementPath());
                System.out.print(" : ");
                System.out.println(statusMessageType.getMessage());
            }
        }
    }

    public static class EventListener extends DefaultAgendaEventListener {
        @Override
        public void beforeActivationFired(final BeforeActivationFiredEvent event) {
            final Rule rule = event.getActivation().getRule();
            System.out.println(rule.getName());
        }
    }
}
