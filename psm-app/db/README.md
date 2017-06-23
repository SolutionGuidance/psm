# Database Setup Files
This directory contains some DDL files to create the database and populate some
initial test data.

## Seed.sql
This file sets up the database, inserts static data, and create some
default users to get you going

## jbpm.sql
Create the tables and static data needed by the embedded [jBPM
engine](http://www.jbpm.org/).

## Legacy_seed.sql
We are in the process of migrating all of the entities from Hibernate 4 to Hibernate 5,
however during the migration we need some of the unmigrated tables configured to perform
basic integration tests. This file creates the tables needed for the application to
run. As entities are migrated to Hibernate 5, the DDL for them should be removed from
here as new tables are created in seed.sql

## legacy_seed.sql
We are in the process of migrating all of the entities from Hibernate
4 to Hibernate 5.  However, during the migration, we need some of the
unmigrated tables configured to perform basic integration tests. This
file creates the tables needed for the application to run. As entities
are migrated to Hibernate 5 and new tables are created in `seed.sql`,
we should remove the DDL for them from `legacy_seed.sql`.