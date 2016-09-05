/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.domain.rules;

import gov.medicaid.services.CMSConfigurator;
import gov.medicaid.services.PortalServiceRuntimeException;
import gov.medicaid.services.util.LogUtil;

import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.transaction.TransactionManager;

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
import org.jbpm.process.workitem.wsht.CommandBasedWSHumanTaskHandler;
import org.jbpm.task.service.DefaultUserGroupCallbackImpl;

import com.topcoder.util.log.Level;
import com.topcoder.util.log.Log;

/**
 * This class is used to configure and execute CMS Business rules.
 *
 * @author TCSASSEMBLER
 * @version 1.0
 */
@SuppressWarnings("deprecation")
public class DroolsKnowledgeDelegate implements KnowledgeDelegate {

    /**
     * The composed knowledge base containing validation.
     */
    private KnowledgeBase validationKnowledgeBase = readValidationKnowledgeBase();

    /**
     * The composed knowledge base.
     */
    private KnowledgeBase processKnowledgeBase = readProcessKnowledgeBase();

    /**
     * The composed knowledge base containing screening.
     */
    private KnowledgeBase screeningKnowledgeBase = readScreeningKnowledgeBase();

    /**
     * The composed knowledge base containing external sources configuration.
     */
    private KnowledgeBase externalSourcesKnowledgeBase = readExternalSourcesKnowledgeBase();

    /**
     * Entity manager.
     */
    private EntityManagerFactory emf;

    /**
     * Flag for task service.
     */
    private boolean started;

    /**
     * Private constructor.
     */
    DroolsKnowledgeDelegate() {
    }

    /**
     * Ensures the task service is started.
     */
    @Override
    public synchronized void ensureTaskServiceStarted() {
        if (!started) {
            init();
        }
    }

    /**
     * Initializes the persistence and rule environment.
     */
    private synchronized void init() {
        System.setProperty("jbpm.usergroup.callback", DefaultUserGroupCallbackImpl.class.getName());
        Log log = LogUtil.getLog(DroolsKnowledgeDelegate.class.getName());
        log.log(Level.INFO, "Starting JBPM Services...");
        CMSConfigurator config = new CMSConfigurator();
        emf = config.getJBPMEntityManagerFactory();


        EntityManagerFactory standalone = Persistence.createEntityManagerFactory("org.jbpm.task");
        org.jbpm.task.service.TaskService taskService = new org.jbpm.task.service.TaskService(standalone,
            SystemEventListenerFactory.getSystemEventListener());
        org.jbpm.task.service.mina.MinaTaskServer server = new org.jbpm.task.service.mina.MinaTaskServer(taskService);

        log.log(Level.INFO, "Running Task Server...");
        Thread thread = new Thread(server);
        thread.start();
        started = true;
        log.log(Level.INFO, "JBPM setup completed...");
    }

    /* (non-Javadoc)
     * @see gov.medicaid.domain.rules.KnowledgeDelegate#newWorkflowSession()
     */
    @Override
    public StatefulKnowledgeSession newWorkflowSession() {
        if (emf == null) {
            init();
        }
        StatefulKnowledgeSession ksession = JPAKnowledgeService.newStatefulKnowledgeSession(processKnowledgeBase, null,
            createEnvironment(emf));
        ksession.getWorkItemManager().registerWorkItemHandler("Human Task",
            new CommandBasedWSHumanTaskHandler(ksession));
        return ksession;
    }
    
    @Override
    public StatefulKnowledgeSession reloadWorkflowSession(int sessionId) {
        if (emf == null) {
            init();
        }
        StatefulKnowledgeSession ksession = JPAKnowledgeService.loadStatefulKnowledgeSession(sessionId, processKnowledgeBase, null,
            createEnvironment(emf));
        return ksession;
    }

    /**
     * Reads the BPMN file and includes it in the knowledge base.
     *
     * @return the composed knowledge base
     */
    private KnowledgeBase readProcessKnowledgeBase() {
        KnowledgeBuilder kbuilder = KnowledgeBuilderFactory.newKnowledgeBuilder();
        kbuilder.add(ResourceFactory.newClassPathResource("EnrollmentProcess.bpmn"), ResourceType.BPMN2);
        return kbuilder.newKnowledgeBase();
    }

    /**
     * Creates a rule environment.
     *
     * @param emf the persistence factory
     * @return a new environment
     */
    private Environment createEnvironment(EntityManagerFactory emf) {
        try {
            Environment env = EnvironmentFactory.newEnvironment();
            env.set(EnvironmentName.ENTITY_MANAGER_FACTORY, emf);
            InitialContext context = new InitialContext();
            TransactionManager txm = (TransactionManager) context.lookup("java:/TransactionManager");
            env.set(EnvironmentName.TRANSACTION_MANAGER, txm);
            return env;
        } catch (NamingException e) {
            throw new PortalServiceRuntimeException("could not instantiate jbpm environment.");
        }
    }

    /* (non-Javadoc)
     * @see gov.medicaid.domain.rules.KnowledgeDelegate#newScreeningValidationSession()
     */
    @Override
    public StatefulKnowledgeSession newScreeningValidationSession() {
        if (emf == null) {
            init();
        }
        return screeningKnowledgeBase.newStatefulKnowledgeSession();
    }

    /**
     * Creates the knowledge base from the screening packages.
     *
     * @return the knowledge base
     */
    private KnowledgeBase readScreeningKnowledgeBase() {
        KnowledgeBuilder kbuilder = KnowledgeBuilderFactory.newKnowledgeBuilder();
        kbuilder.add(ResourceFactory.newClassPathResource("cms.screening.drl"), ResourceType.DRL);

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
     * Creates the knowledge base from the external sources packages.
     *
     * @return the knowledge base
     */
    private KnowledgeBase readExternalSourcesKnowledgeBase() {
        KnowledgeBuilder kbuilder = KnowledgeBuilderFactory.newKnowledgeBuilder();
        kbuilder.add(ResourceFactory.newClassPathResource("cms.externalsources.drl"), ResourceType.DRL);

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

    /* (non-Javadoc)
     * @see gov.medicaid.domain.rules.KnowledgeDelegate#newExternalSourcesConfigSession()
     */
    @Override
    public StatefulKnowledgeSession newExternalSourcesConfigSession() {
        if (emf == null) {
            init();
        }
        return externalSourcesKnowledgeBase.newStatefulKnowledgeSession();
    }

    /* (non-Javadoc)
     * @see gov.medicaid.domain.rules.KnowledgeDelegate#newValidationSession()
     */
    @Override
    public StatefulKnowledgeSession newValidationSession() {
        if (emf == null) {
            init();
        }
        return validationKnowledgeBase.newStatefulKnowledgeSession();
    }
}
