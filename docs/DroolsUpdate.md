## Issue #385: Drools Update (WIP)
#### Goal: Update the RulesEngine used in cms-business-process from Drools 5.4.0.Final to KIE 7.7.0.Final

#### Phases:
1. Analyze the existing code to understand the levels of Drools access from
    1. **lowest**: knowledge base / session creation **to**
    2. **highest**: knowledge base / session invocation
2. Refactor existing code to reduce the exposure of RulesEngine API's to the minimum
    1. Refactor use of Drools knowledge objects
    2. If possible, refactor Drools `WorkItem`-related artifacts by applying subclassing / wrapping / adapting.
3. Rebuild and test refactored code
4. Update Drools to KIE 7.7.0.Final
    - The KIE API's introduced in Drools Version 6 replace most of the
    previous Drools API's
    - Resolve any conflicts with current jBPM version (also version 5.4.0.Final).
5. **Optional**: Move all Drools API-related code to a separate project to support easier testing and guarantee future isolation.
6. **Optional**: Decouple the KIE layer further, providing interfaces
to an external KIE Rules Server process.

---
#### Analysis 1.1: Knowledge Base / Sesssion Creation
**interface gov.medicaid.domain.rules.KnowledgeDelegate**

Defines 4 factory methods for creating `Drools StatefulKnowledgeSession` instances.
1. `StatefulKnowledgeSession newValidationSession()`
2. `StatefulKnowledgeSession newScreeningValidationSession()`
3. `StatefulKnowledgeSession newWorkflowSession(EntityManagerFactory, UserTransaction)`
4. `StatefulKnowledgeSession reloadWorkflowSession(int sessionId, EntityManagerFactory, UserTransaction)`


* See `DroolsKnowledgeDelegate` below for implementation details.

**class gov.medicaid.domain.rules.DroolsKnowledgeDelegate**

This class implements the 4 factory methods defined in `interface KnowledgeDelegate`

Class initialization consists of the following steps:
1. Check the flag (`useGuvnor`) that sets the use of embedded / external rules.
    - To be addressed based on future external rules service implementation.
2. Initialize `validationKnowledgeBase` from validation rules.
3. Initialize `screeningKnowledgeBase` from screening rules
4. Initialize `processKnowledgeBase` from `EnrollmentProcess.bpmn`

Implementation:
1. `StatefulKnowledgeSession newValidationSession()`
creates a session from the `validationKnowledgeBase`
2. `StatefulKnowledgeSession newScreeningValidationSession()`
creates a session from the `screeningKnowledgeBase`
3. `StatefulKnowledgeSession newWorkflowSession(EntityManagerFactory,UserTransaction)`.
Drools and jBPM support persistence of runtime state. This method instantiates
a persistent `StatefulKnowledgeSession` using the provided JPA `EntityManagerFactory`.
4. `StatefulKnowledgeSession reloadWorkflowSession(int sessionId,EntityManagerFactory, UserTransaction)`
Reloads a workflow session identified by `sessionID`.

##### Minor Edits:
* Moved instantiation of `processKnowledgeBase` to constructor for consistency.
* Reformatted: wrap long lines at 90 characters

Note: future code improvements:
* class can be `package` scope
* redundant variables to be removed


**class gov.medicaid.domain.rules.CMSKnowledgeUtility**

This class provides a facade with identical signatures for the four factory methods in
`DroolsKnowledgeDelegate,` of which it holds a static instance.
##### Minor Edits:
* class description change: "This class provides a facade for DroolsKnowledgeDelegate"
* javadoc correction: `@param entityManager` => `entityManagerFactory`
* javadoc correction change: class name and parameter list in `@see` reference
Note: This class should be renamed to `KnowledgeSessionFactory;`
its methods already have typical factory names (`newX()`).

---

#### Analysis 1.2: Knowledge Base / Session Invocation

**class gov.medicaid.services.impl.PresentationServiceBean**

When an enrollment page is submitted `public checkForErrors(EnrollmentType ticket, List<String> tabs)`
calls`private checkForErrors(ValidationRequest request)`.
The latter calls`CMSKnowledgeUtility.newValidationSession()`,
populates the session with data and executes the rules.
##### Minor Edits:
* Provided missing `@Override` annotation for the interface methods.


**gov.medicaid.process.enrollment.ScreeningHandler**

When a provider is screened `public executeWorkItem()` calls`CMSKnowledgeUtility.newScreeningSession(),`
populates the session from the process model and executes the rules.

##### Minor Edits:
* Removed unused `EntityManager` instance member.


**gov.medicaid.services.implBusinessProcessServiceBean**

When a new enrollment process is started
1. `public long enroll()` retrieves a session from `CMSKnowledgeUtility.newWorkflowSession()`,
2. populates it with process data
3. calls `startProcess()` on the session
4. commits the transaction
5. returns the processId returned by the process

When a pending enrollment submission is updated
1. `public updateRequest()` calls `private resubmit()` with an existing `ProcessModel`
2. `resubmit()` retrieves a new session from`CMSKnowledgeUtility.newWorkflowSession()`
3. updates the `ProcessModel` with the new process id
4. The enrollment data (`ticket`) is updated in the database.
    * Note: `getTicketDetails()` is `@Deprecated` - what replaces it?

When a review is performed
1. `public completeReview()` calls `private reloadSessionById()` which
2. reloads a persisted session from `CMSKnowledgeUtility.reloadWorkflowSession()`
3. updates the process model
    * Need to understand whether `updateRequest()` needs to hold on to the knowledge session in order to complete its transaction.  

---

#### 2. Refactoring 2.1: Drools knowledge base / session creation and use

* Note: for simplicity method argument lists are not shown.

**New: class gov.medicaid.domain.rules.RulesExecutor**

This class holds the Drools-referencing code shown in section **1.ii**.

* Moved `PresentationServiceBean private ValidationResponse checkForErrors()` to
`RulesExecutor public static ValidationResponse executeProviderValidationRules()`
* Moved Drools code from `ScreeningHandler public void executeWorkItem()` to
`RulesExecutor public static void executeProviderScreeningRules()`
* Moved  Drools code from `BusinessProcessServiceBean.enroll()` to
`RulesExecutor static long startEnrollmentProcess()`
* Moved Drools code from `BusinessProcessServiceBean resubmit()` to
`RulesExecutor public static void resubmitEnrollment()`
* Moved all code from `BusinessProcessServiceBean.completeReview()` to
`RulesExecutor.completeEnrollmentReview()` because of transaction
boundary.
  - Question: `EnrollmentProcess.getEnrollment()` is called repeatedly
  in this method - is there any reason why the `Enrollment` instance
  returned the first time can't be reused?
  - Note methods moved to new class `EnrollmentProcessUtils` (below).

**New: class gov.medicaid.process.enrollment.EnrollmentProcessUtils**

Two methods from `BusinessProcessServiceBean`, `private EnrollmentProcess getEnrollmentForReview()` and `private ContentData marshalEnrollmentProcess()` have been moved here and made `public static.` They are used by both `BusinessProcessServiceBean` and `RulesExecutor`.

**Deleted: interface gov.medicaid.domain.rules.KnowledgeDelegate**

This interface is implemented only by `gov.medicaid.domain.rules.DroolsKnowledgeDelegate`
and referenced only by `gov.medicaid.domain.rules.CMSKnowledgeUtility`.
* This interface has been removed because it exposes the underlying
rules implementation (Drools), thus providing no decoupling value.


**Changed: class gov.medicaid.domain.rules.CMSKnowledgeUtility**
* removed reference to deleted`interface KnowledgeDelegate`


**Moved: class gov.medicaid.domain.rules.DSLTester**
* This standalone testing application has been moved to a new package `test/groovy/gov.medicaid.domain.rules`, to be converted to Spock test


#### 2. Refactoring 2.2: `WorkItem` artifacts

##### TBD
