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

- **Operating System**: we recommend the stable Debian 8 (jessie). If
  that's not feasible for your environment, any of the supported
  WildFly 10.1 operating systems should work, but our ability to help
  troubleshoot issues that come up may be limited.  Once we test this
  on a few more platforms, we will expand the list of compatible
  operating systems to include onther Linux distributions.
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

1. Fill in your local properties:

```ShellSession
$ cd ../psm/psm-app
$ cp build.properties.template build.properties
$ favorite-editor build.properties
```

# WIP: Installation instructions for the old pesp-jboss/ tree

Very preliminary instructions for actually getting a test version of
this set up, based on the info in the /docs subdir.

1. Create the database
   ```
   $ cd /path/to/coeci-cms-mpsp/pesp-jboss/
   $ mysql -u root -p
   mysql> CREATE USER CMS IDENTIFIED BY {__your_password__};
   mysql> quit
   $ mysql -u CMS -p
   Password: {__your_password__}
   mysql> CREATE DATABASE cms_test;
   # not sure if I need to do GRANT ALL since this user that created the
   # db
   mysql> use cms_test;
   mysql> source db/mita3.sql
   ```

   Or, in Oracle:
   
   Note: CMS is the user name and also the name of the schema.  That is
   why each oracle object is named with the prefix, "CMS.___".
    
   ```
   # the PORT here is usually 1521 
   $ sqlplus __ORACLE_USER__/__ORACLE_PASSWORD__@//localhost:__PORT__/__SCHEMA__
   SQL> CREATE USER CMS;
   SQL> GRANT CREATE SEQUENCE TO CMS;
   SQL> GRANT CREATE SESSION TO CMS;
   SQL> GRANT CREATE TABLE TO CMS;
   SQL> GRANT UNLIMITED TABLESPACE TO CMS; -- just a precaution
   ```
   
2. Load the sample data
   ```
   mysql> source cms-web/src/main/resources/web-test-data.sql
   ```
3. Edit build.properties file

    ```
    # Note that this should properly be build.properties.example, with a
    # cp step in the INSTALL doc.  I just edited the jdbc.url to read
    # MySQL instead of Oracle...we'll see if that works.
    ```
   
4. Install JBoss, probably?



## Background and Troubleshooting

Several people have done work to get this up and running so far.  This
is a summary of their notes.

### WebSphere Version

The WebSphere-based version of the app is documented in
`documentation/Installation/MPSE Portal Deployment Guide for Websphere
v8.5.docx`.  This document includes screenshots of the process, but is
not entirely complete.  We recommend starting there and using these
notes as supplements to those directions.

1. Building the app.
   The app requires WebSphere Application Server 8.5 (WAS).  One person was
   able to get it built using that WAS version on Windows 7.  The
   process she followed was:

     1. Step through the IBM website, create an IBM ID and [fill out
        your
        info](https://www-01.ibm.com/marketing/iwm/iwm/web/preLogin.do?source=swg-wase)

     2. Once you submit that page it will take you to a download
        page. Click the HTML file, it will have instructions on what you
        should download.  Mine said, in part: `On-line Installation`

     3. The easiest way to install IBM WebSphere Application Server is
        to use IBM Installation Manager and an IBM-hosted
        repository. Download a copy of Installation Manager version
        1.8.5 or later from the IBM Installation Manager and Packaging
        Utility download page.  Unzip the Installation Manager download
        to a temporary location.  Navigate to the temporary location and
        run the installer appropriate for your user account. If your
        user account has administrative rights on the computer, run the
        install executable file. If your user account is
        non-administrative, run the userinst executable file.

     4. After Installation Manager is installed, configure an IBM-hosted
        repository.  In Installation Manager, go to File > Preferences.
        In the Repositories panel, click the Add Repository
        button. Enter the repository URL for the edition of WebSphere
        Application Server V9.0 that you want to install.  The following
        composite repositories contain the installation packages for
        WebSphere Application Server, WebSphere Application Server
        Liberty, WebSphere Application Server Supplements, and may
        contain other supporting software. [WebSphere Application Server
        V9.0](http://www.ibm.com/software/repositorymanager/V9WASBase)
        and [WebSphere Application Server Network Deployment
        V9.0](http://www.ibm.com/software/repositorymanager/V9WASND).

        If you only want to install IBM HTTP Server, Web Server Plug-ins
        for WebSphere Application Server, the WebSphere Customization
        Toolbox which includes the Web Server Plug-ins Configuration
        Tool, or the WebSphere Application Client then add the following
        composite repository: [WebSphere Application Server Supplements
        V9.0](http://www.ibm.com/software/repositorymanager/V9WASSupplements).

        Repositories for previous releases of WebSphere Application
        Server are provided at the end of this document.  If prompted, you
        might have to authenticate with the IBM-hosted repository using your
        My IBMid credentials. When Installation Manager connects to the
        repository URL, the connection status icon turns green.  Click OK to
        save the settings and close the Preferences window.
 
        After you configure the repository, use Installation Manager to
        install WebSphere Application Server and other supplemental
        software packages.
 
     5. These are the repositories for previous releases of WebSphere
        Application Server, which can be used with IBM Installation
        Manager or IBM Packaging Utility.  WebSphere Application Server
        version 8.5.x.x:

        [WebSphere Application Server Express Trial](http://www.ibm.com/software/repositorymanager/V85WASExpressTrial)  
        [WebSphere Application Server Trial](http://www.ibm.com/software/repositorymanager/V85WASBASETrial)  
        [WebSphere Application Server for Developers (ILAN)](http://www.ibm.com/software/repositorymanager/V85WASDeveloperILAN)  
        [WebSphere Application Server Network Deployment Trial](http://www.ibm.com/software/repositorymanager/V85WASNDTrial)  
        [IBM HTTP Server (ILAN)](http://www.ibm.com/software/repositorymanager/V85IHSILAN)  
        [WebSphere Application Server Supplements (ILAN)](http://www.ibm.com/software/repositorymanager/V85WASSupplements)  
 
	
     6. I then went to the Installation Manager page at IBM's site, as
        linked in [the
        documentation](https://www-01.ibm.com/support/docview.wss?uid=swg27025142)
        I had to download Installation Manager from Fix Center, this was
        a large download.  I extracted the file and ran it to install
        Installation manager.

     7. Then, I ran Installation Manager.Instead of clicking the large
        'Install' button, I first had to go to File > Properties to add
        the WAS repository.  In the box this opened, I clicked add and
        pasted the link to
        http://www.ibm.com/software/repositorymanager/V85WASBASETrial
        (from above).  I then submitted that information, and clicked
        Install.

     8. There were a lot of options for that repository, the only one I
        selected was WebSphere Application Server v8.5.5.10.  Accept
        license agreements etc, follow the steps in Installation Manager
        and set up two folders as directed to hold your WAS install.

        It took about an hour for me to download 1GB+ of info, then
        extract and install it.  After it finished, Installation Manager
        gave me some options for whether I wanted to set up a server
        with WAS.  I left the default option, which opened a new window
        with the Profile Management Tool.

     9. At this point, you can set was.home in your build.properties to
        the location you installed WAS to (second folder you named).
        `ant dist` should then succeed.

2. Setting up a server with WAS:

   1. In WebSphere Customization Toolbox (earlier/also called Profile
      Management Tool), click Create button at top right.  
   2. Click Application Server. (I had to allow access through Windows
      Firewall after this.)
   3. Set an admin username/password. The admin console is now available
      on port 9060/https port 9043. Other ports: HTTP is 9080, HTTPS
      9443. Bootstrap 2809, SOAP 8880.
   4. Launch first steps console (NOTE: what is this?) when complete, if
      you want (took me about 15 min).
   5. Start the server: (from WAS home directory)

       bin/startServer.bat server1

   6. Go to https://localhost:9043/ibm/console/logon.jsp and log in.

   7. Stop the server (from WAS home directory):
   
       bin/stopServer.bat server1
     
      
3. Connecting to the database:

   - The Oracle JDBC connection jar in `<was install
     root>/profiles/AppSrv01/installedApps/sorayaNode01Cell/cms-portal.ear/lib`
     is `ojdbc14.jar`, but WebSphere expected `ojdbc6.jar`.  This was
     _maybe_ fixed by downloading `ojdbc6.jar` from
     [Oracle](http://www.oracle.com/technetwork/database/enterprise-edition/jdbc-112010-090769.html),
     adding it to that directory, and restarting the local server.  The
     uncertainty is just because the person who made this work was
     trying many different approaches.  We need to test to know for
     sure.

4. Mail and message queues are missing documentation, and without these
   queues the application won't start:

   - No information on configuration and setup of required message queue
     (there is information on how to set up WebSphere with a pre-existing
     queue but it doesn't talk at all about how the queue needs to be set
     up to work with the app, only about where in the WebSphere install you
     should enter the already-set-up queue names) 
   - Likewise no information on mail queue setup/configuration
