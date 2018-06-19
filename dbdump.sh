#!/usr/bin/env bash

# paths
filename=$(basename "$0")
URI=$(readlink -f "$0")
EXTRACT=/${filename}
ROOTDIR=${URI%${EXTRACT}}


##### load config #####
source ${ROOTDIR}/config.sh

if [ $# -lt 2 ]
  then
    echo usage: "dbdump <env-from-where-to-export> <rentbits_db-separated-by-comma or --list flag> <env-where-to-import> [-i]"
    exit 1
fi

# setting arguments
EXPORT_ENV=$1
DATABASE_NAMES=$2
IMPORT_ENV=$3
IMPORT_FLAG=$4
DROP_TRIGGERS_FLAG=$5

# short
if [[ ${1} == 'prod' ]]
then
    EXPORT_ENV=production
fi

# helper
if [[ ${2} == '--list' ]]
then
    source ${DB_LIST}
fi

if [[ ${5} == '--dt' ]]
then
    source ${TR_LIST}
fi

if [[ ${EXPORT_ENV} == ${IMPORT_ENV} ]]
then
    printf "Why!!! \e[91m${EXPORT_ENV}\e[0m = \e[91m${IMPORT_ENV}\e[0m FFS\n"
    exit 1
fi


# set env var
while IFS='' read -r line || [[ -n "$line" ]]; do

    # get indexes from env
    INDEX=$(echo ${line} | cut -d '=' -f 1)

    # set export values
    if [[ ${INDEX} == ${EXPORT_ENV}_DB_HOST ]]
    then
        # set host
        EXPORT_DB_HOST=$(echo ${line} | cut -d '=' -f 2)
        continue
    fi

    if [[ ${INDEX} == ${EXPORT_ENV}_DB_USER ]]
    then
        # set user
        EXPORT_DB_USER=$(echo ${line} | cut -d '=' -f 2)
        continue
    fi

    if [[ ${INDEX} == ${EXPORT_ENV}_DB_PASS ]]
    then
        # set pass
        EXPORT_DB_PASS=$(echo ${line} | cut -d '=' -f 2)
        continue
    fi

    # set import values
    if [[ ${INDEX} == ${IMPORT_ENV}_DB_HOST ]]
    then
        # set host
        IMPORT_DB_HOST=$(echo ${line} | cut -d '=' -f 2)
        continue
    fi

    if [[ ${INDEX} == ${IMPORT_ENV}_DB_USER ]]
    then
        # set user
        IMPORT_DB_USER=$(echo ${line} | cut -d '=' -f 2)
        continue
    fi

    if [[ ${INDEX} == ${IMPORT_ENV}_DB_PASS ]]
    then
        # set pass
        IMPORT_DB_PASS=$(echo ${line} | cut -d '=' -f 2)
        continue
    fi

done < ${ENV}

# explode database names
IFS=',' read -ra DB <<< "$DATABASE_NAMES"

# iterate trough each db name
for db in "${DB[@]}"; do

     dumper

done



