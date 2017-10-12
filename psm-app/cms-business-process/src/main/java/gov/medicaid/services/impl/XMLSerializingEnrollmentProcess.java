/*
 * Copyright (C) 2013 TopCoder Inc., All Rights Reserved.
 */

package gov.medicaid.services.impl;

import gov.medicaid.domain.model.EnrollmentProcess;

import java.io.Externalizable;
import java.io.IOException;
import java.io.ObjectInput;
import java.io.ObjectOutput;
import java.io.StringReader;
import java.io.StringWriter;

import javax.xml.bind.JAXBContext;
import javax.xml.bind.JAXBException;
import javax.xml.bind.Marshaller;
import javax.xml.bind.Unmarshaller;

/**
 * This class is used to ensure backward compatibility of request models thru XML serialization.
 * @author TCSASSEMBLER
 * @version 1.0
 */
public class XMLSerializingEnrollmentProcess extends EnrollmentProcess implements Externalizable {

    /**
     * Reads the enrollment process model from the given input.
     * 
     * @param input the serialized model input
     * @throws IOException if the object could not be read
     * @throws ClassNotFoundException if the class being read is not recognized
     */
    public void readExternal(ObjectInput input) throws IOException, ClassNotFoundException {
        try {
            JAXBContext context = JAXBContext.newInstance("gov.medicaid.domain.model");
            Unmarshaller um = context.createUnmarshaller();
            EnrollmentProcess result = (EnrollmentProcess) um.unmarshal(new StringReader((String) input.readObject()));
            
            setSessionId(result.getSessionId());
            setAssessedFees(result.getAssessedFees());
            setEnrollment(result.getEnrollment());
            setEnrollmentStatus(result.getEnrollmentStatus());
            setEnrollmentStatusHistory(result.getEnrollmentStatusHistory());
            setPostSubmissionInformation(result.getPostSubmissionInformation());
            setPreApprovalQuestions(result.getPreApprovalQuestions());
            setProcessAudit(result.getProcessAudit());
            setProcessResults(result.getProcessResults());
            
        } catch (JAXBException e) {
            throw new IOException("Incompatible request version.");
        }
    }

    /**
     * Serializes this model as an XML string.
     * 
     * @param output the serialized model output
     * @throws IOException if the object could not be written
     */
    public void writeExternal(ObjectOutput output) throws IOException {
        try {
            JAXBContext context = JAXBContext.newInstance("gov.medicaid.domain.model");
            Marshaller m = context.createMarshaller();
            StringWriter sw = new StringWriter();
            m.marshal(this, sw);
            output.writeObject(sw.getBuffer().toString());
        } catch (JAXBException e) {
            throw new IOException("Could not serialize enrollment model.");
        }
    }
}
