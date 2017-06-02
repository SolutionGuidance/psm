#!/bin/bash
set -e

# This script builds the ear file that is the psm app.  When
# docker-compose brings up wildfly, the entrypoint script will run
# this script as part of the bootup. Running it from inside the
# wildfly docker container will put the resulting ear in the
# Wildfly deployments directory.

###############################################################################

# Bail if we're not being run from inside docker.
if ! grep --quiet docker /proc/1/cgroup; then

		printf 'This script gets run by the Docker entrypoint script `cmd.sh`.\nGo up a directory and then do `docker-compose up --build`\n'
		exit 1
		
fi

# If there's a build in the tree, put it in the deployments dir
if [ -e "/mnt/psm-app/build/${EAR_NAME}" ]; then
		printf "Copying psm-app/build/${EAR_NAME} to ${EAR}\n"
		cp "/mnt/psm-app/build/${EAR_NAME}" ${EAR}
fi

# Bail if ${EAR} exists and is newer than all other files in psm-app
if [ -e ${EAR} ]; then
		printf "${EAR} file in place\n"
		
		# If the app in the build tree is newest, we're done
		[[ "/mnt/psm-app/build/${EAR_NAME}" == $(find /mnt/psm-app -type f -printf '%T@ %p\0' | sort -zk 1nr | sed -z 's/^[^ ]* //' | tr '\0' '\n' | head -n 1) ]] && cp /mnt/psm-app/build/${EAR_NAME} ${EAR} && exit
				
		printf "... but something in psm-app has changed, so let's rebuild it.\n"
fi

####################################
# ALRIGHT, LET'S BUILD THIS THING

# Clear the build directory and destination dir
rm -rf /tmp/psm-build/* ${EAR}
mkdir -p /tmp/psm-build
		
# Copy source code to the build directory
cp -r /mnt/psm-app/* /tmp/psm-build

# Set build properties
echo "wildfly.home=/opt/jboss/wildfly" >> /tmp/psm-build/build.properties

# Build ear file
cd /tmp/psm-build
ant regenerate-model
ant dist

# Move ear to destination directory
cp /tmp/psm-build/build/${EAR_NAME} ${EAR}
cp /tmp/psm-build/build/${EAR_NAME} /mnt/psm-app/build/${EAR_NAME}

# Clean up
rm -rf /tmp/psm-build

