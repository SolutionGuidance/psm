# TESTING

The PSM has a few different categories of tests: integration, unit,
and API tests.  This document describes what tests and test frameworks
are in place and gives guidance about contributing new tests in each
of these categories, and about additional manual or semi-automated
testing you should do when developing.

## Browser / Integration Tests

For integration testing we use [Serenity](http://www.thucydides.info) which in
turn uses [Selenium](http://www.seleniumhq.org/).  Specifically, we use the
[cucumber](https://github.com/selenium-cucumber/selenium-cucumber-java)
framework.  See [the Selenium
README](https://github.com/SolutionGuidance/psm/blob/master/psm-app/integration-tests/README.md)
for more details on how to set up and run these tests.

### Serenity Overview

Here's a brief overview of how Serenity test code is intended to be organized
into four layers, with different kinds of files at each layer:

1. "Feature" files that express the tests in human-readable Cucumber/Gherkin
syntax.

2. "Step Definition" files (e.g. "LoginStepDefinitions") that translate those
individual cucumber instructions into Java.

3. "Step" files (e.g. "GeneralSteps") that contain `@Step` methods that are
called from the methods in (2).

4. "Page" files (e.g. "LoginPage") with methods belonging to particular pages
that are called from the methods in (3).

The idea is to express at a high-level "WHAT" is being tested in (1) and (2)
and then handle the implementation details of "HOW" in (3) and (4). For
example, "Search for X" (what) and "Enter X in the search field and click the
search button" (how).

Generally, a test will involve code at all four levels.  For greater code reuse,
we have some methods for generic actions that could happen on any page (like
clicking links or running accessibility checks) defined in the PsmPage
class and in Step files (e.g. GeneralSteps).  This minimizes the amount of
code needed for a given test, and minimizes the need for particular Page files.
A new test that only uses these generic methods will only require adding code
in two files (at levels 1 and 2).  Otherwise it will involve adding code
in 3 or 4 files (at levels 1-3 or 1-4).

The `@Step` annotations on the methods in Step files are what trigger the
screenshots in the Serenity test reports. The Step Definition files and the
Step files are usually in the same directory, while Features files and Page
files are in their own `features` and `ui` directories, respectively.

For more details on Serenity's approach, see
[this page](http://thucydides.info/docs/articles/an-introduction-to-serenity-bdd-with-cucumber.html).

### Adding a New Serenity Test

To add a new Serenity/Selenium test, do the following:

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

See [PR #348](https://github.com/SolutionGuidance/psm/pull/348) for an
example of adding a new Selenium test.

You can check the results of these tests by running:

    $ chromium integration-tests/build/reports/tests/test/index.html

### Running Browser Tests

#### With SauceLabs
Sauce Labs is a proprietary service that is free for open source projects.
We use it for our continuous integration, but local developers are welcome
to use it for local tests as well.  This documentation is geared towards
setting up continuous integration, but the environment variables are the
same in both cases.  To set up local sauce labs testing, please read the
[sauce labs documentation](https://wiki.saucelabs.com/display/DOCS/Sauce+Connect+Proxy).

**Environment Variables:**
These must be set in the testing environment in order to communicate with
Sauce Labs.

- **SAUCE_ACCESS_KEY - ** The saucelabs access key, found in your Sauce
Labs account.

- **SAUCE_USERNAME - ** The username you use when logging into Sauce Labs.

## API Tests

See [the relevant
README](https://github.com/SolutionGuidance/psm/blob/master/etl/leie/README.mdwn)
for details.  This set of tests uses `pytest`.  The full list of
dependencies is in the LEIE API's README -- see the [Testing
section](https://github.com/SolutionGuidance/psm/blob/master/etl/leie/README.mdwn#Testing).
To run the tests, get those dependencies and then do:

    $ cd {path-to-psm}/etl/leie
    $ ./test

If you add new functionality to the ETL process, add a new test in
`{path-to-psm}/etl/leie/leie/tests`.

## Unit Tests

We use [Spock](http://spockframework.org/) for our unit tests.
Currently the framework is set up with a few example tests.  Look at [PR
#253](https://github.com/SolutionGuidance/psm/pull/253) to see where
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

## Manual and Semi-automated Testing

To check for accessibility issues in a new template or other
user-visible change, use the [axe-core browser add-on](https://axe-core.org/),
that integrates with browser developer tools.  Look for issues labeled
"WCAG2AA" which is the [standard we test
against](https://github.com/SolutionGuidance/psm/issues/415).

Another option is to use HTML_CodeSniffer as a
bookmarklet in your browser. Go to the
[HTML_CodeSniffer website](https://squizlabs.github.io/HTML_CodeSniffer/)
and drag the bookmarklet link to your browser's bookmarks toolbar.  Then click
the bookmarklet to run the widget on any given page.
Choose "WCAG2AA" in the "Standards"
dropdown.  [This
checklist](https://www.section508.gov/content/build/website-accessibility-improvement/major-web-issues)
is useful to help you find major accessibility problems.

To test several pages, you can use
[`pa11y`](https://github.com/pa11y/pa11y) on the command line against
a live webpage or a local saved one, and can filter results so it only
tells you about Section 508 issues. To install `pa11y`:

1. [Install Node.js](https://nodejs.org/en/download/package-manager/)
4+ ([Debian/Ubuntu
instructions](https://github.com/nodesource/distributions#deb)

2. [Follow these instructions to handle NPM
packages](https://stackoverflow.com/a/13021677)

3. Install [`pa11y`](https://www.npmjs.com/package/pa11y) with:

`$ npm install -g pa11y`

To run `pa11y` against your running developer instance:

`$ pa11y --standard Section508 http://localhost:8080/cms/login`

Right now we don't have `pa11y` wired up to get past the login screen
or fill in forms. You can get around this by runing `pa11y` against a
webpage you've saved locally:

`$ pa11y -s Section508 file:///tmp/ProviderTypePage.html`

You can use the `-r` flag to get `pa11y` output in a different format,
such as JSON or CSV, to make it easier to run larger analyses.

To make it easier to test branches, we have a script to refresh a
development environment with a new Gradle build and a fresh new
database: `scripts/rebuild-and-change-schema-for-testing.sh`.  Make
sure to run it from within `scripts/`.

## Before Submitting a PR

Before you submit a PR, you should have thoroughly tested your change,
as mentioned in the CONTRIBUTING file.  In particular, that means:

- Build and deploy the new code.
- Log in as a provider type user (e.g., "p1" in the sample data) and
  complete and submit an application for enrollment (called an
  "Enrollment" in the UI and the code).  Can you submit with no errors?
- Log in as a service admin type user (e.g., "admin" in the sample data)
  and review the application you just submitted.  Can you approve and/or
  reject the application with no errors?

It's encouraged to include screenshots and a description of how to test
the change in your PR message.

If you want to submit a PR for discussion before completing it or before
doing all this testing, include the string "WIP" (for "Work in
Progress") in your PR title.  This will show other team members that
your PR isn't ready for review yet.  When it is ready, remove "WIP" from
the title.
