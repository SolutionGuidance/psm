# API endpoints

The PSM endpoints are mostly intended to be used by a browser viewing
the application.  They have not all been tested, and most of them will
likely be affected by the changes happening for issue
[#36](https://github.com/OpenTechStrategies/psm/issues/36).  Some may be
duplicative.  This list will be clarified as we edit API endpoints.

## User Administration

These are endpoints having to do with creating, viewing, and editing
users.  

- Accounts  
  /accounts  
  /accounts/new  
  /accounts/confirm  
  
- Forgot Password  
  /forgotpassword  
  
- Search users  
  /system/search/*  
  /list  
  /delete  
  
- User administration  
  /system/user/*  
  /list  
  /search  
  /details  
  /new  
  /new  
  /edit  
  /delete  
  
- User editing  
  /ops/getUser  
  /ops/beginEditUser  
  /ops/updateUser  
  
- Agent Controller:  
  These endpoints are similar to those in "User administration," but
  specifically for "service agent" type users.  

  /admin/viewAgents  
  /admin/viewAgents  
  /admin/getAgent  
  /admin/beginEditAgent  
  /admin/createAgent  
  /admin/updateAgent  
  /admin/deleteAgents  
  
  
  
## Provider Workflow

These are endpoints having to do with pages providers see: their own
dashboard, profile, and landing page.
  
- Dashboard  
  /provider/dashboard/*  
  /setup  
  /list  
  /drafts  
  /pending  
  /approved  
  /rejected  
  /filter  
  /export  
  /list/filter  
    
  
- Provider Profile  
  /provider/profile/*  
    /reset  
    /renew  
    /edit  
  
- Landing page  
  /landing  
  /myprofile  
    
## Screening / Enrollments

These are endpoints dealing with the screening workflow itself:
documents required for given provider types, how often providers should
be screened, and provider enrollments (applications).
  
- Agreement Documents  
  /admin/viewAgreementDocuments  
  /admin/viewAgreementDocuments  
  /admin/getAgreementDocument  
  /provider/enrollment/agreement  
  /admin/editAgreementDocument  
  /admin/createAgreementDocument  
  /admin/updateAgreementDocument  
  /admin/deleteAgreementDocuments  
  
- Screening schedule  
  /admin/getScreeningSchedule  
  /admin/beginEditScreeningSchedule  
  /admin/updateScreeningSchedule  
    
- Enrollment Controller  
  /agent/enrollment/  
  /agent/enrollment/viewDashboard  
  /agent/enrollment/viewHelp  
  /agent/enrollment/viewHelpItem  
  /agent/enrollment/rejectTicket  
  /agent/enrollment/screeningReview  
  /agent/enrollment/autoScreeningResult  
  /provider/search/exportBatch  
  /provider/search/{view}  
  /agent/enrollment/status  
  /agent/enrollment/details  
  /agent/enrollment/note  
  /agent/enrollment/approve  
  /agent/enrollment/reject  
  /agent/enrollment/screen  
  /agent/enrollment/schedule  
  /agent/enrollment/cos  
  /agent/enrollment/pendingcos  
  /agent/enrollment/addCOS  
  /agent/enrollment/addPendingCOS  
  /agent/enrollment/deleteCOS  
  /agent/enrollment/deletePendingCOS  
  
- Enrollments  
  /provider/enrollment/*  
      /attachment  
      /start  
      /renew  
      /renewTicket  
      /bulkRenewTickets  
      /edit  
      /profile  
      /steps/type  
      /steps/prev  
      /steps/next  
      /steps/rebind  
      /page  
      /print  
      /preview  
      /reviewPrint  
      /exportTicket  
      /export  
      /lookup  
      /lookupProvider  
      /ownerTypes  
      /lookupMinimumLicenses  
      /view  
      /reopen  
      /jump  
      /jump  
      /saveNote  
      /save  
      /submit  
      /resubmitWithChanges  
        
- Provider Type Controller  
  /admin/viewProviderTypes  
  /admin/viewProviderTypes  
  /admin/getProviderType  
  /admin/beginCreateProviderType  
  /admin/beginEditProviderType  
  /admin/createProviderType  
  /admin/updateProviderType  
  /admin/deleteProviderTypes  
  
## General application usage

These endpoints are used for bureaucracy within the application.
  
- Spellcheck  
  /words  
  /word  
  
- Help system  
  /admin/searchHelp  
  /admin/searchHelp  
  /admin/getHelpItem  
  /admin/editHelpItem  
  /admin/createHelpItem  
  /admin/updateHelpItem  
  /admin/deleteHelpItem  
  
- Dashboard Controller  
  /ops/viewDashboard  
  /ops/viewDashboard  
  /viewHelp  
  /viewHelpItem  
  /viewHelp  
  
- Onboarding  
  /provider/onboarding/*  
    /list  
    /link  
    
