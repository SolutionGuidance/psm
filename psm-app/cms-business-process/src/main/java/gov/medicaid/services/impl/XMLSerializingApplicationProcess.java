/*
 * Copyright 2013 TopCoder Inc.
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

package gov.medicaid.services.impl;

import gov.medicaid.domain.model.ApplicationProcess;

import javax.xml.bind.JAXBContext;
import javax.xml.bind.JAXBException;
import javax.xml.bind.Marshaller;
import javax.xml.bind.Unmarshaller;

import java.io.Externalizable;
import java.io.IOException;
import java.io.ObjectInput;
import java.io.ObjectOutput;
import java.io.StringReader;
import java.io.StringWriter;

/**
 * This class is used to ensure backward compatibility of request models thru XML serialization.
 */
public class XMLSerializingApplicationProcess extends ApplicationProcess implements Externalizable {

    /**
     * Reads the application process model from the given input.
     *
     * @param input the serialized model input
     * @throws IOException if the object could not be read
     * @throws ClassNotFoundException if the class being read is not recognized
     */
    public void readExternal(ObjectInput input) throws IOException, ClassNotFoundException {
        try {
            JAXBContext context = JAXBContext.newInstance("gov.medicaid.domain.model");
            Unmarshaller um = context.createUnmarshaller();
            ApplicationProcess result = (ApplicationProcess) um.unmarshal(new StringReader((String) input.readObject()));

            setSessionId(result.getSessionId());
            setAssessedFees(result.getAssessedFees());
            setApplication(result.getApplication());
            setApplicationStatus(result.getApplicationStatus());
            setApplicationStatusHistory(result.getApplicationStatusHistory());
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
            throw new IOException("Could not serialize application model.");
        }
    }
}
