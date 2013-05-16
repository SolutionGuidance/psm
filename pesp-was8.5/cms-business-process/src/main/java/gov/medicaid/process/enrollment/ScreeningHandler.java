/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.process.enrollment;

import gov.medicaid.binders.XMLUtility;
import gov.medicaid.domain.model.EnrollmentProcess;
import gov.medicaid.domain.model.EnrollmentType;
import gov.medicaid.domain.model.ProviderInformationType;
import gov.medicaid.domain.model.ValidationResultType;
import gov.medicaid.domain.rules.CMSKnowledgeUtility;
import gov.medicaid.domain.rules.GlobalLookups;
import gov.medicaid.domain.rules.inference.LookupEntry;
import gov.medicaid.entities.CMSUser;
import gov.medicaid.services.CMSConfigurator;
import gov.medicaid.services.PortalServiceException;
import gov.medicaid.services.ProviderEnrollmentService;
import gov.medicaid.services.util.XMLAdapter;

import java.util.List;
import java.util.logging.Logger;

import javax.persistence.EntityManager;

import org.drools.runtime.StatefulKnowledgeSession;
import org.drools.runtime.process.WorkItem;
import org.drools.runtime.process.WorkItemManager;

/**
 * This handler is responsible all screening rules.
 *
 * @author TCSASSEMBLER
 * @version 1.0
 */
public class ScreeningHandler extends GenericHandler {

    /**
     * Provider service.
     */
    private final ProviderEnrollmentService providerService;

    /**
     * Entity manager.
     */
    private final EntityManager entityManager;

    /**
     * The logger for this class.
     */
    private Logger logger = Logger.getLogger(ScreeningHandler.class.getName());

    /**
     * The screening system user.
     */
    private CMSUser systemUser;

    public ScreeningHandler() {
        CMSConfigurator config = new CMSConfigurator();
        this.providerService = config.getEnrollmentService();
        this.entityManager = config.getPortalEntityManager();
        systemUser = config.getSystemUser();
    }
    
    /**
     * Runs the screening rules.
     *
     * @param item the work item to abort
     * @param manager the work item manager
     */
    public void executeWorkItem(WorkItem item, WorkItemManager manager) {
        logger.info("Screening the provider.");
        EnrollmentProcess processModel = (EnrollmentProcess) item.getParameter("model");

        ValidationResultType validationResult = new ValidationResultType();
        XMLUtility.nsGetScreeningResults(processModel).setAutomaticScreeningStatus(validationResult);
        StatefulKnowledgeSession ksession = CMSKnowledgeUtility.newScreeningValidationSession();

        // known facts for screening
        ksession.insert(processModel.getPostSubmissionInformation());
        EnrollmentType enrollment = processModel.getEnrollment();
		ksession.insert(enrollment);
        ksession.insert(enrollment.getProviderInformation());
        ksession.insert(enrollment.getProviderInformation().getVerificationStatus());
        ksession.insert(processModel.getProcessResults().getScreeningResults());
        ksession.insert(validationResult);
        List<LookupEntry> allLookupEntries = GlobalLookups.getInstance().getAllLookupEntries();
        for (LookupEntry lookupEntry : allLookupEntries) {
            ksession.insert(lookupEntry);
        }

        ksession.fireAllRules();

        // merge rule changes to the model
        try {
            providerService.saveEnrollmentDetails(XMLAdapter.fromXML(systemUser, enrollment));
			long ticketId = Long.parseLong(enrollment.getObjectId());
			ProviderInformationType providerInformation = enrollment.getProviderInformation();
			String reviewer = providerInformation.getReviewedBy(); // transient field (should really add to DB)
			ProviderInformationType updatedInfo = XMLAdapter.toXML(providerService.getTicketDetails(systemUser, ticketId)).getProviderInformation();
			updatedInfo.setReviewedBy(reviewer);
			enrollment.setProviderInformation(updatedInfo);
        } catch (PortalServiceException e) {
            logger.log(java.util.logging.Level.SEVERE, e.getMessage(), e);
        }

        // reset validation results
        item.getResults().put("model", processModel);
        manager.completeWorkItem(item.getId(), item.getResults());
    }
}