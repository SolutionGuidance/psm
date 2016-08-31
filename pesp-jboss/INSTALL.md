# INSTALL.md

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

