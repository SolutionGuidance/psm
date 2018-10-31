package gov.medicaid.process.application;

import com.google.gson.FieldNamingPolicy;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import gov.medicaid.binders.XMLUtility;
import gov.medicaid.domain.model.ApplicationProcess;
import gov.medicaid.domain.model.ApplicationType;
import gov.medicaid.domain.model.BeneficialOwnerType;
import gov.medicaid.domain.model.DesignatedContactType;
import gov.medicaid.domain.model.GroupMemberType;
import gov.medicaid.domain.model.IndividualApplicantType;
import gov.medicaid.domain.model.PersonType;
import gov.medicaid.domain.model.QualifiedProfessionalType;
import gov.medicaid.entities.Application;
import gov.medicaid.entities.AutomaticScreening;
import gov.medicaid.entities.DmfAutomaticScreening;

import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.Response;

import org.drools.runtime.process.WorkItem;
import org.drools.runtime.process.WorkItemManager;

import javax.persistence.EntityManager;

import java.io.IOException;
import java.util.Objects;
import java.util.Set;
import java.util.TreeSet;
import java.util.logging.Logger;
import java.util.stream.Collectors;

import static java.util.logging.Level.WARNING;

public class DmfScreeningHandler extends GenericHandler {
    private final Logger logger = Logger.getLogger(getClass().getName());

    private final ExternalDmfService service;
    private final EntityManager entityManager;

    public DmfScreeningHandler(
        String baseUri,
        EntityManager entityManager
    ) {
        this(new HttpDmfService(baseUri), entityManager);
    }

    public DmfScreeningHandler(
        ExternalDmfService service,
        EntityManager entityManager
    ) {
        this.service = service;
        this.entityManager = entityManager;
    }

    @Override
    public void executeWorkItem(WorkItem item, WorkItemManager manager) {
        logger.info("Checking against DMF.");
        ApplicationProcess processModel = (ApplicationProcess) item.getParameter("model");

        long applicationId = Long.parseLong(processModel.getApplication().getObjectId());
        Application application = entityManager.find(Application.class, applicationId);

        Set<String> ssnsToSearch = getSsnsInApplication(processModel.getApplication());

        DmfAutomaticScreening screening = new DmfAutomaticScreening();

        try {
            boolean found =
                ssnsToSearch.stream()
                        .map(this::searchInDmf)
                        // Terminate and restart so not partial in case of error
                        .collect(Collectors.toList()).stream()
                        .map(result -> {
                            screening.addMatch(result.toMatch());
                            return result.getDmfRecordPresent();
                        })
                        // Terminate and restart so all matches get added
                        .collect(Collectors.toList()).stream()
                        .anyMatch(Boolean::booleanValue);

            screening.setResult(found ? AutomaticScreening.Result.FAIL : AutomaticScreening.Result.PASS);
            XMLUtility.nsGetVerificationStatus(processModel).setNotInDmf(found ? "N" : "Y");

        } catch (RuntimeException e) {
            logger.log(WARNING, "Error checking against DMF", e);
            screening.setResult(AutomaticScreening.Result.ERROR);
        }

        application.addAutomaticScreening(screening);
        entityManager.merge(application);
        item.getResults().put("model", processModel);
        manager.completeWorkItem(item.getId(), item.getResults());
    }

    public DmfResult searchInDmf(String ssn) {
        try {
            JsonObject obj = new JsonParser().parse(service.getResult(ssn)).getAsJsonObject();

            Gson gson = new GsonBuilder()
                .setFieldNamingPolicy(FieldNamingPolicy.LOWER_CASE_WITH_UNDERSCORES)
                .create();

            return gson.fromJson(obj, DmfResult.class);
        } catch (IOException e) {
            throw new RuntimeException("Error while getting DMF response", e);
        }
    }

    public interface ExternalDmfService {
        String getResult(String ssn) throws IOException;
    }

    private Set<String> getSsnsInApplication(ApplicationType application) {
        Set<String> ssnsToSearch = new TreeSet<>();

        IndividualApplicantType individual = XMLUtility.nsGetIndividual(application);
        if (individual.getSocialSecurityNumber() != null) {
            ssnsToSearch.add(individual.getSocialSecurityNumber());
        }

        XMLUtility.nsGetQualifiedProfessionals(application)
            .getQualifiedProfessional()
            .stream()
            .map(QualifiedProfessionalType::getSocialSecurityNumber)
            .filter(Objects::nonNull)
            .forEach(ssnsToSearch::add);

        XMLUtility.nsGetDesignatedContactInformation(application)
            .getDesignatedContact()
            .stream()
            .map(DesignatedContactType::getSocialSecurityNumber)
            .filter(Objects::nonNull)
            .forEach(ssnsToSearch::add);

        XMLUtility.nsGetMembershipInformation(application)
            .getGroupMember()
            .stream()
            .map(GroupMemberType::getSocialSecurityNumber)
            .filter(Objects::nonNull)
            .forEach(ssnsToSearch::add);

        XMLUtility.nsGetOwnershipInformation(application)
            .getBeneficialOwner()
            .stream()
            .map(BeneficialOwnerType::getPersonInformation)
            .filter(Objects::nonNull)
            .map(PersonType::getSocialSecurityNumber)
            .filter(Objects::nonNull)
            .forEach(ssnsToSearch::add);

        return ssnsToSearch;
    }

    private static class HttpDmfService implements ExternalDmfService {
        OkHttpClient client = new OkHttpClient();
        String baseUri;

        HttpDmfService(String baseUri) {
            this.baseUri = baseUri;
        }

        public String getResult(String ssn) throws IOException {
            Request request = new Request.Builder()
                .url(baseUri + "dmf/" + ssn)
                .build();
            Response response = client.newCall(request).execute();
            return response.body().string();
        }
    }
}
