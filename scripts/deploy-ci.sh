#!/bin/bash
set -x
scp -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no ./psm-app/cms-portal-services/build/libs/cms-portal-services.ear $PROD_USER@$PROD_SERVER:~ && \
ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no $PROD_USER@$PROD_SERVER 'bash -s' < ./scripts/deploy-server.sh


