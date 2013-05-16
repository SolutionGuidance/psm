/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.domain.rules;

import javax.persistence.EntityManagerFactory;
import javax.transaction.UserTransaction;

import org.drools.runtime.StatefulKnowledgeSession;

/**
 * Knowledge delegate definition.
 *
 * v1.1 - WAS Porting - pass reference to user transaction when invoking BPMN
 * @author TCSASSEMBLER
 * @version 1.1
 */
public interface KnowledgeDelegate {

    /**
     * Creates a new business process session for CMS workflow.
     * @param entityManager 
     * @param utx 
     *
     * @return the session created
     */
    public abstract StatefulKnowledgeSession newWorkflowSession(EntityManagerFactory entityManagerFactory, UserTransaction utx);

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
     * Reloads a persisted session
     * @param sessionId the session id.
     * @param factory the entity manager factory
     * @param utx the user transaction to be used
     * @return the loaded session
     */
    public StatefulKnowledgeSession reloadWorkflowSession(int sessionId, EntityManagerFactory factory, UserTransaction utx);

}