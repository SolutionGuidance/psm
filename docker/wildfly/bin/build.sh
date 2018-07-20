#!/bin/bash
set -e

# This script builds the PSM application and deploys it to Wildfly, and then 
# builds the Liquibase database files.

# We first check to see if a new build is necessary. If not 
# (in other words, if a recent build already exists), we prepare and
# deploy that build. If a new build is necessary, we rebuild the application 
# and deploy the relevant buld artifact.

# The application is encapsulated by an .ear file, which is produced as a build 
# artifact. This application is deployed by simply moving it into the appropriate 
# Wildfly deployment directory.

###############################################################################

# Bail if we're not being run from inside docker.
if ! grep --quiet docker /proc/1/cgroup; then
		echo "This script gets run by the Docker entrypoint script `cmd.sh`."
		echo "Go up a directory and then do `docker-compose up --build`"
		exit 1
fi

# If there's an existing build in the tree, put it in the Wildfly deployments directory
# (represented by the ${EAR} environment variable)
if [ -e "/mnt/psm-app/cms-portal-services/build/libs/${EAR_NAME}" ]; then
		echo "A build already exists in the tree; copying to Wildfly deployments directory"
		echo "Copying psm-app/cms-portal-services/build/libs/${EAR_NAME} to ${EAR}"
		cp "/mnt/psm-app/cms-portal-services/build/libs/${EAR_NAME}" ${EAR}
fi

# Bail if a build (in other words, an .ear file) exists and is newer than all other files 
# in psm-app.
if [ -e ${EAR} ]; then
		echo "Wildfly deployments directory has a build in place at ${EAR}"
		
		# If the app in the build tree is newest, we're done
		[[ "/mnt/psm-app/cms-portal-services/build/libs/${EAR_NAME}" == $(find /mnt/psm-app -type f -printf '%T@ %p\0' | sort -zk 1nr | sed -z 's/^[^ ]* //' | tr '\0' '\n' | head -n 1) ]] && cp /mnt/psm-app/cms-portal-services/build/libs/${EAR_NAME} ${EAR} && exit
		echo "...but something in psm-app has changed. Rebuilding project now."
fi

####################################
# If we've made it this far, we need to rebuild and redeploy the application.

# Clear the temporary build directory and the deployment directory (represented by ${EAR})
rm -rf /tmp/psm-build/* ${EAR}
mkdir -p /tmp/psm-build
		 
# Copy source code to the temporary build directory, and change into the build directory
cp -r /mnt/psm-app/* /tmp/psm-build
cd /tmp/psm-build

# Run the main gradle build (from local installation instructions)
./gradlew cms-portal-services:build

# Move the resulting .ear file to both the Wildfly deployments directory and the build
# tree directory.

# First, create build tree directory if it doesn't exist
if [ ! -e "/mnt/psm-app/cms-portal-services/build" ]; then
		echo "Making new build directory"
		mkdir /mnt/psm-app/cms-portal-services/build
		mkdir /mnt/psm-app/cms-portal-services/build/libs
fi

# Move .ear file to appropriate directories
cp /tmp/psm-build/cms-portal-services/build/libs/${EAR_NAME} ${EAR}
cp /tmp/psm-build/cms-portal-services/build/libs/${EAR_NAME} /mnt/psm-app/cms-portal-services/build/libs/${EAR_NAME}

# We may need to rebuild the Liquibase database; it may have changed configuration. To
# see more information about the Liquibase setup, see comments in setup.sh.
echo "Rebuilding Liquibase database."
./gradlew db:update -DdatabasePath=jdbc:postgresql://${DBNAME}:5432/psm -DdatabaseUser=${DBUSER} -DdatabasePassword=${PWORD};

# Clean up the temporary build directory.
rm -rf /tmp/psm-build