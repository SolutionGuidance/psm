#!/bin/bash

# Make sure we're in Docker, not at command line
if ! grep --quiet docker /proc/1/cgroup; then
		echo "This script should be run from within the Wildfly Docker container."
		echo "No need for you to run it manually!"
		exit
fi

[ -z "$(ls -A /opt/jboss/wildfly)" ] && cp -r /opt/jboss/wildfly.static/* /opt/jboss/wildfly
echo "Running setup.sh"
/usr/local/bin/setup.sh && echo "Finished setup!";

echo "Running build.sh"
/usr/local/bin/build.sh && echo "Finished build process!";

echo "Starting Wildfly with networking..."
${JBOSS_HOME}/bin/standalone.sh -c standalone-full.xml -bmanagement 0.0.0.0 -b 0.0.0.0


