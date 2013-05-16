/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.domain.rules;

import org.drools.runtime.StatefulKnowledgeSession;

/**
 * This class is used to configure and execute CMS Business rules.
 *
 * @author TCSASSEMBLER
 * @version 1.0
 */
public class CMSKnowledgeUtility {

    /**
     * Knowledge implementation.
     */
    private static KnowledgeDelegate knowledge = new DroolsKnowledgeDelegate();

    /**
     * Private constructor.
     */
    private CMSKnowledgeUtility() {
    }

    /**
     * Ensures the task service is started.
     */
    public static void ensureTaskServiceStarted() {
        knowledge.ensureTaskServiceStarted();
    }

    /**
     * Creates a new business process session for CMS workflow.
     *
     * @return the session created
     */
    public static StatefulKnowledgeSession newWorkflowSession() {
        return knowledge.newWorkflowSession();
    }

    /**
     * Creates a new validation session.
     *
     * @return a new screening knowledge session
     */
    public static StatefulKnowledgeSession newScreeningValidationSession() {
        return knowledge.newScreeningValidationSession();
    }

    /**
     * Creates a new session for configuring external sources.
     *
     * @return a new session.
     */
    public static StatefulKnowledgeSession newExternalSourcesConfigSession() {
        return knowledge.newExternalSourcesConfigSession();
    }

    /**
     * Creates a new session for running frontend validation.
     *
     * @return a new session.
     */
    public static StatefulKnowledgeSession newValidationSession() {
        return knowledge.newValidationSession();
    }

    /**
     * @param sessionId
     * @return
     * @see gov.medicaid.domain.rules.KnowledgeDelegate#reloadWorkflowSession(int)
     */
    public static StatefulKnowledgeSession reloadWorkflowSession(int sessionId) {
        return knowledge.reloadWorkflowSession(sessionId);
    }
}
