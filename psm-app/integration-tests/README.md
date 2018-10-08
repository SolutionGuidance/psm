#  Integration tests
This module implements integration tests for the application using a popular
Behavior Driven Development framework called
[Serenity](http://www.thucydides.info/#/whatisserenity) to use formal
[Cucumber](https://cucumber.io/) feature files to document the workflow and
drive Selenium tests. The output from Serenity is an interactive dashboard which
shows the states of all of the tests and captures screenshots of the web page
taken as the tests are being run.

# Preparing to run tests locally
The tests will launch a browser against http://localhost:8080/cms so make sure
that your WildFly server is running locally and the PSM app has been deployed.

Serenity supports multiple browsers from which the tests will be run. The choice
of browser as well as other settings is made in `serenity.properties` in the
root directory of the integration-tests module.

The repo contains a template version of this file which you will need to
edit to fit your needs. Make a copy of `serenity.properties.template` as
`serenity.properties` and edit the latter file.

The most straightforward browser configuration is Chrome with the chromedriver.
It will run in GUI mode by default so you can follow along with the tests, and
can be configured to run headless for more efficient test runs. Instructions
for other configurations are provided further down in this README.

To use Chrome you can just switch the commented `webdriver.driver` properties in
`serenity.properties`. You need to download a copy of
[chromedriver](https://sites.google.com/a/chromium.org/chromedriver/downloads)
and insure its location is referenced in the `webdriver.chrome.driver` property.
For Linux distros you will also need to install `libgconf-2-4`.

`sudo apt-get install -y libgconf-2-4`

# Running the tests
To run the tests run:

    $ ./gradlew integration-tests:test integration-tests:aggregate

This command will run the tests and put the generated dashboard into
`target/site/serenity`.

If you only want to run some of the tests, you can specify a regular expression
to match against the name of the tests:

    $ ./gradlew "-Dcucumber.options=--name 'Completes an application'" \
        integration-tests:test integration-tests:aggregate

This specific example is also useful to create a sample pending application,
so that you can explore the admin interface without going through
the application process manually.

You can also specify a set of tags to match:

    $ ./gradlew "-Dcucumber.options=--tags @psm-FR-2.9" \
        integration-tests:test integration-tests:aggregate

See also the [Cucumber documentation on running from the command
line](https://cucumber.io/docs/reference/jvm#running) for other options you can
pass along through gradle via the `-Dcucumber.options=...` interface.

# Other browser configurations
There are many different options for running the serenity tests. Finding the
correct configuration for each browser and operating system can be a challenge.
The following sections document what works.

## Chromium

The webdriver for Chromium is packaged on Debian as
[chromium-driver](https://packages.debian.org/stretch/chromium-driver) and on
Ubuntu as
[chromium-chromedriver](https://packages.ubuntu.com/xenial/chromium-chromedriver).
`apt install` the appropriate package, and update `serenity.properties` to
specify the Chrome driver and the location of the driver
(`/usr/bin/chromedriver` on Debian, or `/usr/lib/chromium-browser/chromedriver`
on Ubuntu).

## Headless Chrome & Firefox

For testing the system in a continuous integration environment it is
necessary that the application can be run without an attached
monitor. Selenium offers support for this through a variety of
mechanisms.  The currently suggested approach is using
[Xvfb](https://www.x.org/archive/X11R7.6/doc/man/man1/Xvfb.1.xhtml), an
X virtual framebuffer.

### Install Xvfb
In Linux we need to find the relevant package names for the package manager and
install them (e.g., `apt-get install xvfb` for Debian based systems like
Ubuntu, `yum install Xvfb`  for RedHat based systems, etc.).

The service can be started from the command line as:

  `Xvfb :10 -ac &`

This starts the service as Display :10 and runs it in the background.

In order for `gradle.build` to select the correct X Display, it expects an
environment variable to be set called `XVFB_DISPLAY`. Set it to `:10` before
starting the gradle task like so:

    $ env XVFB_DISPLAY=":10" ./gradlew test aggregate

## Firefox
Selenium can only interact with specific versions of Firefox. The current version
of the library requires Firefox version 46.

To install this version, download the tar file from [https://ftp.mozilla.org/pub/firefox/releases/46.0.1/linux-x86_64/en-US/firefox-46.0.1.tar.bz2](https://ftp.mozilla.org/pub/firefox/releases/46.0.1/linux-x86_64/en-US/firefox-46.0.1.tar.bz2)

UnTAR this file in the directory above the PSM repo on your workstation.

In order for `build.gradle` to find the correct version of Firefox, it
expects an environment variable to be set called `FIREFOX_HOME`. Set it
to the path to your installed Firefox binary (the newly downloaded file)
before starting the Gradle task.

## Running headless with PhantomJS (unsupported)
The PhantomJS driver was a popular headless web driver used for Selenium tests.
This product no longer enjoys much support and it has been deprecated.
Nevertheless, it might be useful in some environments.

To run these tests locally, you will need a copy of the PhantomJS driver
executable. You can download it from
http://phantomjs.org/download.html. The tests are configured in
`serenity.properties` to find this driver in the directory above the
`psm` directory (where this repository is checked out). The committed version
assumes this is running on Linux and the driver is in `bin` inside a
directory called `phantomjs-2.1.1-linux-x86_64`.
