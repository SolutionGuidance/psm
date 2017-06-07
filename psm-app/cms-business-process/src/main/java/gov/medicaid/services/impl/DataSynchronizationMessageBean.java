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

import gov.medicaid.entities.ProviderProfile;
import gov.medicaid.process.enrollment.sync.FlatFileImporter;
import gov.medicaid.services.PortalServiceException;
import gov.medicaid.services.ProviderEnrollmentService;

import javax.ejb.EJB;
import javax.ejb.MessageDriven;
import javax.jms.BytesMessage;
import javax.jms.JMSException;
import javax.jms.Message;
import javax.jms.MessageListener;
import javax.jms.TextMessage;

import com.topcoder.util.log.Level;

/**
 * Receives data sync messages from MQ.
 *
 * @author TCSASSEMBLER
 */
@MessageDriven
public class DataSynchronizationMessageBean extends BaseService implements MessageListener {

    /**
     * Used to persist the synchronized data.
     */
    @EJB
    private ProviderEnrollmentService providerEnrollmentService;

    /**
     * Empty constructor.
     */
    public DataSynchronizationMessageBean() {
    }

    /**
     * Called by the container when a message is received from the configured queue.
     */
    public void onMessage(Message message) {
        try {
            if (message instanceof TextMessage) {
                TextMessage msg = (TextMessage) message;
                getLog().log(Level.INFO, "Message: " + msg.getText());
                new FlatFileImporter().importContent(msg.getText().getBytes());
            } else if (message instanceof BytesMessage) {
                BytesMessage msg = (BytesMessage) message;
                byte[] bytes = new byte[(int) msg.getBodyLength()];
                msg.readBytes(bytes);
                getLog().log(Level.INFO, "Message: " + new String(bytes));
                new FlatFileImporter().importContent(bytes);
            } else {
                getLog().log(Level.WARN, "Message of wrong type: " + message.getClass().getName());
            }
        } catch (PortalServiceException e) {
            getLog().log(Level.ERROR, e);
        } catch (JMSException e) {
            getLog().log(Level.ERROR, e);
        }
    }
}
