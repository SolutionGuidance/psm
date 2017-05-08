       Installation instructions for the Provider Screening Module
       ===========================================================

***NOTE: 2017-04-28: These instructions are still very incomplete and
   are a work in progress.  We welcome suggestions on improving
   them.***

# Background and Current Deployment Status

2017-04-28: The PSM is not yet ready for production or development deployment.

The PSM was originally developed to run in the open source web
application server Apache JBoss (now called WildFly).  Somewhat late
in the PSM's development, it was retargeted to the IBM WebSphere
Application Server (WAS) 8.5, in order to better support a particular
state's MMIS environment.  Our plan is to retarget the PSM to WildFly
(formerly JBoss), though still keeping all of the functionality
additions made while the PSM was in its WebSphere interregnum.

This INSTALL.md file will be continuously improved as we work.  When
it loses the warning at the top, that will mean we expect the PSM to
be deployable in WildFly.  We are currently evaluating the additional
resources it would take to continue development support for WebSphere
deployment.

Note that the repository currently depends on access to a Oracle
database.  We intend to shift towards PostgreSQL in order to eliminate
a proprietary dependency.

# Overview

The Provider Screening Module is a Java EE Enterprise Application. It depends
on a correctly-configured Java EE Application Server. While it was originally
written for the Java EE 6 profile, it is currently being ported to run on Java
EE 7 Application Servers, starting with WildFly 10.

## System Requirements

These requirements are based on our understanding of the application at this
time, and will evolve as we understand it more.

### Hardware

- **Memory**: 8 GB should be enough for a test system
- **CPU**: TBA; provisioning CPU proportional to memory (whatever that looks
  like in your environment) should be reasonable.
- **Storage**: 10 GB of storage for WildFly, the PSM repository, and its
  dependencies should be plenty.

### Software

- **Operating System**: we recommend Debian 8 (jessie). If that's not feasible
  for your environment, any of the supported WildFly 10.1 operating systems
  should work, but our ability to help troubleshoot issues that come up may be
  limited.
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

### Mail

The application requires the application server to be configured with a mail service:
- JNDI name `java:/Mail`

# Building

1. Get Wildfly: Visit
   [http://wildfly.org/downloads/](http://wildfly.org/downloads/). Download
   the [10.1.0.Final full
   distribution](http://download.jboss.org/wildfly/10.1.0.Final/wildfly-10.1.0.Final.tar.gz).

   ```ShellSession
   $ cd /path/to/this_psm_repo
   $ # this should be a peer directory, so:
   $ cd ..
   $ tar -xzf wildfly-10.1.0.Final.tar.gz
   $ cd wildfly-10.1.0.Final
   ```

1. Fill in your local properties:

   ```ShellSession
   $ cd ../psm/psm-app
   $ cp build.properties.template build.properties
   $ favorite-editor build.properties
   ```

1. Build the application with `ant`. This depends on libraries provided by the
   application server.

   ```ShellSession
   $ cd ../psm/psm-app
   $ ant dist
   Buildfile: /path/to/psm/psm-app/build.xml
   ...[cut]...
   dist:
         [ear] Building ear: /path/to/psm/psm-app/build/cms-portal-services.ear
   ```
