#!/bin/bash
set -e

# This script does a TEST AND DEVELOPMENT install of the Provider
# Screening Module and dependencies on Debian and RHEL systems.  It
# might work on Ubuntu or CentOS, but we haven't tried it there yet.
# If you are trying to get it working on either of those systems,
# please let us know of any successes, failures, and adjustments you
# made to the script.

# This script will install postgres, jdbc, mailcatcher, wildfly and
# the psm.  It will run mailcatcher and wildfly and if all works out,
# you will be able to see the PSM as a running instance at
# http://localhost:8080/cms

# This is for a test/dev setup, not a deployment setup.  It blows away
# existing Wildfly and DB contents.  It uses mailcatcher on port 1025,
# rather than a real SMTP server.  It also seeds the database with the
# test data from the repo.  If you're deploying in earnest, you'll
# want to adjust things.

WILDFLY_VERSION="11.0.0.Final"
WILDFLY_DIR="./wildfly-${WILDFLY_VERSION}"

function download_and_sha1 {
	base=$(basename $1)
	[ -e $base ] || curl -OL $1
	echo "$2 $base" | sha1sum --quiet -c - || (printf "$base has an unexpected sha1sum: $(sha1sum $base | awk '{print $1}')\n" && exit)
}

function kill_jboss {
	# kill any running wildfly servers
	pgrep -f "^java.*wildfly" && pgrep -f "^java.*wildfly" | xargs kill -9
	echo Killed any running Wildfly instances
}

function seed_db {
	# Seed the database
	echo Seed the database
	export PGPASSWORD=${pword}; cat psm/psm-app/db/jbpm.sql psm/psm-app/db/seed.sql | psql -h localhost -U psm psm
	echo Your db user psm has a password of ${pword}
	echo Point your browser at http://localhost:8080/cms to see it working.
}

function start_jboss {
	${WILDFLY_DIR}/bin/standalone.sh \
		-c standalone-full.xml \
		-b 0.0.0.0 \
		-bmanagement 0.0.0.0 &
	wait_for_jboss ${JBOSS_CLI}
}

function wait_for_jboss {
	until `$1 -c "ls /deployment" &> /dev/null`; do
		sleep 5
		echo "Waiting for wildfly to come up."
	done
}

kill_jboss

# Install some packages after detecting distribution (see https://www.novell.com/coolsolutions/feature/11251.html)
if [ -e "/etc/debian_version" ]; then
	echo We appear to be on a Debian system.

	# apt update if we haven't done it recently
	let "a = $(date +%s) - $(stat -c %Y /var/cache/apt)"
	[[ "$a" -gt "3600" ]] && sudo apt -y update
	
	sudo apt install -y git libsqlite3-dev openjdk-8-jdk-headless postgresql-9.6 ruby-dev
elif [ -e "/etc/redhat_version" ]; then
	echo "Installing postgres"
	download_and_sha1 "https://download.postgresql.org/pub/repos/yum/9.6/redhat/rhel-7-x86_64/pgdg-redhat96-9.6-3.noarch.rpm" \
					  43715d4c1d7fcf8d5d825b24c5f62c08cbca040d
	echo "Downloaded"
	sudo rpm -ivh pgdg-redhat96-9.6-3.noarch.rpm
	rm pgdg-redhat96-9.6-3.noarch.rpm
	sudo yum -y install postgresql96-server postgresql96-contrib postgresql96-devel

	sudo /usr/pgsql-9.6/bin/postgresql96-setup initdb
	sudo sed -i 's/ident/md5/g' /var/lib/pgsql/9.6/data/pg_hba.conf
	sudo systemctl enable postgresql-9.6.service
	sudo systemctl start postgresql-9.6.service

	sudo yum -y install git
	sudo yum -y install java-1.8.0-openjdk
	sudo yum-config-manager --enable rhui-REGION-rhel-server-optional
	sudo yum -y install gcc ruby-devel rubygems sqlite-devel
	sudo yum -y groupinstall 'Development Tools'
else
	echo "We don't appear to be on a Red Hat or a Debian system. Exiting."
	echo "Please feel free to add support for your favorite system here!"
	exit
fi

# Install and run mailcatcher as needed
echo Making sure mailcatcher is available
which mailcatcher > /dev/null || sudo gem install mailcatcher
pgrep mailcatcher > /dev/null || mailcatcher

# If the script is not in a psm git tree (which here is defined as a
# repo that has among its remotes the official repo), download the
# codebase.  If we are, then cd to the dir above the git tree so we
# can put wildfly in a dir that is parallel to the psm repo.
pushd $(dirname $0) > /dev/null
if git remote -v | grep -q "SolutionGuidance/psm.git"; then
	printf "Install script is in a PSM repo, so we'll use that repo for the install.\n"
	cd $(git rev-parse --show-toplevel)
	cd ..
else
	printf "Downloading the PSM from git.\n"
	popd  > /dev/null
	git clone https://github.com/SolutionGuidance/psm.git
fi

# Generate a password to use when passwords are needed and save to
# /tmp/pass.txt.  If, however, the password is in the xml config from
# a prior run, just use that password.
pword=""
if grep -q user-name.psm..user-name ${WILDFLY_DIR}/standalone/configuration/standalone-full.xml; then
	pword=$(grep -m 1 -A 1 user-name.psm..user-name ${WILDFLY_DIR}/standalone/configuration/standalone-full.xml | \
		grep password | \
		sed "s/.*<password>//" | \
		sed "s/<.password>//")
fi
[[ -z "$pword" ]] && pword=< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c30 | awk '{print $1"!"}'

# At this point, we are one dir above a checkout of the psm repo, so
# we can download and install Wildfly
echo "Downloading and installing Wildfly"
download_and_sha1 "http://download.jboss.org/wildfly/${WILDFLY_VERSION}/wildfly-${WILDFLY_VERSION}.tar.gz" \
                  0e89fe0860a87bfd6b09379ee38d743642edfcfb
rm -rf ${WILDFLY_DIR}
tar -xzf wildfly-${WILDFLY_VERSION}.tar.gz

# Config postgres - setup user/pass and make db
pushd /tmp > /dev/null # Prevent complaining about not being able to change to dir (permission denied)
sudo -upostgres psql -l | grep -q "^ psm" && sudo -upostgres psql -c "drop database psm"
sudo -upostgres psql -c "\du" | grep -q "^ psm" && sudo -upostgres psql -c "drop user psm"
sudo -upostgres psql -c "create user psm with password '${pword}'"
sudo -upostgres psql -c "create database psm with owner psm encoding=utf8 template template0"
popd > /dev/null

# Set up user and run wildfly server
JBOSS_CLI=${WILDFLY_DIR}/bin/jboss-cli.sh
${WILDFLY_DIR}/bin/add-user.sh psm "${pword}"
start_jboss

# Configure wildfly service bindings
if ! grep -Fq "<remote-destination host=\"localhost\" port=\"1025\"/>" ${WILDFLY_DIR}/standalone/configuration/standalone-full.xml; then
	echo Tell Wildfly to use localhost:1025 for mail service.
	${JBOSS_CLI} --connect << EOF
/socket-binding-group=standard-sockets/remote-destination-outbound-socket-binding=mail-smtp:write-attribute(name=port,value=1025)
/subsystem=mail/mail-session="java:/Mail":add(jndi-name="java:/Mail")
/subsystem=mail/mail-session="java:/Mail"/server=smtp:add(outbound-socket-binding-ref=mail-smtp)
EOF
fi

echo Deploy jdbc jar
JDBC_VERSION=42.1.4
download_and_sha1 "https://jdbc.postgresql.org/download/postgresql-$JDBC_VERSION.jar" \
				  1c7788d16b67d51f2f38ae99e474ece968bf715a
${JBOSS_CLI} --connect --command="deploy --force postgresql-$JDBC_VERSION.jar"

echo Configure Wildfly to use Postgres
if ! grep -Fq 'TaskServiceDS' \
	 ${WILDFLY_DIR}/standalone/configuration/standalone-full.xml; then
${JBOSS_CLI} --connect <<EOF
xa-data-source add \
  --name=TaskServiceDS \
  --jndi-name=java:/jdbc/TaskServiceDS \
  --driver-name=postgresql-${JDBC_VERSION}.jar \
  --xa-datasource-class=org.postgresql.xa.PGXADataSource \
  --valid-connection-checker-class-name=org.jboss.jca.adapters.jdbc.extensions.postgres.PostgreSQLValidConnectionChecker \
  --exception-sorter-class-name=org.jboss.jca.adapters.jdbc.extensions.postgres.PostgreSQLExceptionSorter \
  --enabled=true \
  --use-ccm=true \
  --background-validation=true \
  --user-name=psm \
  --password=${pword} \
  --xa-datasource-properties=ServerName=localhost,PortNumber=5432,DatabaseName=psm
EOF
fi

if ! grep -Fq 'MitaDS' ${WILDFLY_DIR}/standalone/configuration/standalone-full.xml; then
${JBOSS_CLI} --connect <<EOF
xa-data-source add \
  --name=MitaDS \
  --jndi-name=java:/jdbc/MitaDS \
  --driver-name=postgresql-${JDBC_VERSION}.jar \
  --xa-datasource-class=org.postgresql.xa.PGXADataSource \
  --valid-connection-checker-class-name=org.jboss.jca.adapters.jdbc.extensions.postgres.PostgreSQLValidConnectionChecker \
  --exception-sorter-class-name=org.jboss.jca.adapters.jdbc.extensions.postgres.PostgreSQLExceptionSorter \
  --enabled=true \
  --use-ccm=true \
  --background-validation=true \
  --user-name=psm \
  --password=${pword} \
  --xa-datasource-properties=ServerName=localhost,PortNumber=5432,DatabaseName=psm
EOF
fi

# Build and deploy the psm app
echo Build and deploy the PSM
cd psm/psm-app
./gradlew cms-portal-services:build
cd ../../
${JBOSS_CLI} --connect \
			 --command="deploy --force psm/psm-app/cms-portal-services/build/libs/cms-portal-services.ear"
seed_db
