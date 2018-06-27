#!/usr/bin/env bash

dumper(){

    (while :; do for c in / - \\ \|; do printf "\e[92m%s\b\e[0m" "$c"; sleep 0.1; done; done) &

        # Run the synchronous (blocking) commands.

        # dump database into designated folder
        printf "Dumping \e[91m${EXPORT_ENV}\e[0m \e[92m${db}\e[0m into dumps dir: \e[92m${db}${DUMP_NAME}\e[0m\n"
        export_db > /dev/null 2>&1

        # import dump into local database if requested
        printf "Importing into \e[93m${IMPORT_ENV}\e[0m \e[92m${db}\e[0m:\n"
        import_db > /dev/null 2>&1

        # drop production triggers from main database on local if any
        # see db_list
        drop_triggers

        # The blocking command has finished:
        # Print a newline and kill the spinner job.
        { printf '\n'; kill $! && wait $!; } 2>/dev/null

    echo Done.

}

drop_triggers(){

     # drop production triggers from main database on local if any
     # see db_list

    if [[ ${DROP_TRIGGERS_FLAG} == '--dt' ]]
        then
        if [[ ${db} == ${TRIGGER_DB_NAME} ]]
            then

            # explode trigger names
            IFS=',' read -ra TR <<< "$TRIGGER_NAMES"

            for tr in "${TR[@]}"; do

                printf "Dropping trigger...\e[92m${tr}\e[0m from \e[92m${TRIGGER_DB_NAME}\e[0m\n"
                $(mysql -h ${IMPORT_DB_HOST} -u ${IMPORT_DB_USER} -p${IMPORT_DB_PASS} -D ${db} -e "DROP TRIGGER IF EXISTS "${tr} > /dev/null 2>&1)

            done
        fi
    fi

}

export_db(){

    # if no password for db
    if [[ -z ${EXPORT_DB_PASS} ]]
    then
        pass=''
    else
        pass=-p${EXPORT_DB_PASS}
    fi

    if [[ $(uname -s) == Linux ]]
    then
        stats=''
    else
        stats=--column-statistics=0
    fi


    $(mysqldump ${stats} -h ${EXPORT_DB_HOST} -u ${EXPORT_DB_USER} ${pass} ${db} > ${DUMP_DIR}${db}${DUMP_NAME})

}

import_db(){

    if [[ ${IMPORT_FLAG} == "-i" ]]
        then

         # if no password for db
        if [ -z ${IMPORT_DB_PASS} ]
        then
            pass=''
        else
            pass=-p${IMPORT_DB_PASS}
        fi

        $(mysql -h ${IMPORT_DB_HOST} -u ${IMPORT_DB_USER} ${pass} ${db} < ${DUMP_DIR}${db}${DUMP_NAME})
    fi

}
