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

import gov.medicaid.binders.XMLUtility;
import gov.medicaid.domain.model.ApplicantType;
import gov.medicaid.domain.model.EnrollmentType;
import gov.medicaid.domain.model.LicenseNames;
import gov.medicaid.domain.model.LicenseType;
import gov.medicaid.domain.model.ProviderInformationType;
import gov.medicaid.domain.model.ProviderType;
import gov.medicaid.domain.model.SpecialtyNames;
import gov.medicaid.domain.model.UISection;
import gov.medicaid.domain.model.ValidationRequest;
import gov.medicaid.domain.model.ValidationResponse;
import gov.medicaid.domain.model.ValidationResultType;
import gov.medicaid.domain.rules.CMSKnowledgeUtility;
import gov.medicaid.domain.rules.GlobalLookups;
import gov.medicaid.domain.rules.inference.LookupEntry;
import gov.medicaid.entities.License;
import gov.medicaid.entities.ProviderProfile;
import gov.medicaid.entities.dto.FormSettings;
import gov.medicaid.entities.dto.MinimumLicenseRulesModel;
import gov.medicaid.entities.dto.UITabModel;
import gov.medicaid.entities.dto.ViewModel;
import gov.medicaid.entities.dto.ViewStatics;
import gov.medicaid.services.PresentationService;
import gov.medicaid.services.util.Util;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;

import javax.ejb.Local;
import javax.ejb.Stateless;
import javax.ejb.TransactionAttribute;
import javax.ejb.TransactionAttributeType;
import javax.ejb.TransactionManagement;
import javax.ejb.TransactionManagementType;

import org.drools.runtime.StatefulKnowledgeSession;

/**
 * Defines the UI related services.
 *
 * @author TCSASSEMBLER
 * @version 1.0
 */
@Stateless
@Local(PresentationService.class)
@TransactionAttribute(TransactionAttributeType.REQUIRED)
@TransactionManagement(TransactionManagementType.CONTAINER)
public class PresentationServiceBean extends BaseService implements PresentationService {

    /**
     * Retrieves the presentation model to be used for the given provider. This is shared between the screen and some
     * other views like exporting providers.
     *
     * @param provider
     *            the provider to determine how to display
     * @return the model having some instructions on how to present the given provider
     */
    public ViewModel getProviderViewModel(ProviderProfile provider) {
        if (provider == null) {
            throw new IllegalArgumentException("provider cannot be null.");
        }

        Map<String, Boolean> facts = new HashMap<String, Boolean>();
        String providerType = null;
        if (provider.getEntity() != null && provider.getEntity().getProviderType() != null) {
            providerType = provider.getEntity().getProviderType().getDescription();
        }

        facts.put("isIndividual", isIndividual(providerType));
        facts.put("canBeInPrivatePractice", canBeInPrivatePractice(providerType));
        facts.put("isInPrivatePractice", "Y".equals(provider.getMaintainsOwnPrivatePractice()));
        facts.put("isNotInPrivatePractice", "N".equals(provider.getMaintainsOwnPrivatePractice()));
        facts.put("isInAdditionalPractice", "Y".equals(provider.getEmployedOrContractedByGroup()));
        facts.put("canHaveSpecialty", canHaveSpecialty(providerType));
        facts.put("askedForHighestDegree", askedForHighestDegree(providerType));

        List<License> certifications = provider.getCertifications();
        HashSet<String> certs = new HashSet<String>();
        if (certifications != null) {
            for (License license : certifications) {
                if (license.getType() != null) {
                    certs.add(license.getType().getDescription());
                }
            }
        }
        facts.put("askForMembers", askedForMembers(providerType, certs));

        facts.put("askForOwners", askedForOwners(providerType));
        facts.put("askForSetup", askedForSetup(providerType));
        facts.put("askForCLIA", askForCLIA(providerType));
        facts.put("askForRemmitanceSequence", askForRemmitanceSequence(providerType));
        facts.put("askedForFacilityCredentials", askedForFacilityCredentials(providerType));
        facts.put("askHighestDegreeForPsychiatricSpecialty", askHighestDegreeForPsychiatricSpecialty(providerType));
        return runViewRule(providerType, facts);
    }

    private Boolean askForRemmitanceSequence(String type) {
        if (isIndividual(type)) {
            return false;
        }

        if (ProviderType.BILLING_ENTITY_FOR_PHYSICAL_REHABILITATIVE_PROVIDERS.value().equals(type)) {
            return false;
        } else if (ProviderType.CLEARING_HOUSE.value().equals(type)) {
            return false;
        } else if (ProviderType.DURABLE_MEDICAL_EQUIPMENT.value().equals(type)) {
            return false;
        } else if (ProviderType.EDI_TRADING_PARTNER.value().equals(type)) {
            return false;
        } else if (ProviderType.FAMILY_PLANNING_AGENCY.value().equals(type)) {
            return false;
        } else if (ProviderType.HEAD_START.value().equals(type)) {
            return false;
        } else if (ProviderType.HOME_HEALTH_AGENCY.value().equals(type)) {
            return false;
        } else if (ProviderType.INDEPENDENT_DIAGNOSTIC_TESTING_FACILITY.value().equals(type)) {
            return false;
        } else if (ProviderType.INDEPENDENT_LABORATORY.value().equals(type)) {
            return false;
        } else if (ProviderType.INDIAN_HEALTH_SERVICE_FACILITY.value().equals(type)) {
            return false;
        } else if (ProviderType.INTENSIVE_RESIDENTIAL_TREATMENT_FACILITY.value().equals(type)) {
            return false;
        } else if (ProviderType.OPTICAL_SUPPLIER.value().equals(type)) {
            return false;
        } else if (ProviderType.BILLING_INTERMEDIARY.value().equals(type)) {
            return false;
        }

        return true;
    }

    private Boolean askForCLIA(String type) {
        if (isIndividual(type)) {
            return false;
        }
        if (ProviderType.INDEPENDENT_LABORATORY.value().equals(type)) {
            return true;
        } else if (ProviderType.PUBLIC_HEALTH_NURSING_ORGANIZATION.value().equals(type)) {
            return true;
        } else if (ProviderType.NURSING_FACILITY.value().equals(type)) {
            return true;
        } else if (ProviderType.RENAL_DIALYSIS_FACILITY.value().equals(type)) {
            return true;
        }
        // Fix for PESP-413
        else if (ProviderType.PHYSICIAN_CLINIC.value().equals(type)) {
            return true;
        }
        // Fix for PESP-428
        else if (ProviderType.RURAL_HEALTH_CLINIC.value().equals(type)) {
            return true;
        }
        // Fix for PESP-353
        else if (ProviderType.AMBULATORY_SURGICAL_CENTER.value().equals(type)) {
            return true;
        }
        // Fix for PESP-363
        else if (ProviderType.BIRTHING_CENTER.value().equals(type)) {
            return true;
        }
        return false;
    }

    private Boolean askedForFacilityCredentials(String type) {
        if (isIndividual(type)) {
            return false;
        }
        if (ProviderType.CLEARING_HOUSE.value().equals(type)) {
            return false;
        } else if (ProviderType.EDI_TRADING_PARTNER.value().equals(type)) {
            return false;
        } else if (ProviderType.DURABLE_MEDICAL_EQUIPMENT.value().equals(type)) {
            return false;
        } else if (ProviderType.FAMILY_PLANNING_AGENCY.value().equals(type)) {
            return false;
        } else if (ProviderType.BILLING_ENTITY_FOR_PHYSICAL_REHABILITATIVE_PROVIDERS.value().equals(type)) {
            return false;
        } else if (ProviderType.OPTICAL_SUPPLIER.value().equals(type)) {
            return false;
        } else if (ProviderType.PUBLIC_HEALTH_CLINIC.value().equals(type)) {
            return false;
        } else if (ProviderType.WIC_PROGRAM.value().equals(type)) {
            return false;
        } else if (ProviderType.CERTIFIED_REGISTERED_NURSE_ANESTHETIST_GROUP.value().equals(type)) {
            return false;
        } else if (ProviderType.BILLING_INTERMEDIARY.value().equals(type)) {
            return false;
        } else if (ProviderType.INDIVIDUAL_EDUCATION_PLAN.value().equals(type)) {
            return false;
        } else if (ProviderType.DENTAL_CLINIC.value().equals(type)) {
            return false;
        } else if (ProviderType.DENTAL_HYGIENIST_CLINIC.value().equals(type)) {
            return false;
        } else if (ProviderType.PODIATRY_CLINIC.value().equals(type)) {
            return false;
        } else if (ProviderType.BILLING_ENTITY_FOR_MENTAL_HEALTH.value().equals(type)) {
            return false;
        } else if (ProviderType.CHIROPRACTIC_CLINIC.value().equals(type)) {
            return false;
        } else if (ProviderType.BILLING_ENTITY_FOR_PHYSICIAN_SERVICES.value().equals(type)) {
            return false;
        }

        return true;
    }

    private Boolean askedForSetup(String type) {
        if (isIndividual(type)) {
            return false;
        }

        if (ProviderType.CLEARING_HOUSE.value().equals(type)) {
            return true;
        } else if (ProviderType.EDI_TRADING_PARTNER.value().equals(type)) {
            return true;
        } else if (ProviderType.BILLING_INTERMEDIARY.value().equals(type)) {
            return true;
        }
        return false;
    }

    private Boolean askedForOwners(String type) {
        if (isIndividual(type)) {
            return false;
        }
        if (ProviderType.CLEARING_HOUSE.value().equals(type)) {
            return false;
        } else if (ProviderType.EDI_TRADING_PARTNER.value().equals(type)) {
            return false;
        } else if (ProviderType.BILLING_INTERMEDIARY.value().equals(type)) {
            return false;
        }

        return true;
    }

    private Boolean askedForMembers(String type, HashSet<String> certs) {
        if (isIndividual(type)) {
            return false;
        }
        if (ProviderType.CLEARING_HOUSE.value().equals(type)) {
            return false;
        } else if (ProviderType.DURABLE_MEDICAL_EQUIPMENT.value().equals(type)) {
            return false;
        } else if (ProviderType.EDI_TRADING_PARTNER.value().equals(type)) {
            return false;
        } else if (ProviderType.INDEPENDENT_DIAGNOSTIC_TESTING_FACILITY.value().equals(type)) {
            return false;
        } else if (ProviderType.INDEPENDENT_LABORATORY.value().equals(type)) {
            return false;
        } else if (ProviderType.INTENSIVE_RESIDENTIAL_TREATMENT_FACILITY.value().equals(type)) {
            return false;
        } else if (ProviderType.PUBLIC_HEALTH_NURSING_ORGANIZATION.value().equals(type)) {
            return false;
        } else if (ProviderType.REHABILITATION_AGENCY.value().equals(type)) {
            return certs.contains(LicenseNames.CORF_CERTIFICATION.value());
        } else if (ProviderType.TARGETED_CASE_MANAGEMENT.value().equals(type)) {
            return false;
        } else if (ProviderType.WIC_PROGRAM.value().equals(type)) {
            return false;
        } else if (ProviderType.X_RAY_SERVICES.value().equals(type)) {
            return false;
        } else if (ProviderType.CHILD_AND_TEEN_CHECKUP_CLINIC.value().equals(type)) {
            return false;
        } else if (ProviderType.CHILDRENS_MENTAL_HEALTH_RESIDENTIAL_TREATMENT_FACILITY.value().equals(type)) {
            return false;
        } else if (ProviderType.BILLING_INTERMEDIARY.value().equals(type)) {
            return false;
        } else if (ProviderType.INDIVIDUAL_EDUCATION_PLAN.value().equals(type)) {
            return false;
        } else if (ProviderType.HOSPICE.value().equals(type)) {
            return false;
        } else if (ProviderType.HOSPITAL.value().equals(type)) {
            return false;
        } else if (ProviderType.INTERMEDIATE_CARE_FACILITIES_FOR_PERSONS_WITH_DEVELOPMENTAL_DISABILITIES.value()
                .equals(type)) {
            return false;
        }
        // Fix for PESP-390
        else if (ProviderType.HOME_AND_COMMUNITY_BASED_SERVICES_WAIVERED_SERVICES.value().equals(type)) {
            return false;
        }
        // Fix for PESP-300
        else if (ProviderType.DAY_TRAINING_AND_HABILITATION_DAY_ACTIVITY_CENTER.value().equals(type)) {
            return false;
        }
        // Fix for PESP-298
        else if (ProviderType.NURSING_FACILITY.value().equals(type)) {
            return false;
        }
        // Fix for PESP-350
        else if (ProviderType.DAY_TREATMENT.value().equals(type)) {
            return false;
        }
        // Fix for PESP-406
        else if (ProviderType.MEDICAL_TRANSPORTATION.value().equals(type)) {
            return false;
        }
        return true;
    }

    private Boolean canBeInPrivatePractice(String providerType) {
        if (ProviderType.ALLIED_DENTAL_PROFESSIONAL.value().equals(providerType)) {
            return false;
        } else if (ProviderType.COMMUNITY_HEALTH_CARE_WORKER.value().equals(providerType)) {
            return false;
        } else if (ProviderType.PHYSICIAN_ASSISTANT.value().equals(providerType)) {
            return false;
        }
        return true;
    }

    /**
     * Checks if the provider type can have specialties.
     *
     * @param providerType
     *            the provider type.
     * @return true if the provider can enter specialty
     */
    private Boolean canHaveSpecialty(String providerType) {
        if (ProviderType.CERTIFIED_REGISTERED_NURSE_ANESTHETIST.value().equals(providerType)) {
            return true;
        } else if (ProviderType.CERTIFIED_PROFESSIONAL_MIDWIFE.value().equals(providerType)) {
            return true;
        } else if (ProviderType.CLINICAL_NURSE_SPECIALIST.value().equals(providerType)) {
            return true;
        } else if (ProviderType.LICENSED_PSYCHOLOGIST.value().equals(providerType)) {
            return true;
        } else if (ProviderType.NURSE_PRACTITIONER.value().equals(providerType)) {
            return true;
        } else if (ProviderType.PHYSICIAN.value().equals(providerType)) {
            return true;
        } else if (ProviderType.OCCUPATIONAL_THERAPIST.value().equals(providerType)) {
            return true;
        } else if (ProviderType.DENTIST.value().equals(providerType)) {
            return true;
        } else if (ProviderType.NURSE_MIDWIFE.value().equals(providerType)) {
            return true;
        } else if (ProviderType.MEDICAL_TRANSPORTATION.value().equals(providerType)) {
            return true;
        }
        return false;
    }

    /**
     * Retrieves the presentation model to be used for the given provider. This is shared between the screen and some
     * other views like exporting providers.
     *
     * @param provider
     *            the provider to determine how to display
     * @return the model having some instructions on how to present the given provider
     */
    public ViewModel getProviderViewModel(ProviderInformationType provider) {
        if (provider == null) {
            throw new IllegalArgumentException("provider cannot be null.");
        }

        Map<String, Boolean> facts = new HashMap<String, Boolean>();
        facts.put("isIndividual", isIndividual(provider.getProviderType()));
        facts.put("canBeInPrivatePractice", canBeInPrivatePractice(provider.getProviderType()));
        facts.put("isInPrivatePractice", "Y".equals(provider.getMaintainsOwnPrivatePractice()));
        facts.put("isNotInPrivatePractice", "N".equals(provider.getMaintainsOwnPrivatePractice()));
        facts.put("isInAdditionalPractice", "Y".equals(provider.getEmployedOrContractedByGroup()));
        facts.put("canHaveSpecialty", canHaveSpecialty(provider.getProviderType()));
        facts.put("askedForHighestDegree", askedForHighestDegree(provider.getProviderType()));

        HashSet<String> certs = new HashSet<String>();
        if (provider.getFacilityCredentials() != null) {
            for (LicenseType license : provider.getFacilityCredentials().getLicense()) {
                certs.add(license.getLicenseType());
            }
        }
        facts.put("askForMembers", askedForMembers(provider.getProviderType(), certs));
        facts.put("askForOwners", askedForOwners(provider.getProviderType()));
        facts.put("askForSetup", askedForSetup(provider.getProviderType()));
        facts.put("askForCLIA", askForCLIA(provider.getProviderType()));
        facts.put("askForRemmitanceSequence", askForRemmitanceSequence(provider.getProviderType()));
        facts.put("askedForFacilityCredentials", askedForFacilityCredentials(provider.getProviderType()));
        facts.put("askHighestDegreeForPsychiatricSpecialty",
                askHighestDegreeForPsychiatricSpecialty(provider.getProviderType()));

        return runViewRule(provider.getProviderType(), facts);
    }

    /**
     * Checks if the provider type should be asked for degree earned on mental health specialty.
     *
     * @param providerType
     *            the provider type.
     * @return true if the provider can enter degree
     */
    private boolean askHighestDegreeForPsychiatricSpecialty(String providerType) {
        if (ProviderType.CLINICAL_NURSE_SPECIALIST.value().equals(providerType)) {
            return true;
        } else if (ProviderType.NURSE_PRACTITIONER.value().equals(providerType)) {
            return true;
        }
        return false;
    }

    /**
     * Checks if the provider type should be asked for degree earned.
     *
     * @param providerType
     *            the provider type.
     * @return true if the provider can enter degree
     */
    private boolean askedForHighestDegree(String providerType) {
        if (ProviderType.CERTIFIED_MENTAL_HEALTH_REHAB_PROF_CPRP.value().equals(providerType)) {
            return true;
        } else if (ProviderType.LICENSED_MARRIAGE_AND_FAMILY_THERAPIST.value().equals(providerType)) {
            return true;
        } else if (ProviderType.LICENSED_PROFESSIONAL_CLINICAL_COUNSELOR.value().equals(providerType)) {
            return true;
        } else if (ProviderType.LICENSED_PSYCHOLOGIST.value().equals(providerType)) {
            return true;
        } else if (ProviderType.LICENSED_INDEPENDENT_CLINICAL_SOCIAL_WORKER.value().equals(providerType)) {
            return true;
        }
        return false;
    }

    /**
     * Retrieves the view rules.
     *
     * @param type
     *            the provider type.
     * @param facts
     *            the facts
     * @return the view model
     */
    private ViewModel runViewRule(String type, Map<String, Boolean> facts) {
        ViewModel viewModel = new ViewModel();
        if (Util.isBlank(type)) {
            return viewModel;
        }

        if (facts.get("isIndividual")) {
            UITabModel page;

            if (ProviderType.PERSONAL_CARE_ASSISTANT.value().equals(type)) {

                page = new UITabModel();
                page.addForm(ViewStatics.PCA_INDIVIDUAL_FORM, new FormSettings());
                viewModel.addTabModel(ViewStatics.INDIVIDUAL_PCA_INFORMATION, page);

                page = new UITabModel();
                page.addForm(ViewStatics.LICENSE_INFO_FORM, new FormSettings());
                viewModel.addTabModel(ViewStatics.TRAINING_INFORMATION, page);

                page = new UITabModel();
                page.addForm(ViewStatics.INDIVIDUAL_AGENCY_FORM, new FormSettings());
                if (facts.get("isInAdditionalPractice")) {
                    page.addForm(ViewStatics.ADDITIONAL_AGENCY_FORM, new FormSettings());
                }
                viewModel.addTabModel(ViewStatics.INDIVIDUAL_AGENCY_INFORMATION, page);

            } else {
                page = new UITabModel();
                // BUGR-9673 for CHW, do not mark NPI as required.
                FormSettings personalInfoFormSettings = new FormSettings();
                personalInfoFormSettings.addSetting("requireNPI", true);
                personalInfoFormSettings.addSetting("hideRenewalDate", false);
                personalInfoFormSettings.addSetting("hideLicenseNumber", false);
                if (ProviderType.COMMUNITY_HEALTH_CARE_WORKER.value().equals(type)) {
                    personalInfoFormSettings.addSetting("requireNPI", false);
                }
                if (ProviderType.COMMUNITY_HEALTH_CARE_WORKER.value().equals(type)) {
                	personalInfoFormSettings.addSetting("hideRenewalDate", true);
                    personalInfoFormSettings.addSetting("hideLicenseNumber", true);
                }
                page.addForm(ViewStatics.PERSONAL_INFO_FORM, personalInfoFormSettings);

                // end BUGR-9673
                viewModel.addTabModel(ViewStatics.PERSONAL_INFORMATION, page);

                page = new UITabModel();
                if (facts.get("canBeInPrivatePractice")) {
                    page.addForm(ViewStatics.TRIBAL_INFO_FORM, new FormSettings());
                }
                page.addForm(ViewStatics.LICENSE_INFO_FORM, new FormSettings());
                if (facts.get("canHaveSpecialty")) {
                    page.addForm(ViewStatics.SPECIALTY_INFO_FORM, new FormSettings());
                }
                if (facts.get("askedForHighestDegree")) {
                    page.addForm(ViewStatics.HIGHEST_DEGREE_FORM, new FormSettings());
                } else if (facts.get("askHighestDegreeForPsychiatricSpecialty")) {
                    FormSettings settings = new FormSettings();
                    settings.addSetting("specialtyTrigger", SpecialtyNames.PSYCHIATRIC_MENTAL_HEALTH.value());
                    page.addForm(ViewStatics.HIGHEST_DEGREE_FORM, settings);
                }

                viewModel.addTabModel(ViewStatics.LICENSE_INFORMATION, page);

                page = new UITabModel();
                FormSettings practiceSettings = new FormSettings();
                if (facts.get("canBeInPrivatePractice")) {
                    page.addForm(ViewStatics.PRACTICE_TYPE_FORM, practiceSettings);
                    if (facts.get("isInPrivatePractice")) {
                        page.addForm(ViewStatics.PRIVATE_PRACTICE_FORM, new FormSettings());
                    } else if (facts.get("isNotInPrivatePractice")) {
                        page.addForm(ViewStatics.PRIMARY_PRACTICE_FORM, new FormSettings());
                    }
                    if (facts.get("isInAdditionalPractice")) {
                        page.addForm(ViewStatics.ADDITIONAL_PRACTICE_FORM, new FormSettings());
                    }
                } else {
                    page.addForm(ViewStatics.PRIMARY_PRACTICE_FORM, new FormSettings());
                    page.addForm(ViewStatics.ADDITIONAL_PRACTICE_FORM, new FormSettings());
                }

                viewModel.addTabModel(ViewStatics.PRACTICE_INFORMATION, page);
            }

            page = new UITabModel();
            viewModel.addTabModel(ViewStatics.SUMMARY_INFORMATION, page);

            page = new UITabModel();
            viewModel.addTabModel(ViewStatics.PROVIDER_STATEMENT, page);
            page.addForm(ViewStatics.INDIVIDUAL_DISCLOSURE_FORM, new FormSettings());

        } else {
            viewModel.setIndividual(false);

            UITabModel page;
            page = new UITabModel();
            FormSettings settings = new FormSettings();
            settings.addSetting("askEffectiveDate", true);
            settings.addSetting("askFiscalYear", false);
            settings.addSetting("askTaxPayerName", false);
            settings.addSetting("askDBAName", false);
            settings.addSetting("useEDILayout", false);
            settings.addSetting("useEducationPlanLayout", false);
            settings.addSetting("useNursingFacilityLayout", false);
            settings.addSetting("showInitialChoices", false);
            settings.addSetting("askUMPI", false);
            settings.addSetting("requireNPI", true);
            settings.addSetting("clearingHouseLayout", false);

            page.addForm(ViewStatics.ORG_INFO_FORM, settings);

            if (facts.get("askForRemmitanceSequence")) {
                page.addForm(ViewStatics.REMITTANCE_SEQUENCE_FORM, settings);
            }

            if (ProviderType.DAY_TRAINING_AND_HABILITATION_DAY_ACTIVITY_CENTER.value().equals(type)) {
            	settings.addSetting("requireNPI", false);
            }

            if (ProviderType.HOME_AND_COMMUNITY_BASED_SERVICES_WAIVERED_SERVICES.value().equals(type)) {
            	settings.addSetting("askUMPI", true);
            }
            if (ProviderType.PERSONAL_CARE_PROVIDER_ORGANIZATION.value().equals(type)) {
                // custom form settings
                settings.addSetting("askEffectiveDate", false);
                settings.addSetting("askFiscalYear", true);
                settings.addSetting("askTaxPayerName", true);
                settings.addSetting("askDBAName", true);
                settings.addSetting("askUMPIorNPI", true);
                page.addForm(ViewStatics.PCA_BILLING_CONTACT_FORM, new FormSettings());
            } else if (ProviderType.INDIVIDUAL_EDUCATION_PLAN.value().equals(type)) {
                settings.addSetting("useEducationPlanLayout", true);
            } else if (ProviderType.NURSING_FACILITY.value().equals(type)) {
                settings.addSetting("useNursingFacilityLayout", true);
            } else if (ProviderType.INTERMEDIATE_CARE_FACILITIES_FOR_PERSONS_WITH_DEVELOPMENTAL_DISABILITIES.value()
                    .equals(type)) {
                settings.addSetting("useNursingFacilityLayout", true);
            } else if (ProviderType.EDI_TRADING_PARTNER.value().equals(type)) {
                settings.addSetting("useEDILayout", true);
                settings.addSetting("showInitialChoices", true);
                // PESP-384
                settings.addSetting("showNameOfPersonFillingTheForm", false);
            } else if (ProviderType.BILLING_INTERMEDIARY.value().equals(type)) {
                settings.addSetting("useEDILayout", true);
                settings.addSetting("showInitialChoices", false);
                settings.addSetting("showNameOfPersonFillingTheForm", true);
            } else if (ProviderType.CLEARING_HOUSE.value().equals(type)) {
                settings.addSetting("askUMPI", true);
                settings.addSetting("clearingHouseLayout", true);
            }

            viewModel.addTabModel(ViewStatics.ORGANIZATION_INFO, page);

            if (facts.get("askedForFacilityCredentials")) {
                page = new UITabModel();

                if (ProviderType.TARGETED_CASE_MANAGEMENT.value().equals(type)) {
                    page.addForm(ViewStatics.TCM_CONTRACT_FORM, new FormSettings());
                } else if (ProviderType.CHILD_AND_TEEN_CHECKUP_CLINIC.value().equals(type)) {
                    page.addForm(ViewStatics.CTCC_FORM, new FormSettings());
                } else if (ProviderType.COMMUNITY_HEALTH_CLINIC.value().equals(type)) {
                    page.addForm(ViewStatics.NONPROFIT_CORPORATION_FORM, new FormSettings());
                } else if (ProviderType.COUNTY_CONTRACTED_MENTAL_HEALTH_REHAB.value().equals(type)) {
                    page.addForm(ViewStatics.FACILITY_CONTRACTS_FORM, new FormSettings());
                } else if (ProviderType.FEDERALLY_QUALIFIED_HEALTH_CENTER.value().equals(type)) {
                    page.addForm(ViewStatics.FEDERAL_QUALIFICATION_FORM, new FormSettings());
                } else if (ProviderType.PHYSICIAN_CLINIC.value().equals(type)) {
                    page.addForm(ViewStatics.PHYSICIAN_CLINIC_FACILITY_QUALIFICATION_FORM, new FormSettings());
                } else {
                    FormSettings licenseSettings = new FormSettings();
                    licenseSettings.addSetting("showCategories", false);
                    if (ProviderType.HOME_AND_COMMUNITY_BASED_SERVICES_WAIVERED_SERVICES.value().equals(type)) {
                        licenseSettings.addSetting("showCategories", true);
                    }
                    page.addForm(ViewStatics.FACILITY_LICENSE_FORM, licenseSettings);
                }

                if (ProviderType.COMMUNITY_MENTAL_HEALTH_CENTER.value().equals(type)) {
                    page.addForm(ViewStatics.NONPROFIT_CORPORATION_FORM, new FormSettings());
                    page.addForm(ViewStatics.SLIDING_FEE_SCHEDULE_FORM, new FormSettings());
                } else if (ProviderType.PUBLIC_HEALTH_NURSING_ORGANIZATION.value().equals(type)) {
                    page.addForm(ViewStatics.PHN_AGENCY_FORM, new FormSettings());
                } else if (ProviderType.CHILDRENS_MENTAL_HEALTH_RESIDENTIAL_TREATMENT_FACILITY.value().equals(type)) {
                    page.addForm(ViewStatics.CMHRT_FORM, new FormSettings());
                } else if (ProviderType.DAY_TREATMENT.value().equals(type)) {
                    page.addForm(ViewStatics.ADULT_DAY_TREATMENT_APPLICATION_FORM, new FormSettings());
                    page.addForm(ViewStatics.FACILITY_TYPE_FORM, new FormSettings());
                } else if (ProviderType.NURSING_FACILITY.value().equals(type)) {
                    page.addForm(ViewStatics.FACILITY_ELIGIBILITY_FORM, new FormSettings());
                } else if (ProviderType.INTERMEDIATE_CARE_FACILITIES_FOR_PERSONS_WITH_DEVELOPMENTAL_DISABILITIES
                        .value().equals(type)) {
                    page.addForm(ViewStatics.FACILITY_ELIGIBILITY_FORM, new FormSettings());
                } else if (ProviderType.HOSPICE.value().equals(type)) {
                    page.addForm(ViewStatics.AMBULANCE_SERVICES_FORM, new FormSettings());
                }

                if (facts.get("askForCLIA")) {
                    page.addForm(ViewStatics.CLIA_LICENSE_FORM, new FormSettings());
                }

                if (ProviderType.PERSONAL_CARE_PROVIDER_ORGANIZATION.value().equals(type)) {
                    page.addForm(ViewStatics.PCPO_INSURANCE_FORM, new FormSettings());
                }

                if (ProviderType.REGIONAL_TREATMENT_CENTER.value().equals(type)) {
                    page.addForm(ViewStatics.FACILITY_CAPACITY_FORM, new FormSettings());
                }

                if (facts.get("canHaveSpecialty")) {
                    page.addForm(ViewStatics.SPECIALTY_INFO_FORM, new FormSettings());
                }

                viewModel.addTabModel(ViewStatics.FACILITY_CREDENTIALS, page);
            }

            if (ProviderType.PERSONAL_CARE_PROVIDER_ORGANIZATION.value().equals(type)) {
                page = new UITabModel();
                page.addForm(ViewStatics.QUALIFIED_PROFESSIONAL_FORM, new FormSettings());
                viewModel.addTabModel(ViewStatics.QUALIFIED_PROFESSIONAL, page);
            }

            if (facts.get("askForMembers")) {
                page = new UITabModel();
                FormSettings formSettings = new FormSettings();
                formSettings.addSetting("askBGSInfo", false);
                if (ProviderType.PERSONAL_CARE_PROVIDER_ORGANIZATION.value().equals(type)) {
                	formSettings.addSetting("askBGSInfo", true);
                	formSettings.addSetting("askUMPIorNPI", true);
                }
                page.addForm(ViewStatics.MEMBER_INFO_FORM, formSettings);
                viewModel.addTabModel(ViewStatics.MEMBER_INFO, page);
            }

            if (facts.get("askForSetup")) {
                page = new UITabModel();
                page.addForm(ViewStatics.PROVIDER_SETUP_FORM, new FormSettings());
                viewModel.addTabModel(ViewStatics.PROVIDER_SETUP, page);
            }

            if (facts.get("askForOwners")) {
                page = new UITabModel();
                page.addForm(ViewStatics.OWNERSHIP_INFO_FORM, new FormSettings());
                page.addForm(ViewStatics.ORGANIZATION_DISCLOSURE_FORM, new FormSettings());
                viewModel.addTabModel(ViewStatics.OWNERSHIP_INFO, page);
            }

            page = new UITabModel();
            viewModel.addTabModel(ViewStatics.SUMMARY_INFORMATION, page);

            page = new UITabModel();
            viewModel.addTabModel(ViewStatics.PROVIDER_STATEMENT, page);
            page.addForm(ViewStatics.ORGANIZATION_STATEMENT_FORM, new FormSettings());
        }
        return viewModel;
    }

    /**
     * Checks if the given type is an individual provider.
     *
     * @param type
     *            the type to check
     * @return true if the type is an individual
     */
    private boolean isIndividual(String type) {
        if (Util.isBlank(type)) {
            return false;
        }
        gov.medicaid.entities.ProviderType lookup = findLookupByDescription(gov.medicaid.entities.ProviderType.class,
                type);
        return lookup.getApplicantType() == ApplicantType.INDIVIDUAL;
    }

    /**
     * This calls the business rules to validation the given enrollment. It is used by the frontend whenever validation
     * is needed. It can be used to validate the entire request or a subset of views.
     *
     * @param ticket
     *            the ticket to be validated.
     * @param tabs
     *            the tabs to validate, if null or empty, the entire ticket is checked
     * @return the set of error messages found, empty if the ticket is valid
     */
    public ValidationResponse checkForErrors(EnrollmentType ticket, List<String> tabs) {
        ValidationRequest request = new ValidationRequest();
        if (tabs != null && !tabs.isEmpty()) {
            request.setPartial("Y");
            for (String tab : tabs) {
                if (ViewStatics.ORGANIZATION_INFO.equals(tab)) {
                    request.getSections().add(UISection.ORGANIZATION_INFORMATION);
                } else if (ViewStatics.MEMBER_INFO.equals(tab)) {
                    request.getSections().add(UISection.INDIVIDUAL_MEMBER_INFORMATION);
                } else if (ViewStatics.PROVIDER_SETUP.equals(tab)) {
                    request.getSections().add(UISection.PROVIDER_SETUP);
                } else if (ViewStatics.OWNERSHIP_INFO.equals(tab)) {
                    request.getSections().add(UISection.OWNERSHIP_INFORMATION);
                    request.getSections().add(UISection.ORGANIZATION_DISCLOSURE);
                } else if (ViewStatics.FACILITY_CREDENTIALS.equals(tab)) {
                    request.getSections().add(UISection.FACILITY_CREDENTIALS);
                } else if (ViewStatics.PROVIDER_STATEMENT.equals(tab)) {
                    request.getSections().add(UISection.PROVIDER_STATEMENT);
                    request.getSections().add(UISection.ORGANIZATION_PROVIDER_STATEMENT);
                } else if (ViewStatics.QUALIFIED_PROFESSIONAL.equals(tab)) {
                    request.getSections().add(UISection.QUALIFIED_PROFESSIONALS);
                } else {
                    try {
                        request.getSections().add(UISection.fromValue(tab));
                    } catch (IllegalArgumentException e) {
                    }
                }
            }
        }
        request.setEnrollment(ticket);
        return checkForErrors(request);
    }

    /**
     * Uses the front-end validation rules to check the provider profile.
     *
     * @param request
     *            the validation request
     * @return the validation messages.
     */
    private ValidationResponse checkForErrors(ValidationRequest request) {
        StatefulKnowledgeSession ksession = CMSKnowledgeUtility.newValidationSession();
        try {
            ValidationResultType validation = new ValidationResultType();
            List<LookupEntry> allLookupEntries = GlobalLookups.getInstance().getAllLookupEntries();

            for (LookupEntry lookupEntry : allLookupEntries) {
                ksession.insert(lookupEntry);
            }

            // configure sections to validate
            if ("Y".equals(request.getPartial())) {
                List<UISection> sections = request.getSections();
                for (UISection uiSection : sections) {
                    ksession.insert(new LookupEntry("UISection", uiSection.value(), uiSection.value()));
                }
            }

            ProviderInformationType provider = request.getEnrollment().getProviderInformation();
            ksession.insert(request.getEnrollment());
            ksession.insert(provider);
            ksession.insert(validation);
            ksession.fireAllRules();

            ValidationResponse validationResponse = new ValidationResponse();
            validationResponse.setValidationResult(validation);
            return validationResponse;
        } finally {
            ksession.dispose();
        }
    }

    /**
     * This returns the minimum license rules for the given enrollment.
     *
     * @param enrollment
     *            the enrollment to check
     * @return the minimum license rules
     */
    public MinimumLicenseRulesModel getMinimumLicenseRules(EnrollmentType enrollment) {
        MinimumLicenseRulesModel model = new MinimumLicenseRulesModel();
        ProviderInformationType provider = XMLUtility.nsGetProvider(enrollment);
        gov.medicaid.entities.ProviderType pt = getLookupService().findLookupByDescription(
                gov.medicaid.entities.ProviderType.class, provider.getProviderType());

        model.setAllLicenses(new ArrayList<String>());
        for (gov.medicaid.entities.LicenseType licenseType : pt.getLicenseTypes()) {
            model.getAllLicenses().add(licenseType.getDescription());
        }
        return model;
    }
}