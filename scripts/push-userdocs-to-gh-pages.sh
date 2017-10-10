#!/bin/bash
set -ex

# Publish fresh versions of the user documentation in HTML, PDF, and ePub.
# Push to the gh-pages branch to publish to
# https://solutionguidance.github.io/psm/ .
# For use by PSM developers who already have up-to-date local checkouts
# of the PSM repository.

# Code partially adapted from
# https://benlimmer.com/2013/12/26/automatically-publish-javadoc-to-gh-pages-with-travis-ci/

echo -e "Building userdocs...\n"
cd ../psm-app
./gradlew userhelp:{clean,html,pdf,epub}
cp -R userhelp/build /tmp/userdocs-latest

echo -e "Publishing Sphinx userdocs...\n"
cd ..
git checkout gh-pages #  Will fail if you have uncommitted local changes.
git rm -rf ./userdocs
mkdir -p userdocs/books
cp -Rf /tmp/userdocs-latest/html ./userdocs/html
cp -Rf /tmp/userdocs-latest/latex/ProviderScreeningModuleusermanual.pdf \
   /tmp/userdocs-latest/epub/ProviderScreeningModuleusermanual.epub \
   ./userdocs/books
git add -f ./userdocs/.
git commit -m "Publish user docs and push to gh-pages"
git push -q origin gh-pages

echo -e "Published Sphinx userdocs to gh-pages branch.\n"

# Return to branch and directory where user started

git checkout -
cd scripts/
