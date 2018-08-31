       Installation instructions for the Provider Screening Module
       ===========================================================

***NOTE: We welcome [improvements](CONTRIBUTING.md) to these
installation instructions.  A production deployment guide will be part
of our 1.0 release.***

**Contents**

- **[Background and Current Deployment Status](#background-and-current-deployment-status)**
- **[Requirements Overview](#requirements-overview)**
    - [Hardware](#hardware)
    - [Software](#software)
    - [Database](#database)
    - [Mail](#mail)
- **[Installation Instructions](#installation-instructions)**
    - [Install prerequisites](#install-prerequisites)
    - [Configure WildFly](#configure-wildfly)
    - [Configure Mail](#configure-mail)
    - [Configure Database](#configure-database)
    - [Build and deploy the application](#build-and-deploy-the-application)
    - [Build documentation](#build-documentation)
    - [Run automated tests](#run-automated-tests)
    - [Maintain and update environment](#maintain-and-update-environment)
    - [Run Database Migrations](#run-database-migrations)
- **[Production Deployment](#production-deployment)**
    - [NGINX](#nginx)
    - [Continuous Deployment](#continuous-deployment)

# Background and Current Deployment Status

**Status**: The PSM is not yet ready for production deployment, but
much of its core functionality is implemented and it is deployable for
development purposes.

The PSM was originally developed to run in the open source web
application server Apache JBoss (now called WildFly), then retargeted
to the IBM WebSphere Application Server (WAS) 8.5 in order to better
support a particular state's MMIS environment.  After inheriting the
code, we retargeted to WildFly (formerly JBoss), though still keeping
all of the functionality that was added while the PSM was in its
WebSphere interregnum.

If you are using Debian GNU/Linux or Red Hat Enterprise Linux, it may
be easiest for you to run the automated installation script
in [scripts/install.sh](scripts/install.sh).

You can also use Docker to run the current development version of the
PSM.  That would obviate all the manual configuration steps listed in
this file.  See [docker/README.md](docker/README.md) for details.

# Requirements Overview

The Provider Screening Module is a Java EE Enterprise Application. It depends
on a correctly-configured Java EE Application Server. While it was originally
written for the Java EE 6 profile, it is currently being ported to run on Java
EE 7 Application Servers, starting with WildFly 11.

These requirements are based on our understanding of the application at this
time, and will evolve as we understand it more.

## Hardware

- **Memory**: 8 GB should be enough for a test system.
- **CPU**: TBA; provisioning CPU proportional to memory (whatever that
  looks like in your environment) should be reasonable. Our
  demonstration instance runs on two cores of an Intel(R) Xeon(R) CPU
  E5-2676 v3 @ 2.40GHz.
- **Storage**: 10 GB of storage for WildFly, the PSM repository, and its
  dependencies should be plenty.

## Software

This is just an overview; see installation instructions below.

- **Operating System**: we recommend Debian 9 stable, also known as
  stretch.  If you prefer Debian testing, we have had success with
  Debian testing (aka buster).  A developer has also successfully
  installed the PSM on Red Hat 7.3 Enterprise Linux. If that's not
  feasible for your environment, any of the supported WildFly 11
  operating systems should work, but our ability to help troubleshoot
  issues that come up may be limited.  Once we test this on a few more
  platforms, we will expand the list of compatible operating systems
  to include other Linux distributions.
- **Java**: We're using OpenJDK 8, which is currently 8u121, but you should
  keep up with the latest releases and post if you have issues relating to
  upgrading.
- **Java EE Application Server**: currently WildFly 11. We may support other
  application servers in the future.

## Database

We're testing with PostgreSQL 10.x and 9.6.x.  You should be fine with
anything in the 10.x series or the 9.6.x series.

- **Storage**: We suggest starting by planning 10 GB for the database,
  and having a plan to expand or reprovision later.  We will update
  this section as we gain more data on production storage requirements.

The application requires the application server to be configured with two data sources:

- JNDI name `java:/jdbc/MitaDS`
- JNDI name `java:/jdbc/TaskServiceDS`

These should be XA data sources that both point to the same
database. The installation instructions below will take care of this
configuration for a development install.

## Mail

The application requires the application server to be configured with a mail service:
- JNDI name `java:/Mail`

The installation instructions below will take care of this
configuration for a development install.

# Installation Instructions

## Install prerequisites

1. A [Java 8](https://www.java.com) JRE and JDK. Run `java -version`
   to check your Java version; "1.8" refers to Java 8. We are testing
   with OpenJDK 8, which you can install on Debian-like systems with
   `sudo apt install openjdk-8-jdk-headless`.
1. An SMTP server. For development, consider the built-in Python SMTP
   debugging server (works on Python 2 or Python 3). In your terminal,
   run:

   ```ShellSession
   $ python -m smtpd -n -c DebuggingServer localhost:1025
   ```

   Leave the terminal session open; leave the SMTP server running as
   you continue the install process.

1. [PostgreSQL](https://www.postgresql.org/). We are testing with
   PostgreSQL 10.x and 9.6.x. Check that you have PostgreSQL installed.  If you
   do not, it is available on Debian via `sudo apt install postgresql`,
   or you can download it from https://www.postgresql.org.

1. The PSM code repository. Currently we suggest you run the PSM from
   the master branch of the development repository. Run the command
   below and it will download the source code into a new subdirectory
   called `psm`.

   ```ShellSession
   $ git clone https://github.com/SolutionGuidance/psm.git
   ```

## Configure WildFly

Building and deploying the PSM application requies WildFly to be installed and
configured. See also the [WildFly Getting Started
Guide](https://docs.jboss.org/author/display/WFLY/Getting+Started+Guide).

1. Get WildFly: Visit
   [http://wildfly.org/downloads/](http://wildfly.org/downloads/). Download
   the [11.0.0.Final full
   distribution](http://download.jboss.org/wildfly/11.0.0.Final/wildfly-11.0.0.Final.tar.gz).
   (Wildfly's downloads page doesn't offer checksums or signatures,
   but [this
   workaround](https://github.com/wildfly/wildfly.org/issues/87#issuecomment-412181885)
   can help you verify authenticity.)

   ```ShellSession
   $ cd {/path/to/this_psm_repo}
   $ # this should be a peer directory, so:
   $ cd ..
   $ tar -xzf wildfly-11.0.0.Final.tar.gz
   $ cd wildfly-11.0.0.Final
   ```

1. Check that you're really running Java 1.8.

   Some systems have multiple versions of Java installed on them.  You
   want `java` to invoke Java 1.8 -- it should look something like this:

   ```ShellSession
   $ java -version
   openjdk version "1.8.0_171"
   OpenJDK Runtime Environment (build 1.8.0_171-8u171-b11-2-b11)
   OpenJDK 64-Bit Server VM (build 25.171-b11, mixed mode)
   ```

   If you have multiple Java versions on your system and the default
   is not 1.8, you could try setting up the [jEnv](http://www.jenv.be/)
   wrapper to control which version of Java you get.

1. Add a WildFly management console user named 'psm' with a password of 'psm':

   ```ShellSession
   $ ./bin/add-user.sh psm psm
   ```

   Note that this puts the password in your shell history.  If that
   concerns you, just run `./bin/add-user` without the arguments and
   follow the prompts to add a "Management User" with the desired name
   and password, leave the group blank and answer "no" to the question
   about host controllers.

1. Stop the server if it is already running.  (It should not be running yet.)

   ```ShellSession
   $ ./bin/jboss-cli.sh --connect --command=:shutdown
   ```

1. PSM requires the `standalone-full` profile.  `standalone-full.xml` lives in
   the WildFly directory, at `standalone/configuration/standalone-full.xml`. To
   start the server:

   ```ShellSession
   $ ./bin/standalone.sh -c standalone-full.xml
   ```

   WildFly, by default, is only accessible to localhost. If you are running
   WildFly on a remote system, you may start the server in a way that allows
   remote connections:

   ```ShellSession
   $ ./bin/standalone.sh \
       -c standalone-full.xml \
       -b 0.0.0.0 \
       -bmanagement 0.0.0.0
   ```

   Be careful of the security implications of exposing the management interface
   to the internet! These instructions are for a **development** environment,
   not for a production environment.

1. Check that the server is running by visiting
   [http://localhost:9990/](http://localhost:9990/) for the management console
   and [https://localhost:8443/](https://localhost:8443/) for the app(s) it
   hosts - currently none.

   At this point, please make sure that Wildfly starts and runs with
   no errors.  Warnings are ok at this stage, but any errors in the
   console output in the terminal (usually displayed in red text) will
   prevent successful completion of the install process.

   If you see errors, one thing to check is that you do not have any
   other processes running on the ports Wildfly needs.  With Wildfly
   shut down, make sure nothing is listening on ports 8080, 8443, and
   9990.  You can see what ports are open with `nmap localhost` or
   `nmap {ip address of wildfly server}`.

1. Leave WildFly running as you continue the install process.

## Configure Mail

If you are using a debugging mail server such as the Python
`DebuggingServer` recommended above: open a new terminal session so
you can leave WildFly running in its existing terminal and Python
running in its existing terminal. In the new terminal navigate to the
WildFly directory and paste in the entire command below, all the
way through the second `EOF`:

```ShellSession
$ ./bin/jboss-cli.sh --connect << EOF
/socket-binding-group=standard-sockets/remote-destination-outbound-socket-binding=mail-smtp:write-attribute(name=port,value=1025)
/subsystem=mail/mail-session="java:/Mail":add(jndi-name="java:/Mail")
/subsystem=mail/mail-session="java:/Mail"/server=smtp:add(outbound-socket-binding-ref=mail-smtp)
EOF
```

If you are using a production mail server, add a mail session with a JNDI name
of `java:/Mail` to your application server with the appropriate credentials
using the command line or web interface.

## Configure Database

Download the [PostgreSQL JDBC driver](https://jdbc.postgresql.org/download.html)
(specifically, the JDBC 4.2 version of the driver). Place it in the
parent directory, relative to the WildFly directory.  Then deploy it to
your application server by running the following command in the WildFly
directory:

```ShellSession
$ ./bin/jboss-cli.sh --connect --command="deploy ../postgresql-{VERSION}.jar"
```

If you get an error saying that the `.jar` file "is not a valid node
type name", double-check that it's in the correct directory. If it is,
then place the `.jar` file in
`wildfly-11.0.0.Final/standalone/deployments` and then restart the
WildFly server. The terminal logging for WildFly should then include
an `INFO` line like:

```
15:32:15, 773 INFO [org.jboss.as.server] (management-handler-thread - 6) WFLYSRV0010: Deployed "postgresql-42.1.1.jar" (runtime-name: "postgresql-42.1.1.jar")
```

Create a database user and a database owned by that user.  You will be prompted
to enter/create a password for the database user. Make a note of this password.

```ShellSession
$ sudo -u postgres createuser --pwprompt psm
$ sudo -u postgres createdb --owner=psm psm
```

If you get an error saying `role "postgres" does not exist`, this is likely due
to Mac OS X not assigning "postgres" as a superuser. You will need to access
your postgres database to find the superuser name and substitute it into the scripts:

```ShellSession
$ sudo -u {superuser name} createuser --pwprompt psm
$ sudo -u {superuser name} createdb --owner=psm psm
```

After creating the databases, add the data sources to the application
server.  Run the command below from the WildFly directory, replacing
`VERSION` with the version of the PostgreSQL JDBC driver you
downloaded and `PWORD` with the password you assigned to your `psm`
database user:

```ShellSession
$ VERSION=42.2.4; PWORD=psm; ./bin/jboss-cli.sh --connect <<EOF
xa-data-source add \
  --name=TaskServiceDS \
  --jndi-name=java:/jdbc/TaskServiceDS \
  --driver-name=postgresql-${VERSION}.jar \
  --xa-datasource-class=org.postgresql.xa.PGXADataSource \
  --valid-connection-checker-class-name=org.jboss.jca.adapters.jdbc.extensions.postgres.PostgreSQLValidConnectionChecker \
  --exception-sorter-class-name=org.jboss.jca.adapters.jdbc.extensions.postgres.PostgreSQLExceptionSorter \
  --enabled=true \
  --use-ccm=true \
  --background-validation=true \
  --user-name=psm \
  --password=${PWORD} \
  --xa-datasource-properties=ServerName=localhost,PortNumber=5432,DatabaseName=psm
xa-data-source add \
  --name=MitaDS \
  --jndi-name=java:/jdbc/MitaDS \
  --driver-name=postgresql-${VERSION}.jar \
  --xa-datasource-class=org.postgresql.xa.PGXADataSource \
  --valid-connection-checker-class-name=org.jboss.jca.adapters.jdbc.extensions.postgres.PostgreSQLValidConnectionChecker \
  --exception-sorter-class-name=org.jboss.jca.adapters.jdbc.extensions.postgres.PostgreSQLExceptionSorter \
  --enabled=true \
  --use-ccm=true \
  --background-validation=true \
  --user-name=psm \
  --password=${PWORD} \
  --xa-datasource-properties=ServerName=localhost,PortNumber=5432,DatabaseName=psm
EOF
```

## Build and deploy the application
1. Navigate to the psm-app directory:

   ```ShellSession
   $ cd ../{psm}/psm-app
   ```

1. Build the application with `gradle`. This depends on libraries
   provided by the application server.  Note that the command used is a wrapper
   around gradle and it is called `gradlew`, not `gradle`.  The
   `gradlew` wrapper executable is in the `psm-app` directory of the git
   repository.

   ```ShellSession
   $ cd ../{psm}/psm-app
   $ ./gradlew cms-portal-services:build
   ...[cut]...
   BUILD SUCCESSFUL
   ```

1. Deploy the built app.  You can use the WildFly Management Console UI
   at [http://localhost:9990/](http://localhost:9990/).  Log in with
   your management console username and password (if you are not already logged
   in).  Then do the following: "Deployments [tab] > Add [button] > Upload a new
   deployment > browse to file."  And browse to this file:

   `{/path/to/psm}/psm-app/cms-portal-services/build/libs/cms-portal-services.ear`

   Alternatively, you can use the command line interface, replacing the relevant
   paths below:

   ```ShellSession
   $ {/path/to/wildfly}/bin/jboss-cli.sh --connect \
       --command="deploy {/path/to/psm}/psm-app/cms-portal-services/build/libs/cms-portal-services.ear"

   ```

   If you have a previous build deployed already, you can replace the
   deployment in the UI or add the `--force` switch after `deploy`.

1. Set up the database access configuration.

    ```ShellSession
    $ cd psm-app
    $ ls gradle.properties
    ls: cannot access 'gradle.properties': No such file or directory

    ### Okay, it doesn't exist, so we can safely create it.      ###
    ### But if it *does* exist, don't do this next step, because ###
    ### we don't necessarily want to overwrite it, we just want  ###
    ### to make sure it has the right content.                   ###

    $ cp gradle.properties.template gradle.properties

    ### Now edit the file to add correct values for 
    ### `systemProp.databaseUser` and `systemProp.databasePassword`. ###
    $ {your-favorite-editor} gradle.properties
    ```

1. Create database schema and initial data. There are two sets of tables in this project.  The first are application tables, and they are created and seeded using liquibase migrations.  The second set of tables are related to jbpm and these are loaded via a SQL script.  In the `psm-app` subdirectory, run the commands below in any order to load both sets:


    ```ShellSession
    $ ./gradlew db:update
    ```

    ```ShellSession
    $ cat {/path/to/psm}/psm-app/db/jbpm.sql \
      | psql -h localhost -U psm psm
    ```

1. To check that the app is running, navigate to
   [http://localhost:8080/cms/login](http://localhost:8080/cms/login).
   You should see a login screen.

1.  Login with one of the test users: Username `system` with password
    `system` is a "system administrator" account that can create new
    accounts.  Username `admin` with password `admin` is a "service
    admin" account that can create new provider enrollments.

## Build documentation

Generate the API documentation from Javadoc annotations by navigating to the
`psm-app` directory and invoking gradle:

    ./gradlew cms-web:apiDocs

The generated documentation will go into `psm-app/cms-web/build/reports/api-docs`.

To build the user documentation, invoke gradle:

    ./gradlew userhelp:html

The generated documentation will go into
`psm-app/userhelp/build/html`. Open
[`psm-app/userhelp/build/html/index.html`](psm-app/userhelp/build/html/index.html)
in your browser.

More commands are available; run `./gradlew userhelp:tasks` or see
`psm-app/userhelp/README.mdwn`.

## Run automated tests

See `docs/TESTING.md` for instructions on running the automated tests.

## Maintain and update environment

See `scripts/` for several utility scripts for use by system
administrators or our build systems.

## Run Database Migrations

Updating the database requires running the Liquibase migrations to get
the database into the up-to-date configuration. See
[MIGRATIONS.md](docs/MIGRATIONS.md) for details.

Migration scripts are stored in `psm-app/db/`.


1. To run the migrations:

    ```shell
       > ./gradlew db:update
    ```

More material coming soon about how to run individual migrations.

## Set up external data sources

See the [Credentialing and Verification: Extract, Translate, and Load
repository](https://github.com/SolutionGuidance/cavetl) for information on
using the API wrappers around the various external data sources the PSM
integrates with.

### Death Master File test data

As the Social Security Administration limits access to the Death Master file,
we have a substitute for the sake of development and testing. See the [README
for the mock
wrapper](psm-app/cms-business-process/src/test/resources/dmf-api-mock/README.md)
for more information.

# Production Deployment

If you want to deploy this in earnest, there will be additional steps
necessary to scale up to a large number of users.  Every deployment
environment will be different, so this section is not a set of
instructions to deploy.  Instead, it contains notes that might be
useful to inform your own approach to deploying the PSM.

## NGINX

NGINX has a maximum upload file size.  Its default can be quite low
(1MB on our Debian system), and large PDFs of licenses and
certificates can trigger "413 Request Entity Too Large" errors in
NGINX.  You will want to set maximum uploaded file size in both NGINX
*and* in the PSM (adjust `max.upload.size` in
`psm/psm-app/services/src/main/resources/cms.properties`).  PDFs can
get quite large, especially if they are multi-page PDFs of scanned
documents.  We do not yet have a recommended size to set this to, but
we will set a sane default in `cms.properties` when we do.  See [issue
263 in GitHub](https://github.com/SolutionGuidance/psm/issues/263)
for some discussion of the problem.

## Configuration options

Note: This section will grow as we describe more configurable options.

1. The amount of time before the system logs out an inactive user can be
set in the `session-timeout` variable in
`psm-app/cms-web/WebContent/WEB-INF/web.xml`.

## Continuous Deployment and Continuous Integration

### Jenkins

This project uses Jenkins for continuous deployment and continuous integration.

In order to configure another Jenkins server that does these tasks, follow the
appropriate documentation on the [Jenkins web site](https://jenkins.io/), and
then install the following plugins:

- [Checkstyle Plugin](https://wiki.jenkins.io/display/JENKINS/Checkstyle+Plugin)
- [GitHub pull request builder plugin](https://wiki.jenkins.io/display/JENKINS/GitHub+pull+request+builder+plugin)
- [Gradle Plugin](https://wiki.jenkins.io/display/JENKINS/Gradle+Plugin)
- [HTML Publisher Plugin](https://wiki.jenkins.io/display/JENKINS/HTML+Publisher+Plugin)

You will need a [GitHub personal access
token](https://help.github.com/articles/creating-a-personal-access-token-for-the-command-line/)
to have Jenkins mark the results of its builds in GitHub. The token should have
the `repo:status`, `admin:repo_hook`, and `repo_deployment` permission scopes.

Publishing the Serenity test reports uses the HTML Publisher Plugin. As the
reports use JavaScript, the
[default](https://wiki.jenkins.io/display/JENKINS/Configuring+Content+Security+Policy)
[content security policy](https://content-security-policy.com/) needs to be
reconfigured to the value `sandbox allow-scripts allow-same-origin`. We did so
by editing `/etc/default/jenkins` and adding the following argument to the
`JAVA_ARGS` variable:

```
-Dhudson.model.DirectoryBrowserSupport.CSP=\"sandbox allow-scripts allow-same-origin
```

### Continuous Integration

We have configured Jenkins to do several things on new pull requests:

- build the project
- build the docs
- run the unit tests
- run the integration tests
- check the code style against our style guide

Each task is a freestyle project, triggered by the GitHub pull request plugin.

- build: runs the `cms-portal-services:build` gradle target
- docs: runs the following gradle targets, and collect Javadocs:
  - `cms-web:apiDocs`
  - `userhelp:epub`
  - `userhelp:html`
  - `userhelp:latex`
  - `userhelp:pdf`
- unit tests: runs the following gradle targets, and collect JUnit reports:
  - `cms-business-model:test`
  - `cms-business-process:test`
  - `cms-web:test`
  - `services:test`
- integration tests: runs the `cms-portal-services:build` gradle target,
  deploys the result to a local WildFly application server, runs the
  `integration-tests:test` and `integration-tests:aggregate` targets, and
  collects the JUnit and Serenity test reports. See also `docs/TESTING.md` for
  more on running the integration tests, and the installation instructions (in
  this document) for configuring a WildFly application server.
- checkstyle: runs the following gradle targets, and collects the Checkstyle
  reports:
  - `checkstyleMain`
  - `checkstyleTest`
- jscs: runs the `frontend:npm_run_lint-ci` gradle target, and collects the
  Checkstyle reports. If running locally and interactively, use the
  `frontend:npm_run_lint` target, instead.

Currently, for security reasons, we do not run Jenkins on PRs that
originate outside this repository.  To run the tests on PRs from
external contributors, type "Jenkins, test this please." in the PR.
That phrase is magic, but only when written by someone with the correct
access in Jenkins.  To give a new GitHub username this power in Jenkins,
add it to the admin list for the desired builds.  For each build:

1. Click "Configure"
2. Scroll to "Admin list"
3. Add the GitHub username to the "admin list" textarea

After those steps, the person with that GitHub username will be able to
tell Jenkins to test an outside PR.  Note that doing this causes Jenkins
to run code, so if you have this power please read such contributions
carefully.

### Continuous Deployment

We have configured Jenkins to keep [our testing
site](http://testing.psm.solutionguidance.com:8080/cms/) up to date with the
`master` branch. There is a Jenkins job that will build the project, copy it to
the testing server, and deploy it to the WildFly instance there. It uses
`scripts/deploy-ci.sh` and `scripts/deploy-server.sh` to do so.
