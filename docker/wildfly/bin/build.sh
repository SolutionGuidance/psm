#!/bin/bash
set -e

# This script builds the .ear file that is the psm app.  When
# docker-compose brings up wildfly, the entrypoint script will run
# this script as part of the bootup. Running it from inside the
# wildfly docker container will put the resulting ear in the
# Wildfly deployments directory.

###############################################################################

# Bail if we're not being run from inside docker.
if ! grep --quiet docker /proc/1/cgroup; then
		echo "This script gets run by the Docker entrypoint script `cmd.sh`."
		echo "Go up a directory and then do `docker-compose up --build`"
		exit 1
fi

# If there's a build in the tree, put it in the Wildfly deployments directory
if [ -e "/mnt/psm-app/cms-portal-services/build/libs/${EAR_NAME}" ]; then
		echo "A build already exists in the tree; copying to Wildfly deployments directory"
		echo "Copying psm-app/cms-portal-services/build/libs/${EAR_NAME} to ${EAR}"
		cp "/mnt/psm-app/cms-portal-services/build/libs/${EAR_NAME}" ${EAR}
fi

# Bail if ${EAR} exists and is newer than all other files in psm-app
if [ -e ${EAR} ]; then
		echo "Wildfly deployments directory has a build in place at ${EAR}"
		
		# If the app in the build tree is newest, we're done
		[[ "/mnt/psm-app/cms-portal-services/build/libs/${EAR_NAME}" == $(find /mnt/psm-app -type f -printf '%T@ %p\0' | sort -zk 1nr | sed -z 's/^[^ ]* //' | tr '\0' '\n' | head -n 1) ]] && cp /mnt/psm-app/cms-portal-services/build/libs/${EAR_NAME} ${EAR} && exit
		printf "...but something in psm-app has changed. Rebuilding project now."
fi

####################################
# ALRIGHT, LET'S BUILD THIS THING

# Clear the build directory and destination dir
rm -rf /tmp/psm-build/* ${EAR}
mkdir -p /tmp/psm-build
		 
# Copy source code to the build directory
cp -r /mnt/psm-app/* /tmp/psm-build

# Build .ear file
cd /tmp/psm-build

# Run gradle build (from install instructions)
./gradlew cms-portal-services:build

# Move .ear file to both the Wildfly deployments directory and the build tree directory.
# Create build tree directory if it doesn't exist
if [ ! -e "/mnt/psm-app/cms-portal-services/build" ]; then
		echo "Making new build directory"
		mkdir /mnt/psm-app/cms-portal-services/build
		mkdir /mnt/psm-app/cms-portal-services/build/libs
fi

# Move .ear file to destinations
cp /tmp/psm-build/cms-portal-services/build/libs/${EAR_NAME} ${EAR}
cp /tmp/psm-build/cms-portal-services/build/libs/${EAR_NAME} /mnt/psm-app/cms-portal-services/build/libs/${EAR_NAME}

# Clean up
rm -rf /tmp/psm-build

