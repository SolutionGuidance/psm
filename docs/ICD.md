# Interface Control Document

This document describes current and projected inputs and outputs of this
Provider Screening Module (PSM).

## Current Inputs

Currently, the PSM takes data input through its user interface, which is
available through a web browser.  It also receives information from the
LEIE.  This information is received through a REST API, and used by the
PSM to determine whether or not a provider is eligible to participate in
Medicaid.

### LEIE

For full information about this input to the PSM, please see [the API
documentation](https://github.com/SolutionGuidance/psm/blob/master/etl/leie/leie/api.mdwn).

## Current Outputs

The PSM sends emails to users to confirm their registration with the
system.  In the future, it will also communicate with users about
changes in the status of their application.

## Projected Inputs and Outputs

_Note: This document is a work in progress, and this section in
particular is likely to change as work on the PSM continues._

### Federal datasources

See [the user
help](https://solutionguidance.github.io/psm/userdocs/html/service-admin-help.html#how-do-i-use-the-enrollment-verification-process)
for full descriptions of these data sources.

- LEIE: See above

- Death Master File (DMF): Currently seeking information about a sample
  data set that the PSM can use to set up automated access to this source.

- NPPES: TBD

- EPLS: This is a superset of the LEIE available through SAM.

PECOS is also a possible source of information.

### State datasources

TBD.  Inputs from state data sources are likely to be added as part of a
systems integration effort in individual states.

### Eligibility query API

The PSM expects to communicate with a provider management module and
other parts of the MMIS.  The major way in which it will do this is in
sending information about whether a given provider is approved to
participate in Medicaid or another program.  Currently, the team
anticipates that the PSM will respond to queries about provider
eligibility through an API, most likely a RESTful API.  Other modules in
the MMIS (notably the provider management module) will send a query
requesting the status of a given provider by that provider's NPI, name,
DOB, or other identifying information.  While NPI is the preferred
identifying piece of information, not all providers in all states have
NPIs, so the API will need to accept different pieces of information to
return accurate information about these "atypical" providers.  The major
output of the PSM will be a "status" for each provider queried.  This
list of statuses is a draft and is subject to change.

Statuses of providers that exist in the system (`200` responses).  These
will include a date at which the status was last accurate.

```
- draft / in progress
- pending
- rejected
- approved
- terminated (voluntarily)
- terminated (involuntarily)
```

Responses when a query does not return any records (`400` responses) or
there is an error.

```
- not found
- error
```

Other potential statuses for existent providers are `provisionally
approved` and `suspended.` The provider management module and other MMIS
modules will use the provider's status to make decisions about their
parts of the PSM (e.g., reimbursing claims).  

Note: it may be useful for other modules to know the date ranges
associated with all the statuses for a given provider.  For example, if
a provider is suspended, reinstated, then terminated (involuntarily),
claims filed during the reinstatement period should still be honored.
The billing system would need to know the exact dates for which the
provider was approved in order to reimburse them correctly.
