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
# the server is fully up and running.
# Adapted from https://stackoverflow.com/questions/48702307/how-to-check-if-a-wildfly-server-has-started-successfully-using-command-script
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
# we check if our config is newer than product.conf, the file we touched 
# as part of the initial Dockerfile.
# If setup has never been run before, standalone-full.xml will not exist, and
# the check will fail. The rest of the setup script will then execute, creating
# a new version of standalone-full.xml. On subsequent iterations, the check will 
# succeed, and the script will exit and skip the now-redundant setup step.
if [[ ${JBOSS_HOME}/standalone/configuration/standalone-full.xml -nt ${JBOSS_HOME}/bin/product.conf  ]] ; then
  echo "Wildfly seems to be configured; exiting setup and restarting."
  exit
fi

# If the above check failed, we need to run configuration. We start by booting up 
# Wildfly locally, with no networking (not necessary for setup). 
# In order for the rest of the script to run correctly, Wildfly must run in the 
# background. We use nohup to achieve this.
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

# Now that setup is complete, we shut down the server so that it can be
# rebooted with networking.
$JBOSS_CLI -c ":shutdown"
echo "Shutting down local Wildfly server after setup."