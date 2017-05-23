#!/bin/bash

# Make sure we're in Docker, not at command line
if ! grep --quiet docker /proc/1/cgroup; then
		echo This script should be run from within the wildfly Docker container.
		echo No need for you to run it manually!
		exit
fi

function wait_for_mail() {
		echo "Waiting for mail server to come up."
		until `echo "QUIT" | nc -w 5 mail 25 | grep -q "221 Ok"`; do
				sleep 1
		done
		echo "Mail server is up."
}

function wait_for_db {
		echo "Waiting for db server to come up."
		until false; do
				/usr/pgsql-9.6/bin/pg_isready -h db && return
				sleep 1
		done
}

[ -z "$(ls -A /opt/jboss/wildfly)" ] && cp -r /opt/jboss/wildfly.static/* /opt/jboss/wildfly
/root/bin/build.sh
/root/bin/setup.sh
wait_for_db
wait_for_mail

echo "Starting wildfly server!"
${JBOSS_HOME}/bin/standalone.sh -c standalone-full.xml -bmanagement 0.0.0.0 -b 0.0.0.0 -Djboss.http.port=80
