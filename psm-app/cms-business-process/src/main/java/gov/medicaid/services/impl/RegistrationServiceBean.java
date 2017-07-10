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

import gov.medicaid.binders.BinderUtils;
import gov.medicaid.dao.IdentityProviderDAO;
import gov.medicaid.entities.AuditDetail;
import gov.medicaid.entities.AuditRecord;
import gov.medicaid.entities.CMSUser;
import gov.medicaid.entities.EmailTemplate;
import gov.medicaid.entities.ExternalAccountLink;
import gov.medicaid.entities.Role;
import gov.medicaid.entities.SearchResult;
import gov.medicaid.entities.SystemId;
import gov.medicaid.entities.UserSearchCriteria;
import gov.medicaid.entities.UserStatus;
import gov.medicaid.entities.dto.ViewStatics;
import gov.medicaid.services.CMSConfigurator;
import gov.medicaid.services.EntityNotFoundException;
import gov.medicaid.services.PortalServiceConfigurationException;
import gov.medicaid.services.PortalServiceException;
import gov.medicaid.services.RegistrationService;
import gov.medicaid.services.util.Sequences;
import gov.medicaid.services.util.Util;

import java.io.StringWriter;
import java.security.SecureRandom;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;
import javax.annotation.Resource;
import javax.ejb.EJB;
import javax.ejb.Local;
import javax.ejb.Stateless;
import javax.ejb.TransactionAttribute;
import javax.ejb.TransactionAttributeType;
import javax.ejb.TransactionManagement;
import javax.ejb.TransactionManagementType;
import javax.mail.Message.RecipientType;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.persistence.PersistenceException;
import javax.persistence.Query;

import org.apache.velocity.Template;
import org.apache.velocity.VelocityContext;
import org.apache.velocity.app.VelocityEngine;

import com.topcoder.util.keygenerator.random.RandomStringGenerator;

/**
 * Defines registration related logic.
 *
 * @author TCSASSEMBLER
 * @version 1.0
 */
@Stateless
@Local(RegistrationService.class)
@TransactionManagement(TransactionManagementType.CONTAINER)
public class RegistrationServiceBean extends BaseService implements RegistrationService {

    /**
     * Table name for auditing account links.
     */
    private static final String TBL_ACCOUNT_LINK = "EXTERNAL_ACCOUNT_LINK";

    /**
     * CMS user table for auditing.
     */
    private static final String TBL_CMS_USER = "CMS_USER";

    /**
     * Empty user used for audit comparison.
     */
    private static final CMSUser EMPTY_USER = new CMSUser();

    /**
     * Identity provider.
     */
    @EJB
    private IdentityProviderDAO identityProvider;

    /**
     * Represents the velocity engine, it is initialized during post construct and never modified after.
     */
    private VelocityEngine velocityEngine;

    /**
     * CMS Configuration object.
     */
    private CMSConfigurator config;

    /**
     * Represents the mail session. It is injected by the container it is used in the business methods. It may have any
     * value, fully mutable, but not expected to change after dependency injection
     */
    @Resource(mappedName = "java:/Mail")
    private Session session;

    /**
     * Password generator.
     */
    private final RandomStringGenerator passwordGenerator = new RandomStringGenerator(
        RandomStringGenerator.ALPHANUMERIC_SYMBOLS + "~!@#$%^&*()", 8, 8, new SecureRandom());

    /**
     * Empty constructor.
     */
    public RegistrationServiceBean() {

    }

    /**
     * Retrieves the user with a linked account from the given system using the username provided.
     *
     * @param systemName the external system name to search the link for
     * @param username the username for the external system
     * @return the matching user, or null if not found
     * @throws PortalServiceException for any errors encountered
     */
    @SuppressWarnings("rawtypes")
    @TransactionAttribute(TransactionAttributeType.SUPPORTS)
    public CMSUser findByExternalUsername(SystemId systemName, String username) throws PortalServiceException {
        String str = "SELECT u FROM CMSUser u, ExternalAccountLink e WHERE e.systemId = :system "
            + "AND e.externalUserId = :username AND u.userId = e.userId AND u.username IS NULL";

        Query q = getEm().createQuery(str);
        q.setParameter("system", systemName);
        q.setParameter("username", username);
        List rs = q.getResultList();
        if (rs.isEmpty()) {
            return null;
        }
        return (CMSUser) rs.get(0);
    }

    /**
     * Retrieves the user with the given user name.
     *
     * @param username the username to search for
     * @return the matching user, null if not found
     * @throws PortalServiceException for any errors encountered
     */
    @SuppressWarnings("rawtypes")
    @TransactionAttribute(TransactionAttributeType.SUPPORTS)
    public CMSUser findByUsername(String username) throws PortalServiceException {
        Query q = getEm().createQuery("FROM CMSUser u WHERE u.username = :username");
        q.setParameter("username", username);
        List rs = q.getResultList();
        if (rs.isEmpty()) {
            return null;
        }
        return (CMSUser) rs.get(0);
    }

    /**
     * Registers the given user.
     *
     * Default role assigned will be Provider if not set (self service registration). Passwords will be generated and
     * sent via email so user email cannot be null
     *
     * @param registrant the user to be registered
     * @return the user id for the new user
     * @throws PortalServiceException for any errors encountered, or if any field is considered invalid by the
     *             underlying implementations
     */
    @TransactionAttribute(TransactionAttributeType.REQUIRED)
    public String register(CMSUser registrant) throws PortalServiceException {
        if (registrant == null) {
            throw new IllegalArgumentException("registrant cannot be null.");
        }

        if (Util.isBlank(registrant.getUsername())) {
            throw new IllegalArgumentException("username is required by this implementation.");
        }

        if (Util.isBlank(registrant.getEmail())) {
            throw new IllegalArgumentException("email is required by this implementation.");
        }

        String userId = createUser(null, registrant);

        String password = passwordGenerator.nextString();
        identityProvider.provisionUser(registrant, password);

        Map<String, Object> vars = new HashMap<String, Object>();
        vars.put("registrant", registrant);
        vars.put("password", password);

        sendNotification(registrant.getEmail(), EmailTemplate.NEW_REGISTRATION, vars);
        return userId;
    }

    /**
     * Registers an external user. Default role assigned will be Provider (self service registration).
     *
     * @param systemId the system id for the user
     * @param username the external user id
     * @param registrant the user profile
     * @return the generated user id
     * @throws PortalServiceException for any errors encountered, or if any field is considered invalid by the
     *             underlying implementations
     */
    @TransactionAttribute(TransactionAttributeType.REQUIRED)
    public String registerExternalUser(SystemId systemId, String username, CMSUser registrant)
        throws PortalServiceException {

        // create only in database (no LDAP account)
        String userId = createUser(null, registrant);

        ExternalAccountLink link = new ExternalAccountLink();
        link.setSystemId(systemId);
        link.setExternalUserId(username);
        addAccountLink(userId, link);

        return userId;
    }

    /**
     * Suspends the given user.
     *
     * @param principal the user performing the action
     * @param userId the user to be suspended
     * @throws PortalServiceException for any errors encountered
     */
    @TransactionAttribute(TransactionAttributeType.REQUIRED)
    public void suspend(CMSUser principal, String userId) throws PortalServiceException {
        changeStatus(principal, userId, UserStatus.DISABLED);
    }

    /**
     * Reinstates the given user.
     *
     * @param principal the user performing the action
     * @param userId the user to be reinstated
     * @throws PortalServiceException for any errors encountered
     */
    @TransactionAttribute(TransactionAttributeType.REQUIRED)
    public void reinstate(CMSUser principal, String userId) throws PortalServiceException {
        changeStatus(principal, userId, UserStatus.ACTIVE);
    }

    /**
     * Creates the account link. Ignores if there is already a link for the account
     *
     * @param userId the user id to be linked
     * @param link the account link details
     * @throws PortalServiceException for any errors encountered
     */
    @TransactionAttribute(TransactionAttributeType.REQUIRED)
    public void addAccountLink(String userId, ExternalAccountLink link) throws PortalServiceException {
        ExternalAccountLink existing = findAccountLink(userId, link.getSystemId(), link.getExternalUserId());
        if (existing == null) {
            link.setId(0);
            link.setUserId(userId);
            getEm().persist(link);
            auditNewAccountLink(userId, link);
        }
    }

    /**
     * Retrieves the account link.
     *
     * @param userId the user id linked
     * @param system the system linked to
     * @param externalAccountId the external user
     * @return the matching account link or null if not found
     */
    @SuppressWarnings("rawtypes")
    public ExternalAccountLink findAccountLink(String userId, SystemId system, String externalAccountId) {
        String str = "FROM ExternalAccountLink e WHERE e.systemId = :system AND e.externalUserId = :username "
            + "AND e.userId = :userId";

        Query q = getEm().createQuery(str);
        q.setParameter("system", system);
        q.setParameter("username", externalAccountId);
        q.setParameter("userId", userId);
        List rs = q.getResultList();
        if (rs.isEmpty()) {
            return null;
        }
        return (ExternalAccountLink) rs.get(0);
    }

    /**
     * Sets the value of the field <code>identityProvider</code>.
     *
     * @param identityProvider the identityProvider to set
     */
    public void setIdentityProvider(IdentityProviderDAO identityProvider) {
        this.identityProvider = identityProvider;
    }

    /**
     * Audits the newly created user.
     *
     * @param actor the user performing the action
     * @param registrant the user that was created
     */
    private void auditNewUser(String actor, CMSUser registrant) {
        auditUserChange(actor, registrant, EMPTY_USER);
    }

    /**
     * Audits the newly created user.
     *
     * @param actor the user performing the action
     * @param updated the user that was created
     * @param original the old state of the entity
     */
    private void auditUserChange(String actor, CMSUser updated, CMSUser original) {
        AuditRecord audit = new AuditRecord();
        audit.setSystemId(SystemId.CMS_ONLINE.value());
        audit.setAction("A");

        if (updated == EMPTY_USER) {
            audit.setAction("D");
        } else if (original != EMPTY_USER) {
            audit.setAction("U");
        }

        audit.setDate(Calendar.getInstance().getTime());
        audit.setUsername(actor);
        audit.setDetails(new ArrayList<AuditDetail>());
        getEm().persist(audit);

        List<AuditDetail> lst = audit.getDetails();
        String tbl = TBL_CMS_USER;

        lst.add(createDetail(tbl, "USER_ID", updated.getUserId(), original.getUserId()));
        lst.add(createDetail(tbl, "USER_NAME", updated.getUsername(), original.getUsername()));
        lst.add(createDetail(tbl, "FIRST_NAME", updated.getFirstName(), original.getFirstName()));
        lst.add(createDetail(tbl, "MIDDLE_NAME", updated.getMiddleName(), original.getMiddleName()));
        lst.add(createDetail(tbl, "PHONE_NUMBER", updated.getPhoneNumber(), original.getPhoneNumber()));
        lst.add(createDetail(tbl, "EMAIL", updated.getEmail(), original.getEmail()));
        lst.add(createDetail(tbl, "STATUS", nsGetStatus(updated), nsGetStatus(original)));
        lst.add(createDetail(tbl, "ROLE_CD", nsGetRole(updated), nsGetRole(original)));

        for (AuditDetail auditDetail : lst) {
            if (auditDetail != null) {
                auditDetail.setAuditRecordId(audit.getId());
                getEm().persist(auditDetail);
            }
        }
    }

    /**
     * Retrieves the role of the user, null if not found.
     * @param updated the user
     * @return the role description, null if not set
     */
    private String nsGetRole(CMSUser updated) {
        if (updated.getRole() == null) {
            return null;
        }
        return updated.getRole().getCode();
    }

    /**
     * Retrieves the status of the user, null if not found.
     *
     * @param updated the user
     * @return the role description, null if not set
     */
    private String nsGetStatus(CMSUser updated) {
        if (updated.getStatus() == null) {
            return null;
        }
        return updated.getStatus().name();
    }

    /**
     * Creates an audit detail from the given values.
     *
     * @param tableName the table name
     * @param columnName the column name
     * @param value the value inserted
     * @return the audit detail
     */
    private AuditDetail createDetail(String tableName, String columnName, String value) {
        return createDetail(tableName, columnName, value, null);
    }

    /**
     * Creates an audit detail from the given values.
     *
     * @param tableName the table name
     * @param columnName the column name
     * @param value the value inserted
     * @param oldValue the old value
     * @return the audit detail
     */
    private AuditDetail createDetail(String tableName, String columnName, String value, String oldValue) {
        if (Util.defaultString(value).equals(Util.defaultString(oldValue))) {
            return null; // no change
        }

        AuditDetail d = new AuditDetail();
        d.setTableName(tableName);
        d.setColumnName(columnName);
        d.setNewValue(value);
        d.setOldValue(oldValue);
        return d;
    }

    /**
     * Audits the created account link.
     *
     * @param userId the user that created link
     * @param link the created link
     */
    private void auditNewAccountLink(String userId, ExternalAccountLink link) {
        // audit account link
        AuditRecord audit = new AuditRecord();
        audit.setSystemId(SystemId.CMS_ONLINE.value());
        audit.setAction("A");
        audit.setDate(Calendar.getInstance().getTime());
        audit.setUsername(userId);
        audit.setDetails(new ArrayList<AuditDetail>());
        getEm().persist(audit);

        List<AuditDetail> lst = audit.getDetails();
        String tbl = TBL_ACCOUNT_LINK;
        lst.add(createDetail(tbl, "USER_ID", link.getUserId()));
        lst.add(createDetail(tbl, "SYSTEM_ID", link.getSystemId().value()));
        lst.add(createDetail(tbl, "EXTERNAL_USER_ID", link.getExternalUserId()));

        for (AuditDetail auditDetail : lst) {
            if (auditDetail != null) {
                auditDetail.setAuditRecordId(audit.getId());
                getEm().persist(auditDetail);
            }
        }
    }

    /**
     * Creates the user in the database.
     *
     * @param actor the user id performing the action (null for self registration)
     * @param registrant the entity to be created
     * @return the generated user id string
     */
    private String createUser(String actor, CMSUser registrant) {
        // ensure we get a generated ID
        registrant.setUserId(null);

        // active by default
        registrant.setStatus(UserStatus.ACTIVE);

        // Provider by default
        if (registrant.getRole() == null) {
            registrant.setRole(findLookupByDescription(Role.class, ViewStatics.ROLE_PROVIDER));
        } else {
            registrant.setRole(findLookupByDescription(Role.class, registrant.getRole().getDescription()));
        }

        getEm().persist(registrant);

        if (actor == null) {
            actor = registrant.getUserId(); // self registration
        }

        // audit because user is not a versioned object.
        auditNewUser(actor, registrant);
        return registrant.getUserId();
    }

    /**
     * Sends email notifications.
     *
     * @param email the recipient
     * @param emailType the name of the template to be used
     * @param vars the substitution variables to put in the templating context
     * @throws PortalServiceException for any errors encountered
     */
    private void sendNotification(String email, EmailTemplate emailType, Map<String, Object> vars)
        throws PortalServiceException {
        MimeMessage message = new MimeMessage(session);

        try {
            message.setRecipient(RecipientType.TO, new InternetAddress(email));
            message.setSubject(config.getEmailSubject(emailType));

            Template template = velocityEngine.getTemplate(config.getEmailTemplateFile(emailType));
            StringWriter writer = new StringWriter();
            VelocityContext velocityContext = new VelocityContext();
            for (Map.Entry<String, Object> entry : vars.entrySet()) {
                velocityContext.put(entry.getKey(), entry.getValue());
            }
            template.merge(velocityContext, writer);
            message.setText(writer.toString());

            Transport.send(message);
        } catch (Exception e) {
            throw new PortalServiceException("Error while sending notification.", e);
        }
    }

    /**
     * Change the status of the user.
     *
     * @param principal the user performing the action
     * @param userId the user that will have the change in status
     * @param status the new status expected
     */
    private void changeStatus(CMSUser principal, String userId, UserStatus status) {
        CMSUser user = getEm().find(CMSUser.class, userId);

        UserStatus oldValue = user.getStatus();
        if (status == oldValue) {
            // nothing to do since it is already in this status
            return;
        }

        user.setStatus(status);
        getEm().merge(user);

        // audit status change
        AuditRecord audit = new AuditRecord();
        audit.setSystemId(SystemId.CMS_ONLINE.value());
        audit.setAction("U");
        audit.setDate(Calendar.getInstance().getTime());
        if (principal != null) {
            audit.setUsername(principal.getUserId());
        } else {
            audit.setUsername(ViewStatics.SYSTEM_USER);
        }
        getEm().persist(audit);

        String tbl = TBL_CMS_USER;
        AuditDetail auditDetail = new AuditDetail();
        auditDetail.setTableName(tbl);
        auditDetail.setColumnName("STATUS");
        auditDetail.setOldValue(oldValue.name());
        auditDetail.setNewValue(status.name());
        auditDetail.setAuditRecordId(audit.getId());
        getEm().persist(auditDetail);
    }

    /**
     * This method checks that all required injection fields are in fact provided.
     *
     * @throws PortalServiceConfigurationException - If there are required injection fields that are not injected
     */
    @PostConstruct
    public void init() {
        super.init();
        if (session == null) {
            throw new PortalServiceConfigurationException("session must be configured.");
        }

        if (identityProvider == null) {
            throw new PortalServiceConfigurationException("identityProvider must be configured.");
        }

        config = new CMSConfigurator();
        velocityEngine = config.getVelocityEngine();
    }

    /**
     * Sets the value of the field <code>session</code>.
     *
     * @param session the session to set
     */
    public void setSession(Session session) {
        this.session = session;
    }

    /**
     * Replaces the password of the given user.
     *
     * @param user the user resetting the password
     * @param oldPassword the old password
     * @param password the new password
     * @return true only if the password was reset
     * @throws PortalServiceException for any errors encountered
     */
    public boolean resetPassword(CMSUser user, String oldPassword, String password) throws PortalServiceException {
        if (identityProvider.authenticate(user.getUsername(), oldPassword)) {
            identityProvider.resetPassword(user.getUsername(), password);
            HashMap<String, Object> vars = new HashMap<String, Object>();
            vars.put("user", user);
            sendNotification(user.getEmail(), EmailTemplate.UPDATE_PASSWORD, vars);
            return true;
        }
        return false;
    }

    /**
     * Replaces the password of the given user and emails it to them.
     * @param username the user resetting the password
     * @param emailAddress the email address (should match one on file)
     * @return true if the password was reset
     *
     * @throws PortalServiceException for any errors encountered
     */
    public boolean resetPassword(String username, String emailAddress) throws PortalServiceException {

        CMSUser user = findByUsername(username);
        if (user == null || !user.getEmail().equals(emailAddress)) {
            return false;
        }

        String password = passwordGenerator.nextString();
        identityProvider.resetPassword(username, password);
        Map<String, Object> vars = new HashMap<String, Object>();
        vars.put("user", user);
        vars.put("password", password);
        sendNotification(user.getEmail(), EmailTemplate.FORGOT_PASSWORD, vars);
        return true;
    }

    /**
     * Retrieves the user with the given user id.
     *
     * @param userId the id to search for
     * @return the matching user, null if not found
     */
    public CMSUser findByUserId(String userId) {
        return getEm().find(CMSUser.class, userId);
    }

    /**
     * Updates basic profile information for the given user.
     *
     * @param actorId the actor performing this operation
     * @param user the user to be updated.
     * @throws PortalServiceException for any errors encountered
     */
    public void updateUserProfile(String actorId, CMSUser user) throws PortalServiceException {
        if (user == null || Util.isBlank(user.getUserId())) {
            throw new PortalServiceException("Cannot update non-persistent entity.");
        }

        if (getEm().contains(user)) {
            // detach so we can get the current object state.
            user = BinderUtils.clone(user);
        }

        CMSUser oldState = getEm().find(CMSUser.class, user.getUserId());
        if (oldState == null) {
            throw new EntityNotFoundException("Cannot update non-persistent entity.");
        }

        CMSUser changes = BinderUtils.clone(oldState);
        // bind only updateable fields
        changes.setPhoneNumber(user.getPhoneNumber());
        changes.setFirstName(user.getFirstName());
        changes.setLastName(user.getLastName());
        changes.setMiddleName(user.getMiddleName());
        changes.setEmail(user.getEmail());

        if (user.getStatus() != null) {
            changes.setStatus(user.getStatus());
        }
        if (user.getRole() != null) {
            changes.setRole(getLookupService().findLookupByDescription(Role.class, user.getRole().getDescription()));
        }

        auditUserChange(actorId, changes, oldState);
        identityProvider.updateUser(changes);
        getEm().merge(changes);
    }

    /**
     * Search for users given a criteria.
     *
     * @param criteria the criteria to be used
     * @return the matching users
     * @throws PortalServiceException for any errors encountered
     */
    @SuppressWarnings("unchecked")
    public SearchResult<CMSUser> findUsersByCriteria(UserSearchCriteria criteria)  throws PortalServiceException {
        if (criteria == null) {
            throw new IllegalArgumentException("Criteria cannot be null.");
        }

        try {
            SearchResult<CMSUser> results = new SearchResult<CMSUser>();
            results.setPageNumber(criteria.getPageNumber());
            results.setPageSize(criteria.getPageSize());

            StringBuilder countQuery = new StringBuilder("SELECT count(entity) FROM CMSUser entity WHERE 1 = 1 ");
            appendCriteria(countQuery, criteria);

            Query count = getEm().createQuery(countQuery.toString());
            bindParameters(count, criteria);
            results.setTotal(((Number) count.getSingleResult()).intValue());

            StringBuilder fetchQuery = new StringBuilder("SELECT entity FROM CMSUser entity WHERE 1 = 1 ");
            appendCriteria(fetchQuery, criteria);
            appendSorting(fetchQuery, criteria);

            Query items = getEm().createQuery(fetchQuery.toString());
            bindParameters(items, criteria);
            if (criteria.getPageSize() > 0) {
                int offset = (criteria.getPageNumber() - 1) * criteria.getPageSize();
                items.setFirstResult(offset);
                items.setMaxResults(criteria.getPageSize());
            }

            results.setItems(items.getResultList());
            return results;
        } catch (PersistenceException e) {
            throw new PortalServiceException("Could not complete search.", e);
        }
    }

    /**
     * Deletes the given users.
     *
     * @param actorId the user performing this operation
     * @param userIds the user ids to be removed from the system.
     * @throws PortalServiceException for any errors encountered
     */
    public void unregisterUsers(String actorId, String[] userIds) throws PortalServiceException {
        if (userIds == null) {
            throw new IllegalArgumentException("userIds cannot be null.");
        }

        for (String userId : userIds) {
            CMSUser oldState = findByUserId(userId);
            auditUserChange(actorId, EMPTY_USER, oldState);
            identityProvider.removeUser(oldState.getUsername());
            getEm().remove(oldState);
        }
    }

    /**
     * Appends the user search criteria to the current buffer.
     *
     * @param buffer the query buffer
     * @param criteria the search criteria
     */
    private void appendCriteria(StringBuilder buffer, UserSearchCriteria criteria) {
        String operator = "AND";
        if ((!criteria.isAnd() && (criteria.getFirstName().length() != 0))) {
            operator = "OR";
        }
        StringBuilder conditions = new StringBuilder();
        if (Util.isNotBlank(criteria.getUsername())) {
            conditions.append(operator).append(" entity.username = :username ");
        }
        if (Util.isNotBlank(criteria.getLastName())) {
            conditions.append(operator).append(" entity.lastName = :lastName ");
        }
        if (Util.isNotBlank(criteria.getFirstName())) {
            conditions.append(operator).append(" entity.firstName = :firstName ");
        }
        if (Util.isNotBlank(criteria.getEmail())) {
            conditions.append(operator).append(" entity.email = :email ");
        }
        if (Util.isNotEmpty(criteria.getRoles())) {
            conditions.append("AND").append(" entity.role.description in (:roles) ");
        }

        if (conditions.length() > 0) {
            if ("AND".equals(operator)) {
                buffer.append(conditions.toString());
            } else {
                buffer.append("AND ( 1=0 ");
                buffer.append(conditions.toString());
                buffer.append(") ");
            }
        }

        // internal users only as external users are auto-provisioned
        buffer.append("AND entity.username IS NOT NULL ");
    }

    /**
     * Binds the user search criteria to the query.
     *
     * @param query the query to bind to
     * @param criteria the search criteria
     */
    private void bindParameters(Query query, UserSearchCriteria criteria) {
        if (Util.isNotBlank(criteria.getUsername())) {
            query.setParameter("username", criteria.getUsername());
        }
        if (Util.isNotBlank(criteria.getLastName())) {
            query.setParameter("lastName", criteria.getLastName());
        }
        if (Util.isNotBlank(criteria.getFirstName())) {
            query.setParameter("firstName", criteria.getFirstName());
        }
        if (Util.isNotBlank(criteria.getEmail())) {
            query.setParameter("email", criteria.getEmail());
        }
        if (Util.isNotEmpty(criteria.getRoles())) {
            query.setParameter("roles", criteria.getRoles());
        }
    }

    /**
     * Appends the sorting criteria.
     * @param fetchQuery the fetch query
     * @param criteria the criteria to append
     */
    private void appendSorting(StringBuilder fetchQuery, UserSearchCriteria criteria) {
        if (Util.isNotBlank(criteria.getSortColumn())) {
            fetchQuery.append(" ORDER BY entity.").append(criteria.getSortColumn())
                .append(!criteria.isAscending() ? " DESC" : " ASC");
        }
    }

    /**
     * Performs registration through administrator screens.
     * @param actor the administrator user
     * @param registrant the user to register
     * @param password the password to assign (if null, a new one is generated and emailed)
     * @return the user id
     * @throws PortalServiceException for any errors encountered
     */
    public String registerByAdmin(CMSUser actor, CMSUser registrant, String password) throws PortalServiceException {
        if (registrant == null) {
            throw new IllegalArgumentException("registrant cannot be null.");
        }

        if (Util.isBlank(registrant.getUsername())) {
            throw new IllegalArgumentException("username is required by this implementation.");
        }

        if (Util.isBlank(registrant.getEmail())) {
            throw new IllegalArgumentException("email is required by this implementation.");
        }

        String userId = createUser(actor.getUserId(), registrant);
        if (password == null) {
            password = passwordGenerator.nextString();
        }
        identityProvider.provisionUser(registrant, password);

        Map<String, Object> vars = new HashMap<String, Object>();
        vars.put("admin", actor);
        vars.put("registrant", registrant);
        vars.put("password", password);
        sendNotification(registrant.getEmail(), EmailTemplate.NEW_REGISTRATION_BY_ADMIN, vars);
        return userId;
    }

    /**
     * Performs registration updated administrator screens.
     * @param actor the administrator user
     * @param registrant the user to updated
     * @param password the password to assign (if null, no password change is made)
     * @return the user id
     * @throws PortalServiceException for any errors encountered
     */
    public String updateByAdmin(CMSUser actor, CMSUser registrant, String password) throws PortalServiceException {
        updateUserProfile(actor.getUserId(), registrant);

        if (Util.isNotBlank(password)) {
            Map<String, Object> vars = new HashMap<String, Object>();
            vars.put("user", registrant);
            identityProvider.resetPassword(registrant.getUsername(), password);
            sendNotification(registrant.getEmail(), EmailTemplate.UPDATE_PASSWORD, vars);
        }
        return registrant.getUserId();
    }
    
    /**
     * Authenticates the user.
     *
     * @param username the username
     * @param password the password
     * @return if a matching record is found
     * @throws PortalServiceException for any errors encountered 
     */
    public boolean authenticate(String username, String password) throws PortalServiceException {
        return identityProvider.authenticate(username, password);
    }
}