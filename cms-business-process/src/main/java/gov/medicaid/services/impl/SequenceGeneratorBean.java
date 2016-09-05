/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.services.impl;

import gov.medicaid.entities.SystemId;
import gov.medicaid.services.SequenceGenerator;
import gov.medicaid.services.util.Util;

import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

import javax.ejb.Local;
import javax.ejb.Stateless;
import javax.ejb.TransactionAttribute;
import javax.ejb.TransactionAttributeType;
import javax.ejb.TransactionManagement;
import javax.ejb.TransactionManagementType;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.hibernate.Hibernate;
import org.hibernate.Session;
import org.hibernate.engine.SessionFactoryImplementor;
import org.hibernate.engine.SessionImplementor;
import org.hibernate.id.MultipleHiLoPerTableGenerator;


/**
 * This implementation of the sequence generator interface uses the HIBERNATE {@link SequenceGeneratorBean} to minimize
 * database calls on sequence generation.
 *
 * @author TCSASSEMBLER
 * @version 1.0
 */
@Stateless
@Local(SequenceGenerator.class)
@TransactionAttribute(TransactionAttributeType.REQUIRED)
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
        generator.configure(Hibernate.LONG, params, impl.getDialect());
        generators.put(sequenceName, generator);
        return generator;
    }

    /**
     * Retrieves the next value for the sequence.
     *
     * @param sequenceName the name of the sequence
     * @return the next value (using HI-LO algorithm)
     */
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

    /**
     * Creates a unique 28 character string by combining a sequence and the system name.
     *
     * @param system the system name to prepend to the unique value
     * @param sequenceName the name of the sequence
     * @return the next value for the named sequence
     */
    public String getNextSystemValue(SystemId system, String sequenceName) {
        return Util.pad(system.value(), SYSTEM_ID_LENGTH, 'X')
            + Util.pad("" + getNextValue(sequenceName), SEQ_LENGTH, '0');
    }
}
