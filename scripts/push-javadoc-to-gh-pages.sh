#!/bin/bash
set -ex

# Adaptation of code from https://benlimmer.com/2013/12/26/automatically-publish-javadoc-to-gh-pages-with-travis-ci/

if [ "$TRAVIS_REPO_SLUG" == "OpenTechStrategies/psm" ] \
       && [ "$TRAVIS_JDK_VERSION" == "openjdk8" ]; then

  echo -e "Publishing Javadoc...\n"

  cp -R cms-web/build/reports/api-docs $HOME/javadoc-latest

  cd $HOME
  git clone --quiet --branch=gh-pages \
      https://${GH_TOKEN}@github.com/OpenTechStrategies/psm gh-pages > /dev/null

  cd gh-pages
  git rm -rf ./javadoc
  cp -Rf $HOME/javadoc-latest ./javadoc
  git add -f .
  git commit -m "Javadoc published from Travis build ${TRAVIS_BUILD_NUMBER}" \
      -m "Generated from commit ${TRAVIS_COMMIT}, pushed to gh-pages" \
      --author="Travis CI automated push <psm-dev@googlegroups.com>"
  git push -fq origin gh-pages > /dev/null

  echo -e "Published Javadoc to gh-pages branch.\n"

fi
