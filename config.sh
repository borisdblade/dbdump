#!/usr/bin/env bash

#########
# PATHS #
#########
# scripts
URI=$(readlink -f "$0")
EXTRACT=/dbdump.sh
ROOTDIR=${URI%${EXTRACT}}

CORE=${ROOTDIR}/core.sh
source ${CORE}

DB_LIST=${ROOTDIR}/lists/db_list;
TR_LIST=${ROOTDIR}/lists/tr_list;

# dump dir
DUMP_DIR=${ROOTDIR}/dumps/
DUMP_NAME=_$(date +%s).sql

# env file
ENV=${ROOTDIR}/.env
