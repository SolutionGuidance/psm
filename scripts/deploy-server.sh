#!/bin/bash
/opt/wildfly/bin/jboss-cli.sh --user="psm" --password="$(< ~/pass.txt)" --connect \
	--command="deploy ~/cms-portal-services.ear"
