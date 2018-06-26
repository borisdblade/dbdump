#!/usr/bin/env bash

AUTO_URI=$(readlink -f "$0")
AUTO_EXTRACT=/autorun_dump.sh
AUTO_ROOTDIR=${AUTO_URI%${AUTO_EXTRACT}}

bash ${AUTO_ROOTDIR}/dbdump.sh prod --list local -i --dt
