#!/usr/bin/env bash

IMPORT_FLAG=$1

bash dbdump.sh prod --list local -i --dt
