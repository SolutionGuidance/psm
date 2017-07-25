#!/bin/bash
set -x
scp -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no ./psm-app/cms-portal-services/build/libs/cms-portal-services.ear $CD_USER@$CD_SERVER:~ && \
ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no $CD_USER@$CD_SERVER 'bash -s' < ./scripts/deploy-server.sh


