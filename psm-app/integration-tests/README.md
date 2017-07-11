#  Integration Tests

This module implements integration tests for the application using a popular
Behavior Driven Development framework called
[Serenity](http://www.thucydides.info/#/whatisserenity) to use formal
[Cucumber](https://cucumber.io/) feature files to document the workflow and
drive Selenium tests. The output from Serenity is an interactive dashboard which
shows the states of all of the tests and captures screenshots of the web page
taken as the tests are being run.

# Running the Tests

To run the tests run the gradle target `test aggregate`

It will run the tests and put the generated dashboard into
`target/site/serenity`

## Running Headless with Firefox

For testing the system in a continuous integration environment it is neccssary
that the application can be run without an attached monitor. Selenium offers
support for this through a variety of mechanisms.  The currently suggested
approach is with Firefox, using Xvfp, an X virtual framebuffer.

### Install Xvfb

In Linux we need to find the relevant package names for the package manager and
install them (e.g., apt-get install xvfb firefox for Debian based systems like
Ubuntu, yum install Xvfb firefox for RedHat based systems, etc.).

The service can be started from the command line as:

  `Xvfb :10 -ac &`

This starts the service off as Display :10 and runs it in the background.

There is an environment setting in the `gradle.build` that specifies the DISPLAY
identifier for the integration tests.

### Install a compatible version of Firefox

Selenium can only interact with specific versions of Firefox. The version of the
library  pulled in my Serenity (2.53) [requires Firefox version
46](https://stackoverflow.com/questions/36747430/which-firefox-version-is-compatible-with-selenium-2-53-0).

To install this version, download the tar file from
[https://ftp.mozilla.org/pub/firefox/releases/46.0.1/linux-x86_64/en-US/firefox-46.0.1.tar.bz2](https://ftp.mozilla.org/pub/firefox/releases/46.0.1/linux-x86_64/en-US/firefox-46.0.1.tar.bz2)

UnTAR this file in the directory above the PSM repo on your workstation.

There is a property setting in `gradle.build` that tells Selenium where to find
the Firefox executable. In the repo it is set to point to this installation.

## Running Headless with Phantom JS

The PhanomJS driver was a popular headless web driver used for Selenium tests.
This product no longer enjoys much support and it has been depricated.
Nevertheless, it might be useful in some environments.

To run these tests locally you will need a copy of the PhantomJS driver
executable. You can download it from http://phantomjs.org/download.html the
tests are configured in `serenity.properties` to find this driver in the
directory above the psm repo. The committed version assumes this is running on
linux and the driver is in `bin` inside a directory called
`phantomjs-2.1.1-linux-x86_64`.

## Running With a Real Chrome Browser

For development it's much more pleasant to watch the tests run in a real
browser. To use Chrome you can just switch the commented `webdriver.driver`
properties in `serenity.properties`. You need to download a copy of
[chromedriver](https://sites.google.com/a/chromium.org/chromedriver/downloads)
and insure it can be found in the `webdriver.chrome.driver` property.
