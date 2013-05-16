/*
 * Copyright (C) 2012 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.controllers.admin;

import gov.medicaid.entities.AgreementDocument;
import gov.medicaid.entities.ProviderType;
import gov.medicaid.services.AgreementDocumentService;
import gov.medicaid.services.PortalServiceConfigurationException;
import gov.medicaid.services.PortalServiceException;

import javax.annotation.PostConstruct;

import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

/**
 * <p>
 * This is the validator for ProviderType instances.
 * </p>
 * <p>
 * This class is mutable and not thread safe, but used in thread safe manner by framework.
 * </p>
 *
 * @author argolite, TCSASSEMBLER
 * @version 1.0
 */
public class ProviderTypeValidator implements Validator {
    /**
     * Represents the agreement document service. It is managed with a getter and setter. It may have any value, but is
     * expected to be set to a non-null/empty value by dependency injection. It is fully mutable, but not expected to
     * change after dependency injection.
     */
    private AgreementDocumentService agreementDocumentService;

    /**
     * Empty constructor.
     */
    public ProviderTypeValidator() {
        // empty
    }

    /**
     * This method checks that all required injection fields are in fact provided.
     *
     * @throws PortalServiceConfigurationException If there are required injection fields that are not injected
     */
    @PostConstruct
    protected void init() {
        if (agreementDocumentService == null) {
            throw new PortalServiceConfigurationException("agreementDocumentService must be configured.");
        }
    }

    /**
     * Can this Validator validate instances of the supplied clazz.
     *
     * @param clazz the Class that this Validator is being asked if it can validate
     *
     * @return true if this Validator can indeed validate instances of the supplied clazz
     */
    @Override
    public boolean supports(Class<?> clazz) {
        return ProviderType.class.isAssignableFrom(clazz);
    }

    /**
     * Validate the supplied target object, which must be of a Class for which the supports(Class) method typically has
     * (or would) return true. The supplied errors instance can be used to report any resulting validation errors.
     *
     * @param target the object that is to be validated (can be null)
     * @param errors contextual state about the validation process (never null)
     */
    @Override
    public void validate(Object target, Errors errors) {
        if (target != null) {
            ProviderType type = (ProviderType) target;
            checkAgreementDocument(type.getAddendum(), errors);
            checkAgreementDocument(type.getAgreement(), errors);
        }
    }

    /**
     * Check if the agreement is correct.
     *
     * @param document the document to be checked.
     * @param errors the errors
     */
    private void checkAgreementDocument(AgreementDocument document, Errors errors) {
        if (document != null) {
            try {
                if (agreementDocumentService.get(document.getId()) == null) {
                    errors.rejectValue("entity.notExist", "the agreementDocument is absent");
                }
            } catch (PortalServiceException e) {
                errors.rejectValue("service.error", e.getMessage());
            }
        }
    }
}
