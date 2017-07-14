       Installation instructions for the Provider Screening Module
       ===========================================================

***NOTE: 2017-07-03: These developer installation instructions are a
   work in progress.  We welcome suggestions on improving them. We do
   not yet have a production deployment guide, and will seek out
   conversation with operations engineers in state IT departments to
   help us develop that guide later in 2017. ***

# Background and Current Deployment Status

2017-07-03: The PSM is not yet ready for production deployment,
but is ready for development deployment.

The PSM was originally developed to run in the open source web
application server Apache JBoss (now called WildFly).  Somewhat late
in the PSM's development, it was retargeted to the IBM WebSphere
Application Server (WAS) 8.5, in order to better support a particular
state's MMIS environment.  We have retargeted the PSM to WildFly
(formerly JBoss), though still keeping all of the functionality
additions made while the PSM was in its WebSphere interregnum.

This `INSTALL.md` file will be continuously improved as we work.  When
it loses the warning at the top, that will mean we expect the PSM to
be deployable in WildFly for production users.  We are currently
evaluating the additional resources it would take to continue
development support for WebSphere deployment.

If you are using Red Hat Enterprise Linux, it will be easiest for you
to run the automated installation script: `rhel-install.sh` in the
root of this repository.

You can use Docker to run the current development version of the PSM.
That would obviate all the manual configuration steps listed in this
file.  See `docker/README.md` for details.

# Requirements Overview

The Provider Screening Module is a Java EE Enterprise Application. It depends
on a correctly-configured Java EE Application Server. While it was originally
written for the Java EE 6 profile, it is currently being ported to run on Java
EE 7 Application Servers, starting with WildFly 10.

## System Requirements

These requirements are based on our understanding of the application at this
time, and will evolve as we understand it more.

### Hardware

- **Memory**: 8 GB should be enough for a test system.
- **CPU**: TBA; provisioning CPU proportional to memory (whatever that
  looks like in your environment) should be reasonable. Our
  demonstration instance runs on two cores of an Intel(R) Xeon(R) CPU
  E5-2676 v3 @ 2.40GHz.
- **Storage**: 10 GB of storage for WildFly, the PSM repository, and its
  dependencies should be plenty.

### Software

- **Operating System**: we recommend the old stable Debian 8 (jessie), and
  a developer has successfully installed the PSM on Red Hat 7.3
  Enterprise Linux. If that's not feasible for your environment, any
  of the supported WildFly 10.1 operating systems should work, but our
  ability to help troubleshoot issues that come up may be limited.
  Once we test this on a few more platforms, we will expand the list
  of compatible operating systems to include other Linux
  distributions.
- **Java**: We're using OpenJDK 8, which is currently 8u121, but you should
  keep up with the latest releases and post if you have issues relating to
  upgrading.
- **Java EE Application Server**: currently WildFly 10.1. We may support other
  application servers in the future.

### Database

We're testing with latest stable PostgreSQL, currently 9.6.2. PostgreSQL 10
will be released shortly and we hope/intend to verify compatibility with that.

- **Storage**: TBA. We haven't started integrating with any external data
  sources yet, which will likely be the largest driver of storage requirements.
  We suggest starting with 10 GB for the database, and have a plan to expand or
  reprovision later.

The application requires the application server to be configured with two data sources:

- JNDI name `java:/jdbc/MitaDS`
- JNDI name `java:/jdbc/TaskServiceDS`

These should be XA data sources that both point to the same
database. The installation instructions below will take care of this
configuration for a development install.

### Mail

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

1. [PostgreSQL 9.6](https://www.postgresql.org/). We are testing with
   PostgreSQL 9.6.2. Check that you have PostgreSQL installed.

1. The PSM code repository. Currently we suggest you run the PSM from
   the master branch of the development repository. Run the command
   below and it will download the source code into a new subdirectory
   called `psm`.

   ```ShellSession
   $ git clone https://github.com/OpenTechStrategies/psm.git
   ```

## Configure WildFly

Building and deploying the PSM application requies WildFly to be installed and
configured. See also the [WildFly 10 Getting Started
Guide](https://docs.jboss.org/author/display/WFLY10/Getting+Started+Guide).

1. Get WildFly: Visit
   [http://wildfly.org/downloads/](http://wildfly.org/downloads/). Download
   the [10.1.0.Final full
   distribution](http://download.jboss.org/wildfly/10.1.0.Final/wildfly-10.1.0.Final.tar.gz).

   ```ShellSession
   $ cd {/path/to/this_psm_repo}
   $ # this should be a peer directory, so:
   $ cd ..
   $ tar -xzf wildfly-10.1.0.Final.tar.gz
   $ cd wildfly-10.1.0.Final
   ```

1. Add a WildFly management console user:

   ```ShellSession
   $ ./bin/add-user.sh
   What type of user do you wish to add?
   a) Management User (mgmt-users.properties)
   b) Application User (application-users.properties)
   (a): a

   {Choose username, create and confirm password.}

   What groups do you want this user to belong to? (Please enter a comma separated list, or leave blank for none)[  ]:

   Is this new user going to be used for one AS process to connect to another AS process?
   e.g. for a slave host controller connecting to the master or for a Remoting connection for server to server EJB calls.
   yes/no? no
   ```

1. Stop the server if it is already running:

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

1. Leave WildFly running as you continue the install process.

## Configure services

### Mail

If you are using a debugging mail server such as the Python
`DebuggingServer` recommended above: open a new terminal session so
you can leave WildFly running in its existing terminal and Python
running in its existing terminal. Paste the entire command below, all
the way through the second `EOF`, into your terminal:

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

### Database

Download the [PostgreSQL JDBC driver](https://jdbc.postgresql.org/)
(specifically, the JDBC 4.2 version of the driver). Place it in the
parent directory, relative to the WildFly directory, and deploy it to
your application server:

```ShellSession
$ ./bin/jboss-cli.sh --connect --command="deploy ../postgresql-{VERSION}.jar"
```

If you get an error saying that the `.jar` file "is not a valid node
type name", double-check that it's in the correct directory. If it is,
then place the `.jar` file in
`wildfly-10.1.0.Final/standalone/deployments` and then restart the
WildFly server. The terminal logging for WildFly should then include
an `INFO` line like:

```
15:32:15, 773 INFO [org.jboss.as.server] )ServerService Thread Pool --37) WFLYSRV0010: Deployed "postgresql-42.1.1.jar" (runtime-name: "postgresql-42.1.1.jar")
```

You will need a database user, and a database owned by that
user. Create them, and make a note of the password for the database
user:

```ShellSession
$ sudo -u postgres createuser --pwprompt psm
$ sudo -u postgres createdb --owner=psm psm
```

After creating the databases, add the data sources to the application
server. In the command below, replace `{VERSION}` with the version of
the PostgreSQL JDBC driver you downloaded and `{PostgreSQL psm user
password}` with the password you assigned to your `psm` database user,
and paste it into your terminal:

```ShellSession
$ ./bin/jboss-cli.sh --connect <<EOF
xa-data-source add \
  --name=TaskServiceDS \
  --jndi-name=java:/jdbc/TaskServiceDS \
  --driver-name=postgresql-{VERSION}.jar \
  --xa-datasource-class=org.postgresql.xa.PGXADataSource \
  --valid-connection-checker-class-name=org.jboss.jca.adapters.jdbc.extensions.postgres.PostgreSQLValidConnectionChecker \
  --exception-sorter-class-name=org.jboss.jca.adapters.jdbc.extensions.postgres.PostgreSQLExceptionSorter \
  --enabled=true \
  --use-ccm=true \
  --background-validation=true \
  --user-name=psm \
  --password={PostgreSQL psm user password} \
  --xa-datasource-properties=ServerName=localhost,PortNumber=5432,DatabaseName=psm
xa-data-source add \
  --name=MitaDS \
  --jndi-name=java:/jdbc/MitaDS \
  --driver-name=postgresql-{VERSION}.jar \
  --xa-datasource-class=org.postgresql.xa.PGXADataSource \
  --valid-connection-checker-class-name=org.jboss.jca.adapters.jdbc.extensions.postgres.PostgreSQLValidConnectionChecker \
  --exception-sorter-class-name=org.jboss.jca.adapters.jdbc.extensions.postgres.PostgreSQLExceptionSorter \
  --enabled=true \
  --use-ccm=true \
  --background-validation=true \
  --user-name=psm \
  --password={PostgreSQL psm user password} \
  --xa-datasource-properties=ServerName=localhost,PortNumber=5432,DatabaseName=psm
EOF
```

## Build and deploy the application
1. Fill in your local properties:

   ```ShellSession
   $ cd ../{psm}/psm-app
   $ cp build.properties.template build.properties
   ```

1. If you do not have WildFly deployed in a peer directory to the PSM
repository, update its location in your local properties:

   ```ShellSession
   $ {favorite-editor} build.properties
   ```

1. Build the application with `gradle`. This depends on libraries provided by the
   application server.

   ```ShellSession
   $ cd ../{psm}/psm-app
   $ ./gradlew build
   ...[cut]...
   BUILD SUCCESSFUL
   ```

1. Deploy the built app: you can use the WildFly Management Console UI
   at [http://localhost:9990/](http://localhost:9990/), log in with
   your management console username and password, and do the
   following: "Deployments > Add > Upload a new deployment > browse to
   file." Alternatively, you can use the command line interface,
   replacing the relevant paths below:

   ```ShellSession
   $ {/path/to/wildfly}/bin/jboss-cli.sh --connect \
       --command="deploy {/path/to/psm}/psm-app/cms-portal-services/build/libs/cms-portal-services.ear"

   ```

   If you have a previous build deployed already, you can replace the
   deployment in the UI or add the `--force` switch after `deploy`.

1. Create database schema and initial data. Use `seed.sql` to create tables and
   data for the application, `jbpm.sql` to create tables and data for the
   embedded jBPM engine, and `legacy_seed.sql` to create tables for entities
   that have not yet been migrated to Hibernate 5:

      ```ShellSession
      $ cat {/path/to/psm}/psm-app/db/legacy_seed.sql \
            {/path/to/psm}/psm-app/db/jbpm.sql \
            {/path/to/psm}/psm-app/db/seed.sql \
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

Generate the API documentation from Javadoc annotations by invoking
gradle:

    ./gradlew cms-web:apiDocs

The generated documentation will go into `psm-app/cms-web/build/reports/api-docs`.

# Production Deployment

If you want to deploy this in earnest, there will be additional steps
necessary to scale up to a large number of users.  Every deployment
environment will be different, so this section is not a set of
instructions to deploy.  Instead, it contains notes that might be
useful to inform your own approach to deploying the PSM.

## NGINX

NGINX has a maximum upload file size.  It's default can be quite low
(1MB on our Debian system), and large PDFs of licenses and
certificates can trigger "413 Request Entity Too Large" errors in
NGINX.  You will want to set maximum uploaded file size in both NGINX
*and* in the PSM (adjust max.upload.size in
`psm/psm-app/services/src/main/resources/cms.properties`).  PDFs can
get quite large, especially if they are multi-page PDFs of scanned
documents.  We do not yet have a recommended size to set this too, but
we will set a sane default in `cms.properties` when we do.  See
[Issue 263](https://github.com/OpenTechStrategies/psm/issues/263) for
some discussion of the problem.
