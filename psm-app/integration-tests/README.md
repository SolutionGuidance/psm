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
It can be run in GUI mode so you can follow along with the tests, or headless
for more efficient test runs. Instructions for other configurations are provided
further down in this README.

To use Chrome you can just switch the commented `webdriver.driver` properties in
`serenity.properties`. You need to download a copy of
[chromedriver](https://sites.google.com/a/chromium.org/chromedriver/downloads)
and insure its location is referenced in the `webdriver.chrome.driver` property.
For Linux distros you will also need to install `libgconf-2-4`.

`sudo apt-get install -y libgconf-2-4`

# Running the tests
To run the tests run:

    $ ./gradlew test aggregate

This command will run the tests and put the generated dashboard into
`target/site/serenity`.


# Other browser configurations
There are many different options for running the serenity tests. Finding the
correct configuration for each browser and operating system can be a challenge.
The following sections document what works.

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

## Interactive Chrome on Linux
On Linux, the only way we've found to force an interactive Chrome session is
to delete [the line in `build.gradle` in the test settings
for
`integration-tests`](https://github.com/SolutionGuidance/psm/blob/master/psm-app/build.gradle#L264):

`environment "DISPLAY", System.getenv('XVFB_DISPLAY')`

Delete this line and re-run the tests. You should see Chrome pop up on your
screen and run through the tests.

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
