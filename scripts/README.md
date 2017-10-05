This directory (`scripts`) contains utility scripts for use by system
administrators or our build systems.

* `rhel-install.sh` is an automated script Red Hat sysadmins can use
  to install the PSM.
* `push-javadoc-to-gh-pages.sh` lets TravisCI build our automated API
  documentation using Javadoc and push it to the `gh-pages` branch,
  which updates our GitHub Pages site,
  https://opentechstrategies.github.io/psm/javadoc/ .
* `drools-microservice.sh` sets up a copy of jbpm and Guvnor on a
  standalone server, which the core application can then be configured
  to communicate with.
* `make-zip-of-documents.sh` builds PDFs of our prose documents for
  users, administrators, and developers, builds the HTML
  documentation for our API, and puts together a ZIP file with a
  table of contents.
