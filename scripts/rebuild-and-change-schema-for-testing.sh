#!/bin/bash

# A script to build a fresh EAR, blow away the old database
# contents and build a new schema, and deploy the EAR.
# For use in development when testing a pull request.

# If you don't want to have to type in the psm user's
# PostgreSQL password midway through, create a .pgpass file
# in your home directory:
# https://www.postgresql.org/docs/current/static/libpq-pgpass.html

WILDFLY_CLI=../../wildfly-11.0.0.Final/bin/jboss-cli.sh

RESPONSE=$(${WILDFLY_CLI} --connect --command=":read-attribute(name=server-state)")
# Check whether WildFly is running.
# TODO: use something like
# http://www.mastertheboss.com/jboss-server/jboss-monitoring/monitor-wildfly-with-your-bash-skills
# to check whether WildFly is about to run out of memory.
if echo $RESPONSE | grep "Failed"
then
    echo "Please start WildFly in another terminal first:"
    echo "wildfly-11.0.0.Final/bin/standalone.sh -c standalone-full.xml"
else
    set -e
    cd ../psm-app
    ./gradlew clean cms-portal-services:build
    cd ..
    echo "Re-seeding database"
    cat scripts/drop-contents-of-db-for-testing.sql \
	psm-app/db/jbpm.sql \
	psm-app/db/seed.sql | psql -h localhost -U psm psm
    # Once we have a new dev enrollment schema:
    # psql -h localhost -U psm psm < psm-app/db/dev_enrollment.sql
    echo "Deploying new EAR"
    ${WILDFLY_CLI} --connect \
       --command="deploy --force
       psm-app/cms-portal-services/build/libs/cms-portal-services.ear"
    echo "Ready to test at http://localhost:8080/cms/ ."
    echo "To stop WildFly server:  ${WILDFLY_CLI} --connect --command=:shutdown "
fi
