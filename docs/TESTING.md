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

2. Write the handlers to enter the information or click the buttons in
the `ui` subdirectory.

3. Write the test in the `steps` subdirectory (being sure to import the
`ui` file you created, if any).

See [PR #348](https://github.com/OpenTechStrategies/psm/pull/348) for an
example of adding a new Selenium test.

## API Tests

See [the relevant README](etl/leie/README.mdwn) for details.  This set
of tests uses `pytest`.

## Unit Tests