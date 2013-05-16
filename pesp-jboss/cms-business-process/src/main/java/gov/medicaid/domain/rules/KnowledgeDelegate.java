/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.domain.rules;

import org.drools.runtime.StatefulKnowledgeSession;

/**
 * Knowledge delegate definition.
 *
 * @author TCSASSEMBLER
 * @version 1.0
 */
public interface KnowledgeDelegate {

    /**
     * Creates a new business process session for CMS workflow.
     *
     * @return the session created
     */
    public abstract StatefulKnowledgeSession newWorkflowSession();

    /**
     * Creates a new validation session.
     *
     * @return a new screening knowledge session
     */
    public abstract StatefulKnowledgeSession newScreeningValidationSession();

    /**
     * Creates a new session for configuring external sources.
     *
     * @return a new session.
     */
    public abstract StatefulKnowledgeSession newExternalSourcesConfigSession();

    /**
     * Creates a new session for running frontend validation.
     *
     * @return a new session.
     */
    public abstract StatefulKnowledgeSession newValidationSession();

    /**
     * Ensures the task service is started.
     */
    public abstract void ensureTaskServiceStarted();

    StatefulKnowledgeSession reloadWorkflowSession(int sessionId);

}