#!/bin/bash
set -e

function download_and_sha1 {
		base=$(basename $1)
		[ -e $base ] || curl -OL $1
		echo "$2 $base" | sha1sum --quiet -c - || (printf "$base has an unexpected sha1sum: $(sha1sum $base | awk '{print $1}')\n" && exit)
}

function wait_for_jboss {
	until `$1 -c "ls /deployment" &> /dev/null`; do
		sleep 5
		echo "Waiting for wildfly to come up."
	done
}

sudo yum -y update

## Generate a password to use when passwords are needed
< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c30 | awk '{print $1"!"}' > pass.txt
## Install posgresql repo, then postgres
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
sudo -upostgres psql -c "create user \"psm\" with password '$(< pass.txt)'"
sudo -upostgres psql -c "create database \"psm\" with owner \"psm\" encoding='utf8' template template0"

## Get the project code base
echo "Getting the project code base"
sudo yum -y install git
git clone https://github.com/OpenTechStrategies/psm.git

## Install java dependencies
echo "Installing java dependencies"
sudo yum -y install java-1.8.0-openjdk ant

## Install and run mailcatcher
echo "Installing mailcatcher"
sudo yum-config-manager --enable rhui-REGION-rhel-server-optional
sudo yum -y install gcc mysql-devel ruby-devel rubygems sqlite-devel
sudo yum -y groupinstall 'Development Tools'
gem install mailcatcher
echo "Running mailcatcher"
mailcatcher

## Download and install wildfly
download_and_sha1 "http://download.jboss.org/wildfly/10.1.0.Final/wildfly-10.1.0.Final.tar.gz" \
									9ee3c0255e2e6007d502223916cefad2a1a5e333
tar -xzf wildfly-10.1.0.Final.tar.gz
rm wildfly-10.1.0.Final.tar.gz

## Set up wildfly server
cat pass.txt | awk '{print "psm "$1}'>> script.txt
eval ./wildfly-10.1.0.Final/bin/add-user.sh "$(< script.txt)"
rm script.txt
./wildfly-10.1.0.Final/bin/standalone.sh \
		-c standalone-full.xml \
		-b 0.0.0.0 \
		-bmanagement 0.0.0.0 &
wait_for_jboss ./wildfly-10.1.0.Final/bin/jboss-cli.sh

## Configure wildfly service bindings
./wildfly-10.1.0.Final/bin/jboss-cli.sh --connect << EOF
/socket-binding-group=standard-sockets/remote-destination-outbound-socket-binding=mail-smtp:write-attribute(name=port,value=1025)
/subsystem=mail/mail-session="java:/Mail":add(jndi-name="java:/Mail")
/subsystem=mail/mail-session="java:/Mail"/server=smtp:add(outbound-socket-binding-ref=mail-smtp)
EOF
./wildfly-10.1.0.Final/bin/jboss-cli.sh --connect \
	--command='jms-queue add --queue-address=DataSync --entries=["java:/jms/queue/DataSync"]'
download_and_sha1 "https://jdbc.postgresql.org/download/postgresql-42.1.1.jar" \
									8a0b76d763f5382d6357c412eeb14970ba4405f3
./wildfly-10.1.0.Final/bin/jboss-cli.sh --connect --command="deploy postgresql-42.1.1.jar"
./wildfly-10.1.0.Final/bin/jboss-cli.sh --connect <<EOF
xa-data-source add \
	--name=TaskServiceDS \
	--jndi-name=java:/jdbc/TaskServiceDS \
	--driver-name=postgresql-42.1.1.jar \
	--xa-datasource-class=org.postgresql.xa.PGXADataSource \
	--valid-connection-checker-class-name=org.jboss.jca.adapters.jdbc.extensions.postgres.PostgreSQLValidConnectionChecker \
	--exception-sorter-class-name=org.jboss.jca.adapters.jdbc.extensions.postgres.PostgreSQLExceptionSorter \
	--enabled=true \
	--use-ccm=true \
	--background-validation=true \
	--user-name=psm \
	--password=$(< pass.txt) \
	--xa-datasource-properties=ServerName=localhost,PortNumber=5432,DatabaseName=psm
xa-data-source add \
	--name=MitaDS \
	--jndi-name=java:/jdbc/MitaDS \
	--driver-name=postgresql-42.1.1.jar \
	--xa-datasource-class=org.postgresql.xa.PGXADataSource \
	--valid-connection-checker-class-name=org.jboss.jca.adapters.jdbc.extensions.postgres.PostgreSQLValidConnectionChecker \
	--exception-sorter-class-name=org.jboss.jca.adapters.jdbc.extensions.postgres.PostgreSQLExceptionSorter \
	--enabled=true \
	--use-ccm=true \
	--background-validation=true \
	--user-name=psm \
	--password=$(< pass.txt) \
	--xa-datasource-properties=ServerName=localhost,PortNumber=5432,DatabaseName=psm
EOF

## Build and deploy the psm app
cp psm/psm-app/build.properties.template psm/psm-app/build.properties
cd psm/psm-app
./gradlew build
cd ../../
./wildfly-10.1.0.Final/bin/jboss-cli.sh --connect \
		--command="deploy psm/psm-app/cms-portal-services/build/libs/cms-portal-services.ear"
