#!/bin/bash
./wildfly-10.1.0.Final/bin/jboss-cli.sh --connect \
	--command="deploy ~/cms-portal-services.ear"
