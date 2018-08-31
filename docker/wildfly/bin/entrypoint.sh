#!/bin/bash

# This script orchestrates the sub-scripts necessary to set up the Wildfly server and
# build the PSM application. Once those steps are complete, it boots up Wildfly with 
# networking.

# Make sure we're in Docker, not at command line
if ! grep --quiet docker /proc/1/cgroup; then
		echo "This script should be run from within the Wildfly Docker container."
		echo "No need for you to run it manually!"
		exit
fi

[ -z "$(ls -A ${JBOSS_HOME})" ] && cp -r /opt/jboss/wildfly.static/* ${JBOSS_HOME}

# Run the setup script. This performs first-time Wildfly setup if not already done.
echo "Running setup.sh"
/usr/local/bin/setup.sh && echo "Finished setup!";

# Run the build script. This script checks if a new build is necessary, then 
# rebuilds the PSM application and database if it is.
echo "Running build.sh"
/usr/local/bin/build.sh && echo "Finished build process!";

# Once both scripts finish running, the application should be ready to go.

# Boot up Wildfly one final time with networking. 
echo "Starting Wildfly with networking..."
${JBOSS_HOME}/bin/standalone.sh -c standalone-full.xml -bmanagement 0.0.0.0 -b 0.0.0.0