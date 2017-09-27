# Drools Web UI

The PSM uses [Drools](http://drools.jboss.org/) to manage and run its business
rules, which describe how forms are validated and some of the processing done
to a submitted enrollment. By default and for simplicity, these rules are kept
in text files that are bundled into the application at compile time, but the
PSM can be configured to talk to an external server that provides a web UI to
manage and edit Drools rules.

## Setting up the Drools server

Deploying the version of Drools we are currently using as a standalone
application requires JBoss 7.1.1. The Drools installer has automated that
setup, so that to get a running instance needs only a few steps:

1. [Download Drools](https://downloads.sourceforge.net/project/jbpm/jBPM%205/jbpm-5.4.0.Final/jbpm-5.4.0.Final-installer-full.zip)
2. Unzip
3. Run installer: `ant install.demo.noeclipse`
4. Start server: `ant start.demo.noeclipse`

If you are on a RedHat / CentOS machine, [we've written a script you can
use](../scripts/drools-microservice.sh).

## Configuring the Drools server

In order for the Drools server to be able to understand the rules, it needs to
have a copy of the relevant classes.

1. Build them with `./gradlew cms-business-model:build`, which produces
   `cms-business-model/build/libs/cms-business-model.jar`.
2. Upload this jar to the Drools server
    1. Create a new package named `cms`
    2. Upload `cms-business-model.jar`: 'Create New' > 'Upload POJO Model jar'
        1. Name it 'cms-business-model'
        2. Create in package `cms`
3. Upload rules to the Drools server
    - There are three sets of rules to upload, and they all live in
      `psm-app/cms-business-process/src/main/resources/`:
        - cms.externalsources.drl
        - cms.screening.drl
        - cms.validation.drl
    - For each ruleset: 'Create New' > 'New Package' > 'Import from drl file'.

## Configuring the PSM to use the Drools server

To use the Drools server with the PSM, the PSM needs to know both that it
should use an external server and how to contact it.

- change the value of `rules.embedded` from `Y` to `N` in `cms.properties`
- add location and authentication info to the external rules configurations:
    - `ExternalSourcesRules.xml`
    - `ScreeningRules.xml`
    - `ValidationRules.xml`

One such diff looks like:

```diff
-         <resource source='http://localhost:8080/cms-rules/org.drools.guvnor.Guvnor/package/cms.externalsources/LATEST.drl' type='DRL' />
+         <resource source='http://jboss7.example.com:8080/drools-guvnor/org.drools.guvnor.Guvnor/package/cms.externalsources/LATEST.drl'
+                   type='DRL'
+                   basicAuthentication="enabled"
+                   username="username"
+                   password="password"
+         />
```

The default username and password the jBPM installer configures is
`admin`/`admin`. Substitute your URL, username, and password in the three
rules configuration XML files.

Rebuild the application and deploy it.

## Verifying your configuration

After you've made the PSM configuration changes and built and deployed the
application, you can confirm that it is using the remote rules by starting an
enrollment. Form validation is performed by Drools, so trying to advance from
an empty enrollment page should give you several "this field is required"
errors. If you get a server error, examine the server log for more details as
to what went wrong.

You can also add a new rule to the Drools server. Currently, the PSM loads the
rules the first time it needs to use Drools for anything (effectively, the
first time someone starts an enrollment), so you will need to reload the
application to pick up the new rules. One way to do that is to run
`jboss-cli.sh --connect --command=reload`.
