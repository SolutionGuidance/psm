/*
 * Copyright 2012-2013 TopCoder, Inc.
 *
 * This code was developed under U.S. government contract NNH10CD71C. 
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * You may not use this file except in compliance with the License.
 * You may obtain a copy of the License at:
 *     http://www.apache.org/licenses/LICENSE-2.0
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
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