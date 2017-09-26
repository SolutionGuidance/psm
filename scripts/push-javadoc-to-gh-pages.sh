#!/bin/bash

# Script for a developer to use to push new version of Javadoc to
# GitHub Pages site.
# Before running, ensure that you have committed any local changes
# in your current branch.
#
# Code partially adapted from
# https://benlimmer.com/2013/12/26/automatically-publish-javadoc-to-gh-pages-with-travis-ci/

set -x  # Avoiding -e because we need an exit code on `git diff`

if [[ "$(pwd)" != "$(git rev-parse --show-toplevel)" ]]
then
    set +x
    echo "Please run this from the root of the project by running:"
    echo "   ./scripts/push-javadoc-to-gh-pages.sh"
    echo "This script switches branches;"
    echo "running from the root ensures you won't end up in a deleted directory."
    exit 1
fi

COMMIT=$(git rev-parse HEAD)
echo "Generating Javadoc..."

cd psm-app
./gradlew clean cms-web:apiDocs || exit 1

DOCSDIR=$(mktemp -d /tmp/docXXXX)
cp -R cms-web/build/reports/api-docs $DOCSDIR || exit 1
cd ..

echo "Publishing Javadoc..."

git fetch git@github.com:SolutionGuidance/psm.git gh-pages || exit 1
git rev-parse --verify --quiet "gh-pages"  # Check whether branch exists
if [ $? -eq 0 ]  # Check for truth
then
    git checkout gh-pages || exit 1 #  Will fail if you have uncommitted local changes.
    git pull git@github.com:SolutionGuidance/psm.git gh-pages || exit 1
else
    git fetch git@github.com:SolutionGuidance/psm.git gh-pages:gh-pages || exit 1
    git checkout gh-pages || exit 1 #  Will fail if you have uncommitted local changes.
fi

git rm -rf ./javadoc || exit 1
mv -f $DOCSDIR ./javadoc || exit 1
git add -f ./javadoc/.

git diff --staged --quiet --exit-code  # Check for changed files
if [ $? -eq 1 ]  # Check for differences
then
    git commit -m "Publish Javadocs from $COMMIT and push to gh-pages" || exit 1
    git push -q git@github.com:SolutionGuidance/psm.git gh-pages || exit 1
    echo "Published Javadocs from $COMMIT to gh-pages branch."
else
    echo "No changes; nothing to commit."
fi

echo "Finished."

# Return to branch and directory where user started

git checkout -
