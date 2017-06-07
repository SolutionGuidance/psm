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
package gov.medicaid.services.impl;

import gov.medicaid.services.SequenceGenerator;
import org.hibernate.Session;
import org.hibernate.engine.spi.SessionFactoryImplementor;
import org.hibernate.engine.spi.SessionImplementor;
import org.hibernate.id.MultipleHiLoPerTableGenerator;
import org.hibernate.type.LongType;

import javax.ejb.Local;
import javax.ejb.Stateless;
import javax.ejb.TransactionAttribute;
import javax.ejb.TransactionAttributeType;
import javax.ejb.TransactionManagement;
import javax.ejb.TransactionManagementType;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;


/**
 * This implementation of the sequence generator interface uses the HIBERNATE {@link SequenceGeneratorBean} to minimize
 * database calls on sequence generation.
 *
 * v1.1 - WAS Porting - upgraded to JPA 2
 * @author TCSASSEMBLER
 * @version 1.1
 */
@Stateless
@Local(SequenceGenerator.class)
@TransactionManagement(TransactionManagementType.CONTAINER)
public class SequenceGeneratorBean implements SequenceGenerator {

    /**
     * String length of the sequence.
     */
    private static final int SEQ_LENGTH = 20;

    /**
     * String length for the system id.
     */
    private static final int SYSTEM_ID_LENGTH = 8;

    /**
     * Maximum low numbers to generated before a new fetch.
     */
    private static final int MAXIMUM_LO = 1000;

    /**
     * The entity manager.
     */
    @PersistenceContext(unitName = "cms")
    private EntityManager em;

    /**
     * Cache of known sequence generators.
     */
    private transient Map<String, MultipleHiLoPerTableGenerator> generators;

    /**
     * Sets the value of the field <code>em</code>.
     *
     * @param em the em to set
     */
    public void setEm(EntityManager em) {
        this.em = em;
    }

    /**
     * Creates a new sequence if necessary.
     *
     * @param sequenceName the sequence to get the next set of values for
     * @return the generator
     */
    private MultipleHiLoPerTableGenerator configure(String sequenceName) {
        Properties params = new Properties();
        params.put(MultipleHiLoPerTableGenerator.ID_TABLE, "CMS_SEQUENCE");
        params.put(MultipleHiLoPerTableGenerator.PK_COLUMN_NAME, "SEQ_NAME");
        params.put(MultipleHiLoPerTableGenerator.PK_VALUE_NAME, sequenceName);
        params.put(MultipleHiLoPerTableGenerator.VALUE_COLUMN_NAME, "NEXT_HI");
        params.put(MultipleHiLoPerTableGenerator.MAX_LO, MAXIMUM_LO);

        Session sess = (Session) em.getDelegate();
        SessionFactoryImplementor impl = (SessionFactoryImplementor) sess.getSessionFactory();
        MultipleHiLoPerTableGenerator generator = new MultipleHiLoPerTableGenerator();
        generator.configure(LongType.INSTANCE, params, null);
        generators.put(sequenceName, generator);
        return generator;
    }

    /**
     * Retrieves the next value for the sequence.
     *
     * @param sequenceName the name of the sequence
     * @return the next value (using HI-LO algorithm)
     */
    @TransactionAttribute(TransactionAttributeType.REQUIRES_NEW)
    public long getNextValue(String sequenceName) {
        if (generators == null) {
            generators = new HashMap<String, MultipleHiLoPerTableGenerator>();
        }
        MultipleHiLoPerTableGenerator generator = generators.get(sequenceName);
        if (generator == null) {
            generator = configure(sequenceName);
        }
        Session sess = (Session) em.getDelegate();
        return ((Number) generator.generate((SessionImplementor) sess, null)).longValue();
    }
}
