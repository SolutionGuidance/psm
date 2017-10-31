#!/bin/bash

set -ex

WILDFLY_HOME=${TRAVIS_BUILD_DIR}/../wildfly-10.1.0.Final
WILDFLY_CLI=${WILDFLY_HOME}/bin/jboss-cli.sh
WILDFLY_LOG=$(mktemp --tmpdir wildfly.XXXXXX.log)

function download_and_sha1 {
  base=$(basename $1)
  [ -e $base ] || curl -OL $1
  echo "$2 $base" | sha1sum --quiet -c - \
    || (printf "$base has an unexpected sha1sum: $(sha1sum $base | awk '{print $1}')\n" && exit)
}

function wait_for_wildfly {
  until `$1 -c "ls /deployment" &> /dev/null`; do
    sleep 5
    echo "Waiting for wildfly to come up."
  done
}

${WILDFLY_CLI} --connect --command="deploy ${TRAVIS_BUILD_DIR}/psm-app/cms-portal-services/build/libs/cms-portal-services.ear"

wait_for_wildfly ${WILDFLY_CLI}

cat ${WILDFLY_LOG}
