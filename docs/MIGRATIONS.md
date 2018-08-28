# MIGRATIONS
The PSM uses [Liquibase](http://liquibase.org/) to manage migrations. Review the [Liquibase best practices](http://www.liquibase.org/bestpractices.html) to understand the structure of this project's migrations.

Migrations are stored in a `changelog` folder within the `psm-app/db/` project.  The `db-changelog-master.xml` is the root changelog.

Changes to the database are registered inside of `ChangeLog` files. Each change in a ChangeLog is called a `ChangeSet`. ChangeSets should be as atomic as possible, and should also contain `rollback` instructions which allows them to be undone.

## Running Migrations
To run migrations:

Create or edit the file `psm-app/gradle.properties` if needed,
based on `psm-app/gradle.properties.template.`

Note the format for the URL property `systemProp.DatabasePath`:

```
jdbc:postgresql://host:port/database
```
Then execute the following command:

```shell
> ./gradlew db:update
```

There are a large number of out of the box liquibase tasks available. To see a complete list run the following:

```shell
> ./gradlew db:tasks
```

## Adding Migrations

Future changes to the database are performed by adding ChangeSets to the ChangeLog associated with the current named version.  For instance `db/changelog/db-changelog-1.0.xml`.

ChangeSets should never be updated or deleted once committed to master.  If a past ChangeSet needs to be modified, create a new Changeset with the appropriate alteration commands.

The "always append changes" rule is enforced by Liquibase in the form of checksums for ChangeSets -- if you edit a ChangeSet that has already been run, Liquibase will complain loudly.

The reasoning for this [is explained on this liquibase blog post](http://www.liquibase.org/2008/10/dealing-with-changing-changesets.html).  That post also explains how to bypass the Liquibase safeguards in the event of a big mistake that truly requires a rewriting of history.

```
The goal of a Liquibase change log file is to track the linear sequence of changes required to take a database from a starting point to the current state, and it is built up one change at a time throughtout development. By following the “always append changes” rule you will ensure that all databases are consistent since all will have gone through the exact same set of changes.
```

## Adding Seed Data

Liquibase makes it easy to insert seed data into tables. There is a separate migration file for seed data: `db/changelog/db-changelog-seed.xml`. Seed data itself is stored in the `db/seeds/` directory through csvs.  The first row of a seed data CSV should contain the field names with corresponding data.

The changeset type for seed data is [`loadUpdateData`](https://www.liquibase.org/documentation/changes/load_update_data.html) which makes it easy to add or modify seed data to reflect the contents of the seed CSV.

Liquibase is smart enough to parse certain key words, e.g. a value of "NULL" will insert null for that column.

## Validating Migrations

It is important to validate new ChangeSets before committing them.  Liquibase provides a validation tool.

```shell
> ./gradlew db:validate
```
