#!/bin/bash

# This setup script performs first-time configuration on Wildfly, echoing
# the installation instructions for a local install.

# Make sure we're in Docker, not at command line
if ! grep --quiet docker /proc/1/cgroup; then
		echo This script should be run from within the wildfly Docker container.
		echo No need for you to run it manually!
		exit
fi

# Function to block execution until Wildfly is fully up and running.
# This is necessary since configuration may not apply properly unless 
# the server is fully up and running. Adapted from 
# https://stackoverflow.com/questions/48702307/how-to-check-if-a-wildfly-server-has-started-successfully-using-command-script
function wait_for_jboss() {
  while true
  do
    # Use JBOSS' command line API to check its status; when that call 
    # returns "running", it's ready.
    if ${JBOSS_CLI} --connect command=':read-attribute(name=server-state)' | grep running
    then
      echo "Wildfly is up!"      
      break
    fi
    echo "Waiting for Wildfly to come up"
    sleep 1
  done
}

# The setup steps in this script only need to run once. To avoid redundancy, 
# we check if this script has already run in the past before running it again.

# If setup has never been run before, the .setupcomplete file will not exist, 
# and the check will fail. The rest of the setup script will then execute. At
# the end of this script, we create the .setupcomplete file, indicating that 
# setup is complete. On subsequent iterations, the check will succeed, and 
# the script will exit and skip the now-redundant setup step.
if [[ -e ${JBOSS_HOME}/.setupcomplete ]] ; then
  echo "Wildfly seems to be configured; exiting setup and restarting."
  exit
fi

# If the above check failed, we need to run configuration. We start by booting up 
# Wildfly locally, with no networking (not necessary for setup). 

# In order for the rest of the script to run correctly, Wildfly must run in the 
# background. If run in foreground, Wildfly blocks the rest of the script from executing.
# We use nohup to achieve this.
echo "Wildfly may not be configured; running configuration script."
nohup ${JBOSS_HOME}/bin/standalone.sh -c standalone-full.xml &

# In order for setup to apply properly, Wildfly must be fully up, so the script blocks until
# the server is completely up.
wait_for_jboss

# Once the server is fully up, we can run configuration for different components. A lot of
# these steps are mirrored from the local installation instructions.

# Setup mail server
${JBOSS_CLI} --connect << EOF
/socket-binding-group=standard-sockets/remote-destination-outbound-socket-binding=mail-smtp:write-attribute(name=port,value=25)
/socket-binding-group=standard-sockets/remote-destination-outbound-socket-binding=mail-smtp:write-attribute(name=host,value="mail")
/subsystem=mail/mail-session="java:/Mail":add(jndi-name="java:/Mail")
/subsystem=mail/mail-session="java:/Mail"/server=smtp:add(outbound-socket-binding-ref=mail-smtp)
EOF
echo "Mail server configuration complete."

# Create message queue
${JBOSS_CLI} --connect --command='jms-queue add --queue-address=DataSync --entries=["java:/jms/queue/DataSync"]'
echo "Message queue configuration complete."

# Set node identifier to unique value
${JBOSS_CLI} --connect << EOF
/subsystem=transactions:write-attribute(name=node-identifier,value=QuietWarning)
EOF

# Connect the Postgres JDBC driver to Wildfly.
${JBOSS_CLI} --connect --command="deploy ${JBOSS_HOME}/postgresql.jar"
echo "PostgreSQL driver deployed."

# Configure Wildfly datasources/databases.
# Replace DBNAME with the name of the database's Docker container.
DBNAME=psm_db_1; PWORD=psm; ${JBOSS_CLI} --connect <<EOF
xa-data-source add \
  --name=TaskServiceDS \
  --jndi-name=java:/jdbc/TaskServiceDS \
  --driver-name=postgresql.jar \
  --xa-datasource-class=org.postgresql.xa.PGXADataSource \
  --valid-connection-checker-class-name=org.jboss.jca.adapters.jdbc.extensions.postgres.PostgreSQLValidConnectionChecker \
  --exception-sorter-class-name=org.jboss.jca.adapters.jdbc.extensions.postgres.PostgreSQLExceptionSorter \
  --enabled=true \
  --use-ccm=true \
  --background-validation=true \
  --user-name=psm \
  --password=${PWORD} \
  --xa-datasource-properties=ServerName=${DBNAME},PortNumber=5432,DatabaseName=psm
xa-data-source add \
  --name=MitaDS \
  --jndi-name=java:/jdbc/MitaDS \
  --driver-name=postgresql.jar \
  --xa-datasource-class=org.postgresql.xa.PGXADataSource \
  --valid-connection-checker-class-name=org.jboss.jca.adapters.jdbc.extensions.postgres.PostgreSQLValidConnectionChecker \
  --exception-sorter-class-name=org.jboss.jca.adapters.jdbc.extensions.postgres.PostgreSQLExceptionSorter \
  --enabled=true \
  --use-ccm=true \
  --background-validation=true \
  --user-name=psm \
  --password=${PWORD} \
  --xa-datasource-properties=ServerName=${DBNAME},PortNumber=5432,DatabaseName=psm
EOF
echo "Wildfly data source configuration complete."

# Finally, we need to build the Liquibase database, encapsulated within a Gradle task.

# Normally, this task pulls configuration values from gradle.properties within the repo's 
# root directory; however, those values need to be different for Docker vs. a local installation.
# Since developers may want to run both at the same time, we override that configuration file with 
# command line arguments that work for Docker.

# The database path is configured with the host set to psm_db_1, the name of the database container 
# within the Docker bridge network (used for esy communication between containers). Username and 
# password are configured to match the ones provided as arguments for the database in docker-compose.yml.
echo "Building Liquibase database."
cd /mnt/psm-app
./gradlew db:update -DdatabasePath=jdbc:postgresql://psm_db_1:5432/psm -DdatabaseUser=psm -DdatabasePassword=psm;

# We create a simple file once all steps are complete, indicating that configuration is finished. The script
# checks the existence of this file to determine whether setup needs to be run. If the file doesn't exist,
# then setup 
touch ${JBOSS_HOME}/.setupcomplete | echo "This file is generated by the PSM Docker build process. Please do not remove it.\nThe presence of this file indicates that Wildfly configuration has completed successfully." >> ${JBOSS_HOME}/.setupcomplete

# Now that setup is complete, we shut down the server so that it can be
# rebooted with networking.
$JBOSS_CLI -c ":shutdown"
echo "Shutting down local Wildfly server after setup."