#!/bin/bash
set -ex
scp ./psm-app/cms-portal-services/build/libs/cms-portal-services.ear $CD_USER@$CD_SERVER:~
ssh $CD_USER@$CD_SERVER 'bash -s' < ./scripts/deploy-server.sh


