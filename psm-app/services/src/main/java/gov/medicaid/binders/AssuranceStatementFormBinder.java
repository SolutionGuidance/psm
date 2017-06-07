/*
 * Copyright (C) 2013 TopCoder Inc., All Rights Reserved.
 */
package gov.medicaid.binders;

import gov.medicaid.domain.model.AssuredServiceType;
import gov.medicaid.domain.model.EnrollmentType;
import gov.medicaid.domain.model.FacilityCredentialsType;
import gov.medicaid.domain.model.StatusMessageType;
import gov.medicaid.domain.model.StatusMessagesType;
import gov.medicaid.entities.AssuredService;
import gov.medicaid.entities.CMSUser;
import gov.medicaid.entities.Enrollment;
import gov.medicaid.entities.ProviderProfile;
import gov.medicaid.entities.ServiceAssuranceExtType;
import gov.medicaid.entities.ServiceAssuranceType;
import gov.medicaid.entities.dto.FormError;
import gov.medicaid.services.PortalServiceException;
import gov.medicaid.services.util.Util;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

/**
 * This binder handles the CCDTF Residential/Inpatient Assurance and CCDTF Outpatient Services Assurance for Chemical
 * Dependency Program.
 *
 * @author cyberjag
 * @version 1.0
 */
public class AssuranceStatementFormBinder extends BaseFormBinder {

    /**
     * The namespace for this form.
     */
    public static final String NAMESPACE = "_41_";

    /**
     * Creates a new binder.
     */
    public AssuranceStatementFormBinder() {
        super(NAMESPACE);

    }

    /**
     * Binds the request to the model.
     * @param enrollment
     *            the model to bind to
     * @param request
     *            the request containing the form fields
     *
     * @throws BinderException
     *             if the format of the fields could not be bound properly
     */
    @Override
    public List<BinderException> bindFromPage(CMSUser user, EnrollmentType enrollment, HttpServletRequest request)
            throws PortalServiceException {
        List<BinderException> exceptions = new ArrayList<BinderException>();
        FacilityCredentialsType credentials = XMLUtility.nsGetFacilityCredentials(enrollment);
        synchronized (credentials.getAssuredService()) {
            credentials.getAssuredService().clear();
        }
        // bind InPatient Services
        int i = 0;
        while (param(request, "inServiceType", i) != null) {
            String code = param(request, "inServiceType", i);
            AssuredServiceType svcTyp = new AssuredServiceType();
            svcTyp.setType("I");
            svcTyp.setObjectId(code);
            try {
                svcTyp.setStatus(Integer.parseInt(param(request, "inServiceTypeStatus", i)));
            } catch (NumberFormatException e) {
                BinderException b = new BinderException(e.getMessage(), e);
                b.setAttribute(name("inServiceTypeStatus", i), param(request, "inServiceTypeStatus", i));
                exceptions.add(b);
            }
            try {
                svcTyp.setEffectiveDate(BinderUtils.getAsCalendar(param(request, "inServiceEffDt", i)));
            } catch (BinderException e) {
                e.setAttribute(name("inServiceEffDt", i), param(request, "inServiceEffDt", i));
                exceptions.add(e);
            }
            int j = 0;
            while (param(request, "availableInServices_" + code, j) != null) {
                synchronized (svcTyp.getExtendedTypes()) {
                    svcTyp.getExtendedTypes().add(param(request, "availableInServices_" + code, j));
                }
                j++;
            }
            synchronized (credentials.getAssuredService()) {
                credentials.getAssuredService().add(svcTyp);
            }
            i++;
        }

        // bind OutPatient Services
        i = 0;
        while (param(request, "outServiceType", i) != null) {
            String code = param(request, "outServiceType", i);
            AssuredServiceType svcTyp = new AssuredServiceType();
            svcTyp.setType("O");
            svcTyp.setObjectId(code);
            try {
                svcTyp.setStatus(Integer.parseInt(param(request, "outServiceTypeStatus", i)));
            } catch (NumberFormatException e) {
                BinderException b = new BinderException(e.getMessage(), e);
                b.setAttribute(name("outServiceTypeStatus", i), param(request, "outServiceTypeStatus", i));
                exceptions.add(b);
            }
            try {
                svcTyp.setEffectiveDate(BinderUtils.getAsCalendar(param(request, "outServiceEffDt", i)));
            } catch (BinderException e) {
                e.setAttribute(name("outServiceEffDt", i), param(request, "outServiceEffDt", i));
                exceptions.add(e);
            }
            int j = 0;
            while (param(request, "availableOutServices_" + code, j) != null) {
                synchronized (svcTyp.getExtendedTypes()) {
                    svcTyp.getExtendedTypes().add(param(request, "availableOutServices_" + code, j));
                }
                j++;
            }
            synchronized (credentials.getAssuredService()) {
                credentials.getAssuredService().add(svcTyp);
            }
            i++;
        }

        return exceptions;
    }

    /**
     * Binds the model to the request attributes.
     * @param enrollment
     *            the model to bind from
     * @param mv
     *            the model and view to bind to
     * @param readOnly
     *            if the view is read only
     */
    @Override
    public void bindToPage(CMSUser user, EnrollmentType enrollment, Map<String, Object> mv, boolean readOnly) {
        attr(mv, "bound", "Y");
        FacilityCredentialsType credentials = XMLUtility.nsGetFacilityCredentials(enrollment);
        List<AssuredServiceType> assuredServices = credentials.getAssuredService();
        synchronized (assuredServices) {
            int inpatientCounter = 0;
            int outpatientCounter = 0;
            for (AssuredServiceType svcTyp : assuredServices) {
                if ("I".equals(svcTyp.getType())) {
                    attr(mv, "inServiceType", inpatientCounter, svcTyp.getObjectId());
                    int extCounter = 0;
                    for (int i = 0; i < svcTyp.getExtendedTypes().size(); i++) {
                        attr(mv, "availableInServices_" + svcTyp.getObjectId(), extCounter, svcTyp.getExtendedTypes()
                                .get(i));
                        extCounter++;
                    }
                    attr(mv, "inServiceTypeStatus", inpatientCounter, "" + svcTyp.getStatus());
                    attr(mv, "inServiceEffDt", inpatientCounter, svcTyp.getEffectiveDate());
                    inpatientCounter++;
                } else {
                    attr(mv, "outServiceType", outpatientCounter, svcTyp.getObjectId());
                    int extCounter = 0;
                    for (int i = 0; i < svcTyp.getExtendedTypes().size(); i++) {
                        attr(mv, "availableOutServices_" + svcTyp.getObjectId(), extCounter, svcTyp.getExtendedTypes()
                                .get(i));
                        extCounter++;
                    }
                    attr(mv, "outServiceTypeStatus", outpatientCounter, "" + svcTyp.getStatus());
                    attr(mv, "outServiceEffDt", outpatientCounter, svcTyp.getEffectiveDate());
                    outpatientCounter++;
                }
            }
            attr(mv, "inServiceSize", inpatientCounter);
            attr(mv, "outServiceSize", outpatientCounter);
        }

        List<ServiceAssuranceType> availableInServices = getLookupService().findAssuredServiceTypes("I");
        for (ServiceAssuranceType s : availableInServices) {
            List<ServiceAssuranceExtType> extServices = getLookupService().findAssuredServiceExtTypes(s.getCode());
            attr(mv, "availableInServices_" + s.getCode(), extServices);
        }
        attr(mv, "availableInServices", availableInServices);

        List<ServiceAssuranceType> availableOutServices = getLookupService().findAssuredServiceTypes("O");
        for (ServiceAssuranceType s : availableOutServices) {
            List<ServiceAssuranceExtType> extServices = getLookupService().findAssuredServiceExtTypes(s.getCode());
            attr(mv, "availableOutServices_" + s.getCode(), extServices);
        }
        attr(mv, "availableOutServices", availableOutServices);
    }

    /**
     * Binds the fields of the form to the persistence model.
     *
     * @param enrollment
     *            the front end model
     * @param ticket
     *            the persistent model
     * @throws PortalServiceException
     *             for any errors encountered
     */
    @Override
    public void bindToHibernate(EnrollmentType enrollment, Enrollment ticket) throws PortalServiceException {
        ProviderProfile profile = ticket.getDetails();
        if (profile.getAssuredStatements() == null) {
            profile.setAssuredStatements(new ArrayList<AssuredService>());
        }

        List<AssuredService> existingStatments = new ArrayList<AssuredService>(profile.getAssuredStatements());
        profile.getAssuredStatements().clear();

        Map<String, AssuredService> sMap = mapById(existingStatments);

        FacilityCredentialsType credentials = XMLUtility.nsGetFacilityCredentials(enrollment);
        List<AssuredService> assuredStatements = new ArrayList<AssuredService>();
        for (AssuredServiceType svcTyp : credentials.getAssuredService()) {
            AssuredService s = null;
            if (sMap.get(svcTyp.getObjectId()) != null) {
                s = sMap.get(svcTyp.getObjectId());
            } else {
                s = new AssuredService();
            }
            s.setEffectiveDate(BinderUtils.toDate(svcTyp.getEffectiveDate()));
            s.setType(getLookupService().findLookupByCode(gov.medicaid.entities.ServiceAssuranceType.class,
                    svcTyp.getObjectId()));
            if (svcTyp.getExtendedTypes() != null) {
                List<ServiceAssuranceExtType> extendedTypes = new ArrayList<ServiceAssuranceExtType>();
                for (String ext : svcTyp.getExtendedTypes()) {
                    extendedTypes.add(getLookupService().findLookupByCode(
                            gov.medicaid.entities.ServiceAssuranceExtType.class, ext));
                }
                s.setExtendedTypes(extendedTypes);
            }
            s.setStatus(svcTyp.getStatus());
            assuredStatements.add(s);
        }
        profile.setAssuredStatements(assuredStatements);
    }

    /**
     * Maps the given list by the id.
     *
     * @param hList
     *            the list to map
     * @return the mapped statements
     */
    private Map<String, AssuredService> mapById(List<AssuredService> hList) {
        Map<String, AssuredService> m = new HashMap<String, AssuredService>();
        synchronized (hList) {
            for (AssuredService statement : hList) {
                m.put("" + statement.getId(), statement);
            }
        }
        return m;
    }

    /**
     * Binds the fields of the persistence model to the front end xml.
     *
     * @param ticket
     *            the persistent model
     * @param enrollment
     *            the front end model
     */
    @Override
    public void bindFromHibernate(Enrollment ticket, EnrollmentType enrollment) {
        ProviderProfile profile = ticket.getDetails();
        if (profile != null) {
            List<AssuredService> assuredStatements = profile.getAssuredStatements();
            if (assuredStatements != null) {
                FacilityCredentialsType credentials = XMLUtility.nsGetFacilityCredentials(enrollment);
                credentials.getAssuredService().clear();
                for (AssuredService svc : assuredStatements) {
                    AssuredServiceType svcTyp = new AssuredServiceType();
                    svcTyp.setObjectId(svc.getType().getCode());
                    svcTyp.setType(svc.getType().getPatientInd());
                    svcTyp.setEffectiveDate(BinderUtils.toCalendar(svc.getEffectiveDate()));
                    svcTyp.setStatus(svc.getStatus());
                    if (svc.getExtendedTypes() != null) {
                        for (ServiceAssuranceExtType ext : svc.getExtendedTypes()) {
                            svcTyp.getExtendedTypes().add(ext.getCode());
                        }
                    }
                    credentials.getAssuredService().add(svcTyp);
                }
            }
        }
    }

    /**
     * Captures the error messages related to the form.
     *
     * @param enrollment
     *            the enrollment that was validated
     * @param messages
     *            the messages to select from
     *
     * @return the list of errors related to the form
     */
    @Override
    protected List<FormError> selectErrors(EnrollmentType enrollment, StatusMessagesType messages) {
        List<FormError> errors = new ArrayList<FormError>();

        List<StatusMessageType> ruleErrors = messages.getStatusMessage();
        List<StatusMessageType> caughtMessages = new ArrayList<StatusMessageType>();

        synchronized (ruleErrors) {
            for (StatusMessageType ruleError : ruleErrors) {
                int count = errors.size();

                String path = ruleError.getRelatedElementPath();
                if (path == null) {
                    continue;
                }

                if (path.startsWith("/ProviderInformation/PatientAssurance/")) {
                    FormError error = resolveFieldError(ruleError);
                    if (error != null) {
                        errors.add(error);
                    }
                }

                if (errors.size() > count) { // caught
                    caughtMessages.add(ruleError);
                }
            }

            // so it does not get processed anywhere again
            ruleErrors.removeAll(caughtMessages);
        }

        return errors.isEmpty() ? NO_ERRORS : errors;
    }

    /**
     * Resolves the specific license that is causing the error from the license list.
     *
     * @param ruleError
     *            the error to resolve
     * @return the resolved error
     */
    private FormError resolveFieldError(StatusMessageType ruleError) {
        String path = ruleError.getRelatedElementPath();
        Integer index = resolveIndex(path);

        if (index != null) {
            if (path.endsWith("InServiceTrack")) {
                return createError("inServiceType", index, ruleError.getMessage() + "(InPatient Service #"
                        + (index + 1) + ")");
            } else if (path.endsWith("OutServiceTrack")) {
                return createError("outServiceType", index, ruleError.getMessage() + "(OutPatient Service #"
                        + (index + 1) + ")");
            } else if (path.endsWith("InEffectiveDate")) {
                return createError("inServiceEffDt", index, ruleError.getMessage() + "(InPatient Service #"
                        + (index + 1) + ")");
            } else if (path.endsWith("OutEffectiveDate")) {
                return createError("outServiceEffDt", index, ruleError.getMessage() + "(OutPatient Service #"
                        + (index + 1) + ")");
            }
        }

        if (path.endsWith("Required")) {
            return createError("application", ruleError.getMessage());
        }
        // not a license field error
        return null;
    }

    /**
     * Resolves the index of the field that caused the error.
     *
     * @param path
     *            the field path
     * @return the index of the field, null if cannot be resolved
     */
    private Integer resolveIndex(String path) {
        String strIdx = Util.getStringInBetween(path, "[", "]");
        if (!Util.isBlank(strIdx)) {
            return Integer.parseInt(strIdx);
        }
        return null;
    }
}
