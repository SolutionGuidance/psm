package gov.medicaid.domain.rules;

import gov.medicaid.domain.model.EnrollmentProcess;
import gov.medicaid.domain.model.EnrollmentType;
import gov.medicaid.domain.model.ProviderInformationType;
import gov.medicaid.domain.model.UISection;
import gov.medicaid.domain.model.ValidationRequest;
import gov.medicaid.domain.model.ValidationResponse;
import gov.medicaid.domain.model.ValidationResultType;
import gov.medicaid.domain.rules.inference.LookupEntry;
import org.drools.runtime.StatefulKnowledgeSession;

import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * This class handles all KnowledgeSession operations.
 */

public class RulesExecutor {
    private static final Logger logger =
        Logger.getLogger(RulesExecutor.class.getName());

    private RulesExecutor() {
    }

    /**
     * Uses the front-end validation rules to check the provider profile.
     *
     * @param request the validation request
     * @return ValidationResponse the validation messages.
     */
    public static ValidationResponse executeProviderValidationRules(
        ValidationRequest request) {
        ValidationResponse validationResponse;
        StatefulKnowledgeSession ksession = CMSKnowledgeUtility.newValidationSession();
        try {
            ValidationResultType validationResultType = new ValidationResultType();
            List<LookupEntry> allLookupEntries = GlobalLookups.getInstance().getAllLookupEntries();

            for (LookupEntry thisLookupEntry : allLookupEntries) {
                ksession.insert(thisLookupEntry);
            }

            // configure sections to validate
            if ("Y".equals(request.getPartial())) {
                List<UISection> uiSections = request.getSections();
                for (UISection thisUISection : uiSections) {
                    ksession.insert(new LookupEntry("UISection", thisUISection.value(),
                        thisUISection.value()));
                }
            }

            ProviderInformationType providerInformationType =
                request.getEnrollment().getProviderInformation();
            ksession.insert(request.getEnrollment());
            ksession.insert(providerInformationType);
            ksession.insert(validationResultType);
            ksession.fireAllRules();

            validationResponse = new ValidationResponse();
            validationResponse.setValidationResult(validationResultType);
        } finally {
            if (ksession != null) {
                try {
                    ksession.dispose();
                } catch (Throwable t) {
                    logger.log(Level.SEVERE, "Could not close session.", t);
                }
            }
        }
        return validationResponse;
    }

    public static void executeProviderScreeningRules(
        EnrollmentProcess enrollmentProcess,
        ValidationResultType validationResultType
    ) {
        StatefulKnowledgeSession ksession =
            CMSKnowledgeUtility.newScreeningValidationSession();
        try {
            ksession.insert(enrollmentProcess.getPostSubmissionInformation());
            EnrollmentType enrollmentType = enrollmentProcess.getEnrollment();
            ksession.insert(enrollmentType);
            ksession.insert(enrollmentType.getProviderInformation());
            ksession.insert(
                enrollmentType.getProviderInformation().getVerificationStatus());
            ksession.insert(enrollmentProcess.getProcessResults().getScreeningResults());
            ksession.insert(validationResultType);
            List<LookupEntry> allLookupEntries = GlobalLookups.getInstance().getAllLookupEntries();
            for (LookupEntry thisLookupEntry : allLookupEntries) {
                ksession.insert(thisLookupEntry);
            }
            ksession.fireAllRules();
        } finally {
            if (ksession != null) {
                try {
                    ksession.dispose();
                } catch (Throwable t) {
                    logger.log(Level.SEVERE, "Could not close session.", t);
                }
            }
        }
    }
}
