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

import gov.medicaid.services.CMSConfigurator;
import gov.medicaid.services.impl.LocalHumanTaskHandler;

import org.drools.KnowledgeBase;
import org.drools.KnowledgeBaseFactory;
import org.drools.SystemEventListenerFactory;
import org.drools.builder.KnowledgeBuilder;
import org.drools.builder.KnowledgeBuilderError;
import org.drools.builder.KnowledgeBuilderErrors;
import org.drools.builder.KnowledgeBuilderFactory;
import org.drools.builder.ResourceType;
import org.drools.impl.EnvironmentFactory;
import org.drools.io.ResourceFactory;
import org.drools.persistence.jpa.JPAKnowledgeService;
import org.drools.runtime.Environment;
import org.drools.runtime.EnvironmentName;
import org.drools.runtime.StatefulKnowledgeSession;
import org.jbpm.task.service.TaskService;
import org.jbpm.task.service.local.LocalTaskService;

import javax.persistence.EntityManagerFactory;
import javax.transaction.UserTransaction;

/**
 * This class is used to configure and execute CMS Business rules.
 *
 * v1.1 - WAS Porting - pass reference to user transaction when invoking BPMN, add flag to use guvnor
 */
public class DroolsKnowledgeDelegate implements KnowledgeDelegate {

    /**
     * The composed knowledge base containing validation.
     */
    private final KnowledgeBase validationKnowledgeBase;

    /**
     * The composed knowledge base.
     */
    private final KnowledgeBase processKnowledgeBase = readProcessKnowledgeBase();

    /**
     * The composed knowledge base containing screening.
     */
    private final KnowledgeBase screeningKnowledgeBase;

    /**
     * Flag indicating if guvnor should be used.
     */
    private final boolean useGuvnor;

    /**
     * Private constructor.
     */
    DroolsKnowledgeDelegate() {
        CMSConfigurator config = new CMSConfigurator();
        useGuvnor = "N".equalsIgnoreCase(config.getUseEmbeddedRules());
        validationKnowledgeBase = readValidationKnowledgeBase();
        screeningKnowledgeBase = readScreeningKnowledgeBase();
    }

    /* (non-Javadoc)
     * @see gov.medicaid.domain.rules.KnowledgeDelegate#newWorkflowSession()
     */
    @Override
    public StatefulKnowledgeSession newWorkflowSession(EntityManagerFactory entityManagerFactory, UserTransaction utx) {
        StatefulKnowledgeSession ksession = JPAKnowledgeService.newStatefulKnowledgeSession(processKnowledgeBase, null,
            createEnvironment(entityManagerFactory, utx));
        LocalTaskService client = new LocalTaskService(new TaskService(entityManagerFactory,
            SystemEventListenerFactory.getSystemEventListener()));
        ksession.getWorkItemManager().registerWorkItemHandler("Human Task",
            new LocalHumanTaskHandler(ksession, client));
        return ksession;
    }

    @Override
    public StatefulKnowledgeSession reloadWorkflowSession(int sessionId, EntityManagerFactory factory, UserTransaction utx) {
        StatefulKnowledgeSession ksession = JPAKnowledgeService.loadStatefulKnowledgeSession(sessionId, processKnowledgeBase, null,
            createEnvironment(factory, utx));
        return ksession;
    }

    /**
     * Reads the BPMN file and includes it in the knowledge base.
     *
     * @return the composed knowledge base
     */
    private KnowledgeBase readProcessKnowledgeBase() {
        KnowledgeBuilder kbuilder = KnowledgeBuilderFactory.newKnowledgeBuilder();
        kbuilder.add(ResourceFactory.newClassPathResource("ApplicationProcess.bpmn"), ResourceType.BPMN2);
        return kbuilder.newKnowledgeBase();
    }

    /**
     * Creates a rule environment.
     *
     * @param emf the persistence factory
     * @param utx
     * @return a new environment
     */
    private Environment createEnvironment(EntityManagerFactory emf, UserTransaction utx) {
        Environment env = EnvironmentFactory.newEnvironment();
        env.set(EnvironmentName.ENTITY_MANAGER_FACTORY, emf);
        env.set(EnvironmentName.APP_SCOPED_ENTITY_MANAGER, emf.createEntityManager());
        return env;
    }

    /* (non-Javadoc)
     * @see gov.medicaid.domain.rules.KnowledgeDelegate#newScreeningValidationSession()
     */
    @Override
    public StatefulKnowledgeSession newScreeningValidationSession() {
        return screeningKnowledgeBase.newStatefulKnowledgeSession();
    }

    /**
     * Creates the knowledge base from the screening packages.
     *
     * @return the knowledge base
     */
    private KnowledgeBase readScreeningKnowledgeBase() {
        KnowledgeBuilder kbuilder = KnowledgeBuilderFactory.newKnowledgeBuilder();
        if (useGuvnor) {
            kbuilder.add(ResourceFactory.newClassPathResource("ScreeningRules.xml"), ResourceType.CHANGE_SET);
        } else {
            kbuilder.add(ResourceFactory.newClassPathResource("cms.screening.drl"), ResourceType.DRL);
        }

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
     * Creates the knowledge base from the packages.
     *
     * @return the knowledge base
     */
    private KnowledgeBase readValidationKnowledgeBase() {
        KnowledgeBuilder kbuilder = KnowledgeBuilderFactory.newKnowledgeBuilder();
        if (useGuvnor) {
            kbuilder.add(ResourceFactory.newClassPathResource("ValidationRules.xml"), ResourceType.CHANGE_SET);
        } else {
            kbuilder.add(ResourceFactory.newClassPathResource("cms.dsl"), ResourceType.DSL);
            kbuilder.add(ResourceFactory.newClassPathResource("cms.validation.dslr"), ResourceType.DSLR);
            kbuilder.add(ResourceFactory.newClassPathResource("cms.validation.drl"), ResourceType.DRL);
        }

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

    /* (non-Javadoc)
     * @see gov.medicaid.domain.rules.KnowledgeDelegate#newValidationSession()
     */
    @Override
    public StatefulKnowledgeSession newValidationSession() {
        return validationKnowledgeBase.newStatefulKnowledgeSession();
    }
}
