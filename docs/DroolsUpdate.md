#Issue #385: Drools Update (WIP)
####Goal: Update the RulesEngine used in cms-business-process from Drools 5.4.0.Final to KIE 7.7.0.Final
    
####Phases:
1. Analyze the existing code to understand the levels of Drools access from 
    1. **lowest**: knowledge object creation **to** 
    2. **highest**: knowledge object invocation
2. Refactor existing code to reduce the exposure of RulesEngine API's to the minimum
3. Rebuild and test refactored code
4. Update Drools to KIE 7.7.0.Final 
    - The KIE API's introduced in Drools Version 6 replace most of the
    previous Drools API's
    - Resolve any conflicts with current jBPM version (also version 5.4.0.Final).
5. **Optional**: Decouple the KIE layer further, providing interfaces
to an external KIE Rules Server process.

####Analysis 1.i: Knowledge Object Creation
**interface gov.medicaid.domain.rules.KnowledgeDelegate**

Defines 4 factory methods for creating `Drools StatefulKnowledgeSession` instances.
1. `StatefulKnowledgeSession newValidationSession()`
2. `StatefulKnowledgeSession newScreeningValidationSession()`
3. `StatefulKnowledgeSession newWorkflowSession(EntityManagerFactory,UserTransaction)`
4. `StatefulKnowledgeSession reloadWorkflowSession(int sessionId,EntityManagerFactory, UserTransaction)`
* See `DroolsKnowledgeDelegate` below for implementation details.


**class gov.medicaid.domain.rules.DroolsKnowledgeDelegate**

This class implements the 4 factory methods defined in `interface KnowledgeDelegate` 

Class initialization consists of the following steps:
1. Check the flag (`useGuvnor`) that sets the use of embedded or external rules.
    - To be addressed based on future external rules service implementation.
2. Initialize `validationKnowledgeBase` from validation rules.
3. Initialize `screeningKnowledgeBase` from screening rules
4. Initialize `processKnowledgeBase` from `EnrollmentProcess.bpmn`

Implementation:
1. `StatefulKnowledgeSession newValidationSession()`
Creates a session from the `validationKnowledgeBase`
2. `StatefulKnowledgeSession newScreeningValidationSession()`
Creates a session from the `screeningKnowledgeBase`
3. `StatefulKnowledgeSession newWorkflowSession(EntityManagerFactory,UserTransaction)`
Drools and jBPM support persistence of runtime state. This method instantiates
a persistent `StatefulKnowldegeSession` using the provided JPA `EntityManagerFactory`.
4.   `StatefulKnowledgeSession reloadWorkflowSession(int sessionId,EntityManagerFactory, UserTransaction)`
Reloads a workflow session identified by `sessionID`.
#####Minor Edits:
* Moved instantiation of `processKnowledgeBase` to constructor for consistency.
* Reformatted: wrap long lines at 90 characters

Note: future code improvements:
* class can be `package` scope
* redundant variables to be removed


**class gov.medicaid.domain.rules.CMSKnowledgeUtility**

This class provides a facade with identical signatures for the four factory methods in
`DroolsKnowledgeDelegate`, of which it holds a static instance.
#####Minor Edits:
* class description change: "This class provides a facade for DroolsKnowledgeDelegate"
* javadoc correction: `@param entityManager` => `entityManagerFactory`
* javadoc correction change: class name and parameter list in `@see` reference
Note: This class should be renamed to `KnowledgeSessionFactory`;
its methods already have typical factory names (`newX()`).

####Analysis 1.ii: Knowledge Object Invocation

**class gov.medicaid.services.impl.PresentationServiceBean**
* When an enrollment page is submitted `public checkForErrors(EnrollmentType ticket, List<String> tabs)`
calls`private checkForErrors(ValidationRequest request)`.
The latter calls`CMSKnowledgeUtility.newValidationSession()`,
populates the session with data and executes the rules.
#####Minor Edits:
* Provided missing `@Override` annotation for the interface methods.


**gov.medicaid.process.enrollment.ScreeningHandler**

When a provider is screened `public executeWorkItem()` calls`CMSKnowledgeUtility.newScreeningSession()`,
populates the session from the process model and executes the rules.

#####Minor Edits:
* Removed unused `EntityManager` instance member.


**gov.medicaid.services.impl.BusinessProcessServiceBean**
* When a new enrollment process is started
1. `public long enroll()` retrieves a session from `CMSKnowledgeUtility.newWorkflowSession()`,
2. populates it with process data
3. calls `startProcess()` on the session
4. commits the transaction
5. returns the processId returned by the process
* When a pending enrollment submission is updated 
1. `public updateRequest()` calls `private resubmit()` with an existing `ProcessModel`
2. `resubmit()` retrieves a new session from`CMSKnowledgeUtility.newWorkflowSession()`
3. updates the `PrcessModel` with the new process id
4. The enrollment data (`ticket`) is updated in the database.
    * Note: `getTickedDetails()` is `@Deprecated` - what replaces it?
* When a review is performed
1. `public completeReview()` calls `private reloadSessionById()` which
2. reloads a persisted session from `CMSKnowledgeUtility.reloadWorkflowSession()`
3. updates the process model
    * Need to understand why `updateRequest()` needs to hold on to the knowledge session
    in order to complete its transaction.  

####2. Refactoring

**New: class gov.medicaid.domain.rules.RulesExecutor**
Refactor all Drools-referencing code shown in **1.ii** to corresponding
methods of a class that hides the Drools (then KIE) namespace from the
rest of the code. 

**Deleted: interface gov.medicaid.domain.rules.KnowledgeDelegate**

This interface is implemented only by `gov.medicaid.domain.rules.DroolsKnowledgeDelegate`
and referenced only by `gov.medicaid.domain.rules.CMSKnowledgeUtility`.
* This interface has been removed because it exposes the underlying
rules implementation (Drools), thus providing no decoupling value.


**Changed: class gov.medicaid.domain.rules.CMSKnowledgeUtility**
* removed reference to deleted`interface KnowledgeDelegate`


**Moved: class gov.medicaid.domain.rules.DSLTester**
* This standalone testing application has been moved to a new package `test/groovy/gov.medicaid.domain.rules`,
to be converted to Spock test
