#!/usr/bin/env bash

AUTO_ROOTDIR=$(cd "$(dirname "$0")"; pwd)

bash ${AUTO_ROOTDIR}/dbdump.sh prod --list local -i --dt
