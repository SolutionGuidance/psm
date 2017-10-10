This directory (`scripts`) contains utility scripts for use by system
administrators or our build systems.

* `rhel-install.sh` is an automated script Red Hat sysadmins can use
  to install the PSM.
* `drools-microservice.sh` sets up a copy of jBPM and Guvnor on a
  standalone server, which the core application can then be configured
  to communicate with.
* `rebuild-and-change-schema-for-testing.sh` is useful in testing a
  development installation, or testing a pull request or other
  branch. It builds a fresh EAR, blows away the old database contents
  and builds a new schema, and deploys the EAR.
* `push-javadoc-to-gh-pages.sh` lets TravisCI build our automated API
  documentation using Javadoc and push it to the `gh-pages` branch,
  which updates our GitHub Pages site,
  https://solutionguidance.github.io/psm/javadoc/ .
* `push-userdocs-to-gh-pages.sh` is a script for PSM developers to
  manually run. It builds fresh versions of the user documentation in
  HTML, PDF, and ePub, then pushes them to the `gh-pages` branch for
  publication on our GitHub Pages site.
