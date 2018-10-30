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

import org.drools.runtime.StatefulKnowledgeSession;

import javax.persistence.EntityManagerFactory;
import javax.transaction.UserTransaction;

/**
 * This class is used to configure and execute CMS Business rules.
 *
 * v1.1 - WAS Porting - pass reference to user transaction when invoking BPMN
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
     * Creates a new business process session for CMS workflow.
     * @param entityManager
     * @param utx
     *
     * @return the session created
     */
    public static StatefulKnowledgeSession newWorkflowSession(EntityManagerFactory entityManager, UserTransaction utx) {
        return knowledge.newWorkflowSession(entityManager, utx);
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
    public static StatefulKnowledgeSession reloadWorkflowSession(int sessionId, EntityManagerFactory factory, UserTransaction utx) {
        return knowledge.reloadWorkflowSession(sessionId, factory, utx);
    }
}
