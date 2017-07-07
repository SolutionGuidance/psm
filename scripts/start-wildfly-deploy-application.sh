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

createdb -U postgres psm

${WILDFLY_HOME}/bin/standalone.sh -c standalone-full.xml > ${WILDFLY_LOG} &

download_and_sha1 "https://jdbc.postgresql.org/download/postgresql-42.1.1.jar" \
                  8a0b76d763f5382d6357c412eeb14970ba4405f3

wait_for_wildfly ${WILDFLY_CLI}

${WILDFLY_CLI} --connect --command="deploy postgresql-42.1.1.jar"
${WILDFLY_CLI} --connect <<EOF
/socket-binding-group=standard-sockets/remote-destination-outbound-socket-binding=mail-smtp:write-attribute(name=port,value=1025)

/subsystem=mail/mail-session="java:/Mail":add(jndi-name="java:/Mail")

/subsystem=mail/mail-session="java:/Mail"/server=smtp:add(outbound-socket-binding-ref=mail-smtp)
EOF

${WILDFLY_CLI} --connect <<EOF
xa-data-source add \
  --name=TaskServiceDS \
  --jndi-name=java:/jdbc/TaskServiceDS \
  --driver-name=postgresql-42.1.1.jar \
  --xa-datasource-class=org.postgresql.xa.PGXADataSource \
  --valid-connection-checker-class-name=org.jboss.jca.adapters.jdbc.extensions.postgres.PostgreSQLValidConnectionChecker \
  --exception-sorter-class-name=org.jboss.jca.adapters.jdbc.extensions.postgres.PostgreSQLExceptionSorter \
  --enabled=true \
  --use-ccm=true \
  --background-validation=true \
  --user-name=postgres \
  --password=ignored \
  --xa-datasource-properties=ServerName=localhost,PortNumber=5432,DatabaseName=psm

xa-data-source add \
  --name=MitaDS \
  --jndi-name=java:/jdbc/MitaDS \
  --driver-name=postgresql-42.1.1.jar \
  --xa-datasource-class=org.postgresql.xa.PGXADataSource \
  --valid-connection-checker-class-name=org.jboss.jca.adapters.jdbc.extensions.postgres.PostgreSQLValidConnectionChecker \
  --exception-sorter-class-name=org.jboss.jca.adapters.jdbc.extensions.postgres.PostgreSQLExceptionSorter \
  --enabled=true \
  --use-ccm=true \
  --background-validation=true \
  --user-name=postgres \
  --password=ignored \
  --xa-datasource-properties=ServerName=localhost,PortNumber=5432,DatabaseName=psm
EOF
${WILDFLY_CLI} --connect --command="reload"
${WILDFLY_CLI} --connect --command="xa-data-source test-connection-in-pool --name=MitaDS"
${WILDFLY_CLI} --connect --command="xa-data-source test-connection-in-pool --name=TaskServiceDS"
${WILDFLY_CLI} --connect --command="deploy ${TRAVIS_BUILD_DIR}/psm-app/cms-portal-services/build/libs/cms-portal-services.ear"

python -m smtpd -n -c DebuggingServer localhost:1025 &
PYTHON_SMTPD_PID=$!

curl -v "http://localhost:8080/cms"

${WILDFLY_CLI} --connect --command="shutdown"
kill ${PYTHON_SMTPD_PID}

cat ${WILDFLY_LOG}
