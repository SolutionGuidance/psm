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
		printf "...but something in psm-app has changed. Rebuilding project now."
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

# Finally, we need to build the Liquibase database, encapsulated within a Gradle task.

# Normally, this task pulls configuration values from gradle.properties within the repo's 
# root directory; however, those values need to be different for Docker vs. a local installation.
# Since developers may want to run both at the same time, we override that configuration file with 
# command line arguments that work for Docker.

# The database path is configured with the host set to psm_db_1, the name of the database container 
# within the Docker bridge network (used for esy communication between containers). Username and 
# password are configured to match the ones provided as arguments for the database in docker-compose.yml.
./gradlew db:update -DdatabasePath=jdbc:postgresql://psm_db_1:5432/psm -DdatabaseUser=psm -DdatabasePassword=psm

# Clean up the temporary build directory.
rm -rf /tmp/psm-build