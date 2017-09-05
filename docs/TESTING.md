# TESTING

The PSM has a few different categories of tests: integration, unit, and
API tests.  This document describes what tests and test frameworks are
in place and gives guidance about contributing new tests in each of
these categories.

## Browser / Integration Tests

We use [Selenium](http://www.seleniumhq.org/) for integration testing.
Specifically, we use the
[cucumber](https://github.com/selenium-cucumber/selenium-cucumber-java)
framework.  See [the Selenium
README](https://github.com/OpenTechStrategies/psm/blob/master/psm-app/integration-tests/README.md)
for more details on how to set up and run these tests.

To add a new Selenium test, do the following:

1. Write a new "feature" file describing the
[`Given-When-Then`](http://thucydides.info/docs/serenity-staging/#_serenity_with_cucumber)
flow of the new test.  These feature files are in this repository in
`psm-app/integration-tests/src/test/resources/features`.

2. Run the test suite after creating new scenarios in the feature
file. Serenity writes out template code to the console for any
statements that don't have matching step definitions. You can paste
these template methods into your step definition class to make it easy
to write the behavior.  Remember to remove the unneeded `throws
Throwable` annotation that Serenity automatically adds to the template
method definitions.

3. Write or adjust the handlers to enter the information or click the
buttons in the `ui` subdirectory.

4. Write the test in the `steps` subdirectory (being sure to import the
`ui` file you created, if any).

See [PR #348](https://github.com/OpenTechStrategies/psm/pull/348) for an
example of adding a new Selenium test.

## API Tests

See [the relevant
README](https://github.com/OpenTechStrategies/psm/blob/master/etl/leie/README.mdwn)
for details.  This set of tests uses `pytest`.  The full list of
dependencies is in the LEIE API's README -- see the [Testing
section](https://github.com/OpenTechStrategies/psm/blob/master/etl/leie/README.mdwn#Testing).
To run the tests, get those dependencies and then do:

    $ cd {path-to-psm}/etl/leie
    $ ./test

If you add new functionality to the ETL process, add a new test in
`{path-to-psm}/etl/leie/leie/tests`.

## Unit Tests

We use [Spock](http://spockframework.org/) for our unit tests.
Currently the framework is set up with a few example tests.  Look at [PR
#253](https://github.com/OpenTechStrategies/psm/pull/253) to see where
to add one or more new unit tests in each of the subprojects.  To run
the unit tests, do:

    $ cd {path-to-psm}/psm-app
    $ ./gradlew clean test

When we add new functionality, we add unit tests along with it.  To
specifically see the Spock tests, there are more specific Gradle tasks
that can be run, like `./gradlew cms-business-process:check`.  You can
also run `./gradlew tasks --all` to see all the tasks, and in particular
there is a section labeled "Verification Tasks."  Note that Gradle will
not run all the tests every time if it can see that neither the
underlying code nor the tests have changed, so when you run `./gradlew
test` you might not see test results.  However, those results are
available.  Run `./gradlew cms-business-process:clean
cms-business-process:test --info` to see where the reports are stored.

