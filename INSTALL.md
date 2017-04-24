       Installation instructions for the Provider Screening Module
       ===========================================================

***NOTE: 2017-04-24: These instructions are still very incomplete.***

# Background and Current Deployment Status

2017-04-24: The PSM is not yet ready for producion or development deployment.

The PSM was originally developed to run in the open source web
application server Apache JBoss (now called WildFly).  Somewhat late
in the PSM's development, it was retargeted to the IBM WebSphere
Application Server (WAS) 8.5, in order to better support a particular
state's MMIS environment.

This branching was done in file space rather than in version control
space, hence these two subdirectories:

* [pesp-jboss/](pesp-jboss) Original JBoss-oriented code
* [pesp-was8.5/](pesp-was8.5) Newer WebSphere-oriented changes.

There is a third subdirectory that requires some explanation:

* [pesp-was8.5-ext-srcs/](pesp-was8.5-ext-srcs)

`pesp-was8.5-ext-srcs/` is code for the semi-separate middleware
application that provides the PSM with a consistent API to external
services.  Nothing about this middleware application that is
conceptually tied to WebSphere, it's just that it was (apparently)
started after the WebSphere split, and therefore its
WebSphere-specificity is built into its name, as with `pesp-was8.5/`.

As of April 2017, our development plan is to retarget the PSM to the
WildFly (formerly JBoss), do all development on the `master` branch,
not have application-server-specific subdirectories, and migrate
desired non-WebSphere-specific changes from the WebSphere-oriented
code into the new mainline.

This INSTALL.md file will be continuously improved as we do the above,
and when it loses the warning at the top, that will mean we expect the
PSM to be deployable in WildFly.

# WIP: Preliminary installation instructions for pesp-jboss/

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
