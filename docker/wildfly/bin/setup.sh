#!/bin/bash

# Make sure we're in Docker, not at command line
if ! grep --quiet docker /proc/1/cgroup; then
		echo This script should be run from within the wildfly Docker container.
		echo No need for you to run it manually!
		exit
fi

# Wait until JBOSS is fully up. 
# Adapted from https://stackoverflow.com/questions/48702307/how-to-check-if-a-wildfly-server-has-started-successfully-using-command-script
function wait_for_jboss() {
  while true  #check if the server started successfully
  do  
    if ${JBOSS_CLI} --connect command=':read-attribute(name=server-state)' | grep running
    then
      echo "Wildfly is up!"      
      break
    fi
    echo "Waiting for wildfly to come up"
    sleep 1
  done
}

# If our config is newer than the somewhat randomly-chosen
# bin/product.conf, it indicates we've already done setup.
#[[ ${JBOSS_HOME}/standalone/configuration/standalone-full.xml -nt ${JBOSS_HOME}/bin/product.conf  ]] && echo "Wildfly seems to be configured; exiting setup and restarting." && exit


echo "Wildfly may not be configured; running configuration script."
nohup ${JBOSS_HOME}/bin/standalone.sh -c standalone-full.xml &
wait_for_jboss

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

# Connect the Postgres JDBC driver to Wildfly
${JBOSS_CLI} --connect --command="deploy ${JBOSS_HOME}/postgresql.jar"
echo "PostgreSQL driver deployed."

# Configure database sources.
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

$JBOSS_CLI -c ":shutdown"
echo "Shutting down local Wildfly server after setup."